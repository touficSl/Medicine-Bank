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
                                <th>Medication</th>
                                <th>Dose</th>
                                <th>Units/box</th>
                                <th>Type</th>
                                <th>Qty Ordered</th>
                                <th>Qty Delivered</th>

                                @if( $from == '2' )
                                    <th>Time delivered</th>
                                @endif
                            </tr>
                        </thead>
                        <tbody>
                            @if( count($medications) == 0 )
                                <tr>
                                    <td>No data available</td>
                                </tr>
                            @endif
                            @foreach($medications as $meds)
                            <tr>
                                <td>{{ $meds->medication }}</td>
                                <td>{{ $meds->dose }}</td>
                                <td>{{ $meds->units }}</td>
                                <td>{{ $medicationTypes[$meds->type] }}</td>
                                <td>{{ $meds->qty_ordered }}</td>

                                <!-- if status = 1 ==> Pending -->
                                @if( $meds->status == 1 )

                                    <td contenteditable="true"><input type='number' name='delivered[ {{ $meds->id }} ]' value='{{ ($meds->qty_delivered == 0) ? $meds->qty_ordered : $meds->qty_delivered}}'></td>

                                <!-- if status = 2 ==> Delivered -->
                                @elseif( $meds->status == 2 )

                                    <td>{{ $meds->qty_delivered }}</td>
                                    <td>{{ $meds->timestamp_delivered }}</td>

                                @endif

                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

</div>