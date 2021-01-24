@php
    $isClosedOrCancelled = ($dataTypeContent->status == 5 || $dataTypeContent->status == 6);
    $readableStatus = [
        "0" => "Proposed",
        "1" => "Prepared",
        "2" => "Placed",
        "3" => "Confirmed",
        "4" => "Delivered",
        "5" => "Closed"
    ];
@endphp
@extends('voyager::master')

@section('page_title', 'Delivered Orders')

@section('page_header')
    <h1 class="page-title">
        <i class="{{ $dataType->icon }}"></i> {{ __('voyager::generic.viewing') }} {{ ucfirst($dataType->getTranslatedAttribute('display_name_singular')) }} &nbsp;

        <a href="{{ Route('delivered-orders') }}" class="btn btn-warning">
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
            
                    @include('voyager::partials.orderMedications', ['medications' => $medications, 'from' => '2'])

                </div>
            </div>
        </div>
    </div>
@stop

@section('javascript')
    @if ($isModelTranslatable)
        <script>
            $(document).ready(function () {
                $('.side-body').multilingual();
            });
        </script>
    @endif
    <script>
        $('#displayClientsID').on('click', function() {
            let clientsList = $('#clientsListID');
            let wordShowHide = $('#wordShowHideID');
            let dropdownArrow = $('#dropdownArrowID');
            if (clientsList.is(':visible')) {
                clientsList.hide();
                wordShowHide.html('Show');
                dropdownArrow.attr('src', '/storage/settings/dropdown_arrow_down.png');
            } else {
                clientsList.show();
                wordShowHide.html('Hide');
                dropdownArrow.attr('src', '/storage/settings/dropdown_arrow_up.png');
            }
        });
    </script>
@stop
