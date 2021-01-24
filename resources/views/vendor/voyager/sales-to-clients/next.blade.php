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
                                <h3 class="panel-title">Unit Actual Price </h3>
                            </td> 
                            <td >
                                <div class="col-md-6" style="padding-left: 0px;"> 
                                    <input required type="number" class="form-control" name="unit_actual_price_name" id="unit_actual_price_{{ $dataTypeRows[$i]['salesToClient']->id }}" placeholder="Unit Actual Price" value="{{ $dataTypeRows[$i]['medication']->retail_price }}">
                                </div>
                                  
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
                                <input type="radio" id="cash" name="paid_method" checked="checked" style="margin-right: 12px;">
                                <label for="field_browse_slug">Paid in Cash</label><br>
                                <input type="radio" id="card" name="paid_method" style="margin-right: 12px;">
                                <label for="field_read_slug">Paid by Card</label><br>
                            </div>
                            </td>  
                        </tr>
                        <tr>
                            <td colspan=2 class="panel-footer"> 
                                <form action="/admin/sales-to-clients/next/save" id="save_form" method="POST" style="display:none"> 
                                    {{ csrf_field() }}
                                    <input type="hidden" name="payMethod" id="pay_method" value="">
                                    <input type="hidden" name="ids" id="save_input_ids" value="">
                                    <input type="hidden" name="unitActualPrices" id="save_input_actualPrices" value="">
                                    <input type="submit" class="" value="">
                                </form> 

                                <button class="btn btn-primary save" id="save_btn">{{ __('voyager::generic.save') }}</button>
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


@section('javascript')

    <script>
         
        $(document).ready(function () {
             
            var $saveForm = $('#save_form'); 
            var $saveInputActualPrices = $('#save_input_actualPrices'); 
            var $savePayMethod = $('#pay_method');
            var $saveInputIds = $('#save_input_ids'); 
            var $saveBtnBtn = $('#save_btn');  
            $saveBtnBtn.click(function () { 
                var $returnWarning = false;  
                $saveInputActualPrices.val(''); 
                $saveInputIds.val('');
                var $allInputs = $( "input[name^='unit_actual_price_name']" );
                var $radioCheckedId = $('input[type=radio][name=paid_method]:checked').attr('id');
                var $inputActualPricesValues = [], $inputIdsValues = []; 
                $allInputs.each(function(){ 
                    if($(this).val() == "" || $(this).val() == null){ 
                        $returnWarning = true;
                        return;
                    } 
                    $inputActualPricesValues.push($(this).val());
                    $inputIdsValues.push($(this).attr("id").replace("unit_actual_price_", ""));
                });
                $saveInputActualPrices.val($inputActualPricesValues); 
                $saveInputIds.val($inputIdsValues);   
                $savePayMethod.val($radioCheckedId);
                if(!$returnWarning) {
                    $saveForm.submit(); 
                    toastr.success('Successfully saved');
                }
                else toastr.warning('Unit actual price should not be empty');
            });

            calculateSaleTotal();


            $("[name ='unit_actual_price_name']").keyup(function(){
                var $rowId = $(this).attr("id").replace("unit_actual_price_", "");

                var $totalInputCell = $('#total_input_' + $rowId);
                var $totalCell = $('#total_' + $rowId);
                var $quantityCell = $('#quantity_' + $rowId);
                var $totalVal = $quantityCell.val() * $(this).val();
                $totalCell.html($totalVal); 
                $totalInputCell.val($totalVal);
                
                calculateSaleTotal();
            });

            function calculateSaleTotal() { 
                var $saleTotal = 0; 
            
                var $totalInputs = $("[name ='total_input']"); 
                $totalInputs.each(function(){ 
                    $saleTotal += parseFloat($(this).val()); 
                });  

                var $saleTotalCell = $('#sale_total');
                $saleTotalCell.html($saleTotal); 
            }
        }); 
    </script>

@stop