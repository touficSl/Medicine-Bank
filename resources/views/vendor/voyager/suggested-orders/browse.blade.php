@extends('voyager::master')

@section('page_title', __('voyager::generic.viewing').' '.$dataType->getTranslatedAttribute('display_name_plural'))

@section('page_header')
    <div class="container-fluid">
        <h1 class="page-title">
            <i class="{{ $dataType->icon }}"></i> {{ $dataType->getTranslatedAttribute('display_name_plural') }}
        </h1>
    </div>
@stop

@section('content')
    <div class="page-content browse container-fluid">
        @include('voyager::alerts')
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-bordered">
                    <div class="panel-body">
                        @if ($isServerSide)
                            <form method="get" class="form-search">
                                <div id="search-input">
                                    <div class="col-2">
                                        <select id="search_key" name="key">
                                            @foreach($searchNames as $key => $name)
                                                <option value="{{ $key }}" @if($search->key == $key || (empty($search->key) && $key == $defaultSearchKey)) selected @endif>{{ $name }}</option>
                                            @endforeach
                                        </select>
                                    </div>
                                    <div class="col-2">
                                        <select id="filter" name="filter">
                                            <option value="contains" @if($search->filter == "contains") selected @endif>contains</option>
                                            <option value="equals" @if($search->filter == "equals") selected @endif>=</option>
                                        </select>
                                    </div>
                                    <div class="input-group col-md-12">
                                        <input type="text" class="form-control" placeholder="{{ __('voyager::generic.search') }}" name="s" value="{{ $search->value }}">
                                        <span class="input-group-btn">
                                            <button class="btn btn-info btn-lg" type="submit">
                                                <i class="voyager-search"></i>
                                            </button>
                                        </span>
                                    </div>
                                </div>
                                @if (Request::has('sort_order') && Request::has('order_by'))
                                    <input type="hidden" name="sort_order" value="{{ Request::get('sort_order') }}">
                                    <input type="hidden" name="order_by" value="{{ Request::get('order_by') }}">
                                @endif
                            </form>
                        @endif
                        <div class="table-responsive">
                            <table id="dataTable" class="table table-hover">
                                <thead>
                                    <tr>
                                        @if($showCheckboxColumn)
                                            <th>
                                                <input type="checkbox" class="select_all">
                                            </th>
                                        @endif
                                    	<th>Client</th>
                                    	<th>Medication</th>
                                    	<th>Quantity</th>
                                    	<th>From</th>
                                    	<th>To</th>
                                    </tr>
                                </thead>
                                <tbody>
                                	@foreach($suggestedOrders as $suggestedOrder)
                                		<tr>
                                            <td>
                                                <input type="checkbox" class="hasChangedEvent" name="row_id" id="checkbox_{{ $suggestedOrder->id }}" suggestedOrderID="{{ $suggestedOrder->id }}" value="{{ $suggestedOrder->id }}" {{ ($suggestedOrder->status != 0) ? 'checked="checked"' : '' }}>
                                                <input type="hidden" id="hasChanged_{{ $suggestedOrder->id }}" value="0" />
                                            </td>
                                            <td>{{ $suggestedOrder->Client }}</td>
                                            <td>
                                                <select class="form-control select2 hasChangedEvent" id="medication_for_suggestedOrder_{{ $suggestedOrder->id }}" suggestedOrderID="{{ $suggestedOrder->id }}" name="medication">
                                                    <optgroup>
                                                    @foreach($medications as $option)
                                                        <option value="{{ $option->id }}" @if($suggestedOrder->medication_id == $option->id) selected="selected" @endif>
                                                            {{ $option->brand . " " . $option->dose_per_tablet . " x " . $option->quantity_of_tablets }}
                                                        </option>
                                                    @endforeach
                                                    </optgroup>
                                                </select>
                                            </td>
                                            <td>
                                                <select class="form-control select2 hasChangedEvent" id="quantity_for_suggestedOrder_{{ $suggestedOrder->id }}" suggestedOrderID="{{ $suggestedOrder->id }}" name="quantity">
                                                    <optgroup>
                                                        <option value="1" @if($suggestedOrder->quantity == 1) selected="selected" @endif>1</option>
                                                        <option value="2" @if($suggestedOrder->quantity == 2) selected="selected" @endif>2</option>
                                                        <option value="3" @if($suggestedOrder->quantity == 3) selected="selected" @endif>3</option>
                                                        <option value="4" @if($suggestedOrder->quantity == 4) selected="selected" @endif>4</option>
                                                        <option value="5" @if($suggestedOrder->quantity == 5) selected="selected" @endif>5</option>
                                                    </optgroup>
                                                </select>
                                            </td>
                                            <td>
                                                <select class="form-control select2 hasChangedEvent" id="factory_for_suggestedOrder_{{ $suggestedOrder->id }}" suggestedOrderID="{{ $suggestedOrder->id }}" name="factory">
                                                    <optgroup>
                                                    @foreach($factories as $option)
                                                        <option value="{{ $option->id }}" @if($suggestedOrder->factory_id == $option->id) selected="selected" @endif>
                                                            {{ $option->name_ar }}
                                                        </option>
                                                    @endforeach
                                                    </optgroup>
                                                </select>
                                            </td>
                                            <td>{{ $suggestedOrder->To }}</td>
                                		</tr>
                                	@endforeach
                                    <!-- {{ $medications }}|{{ $factories }} -->
                                </tbody>
                            </table>
                        </div>
                        @if ($isServerSide)
                            <div class="pull-left">
                                <div role="status" class="show-res" aria-live="polite">{{ trans_choice(
                                    'voyager::generic.showing_entries', $dataTypeContent->total(), [
                                        'from' => $dataTypeContent->firstItem(),
                                        'to' => $dataTypeContent->lastItem(),
                                        'all' => $dataTypeContent->total()
                                    ]) }}</div>
                            </div>
                            <div class="pull-right">
                                {{ $dataTypeContent->appends([
                                    's' => $search->value,
                                    'filter' => $search->filter,
                                    'key' => $search->key,
                                    'order_by' => $orderBy,
                                    'sort_order' => $sortOrder,
                                    'showSoftDeleted' => $showSoftDeleted,
                                ])->links() }}
                            </div>
                        @endif
                        <div class="col-sm-12">
                            <div class="pull-right">
                                <!-- form start -->
                                <form role="form"
                                    id="updateSuggestedOrdersFormID"
                                    class="form-edit-add"
                                    action="{{ route('voyager.'.$dataType->slug.'.updateIDs') }}"
                                    method="POST" enctype="multipart/form-data">

                                    <!-- CSRF TOKEN -->
                                    {{ csrf_field() }}

                                    <input type="hidden" id="updatedIDs" name="IDs" />
                                </form>
                                <!-- form end -->

                                <a href="javascript:;" id="createOrdersID" class="btn btn-success btn-add-new">
                                    <i class="voyager-plus"></i> <span>Create Orders</span>
                                </a>
                            </div>
                        </div>
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

<script src="https://cdn.datatables.net/buttons/1.6.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src="https://cdn.datatables.net/buttons/1.6.2/js/buttons.html5.min.js"></script>

    <script>
        $(document).ready(function () {
            @if (!$dataType->server_side)
                $('#dataTable').DataTable( {
                    "searchable": true,
                    "dom": "Bfrtip",
                    "buttons": [
                        {
                            extend: 'excelHtml5',
                            text: '',
                            title: '',
                            className: 'icon voyager-download btn btn-primary btn-md',
                            exportOptions: {
                                format: {
                                    body: function (data, row, column, node) {
                                        return $(data).is("select") ? $(data).find("option:selected").text(): data;
                                    }
                                },
                                columns: ':not(:first-child)',
                            }
                        }
                    ]
                } );
            @else
                $('#search-input select').select2({
                    minimumResultsForSearch: Infinity
                });
            @endif

            @if ($isModelTranslatable)
                $('.side-body').multilingual();
                //Reinitialise the multilingual features when they change tab
                $('#dataTable').on('draw.dt', function(){
                    $('.side-body').data('multilingual').init();
                })
            @endif
            $('.select_all').on('click', function(e) {
                $('input[name="row_id"]').prop('checked', $(this).prop('checked')).trigger('change');
            });
        });

        $('input[name="row_id"]').on('change', function () {
            var ids = [];
            $('input[name="row_id"]').each(function() {
                if ($(this).is(':checked')) {
                    ids.push($(this).val());
                }
            });
            $('.selected_ids').val(ids);
        });

        $('.hasChangedEvent').on('change', function(event) {
            let suggestedOrderID = $(event.target).attr('suggestedOrderID');
            $('#hasChanged_' + suggestedOrderID).val(1);
        });

        $('#createOrdersID').on('click', function() {
            // 1. Gather the IDs that need to be updated.
            let suggestedOrdersUpdatedIDs = {};
            $.each($('input[name ="row_id"]'), function(i, checkbox) {
                let suggestedOrderCheckbox = $(checkbox);
                let suggestedOrderID = suggestedOrderCheckbox.attr('suggestedOrderID');
                if ($('#hasChanged_' + suggestedOrderID).val() == 1) {
                    // Add only the rows that have been changed.
                    suggestedOrdersUpdatedIDs[suggestedOrderID] = {};
                    suggestedOrdersUpdatedIDs[suggestedOrderID].isPutInOrder = suggestedOrderCheckbox.is(":checked");
                    suggestedOrdersUpdatedIDs[suggestedOrderID].medicationID = $('#medication_for_suggestedOrder_' + suggestedOrderID).val();
                    suggestedOrdersUpdatedIDs[suggestedOrderID].quantity = $('#quantity_for_suggestedOrder_' + suggestedOrderID).val();
                    suggestedOrdersUpdatedIDs[suggestedOrderID].factoryID = $('#factory_for_suggestedOrder_' + suggestedOrderID).val();
                }
            });

            // 2. Put them in a hidden input field and post to suggested orders store.
            $('#updatedIDs').val(JSON.stringify(suggestedOrdersUpdatedIDs));
            $('#updateSuggestedOrdersFormID').submit();
        });
    </script>
@stop
