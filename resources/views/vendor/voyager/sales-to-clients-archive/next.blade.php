@extends('voyager::master')
  
@section('page_title', __('voyager::generic.view').' '.$dataType->getTranslatedAttribute('display_name_singular'))

@section('page_header')
    <h1 class="page-title">
        <i class="{{ $dataType->icon }}"></i> {{ __('voyager::generic.viewing') }} {{ ucfirst($dataType->getTranslatedAttribute('display_name_singular')) }} &nbsp;
   
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
                    <table class="table-css"> 
                        <tr>
                            <td class="fix-width">
                                <h3 class="panel-title">Client </h3>
                            </td> 
                            <td>
                                {{ $clientModel->first_name_ar.' '.$clientModel->father_name_ar.' '.$clientModel->last_name_ar }}
                            </td>
                        </tr>  

                        
                    @for ($i = 0; $i < count($dataTypeRows); $i++)
                        <!-- open foreach -->
                        <tr>
                            <td class="td-css">
                                <h3 class="panel-title">Medication </h3>
                            </td> 
                            <td class="td-css">
                                {{ $dataTypeRows[$i]["medication"]->full_description }}
                            </td>
                        </tr>   
                        <tr>
                            <td>
                                <h3 class="panel-title">Medication Type </h3>
                            </td> 
                            <td>

                                @switch($dataTypeRows[$i]["medication"]->type)
                                    @case(0)
                                        <span> Pill</span>
                                        @break
                                    @case(1)
                                        <span> Liquid</span>
                                        @break

                                    @case(2)
                                        <span>Syringe</span>
                                        @break

                                    @default
                                        <span>-</span>
                                @endswitch 
                            </td>
                        </tr>   
                        <tr>
                            <td nextBtn>
                                <h3 class="panel-title">Quantity </h3>
                            </td> 
                            <td> 
                                <input type="hidden" id="quantity_{{ $dataTypeRows[$i]['salesToClient']->id }}" value="{{ $dataTypeRows[$i]['salesToClient']->quantity }}">
                                {{ $dataTypeRows[$i]["salesToClient"]->quantity }}
                            </td>
                        </tr>   
                        <tr>
                            <td nextBtn>
                                <h3 class="panel-title">Unit List Price </h3>
                            </td> 
                            <td>
                            {{ $dataTypeRows[$i]["medication"]->retail_price }}  
                            </td>
                        </tr>       
                        <tr>
                            <td nextBtn>
                                <h3 class="panel-title">Total </h3>
                            </td> 
                            <td >
                                <input type="hidden" id="total_input_{{ $dataTypeRows[$i]['salesToClient']->id }}" name="total_input" value="{{ $dataTypeRows[$i]['medication']->retail_price * $dataTypeRows[$i]['salesToClient']->quantity }}">
                                <label id="total_{{ $dataTypeRows[$i]['salesToClient']->id }}">
                                    {{ $dataTypeRows[$i]["medication"]->retail_price * $dataTypeRows[$i]["salesToClient"]->quantity }}
                                </label>
                            </td>
                        </tr>   
                        <!-- close foreach -->
                    @endfor

                        <tr>
                            <td class="td-css">
                                <h3 class="panel-title">Sale Total </h3>
                            </td> 
                            <td class="td-css">
                                <h3 class="panel-title">
                                    <label id="sale_total"> 
                                        {{ $saleTotal }} 
                                    </label>
                                </h3> 
                            </td>
                        </tr>
                        <tr>
                            <td colspan=2>
                                <div class="col-xs-2" style="font-size: 18px;">
                                    <input type="radio" id="cash" name="paid_method" checked="{{$cash}}" style="margin-right: 12px;">
                                    <label for="field_browse_slug">Paid in Cash</label><br>
                                    <input type="radio" id="card" name="paid_method" checked="{{$cc}}" style="margin-right: 12px;">
                                    <label for="field_read_slug">Paid by Card</label><br>
                                </div>
                            </td>  
                        </tr> 
                    </table>   
                </div>
            </div>
        </div>
    </div>
@stop

@section('css')
    <style>

        .td-css{
            border-top: 3px solid black;
        }

        .table-css{
            width:100%
        }

        .fix-width{
            width: 20%;
        }

        input[required] {
            border: 1px solid red;
        }

    </style>
@stop
 