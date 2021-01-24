@extends('voyager::master')

@section('page_title', __('voyager::generic.view').' '.$dataType->getTranslatedAttribute('display_name_plural'))

@section('page_header')
    <h1 class="page-title">
        <i class="{{ $dataType->icon }}"></i> {{ __('voyager::generic.viewing') }} {{ ucfirst($dataType->getTranslatedAttribute('display_name_plural')) }} &nbsp;

        <a href="{{ route('voyager.'.$dataType->slug.'.index') }}" class="btn btn-warning">
            <span class="glyphicon glyphicon-list"></span>&nbsp;
            {{ __('voyager::generic.return_to_list') }}
        </a>
    </h1>
    @include('voyager::multilingual.language-selector')
@stop

@section('content')
    <div class="page-content read container-fluid">
        <div class="row">
            <div class="col-md-12">

                <div class="panel panel-bordered" style="padding-bottom:5px;">

                    @foreach($suggestedOrders as $key1 => $suggestedOrdersByPharmacy)
                        @foreach($suggestedOrdersByPharmacy as $key2 => $values)
                            @if ($key2 != "factory_name" && $key2 != "placed_by_user" && $key2 != "factory_email1" && $key2 != "factory_email2" && $key2 != "factory_id")
                                @php
                                    $factory = $suggestedOrdersByPharmacy["factory_name"];
                                    $factory_id = $suggestedOrdersByPharmacy["factory_id"];
                                    $placed_by_user = $suggestedOrdersByPharmacy["placed_by_user"];
                                    $pharmacy_name = $values["pharmacy_name"];
                                    $pharmacy_id = $values["pharmacy_id"];
                                    $total_order_price = $values["total_order_price"];

                                    $factory_email1 = $suggestedOrdersByPharmacy["factory_email1"];
                                    $factory_email2 = $suggestedOrdersByPharmacy["factory_email2"];
                                    $factory_emails = [];
                                    if (isset($factory_email1)) {
                                        $factory_emails []= $factory_email1;
                                    }
                                    if (isset($factory_email2)) {
                                        $factory_emails []= $factory_email2;
                                    }
                                    $factory_emails = join(", ", $factory_emails);
                                @endphp

                                <div class="panel-heading" style="border-bottom:0;">
                                    <h3 class="panel-title" style="font-weight: bold; margin-left: 30px; margin-top: 10px;">{{ $factory }}</h3>
                                    <p style="margin-left: 44px;">
                                        <b>To:</b> {{ $pharmacy_name }}<br/>
                                        <b>Placed by:</b> {{ $placed_by_user }}<br/>
                                        <b>Total price:</b> {{ $total_order_price }} JD
                                    </p>

                                    <div class="panel-body" style="padding-top:0;">
                                        <div class="table-responsive">
                                            <table class="dataTable table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th class="col-md-6">Medication</th>
                                                        <th>Dose</th>
                                                        <th>Units/box</th>
                                                        <th>Type</th>
                                                        <th>Qty</th>
                                                        <th>Unit Price</th>
                                                        <th>Total Price</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    @foreach($values as $key3 => $medicationValue)
                                                        @if(gettype($key3) == "integer")
                                                        <tr>
                                                            <td>{{ $medicationValue['medication'] }}</td>
                                                            <td>{{ $medicationValue['dose'] }}</td>
                                                            <td>{{ $medicationValue['units'] }}</td>
                                                            <td>{{ $medicationValue['type'] }}</td>
                                                            <td>{{ $medicationValue['quantity'] }}</td>
                                                            <td>{{ $medicationValue['unitPrice'] }}</td>
                                                            <td>{{ $medicationValue['totalPrice'] }}</td>
                                                        </tr>
                                                        @endif
                                                    @endforeach
                                                </tbody>
                                            </table>
                                            <div class="col-md-8 pull-right">
                                                <input type="text" class="form-control" name="orderEmails" factoryIDPharmacyIDPair="{{ $factory_id . '-' . $pharmacy_id }}" placeholder="Send orders to these emails" value="{{ $factory_emails }}">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            @endif
                        @endforeach
                    @endforeach

                </div>
                <div class="col-sm-12">
                    <div class="pull-right">
                        <!-- form start -->
                        <form role="form"
                            id="sendOrdersFormID"
                            class="form-edit-add"
                            action="{{ route('voyager.'.$dataType->slug.'.sendOrders') }}"
                            method="POST" enctype="multipart/form-data">

                            <!-- CSRF TOKEN -->
                            {{ csrf_field() }}

                            <input type="hidden" id="emails" name="emails" />
                        </form>
                        <!-- form end -->

                        <a href="javascript:;" id="sendOrdersID" class="btn btn-success btn-add-new">
                            <i class="voyager-plus"></i> <span>Send Orders</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
@stop

@section('css')
@if(!$dataType->server_side && config('dashboard.data_tables.responsive'))
    <link rel="stylesheet" href="{{ voyager_asset('lib/css/responsive.dataTables.min.css') }}">
@endif
@stop

@section('javascript')
    <!-- DataTables -->
    @if(!$dataType->server_side && config('dashboard.data_tables.responsive'))
        <script src="{{ voyager_asset('lib/js/dataTables.responsive.min.js') }}"></script>
    @endif
    <script>
        $(document).ready(function () {
            @if (!$dataType->server_side)
                var table = $('.dataTable').DataTable({!! json_encode(
                    array_merge([
                        "paging" => false,
                        "info" => false,
                        "language" => __('voyager::datatable'),
                        "columnDefs" => [['targets' => -1, 'searchable' =>  false, 'orderable' => false]],
                    ],
                    config('voyager.dashboard.data_tables', []))
                , true) !!});
            @else
                $('#search-input select').select2({
                    minimumResultsForSearch: Infinity
                });
            @endif

            $('.select_all').on('click', function(e) {
                $('input[name="row_id"]').prop('checked', $(this).prop('checked')).trigger('change');
            });
        });

        $('#sendOrdersID').on('click', function() {
            let orderEmailAggregatedValues = {};
            $.each($('input[name ="orderEmails"]'), function(i, input) {
                let orderEmails = $(input);
                orderEmailAggregatedValues[orderEmails.attr('factoryIDPharmacyIDPair')] = orderEmails.val();
            });
            $('#emails').val(JSON.stringify(orderEmailAggregatedValues));
            $('#sendOrdersFormID').submit();
        });
    </script>
@stop
