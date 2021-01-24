<div style="padding-bottom:5px; margin-top: 15px;">
        @php
            $medicationTypes = [ "Pill", "Liquid", "Syringe" ];
        @endphp

        <div class="panel-heading" style="border-bottom:0;">
            <div class="panel-body" style="padding-top:0;">
                <div class="table-responsive">
                    <table class="dataTable table table-hover">
                        <thead>
                            <tr>
                                <th class="col-md-6">Medication</th>
                                <th>Dose</th>
                                <th>Units/box</th>
                                <th>Type</th>
                                <th>Unit Price</th>
                                <th>Qty Ordered</th>
                                <th>Value Ordered</th>
                                <th>Qty Delivered</th>
                                <th>Value Delivered</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($orders as $suggestedOrder)
                            <tr>
                                <td>{{ $suggestedOrder->medication }}</td>
                                <td>{{ $suggestedOrder->dose }}</td>
                                <td>{{ $suggestedOrder->units }}</td>
                                <td>{{ $medicationTypes[$suggestedOrder->type] }}</td>
                                <td>{{ $suggestedOrder->list_purchase_price }}</td>
                                <td>{{ $suggestedOrder->quantity }}</td>
                                <td>{{ $suggestedOrder->total_price }}</td>
                                <td>{{ $suggestedOrder->quantity_delivered }}</td>
                                <td>{{ $suggestedOrder->value_delivered }}</td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

</div>