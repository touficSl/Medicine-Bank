@extends('voyager::master')
  
@section('page_title', 'Stock')

@section('page_header')
    <h1 class="page-title">
        <i class="icon voyager-categories"></i> Stock &nbsp;
    </h1>
    @include('voyager::multilingual.language-selector')
@stop

@section('content')
    <div class="page-content edit-add container-fluid">
        <div class="row">
            <div class="col-md-12">

                <div class="panel panel-bordered">
                    <!-- form start -->
                    <form role="form" class="form-edit-add" action="{{ Route('save_stock') }}" method="POST">

                        <!-- CSRF TOKEN -->
                        {{ csrf_field() }}

                        <div class="panel-body">

                            <div class="table-responsive">
                                <table id="dataTable" class="dataTable table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Medication</th>
                                            <th>Quantity in stock</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @if( count($results) == 0 )
                                            <tr>
                                                <td>No data available</td>
                                            </tr>
                                        @endif
                                        @foreach($results as $res)
                                        <tr>
                                            <td>{{ $res->medication }}</td>

                                            <td contenteditable="true">
                                                <input type='number' name='quantity[ {{ $res->med_id }} ]' 
                                                    value='{{ $res->qty_manual }}'>
                                            </td>

                                        </tr>
                                        @endforeach
                                    </tbody>
                                </table>
                            </div>

                        </div><!-- panel-body -->

                        <div class="panel-footer">
                            @section('submit-buttons')
                                <button type='submit' class="btn btn-primary save">Save</button>
                            @stop
                            @yield('submit-buttons')
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>

@stop

@section('javascript')


<!-- <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script> -->

<script src="https://cdn.datatables.net/buttons/1.6.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src="https://cdn.datatables.net/buttons/1.6.2/js/buttons.html5.min.js"></script>

    <script>
        $(document).ready(function() {
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
                                    //check if type is input using jquery
                                    return $(data).is("input") ? $(data).val(): data;
                                }
                            }
                        }
                    }
                ]
            } );
        } );
    </script>

@stop