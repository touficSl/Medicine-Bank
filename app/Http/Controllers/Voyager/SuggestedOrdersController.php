<?php

namespace App\Http\Controllers\Voyager;

use Exception;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use TCG\Voyager\Database\Schema\SchemaManager;
use TCG\Voyager\Events\BreadDataAdded;
use TCG\Voyager\Events\BreadDataDeleted;
use TCG\Voyager\Events\BreadDataRestored;
use TCG\Voyager\Events\BreadDataUpdated;
use TCG\Voyager\Events\BreadImagesDeleted;
use TCG\Voyager\Facades\Voyager;
use TCG\Voyager\Http\Controllers\Traits\BreadRelationshipParser;
use TCG\Voyager\Http\Controllers\VoyagerBaseController;
use Carbon\Carbon;
use App\Prescription;
use App\SuggestedOrder;
use App\Medication;
use App\Factory;
use App\Mail\OrderSent;
use App\Order;
use Illuminate\Support\Facades\Mail;

class SuggestedOrdersController extends VoyagerBaseController
{
    use BreadRelationshipParser;

    public $medicationTypes = [ "", "Pill", "Liquid", "Syringe" ];

    //***************************************
    //               ____
    //              |  _ \
    //              | |_) |
    //              |  _ <
    //              | |_) |
    //              |____/
    //
    //      Browse our Data Type (B)READ
    //
    //****************************************

    public function index(Request $request)
    {
        // GET THE SLUG, ex. 'posts', 'pages', etc.
        $slug = $this->getSlug($request);

        // GET THE DataType based on the slug
        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        // Check permission
        $this->authorize('browse', app($dataType->model_name));

        $getter = $dataType->server_side ? 'paginate' : 'get';

        $search = (object) ['value' => $request->get('s'), 'key' => $request->get('key'), 'filter' => $request->get('filter')];

        $searchNames = [];
        if ($dataType->server_side) {
            $searchable = SchemaManager::describeTable(app($dataType->model_name)->getTable())->pluck('name')->toArray();
            $dataRow = Voyager::model('DataRow')->whereDataTypeId($dataType->id)->get();
            foreach ($searchable as $key => $value) {
                $displayName = $dataRow->where('field', $value)->first()->getTranslatedAttribute('display_name');
                $searchNames[$value] = $displayName ?: ucwords(str_replace('_', ' ', $value));
            }
        }

        $orderBy = $request->get('order_by', $dataType->order_column);
        $sortOrder = $request->get('sort_order', null);
        $usesSoftDeletes = false;
        $showSoftDeleted = false;

        // Next Get or Paginate the actual content from the MODEL that corresponds to the slug DataType
        if (strlen($dataType->model_name) != 0) {
            $model = app($dataType->model_name);

            if ($dataType->scope && $dataType->scope != '' && method_exists($model, 'scope'.ucfirst($dataType->scope))) {
                $query = $model->{$dataType->scope}();
            } else {
                $query = $model::select('*');
            }

            // Use withTrashed() if model uses SoftDeletes and if toggle is selected
            if ($model && in_array(SoftDeletes::class, class_uses_recursive($model)) && Auth::user()->can('delete', app($dataType->model_name))) {
                $usesSoftDeletes = true;

                if ($request->get('showSoftDeleted')) {
                    $showSoftDeleted = true;
                    $query = $query->withTrashed();
                }
            }

            // If a column has a relationship associated with it, we do not want to show that field
            $this->removeRelationshipField($dataType, 'browse');

            if ($search->value != '' && $search->key && $search->filter) {
                $search_filter = ($search->filter == 'equals') ? '=' : 'LIKE';
                $search_value = ($search->filter == 'equals') ? $search->value : '%'.$search->value.'%';
                $query->where($search->key, $search_filter, $search_value);
            }

            if ($orderBy && in_array($orderBy, $dataType->fields())) {
                $querySortOrder = (!empty($sortOrder)) ? $sortOrder : 'desc';
                $dataTypeContent = call_user_func([
                    $query->orderBy($orderBy, $querySortOrder),
                    $getter,
                ]);
            } elseif ($model->timestamps) {
                $dataTypeContent = call_user_func([$query->latest($model::CREATED_AT), $getter]);
            } else {
                $dataTypeContent = call_user_func([$query->orderBy($model->getKeyName(), 'DESC'), $getter]);
            }

            // Replace relationships' keys for labels and create READ links if a slug is provided.
            $dataTypeContent = $this->resolveRelations($dataTypeContent, $dataType);
        } else {
            // If Model doesn't exist, get data from table name
            $dataTypeContent = call_user_func([DB::table($dataType->name), $getter]);
            $model = false;
        }

        // Check if BREAD is Translatable
        if (($isModelTranslatable = is_bread_translatable($model))) {
            $dataTypeContent->load('translations');
        }

        // Check if server side pagination is enabled
        $isServerSide = isset($dataType->server_side) && $dataType->server_side;

        // Check if a default search key is set
        $defaultSearchKey = $dataType->default_search_key ?? null;

        // Actions
        $actions = [];
        if (!empty($dataTypeContent->first())) {
            foreach (Voyager::actions() as $action) {
                $action = new $action($dataType, $dataTypeContent->first());

                if ($action->shouldActionDisplayOnDataType()) {
                    $actions[] = $action;
                }
            }
        }

        // Define showCheckboxColumn
        $showCheckboxColumn = false;
        if (Auth::user()->can('delete', app($dataType->model_name))) {
            $showCheckboxColumn = true;
        } else {
            foreach ($actions as $action) {
                if (method_exists($action, 'massAction')) {
                    $showCheckboxColumn = true;
                }
            }
        }

        // Define orderColumn
        $orderColumn = [];
        if ($orderBy) {
            $index = $dataType->browseRows->where('field', $orderBy)->keys()->first() + ($showCheckboxColumn ? 1 : 0);
            $orderColumn = [[$index, 'desc']];
            if (!$sortOrder && isset($dataType->order_direction)) {
                $sortOrder = $dataType->order_direction;
                $orderColumn = [[$index, $dataType->order_direction]];
            } else {
                $orderColumn = [[$index, 'desc']];
            }
        }

        $view = 'voyager::bread.browse';

        if (view()->exists("voyager::$slug.browse")) {
            $view = "voyager::$slug.browse";
        }

        $suggestedOrders = $this->getSuggestedOrders();
        $medications = Medication::all();
        $factories = Factory::all();

        return Voyager::view($view, compact(
            'actions',
            'dataType',
            'dataTypeContent',
            'isModelTranslatable',
            'search',
            'orderBy',
            'orderColumn',
            'sortOrder',
            'searchNames',
            'isServerSide',
            'defaultSearchKey',
            'usesSoftDeletes',
            'showSoftDeleted',
            'showCheckboxColumn',
            'suggestedOrders',
            'medications',
            'factories'
        ));
    }

    /**
     *  Get all active prescriptions and save them to the suggested_orders table if none have been created
     * for the day. Otherwise, just read them from the table.
     */
    private function getSuggestedOrders ()
    {
        // 1. Read the suggested orders from their table if they had been previously created today.
        // $suggestedOrders = $this->queryForTodaysSuggestedOrders();
        // if (count($suggestedOrders) > 0) {
        //     return $suggestedOrders;
        // }

        // 2. Get all active prescriptions.
        $prescriptions = DB::table('prescriptions')
                ->leftJoin('clients', 'clients.id', '=', 'prescriptions.client_id')
                ->leftJoin('medications', 'medications.id', '=', 'prescriptions.medication_id')
                ->select(DB::raw('1 AS quantity, prescriptions.id, prescriptions.start_date, prescriptions.end_date, prescriptions.pills_per_day_prescription, prescriptions.pills_per_day_actual, prescriptions.status AS prescription_status, prescriptions.client_id, prescriptions.medication_id, medications.factory_id, clients.pharmacy_id, prescriptions.created_at, prescriptions.updated_at, 1 AS status'))
                ->where("prescriptions.status", "1")
                ->get();

        // 3. Save today's prescriptions in the suggested_orders table.
        $suggestedOrders = array();
        $currentDate = Carbon::now()->toDateTimeString();
        foreach ($prescriptions as $prescription) {

            // bade yeh ta ma zido : Check if the client has another order and the order is not cancelled
            // ++ sold and timesold in less than 3 weeks
            // ++ his suggested order is not assigned to an order yet 
            $check = DB::select('
                        SELECT client_id, prescription_id, o.id, o.status as order_stat, s.status as sug_status, timestamp_sold,
                                now() - interval 3 week
                        FROM `suggested_orders` as s
                        LEFT JOIN `orders` as o on o.id = s.order_id
                        WHERE client_id = ? and prescription_id = ?
                            and ((o.id is not null and o.status = 4) 
                                or (s.status = 5 and timestamp_sold < now() - interval 3 week) )'
                        , [$prescription->client_id, $prescription->id]);


            if ($check)
                array_push($suggestedOrders, [
                    "prescription_id" => $prescription->id,
                    "start_date" => $prescription->start_date,
                    "end_date" => $prescription->end_date,
                    "pills_per_day_prescription" => $prescription->pills_per_day_prescription,
                    "pills_per_day_actual" => $prescription->pills_per_day_actual,
                    "prescription_status" => $prescription->prescription_status,
                    "client_id" => $prescription->client_id,
                    "medication_id" => $prescription->medication_id,
                    "factory_id" => $prescription->factory_id,
                    "pharmacy_id" => $prescription->pharmacy_id,
                    "created_at_prescription" => $prescription->created_at,
                    "updated_at_prescription" => $prescription->updated_at,
                    "created_at" => $currentDate
                ]);
        }

        DB::table('suggested_orders')->insert($suggestedOrders);

        return $this->queryForTodaysSuggestedOrders();
    }

    /**
     * Query the suggested_orders table for all rows that have been created today.
     */
    private function queryForTodaysSuggestedOrders ()
    {
        return DB::table('suggested_orders')
                ->leftJoin('clients', 'clients.id', '=', 'suggested_orders.client_id')
                ->leftJoin('pharmacies', 'pharmacies.id', '=', 'clients.pharmacy_id')
                ->select(DB::raw('CONCAT(clients.first_name_ar, " ", clients.father_name_ar, " ", clients.last_name_ar) Client, suggested_orders.quantity AS quantity, pharmacies.name_ar AS `To`, suggested_orders.id, suggested_orders.status, suggested_orders.medication_id, suggested_orders.factory_id'))
                ->where(['suggested_orders.order_id' => null])
                // ->orWhere('suggested_orders.status', '=', 4)
                ->get();
    }

    /**
     * POST - Update the factory ID, supplier ID, and status of the SuggestedOrders that have been updated.
     *
     * @param \Illuminate\Http\Request $request
     *
     * @return \Illuminate\Http\RedirectResponse
     */
    public function updateIDs(Request $request)
    {
        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        $idJSON = json_decode($request->input('IDs'), true);
        foreach ($idJSON as $id => $values) {
            $status = ($values['isPutInOrder']) ? 1 : 0;
            $currentDate = Carbon::now()->toDateTimeString();
            DB::table('suggested_orders')
                    ->where('id', $id)
                    ->update([ 'medication_id' => $values['medicationID'], 'quantity' => $values['quantity'], 'factory_id' => $values['factoryID'], 'status' => $status, 'updated_at' => $currentDate ]);
        }
        $redirect = redirect()->back();
        $redirect = redirect()->route("voyager.{$dataType->slug}.show", 0);
        return $redirect->with([
            'message'=> __('voyager::generic.successfully_updated')." 
                            {$dataType->getTranslatedAttribute('display_name_singular')}",
            'alert-type' => 'success',
        ]);
    }

    /**
     * POST - Create all orders from the suggested orders list and send them as emails to the factories.
     *
     * @param \Illuminate\Http\Request $request
     *
     * @return \Illuminate\Http\RedirectResponse
     */
    public function sendOrders(Request $request)
    {
        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        $emailsJSON = $request->input('emails');
        if (isset($emailsJSON)) {
            $emailsJSON = json_decode($emailsJSON, true);
        }

        // 1. Calculate the order values.
        $suggestedOrdersValues = DB::table('suggested_orders')
                ->select(DB::raw('suggested_orders.factory_id, factories.contact_email1 AS `email`, suggested_orders.pharmacy_id, SUM(medications.list_purchase_price) AS `value`'))
                ->leftJoin('clients', 'clients.id', '=', 'suggested_orders.client_id')
                ->leftJoin('medications', 'medications.id', '=', 'suggested_orders.medication_id')
                ->leftJoin('factories', 'factories.id', '=', 'suggested_orders.factory_id')
                ->leftJoin('pharmacies', 'pharmacies.id', '=', 'suggested_orders.pharmacy_id')
                ->where(['suggested_orders.status' => 1])
                ->groupBy('suggested_orders.factory_id', 'suggested_orders.pharmacy_id')
                ->orderBy('suggested_orders.factory_id', 'asc')
                ->orderBy('suggested_orders.pharmacy_id', 'asc')
                ->get();

        $currentDateTime = Carbon::now()->toDateTimeString();
        $salt = 0;
        foreach ($suggestedOrdersValues as $suggestedOrderValue) {
            // 2. Create the order.
            // TODO Make sure this order number is unique before using it.
            $orderNumber = strtoupper(substr(sha1(time() + ++$salt), 0, 12));
            $orderID = DB::table('orders')
                        ->insertGetId(['timestamp_ordered' => $currentDateTime, 'status' => 1,
                            'total_value_ordered' => $suggestedOrderValue->value, 'number' => $orderNumber,
                            'factory_id' => $suggestedOrderValue->factory_id, 'created_at' => $currentDateTime,
                            'pharmacy_id' => $suggestedOrderValue->pharmacy_id]);

            // 3. Update the statuses in the suggested_orders table as well as the new order_id.
            DB::table('suggested_orders')
                    ->where(['status' => 1, 'factory_id' => $suggestedOrderValue->factory_id, 
                                'pharmacy_id' => $suggestedOrderValue->pharmacy_id])
                    ->update([ 'order_id' => $orderID, 'status' => 2, 'updated_at' => $currentDateTime ]);

            // 3.1 Add data to orderd medications table -- Rhea 
            $ordered_medications = DB::table('suggested_orders')
                        ->select(DB::raw('sum(quantity) as qty, medication_id', 'order_id'))
                        ->where(['status' => 2, 'order_id' => $orderID, 'updated_at' => $currentDateTime])
                        ->groupBy(['medication_id', 'order_id'])
                        ->get();

            foreach ($ordered_medications as $ord_med) {
                DB::table('ordered_medications')
                        ->insert(['medication_id' => $ord_med->medication_id, 'order_id' => $orderID, 
                            'qty_ordered' => $ord_med->qty, 'created_at' => $currentDateTime]);
            }

            // 4. Gather the order summary.
            $orders = $this->getOrderSummary($orderID);

            // 5. Send an email to the factory.
            // Mail::to($suggestedOrderValue->email)->send(new OrderSent($order));
            $emails = $emailsJSON[$suggestedOrderValue->factory_id . "-" . $suggestedOrderValue->pharmacy_id];
            if (!isset($emails) || is_null($emails) || $emails == "") {

                $emails = [];
                array_push($emails, $orders[0]->factory_email1);
                if (isset($orders[0]->factory_email2)) {
                    array_push($emails, $orders[0]->factory_email2);
                }

            } else {
                $emails = explode(",", $emails);
            }

            $this->sendOrdersEmail($orders, $emails);
        }

        $redirect = redirect('/admin/suggested-orders');
        return $redirect->with([
                    'message'    => "Orders sent to factories",
                    'alert-type' => 'success',
                ]);
    }

    public static function getOrderSummary($orderID) {
        return DB::table('suggested_orders')
            ->leftJoin('orders', 'orders.id', '=', 'suggested_orders.order_id')
            ->leftJoin('medications', 'medications.id', '=', 'suggested_orders.medication_id')
            ->leftJoin('factories', 'factories.id', '=', 'suggested_orders.factory_id')
            ->leftJoin('pharmacies', 'pharmacies.id', '=', 'suggested_orders.pharmacy_id')
            ->select(DB::raw('
                orders.number,
                factories.name_ar AS `factory_name`,
                factories.contact_email1 AS `factory_email1`,
                factories.contact_email2 AS `factory_email2`,
                pharmacies.name_ar AS `pharmacy_name`,
                pharmacies.contact_phone1 AS `pharmacy_phone`,
                pharmacies.address_ar AS `pharmacy_address`,
                pharmacies.contact_email1 AS `pharmacy_email1`,
                pharmacies.contact_email2 AS `pharmacy_email2`,
                medications.brand AS `medication`,
                medications.dose_per_tablet AS `dose`,
                medications.quantity_of_tablets AS `units`,
                medications.type AS `type`,
                medications.list_purchase_price,
                SUM(medications.list_purchase_price) AS total_price,
                SUM(suggested_orders.quantity) AS `quantity`,
                suggested_orders.quantity_delivered,
                suggested_orders.value_delivered'
            ))
            ->where('suggested_orders.order_id', '=', $orderID)
            ->groupBy('orders.number', 'factories.name_ar', 'factories.contact_email1', 'factories.contact_email2', 'pharmacies.name_ar', 'pharmacies.contact_phone1', 'pharmacies.address_ar', 'pharmacies.contact_email1', 'pharmacies.contact_email2', 'medications.brand', 'medications.dose_per_tablet', 'medications.quantity_of_tablets', 'medications.type', 'medications.list_purchase_price', 'suggested_orders.quantity_delivered', 'suggested_orders.value_delivered')
            ->orderBy('suggested_orders.medication_id', 'asc')
            ->get();
    }

    private function sendOrdersEmail($orders, $emails) {
        // Always set content-type when sending HTML email
        $headers = "MIME-Version: 1.0" . "\r\n";
        $headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";

        // More headers
        $headers .= 'From: Orders-MB-Jordan <orders@nabedjo.com>'. "\r\n";
        //Multiple CC can be added, if we need (comma separated).  $headers .= 'Cc: myboss1@example.com, myboss2@example.com' . "\r\n";
        // $headers .= 'Cc: iotsprint@iotsprint.com' . "\r\n";
        //Multiple BCC can be send same as CC above. 
        // $headers .= 'Bcc: ziadbak@gmail.com' . "\r\n";
        $to = $emails[0];
        $emailCount = count($emails);
        if ($emailCount > 1) {
            for ($i=1; $i<$emailCount; $i++) {
                $headers .= 'Cc: ' . $emails[$i] . "\r\n";
            }
        }

        // $to = $orders[0]->factory_email1;//"abdallah.chamas@gmail.com";
        //$from = "MB-Jordan";
        $subject = "MB-Jordan Order";
        $message = "
        <html>
        <head>
        <title>MB-Jordan Order</title>
        </head>
        <body>
        <p>
            <b>Order Number</b> " . $orders[0]->number. "<br/>
            <b>Supplier</b> " . $orders[0]->factory_name. "<br/>
            <b>Placed by</b> NABEDJO.COM<br/>
            <b>Placed by user</b> " . auth()->user()->name . "<br/>
            <b>Deliver to</b> " . $orders[0]->pharmacy_name . " - " . $orders[0]->pharmacy_phone . "
        </p>
        <br/>
        <table style=\"border: 1px solid black; border-collapse: collapse;\">
            <tr>
                <th>Medication</th>
                <th>Dose</th>
                <th>Units/box</th>
                <th>Type</th>
                <th>Qty</th>
                <th>Unit Price</th>
                <th>Total Price</th>
                <th>Currency</th>
            </tr>";
        $totalPrice = 0;
        foreach ($orders as $order) {
            $totalPrice += $order->list_purchase_price * $order->quantity;
            $message .= "<tr>
                <td>" . $order->medication . "</td>
                <td>" . $order->dose . "</td>
                <td>" . $order->units . "</td>
                <td>" . ((!is_null($order->type)) ? $this->medicationTypes[$order->type] : $this->medicationTypes[0]) . "</td>
                <td>" . $order->quantity . "</td>
                <td>" . $order->list_purchase_price . "</td>
                <td>" . ($order->list_purchase_price * $order->quantity) . "</td>
                <td>JD</td>
            </tr>";
        }
        $message .= "<tr><td></td><td></td><td></td><td></td><td></td><td>Total</td><td>" . $totalPrice . "</td><td>JD</td></tr>";
        $message .= "</table>
        <p>Note: Please respond to this email by providing a delivery a delivery date for this order.</p>
        </body>
        </html>";

        // return mail("rhea_saade@hotmail.com", $subject, $message, $headers);
        //Mail::send('emails.orders.sent',[], function ($message) {
        //$message->from('orders@nabedjo.com','Nabedjo');
        //$message->to('abdallah.chamas@gmail.com ');
        //$message->subject('Contact form submitted on LOCAL nabedjo.com');
        //});
    }

    //***************************************
    //                _____
    //               |  __ \
    //               | |__) |
    //               |  _  /
    //               | | \ \
    //               |_|  \_\
    //
    //  Read an item of our Data Type B(R)EAD
    //
    //****************************************

    public function show(Request $request, $id)
    {
        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        if ($id == 0) {
            // 1. Get the suggested orders with a 'status = 1' and group them by factory, medication, and pharmacy.
            $suggestedOrders = DB::table('suggested_orders')
                    ->leftJoin('factories', 'factories.id', '=', 'suggested_orders.factory_id')
                    ->leftJoin('pharmacies', 'pharmacies.id', '=', 'suggested_orders.pharmacy_id')
                    ->leftJoin('medications', 'medications.id', '=', 'suggested_orders.medication_id')
                    ->select(DB::raw('
                        suggested_orders.factory_id,
                        factories.name_ar AS `factory`,
                        factories.contact_email1 AS `factory_email1`,
                        factories.contact_email2 AS `factory_email2`,
                        suggested_orders.pharmacy_id,
                        pharmacies.name_ar AS `pharmacy_name`,
                        pharmacies.contact_phone1 AS `pharmacy_phone`,
                        medications.brand AS `medication`,
                        medications.dose_per_tablet AS `dose`,
                        medications.quantity_of_tablets AS `units`,
                        medications.type AS `type`,
                        medications.list_purchase_price,
                        SUM(suggested_orders.quantity) AS `quantity`'))
                    ->where('suggested_orders.status', '=', 1)
                    ->groupBy('suggested_orders.factory_id', 'factories.name_ar', 'factories.contact_email1', 'factories.contact_email2', 'suggested_orders.pharmacy_id', 'pharmacies.name_ar', 'pharmacies.contact_phone1', 'medications.brand', 'medications.dose_per_tablet', 'medications.quantity_of_tablets', 'medications.type', 'medications.list_purchase_price')
                    ->orderBy('suggested_orders.factory_id', 'asc')
                    ->orderBy('suggested_orders.pharmacy_id', 'asc')
                    ->orderBy('suggested_orders.medication_id', 'asc')
                    ->get();

            // 2. Format the data for viewing.
            $suggestedOrdersByFactoryPharmacy = [];
            $totalOrderPrice = 0;
            foreach ($suggestedOrders as $value) {
                if (!isset($suggestedOrdersByFactoryPharmacy[$value->factory])) {
                    $suggestedOrdersByFactoryPharmacy[$value->factory] = [ "factory_name" => $value->factory, "factory_id" => $value->factory_id, "placed_by_user" => auth()->user()->name, "factory_email1" => $value->factory_email1, "factory_email2" => $value->factory_email2 ];
                }
                if (!isset($suggestedOrdersByFactoryPharmacy[$value->factory][$value->pharmacy_name])) {
                    $suggestedOrdersByFactoryPharmacy[$value->factory][$value->pharmacy_name] = [ "pharmacy_name" => $value->pharmacy_name . " - " . $value->pharmacy_phone, "total_order_price" => 0, "pharmacy_id" => $value->pharmacy_id ];
                }
                array_push($suggestedOrdersByFactoryPharmacy[$value->factory][$value->pharmacy_name], [
                    'medication' => $value->medication,
                    'dose' => $value->dose,
                    'units' => $value->units,
                    'type' => ((!is_null($value->type)) ? $this->medicationTypes[$value->type] : $this->medicationTypes[0]),
                    'quantity' => $value->quantity,
                    'unitPrice' => $value->list_purchase_price,
                    'totalPrice' => ($value->list_purchase_price * $value->quantity)
                ]);
                $suggestedOrdersByFactoryPharmacy[$value->factory][$value->pharmacy_name]["total_order_price"] += ($value->list_purchase_price * $value->quantity);
            }
            $suggestedOrders = $suggestedOrdersByFactoryPharmacy;

// echo "<pre>";
// var_dump($suggestedOrders);
// echo "</pre>";
// 5/0;
// dd("aasddd");
            $view = 'voyager::suggested-orders.read';
            return Voyager::view($view, compact('dataType', 'suggestedOrders'));
        } elseif ($id != 0) {
            $isSoftDeleted = false;

            if (strlen($dataType->model_name) != 0) {
                $model = app($dataType->model_name);

                // Use withTrashed() if model uses SoftDeletes and if toggle is selected
                if ($model && in_array(SoftDeletes::class, class_uses_recursive($model))) {
                    $model = $model->withTrashed();
                }
                if ($dataType->scope && $dataType->scope != '' && method_exists($model, 'scope'.ucfirst($dataType->scope))) {
                    $model = $model->{$dataType->scope}();
                }
                $dataTypeContent = call_user_func([$model, 'findOrFail'], $id);
                if ($dataTypeContent->deleted_at) {
                    $isSoftDeleted = true;
                }
            } else {
                // If Model doest exist, get data from table name
                $dataTypeContent = DB::table($dataType->name)->where('id', $id)->first();
            }

            // Replace relationships' keys for labels and create READ links if a slug is provided.
            $dataTypeContent = $this->resolveRelations($dataTypeContent, $dataType, true);

            // If a column has a relationship associated with it, we do not want to show that field
            $this->removeRelationshipField($dataType, 'read');

            // Check permission
            $this->authorize('read', $dataTypeContent);

            // Check if BREAD is Translatable
            $isModelTranslatable = is_bread_translatable($dataTypeContent);

            $view = 'voyager::bread.read';

            if (view()->exists("voyager::$slug.read")) {
                $view = "voyager::$slug.read";
            }

            return Voyager::view($view, compact('dataType', 'dataTypeContent', 'isModelTranslatable', 'isSoftDeleted'));
        }
    }

    //***************************************
    //                ______
    //               |  ____|
    //               | |__
    //               |  __|
    //               | |____
    //               |______|
    //
    //  Edit an item of our Data Type BR(E)AD
    //
    //****************************************

    public function edit(Request $request, $id)
    {
        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        if (strlen($dataType->model_name) != 0) {
            $model = app($dataType->model_name);

            // Use withTrashed() if model uses SoftDeletes and if toggle is selected
            if ($model && in_array(SoftDeletes::class, class_uses_recursive($model))) {
                $model = $model->withTrashed();
            }
            if ($dataType->scope && $dataType->scope != '' && method_exists($model, 'scope'.ucfirst($dataType->scope))) {
                $model = $model->{$dataType->scope}();
            }
            $dataTypeContent = call_user_func([$model, 'findOrFail'], $id);
        } else {
            // If Model doest exist, get data from table name
            $dataTypeContent = DB::table($dataType->name)->where('id', $id)->first();
        }

        foreach ($dataType->editRows as $key => $row) {
            $dataType->editRows[$key]['col_width'] = isset($row->details->width) ? $row->details->width : 100;
        }

        // If a column has a relationship associated with it, we do not want to show that field
        $this->removeRelationshipField($dataType, 'edit');

        // Check permission
        $this->authorize('edit', $dataTypeContent);

        // Check if BREAD is Translatable
        $isModelTranslatable = is_bread_translatable($dataTypeContent);

        $view = 'voyager::bread.edit-add';

        if (view()->exists("voyager::$slug.edit-add")) {
            $view = "voyager::$slug.edit-add";
        }

        return Voyager::view($view, compact('dataType', 'dataTypeContent', 'isModelTranslatable'));
    }

    // POST BR(E)AD
    public function update(Request $request, $id)
    {
        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        // Compatibility with Model binding.
        $id = $id instanceof \Illuminate\Database\Eloquent\Model ? $id->{$id->getKeyName()} : $id;

        $model = app($dataType->model_name);
        if ($dataType->scope && $dataType->scope != '' && method_exists($model, 'scope'.ucfirst($dataType->scope))) {
            $model = $model->{$dataType->scope}();
        }
        if ($model && in_array(SoftDeletes::class, class_uses_recursive($model))) {
            $data = $model->withTrashed()->findOrFail($id);
        } else {
            $data = call_user_func([$dataType->model_name, 'findOrFail'], $id);
        }

        // Check permission
        $this->authorize('edit', $data);

        // Validate fields with ajax
        $val = $this->validateBread($request->all(), $dataType->editRows, $dataType->name, $id)->validate();
        $this->insertUpdateData($request, $slug, $dataType->editRows, $data);

        event(new BreadDataUpdated($dataType, $data));

        if (auth()->user()->can('browse', $model)) {
            $redirect = redirect()->route("voyager.{$dataType->slug}.index");
        } else {
            $redirect = redirect()->back();
        }

        return $redirect->with([
            'message'    => __('voyager::generic.successfully_updated')." {$dataType->getTranslatedAttribute('display_name_singular')}",
            'alert-type' => 'success',
        ]);
    }

    //***************************************
    //
    //                   /\
    //                  /  \
    //                 / /\ \
    //                / ____ \
    //               /_/    \_\
    //
    //
    // Add a new item of our Data Type BRE(A)D
    //
    //****************************************

    public function create(Request $request)
    {
        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        // Check permission
        $this->authorize('add', app($dataType->model_name));

        $dataTypeContent = (strlen($dataType->model_name) != 0)
                            ? new $dataType->model_name()
                            : false;

        foreach ($dataType->addRows as $key => $row) {
            $dataType->addRows[$key]['col_width'] = $row->details->width ?? 100;
        }

        // If a column has a relationship associated with it, we do not want to show that field
        $this->removeRelationshipField($dataType, 'add');

        // Check if BREAD is Translatable
        $isModelTranslatable = is_bread_translatable($dataTypeContent);

        $view = 'voyager::bread.edit-add';

        if (view()->exists("voyager::$slug.edit-add")) {
            $view = "voyager::$slug.edit-add";
        }

        return Voyager::view($view, compact('dataType', 'dataTypeContent', 'isModelTranslatable'));
    }

    /**
     * POST BRE(A)D - Store data.
     *
     * @param \Illuminate\Http\Request $request
     *
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(Request $request)
    {
        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        // Check permission
        $this->authorize('add', app($dataType->model_name));

        // Validate fields with ajax
        $val = $this->validateBread($request->all(), $dataType->addRows)->validate();
        $data = $this->insertUpdateData($request, $slug, $dataType->addRows, new $dataType->model_name());

        event(new BreadDataAdded($dataType, $data));

        if (!$request->has('_tagging')) {
            if (auth()->user()->can('browse', $data)) {
                $redirect = redirect()->route("voyager.{$dataType->slug}.index");
            } else {
                $redirect = redirect()->back();
            }

            return $redirect->with([
                    'message'    => __('voyager::generic.successfully_added_new')." {$dataType->getTranslatedAttribute('display_name_singular')}",
                    'alert-type' => 'success',
                ]);
        } else {
            return response()->json(['success' => true, 'data' => $data]);
        }
    }

    //***************************************
    //                _____
    //               |  __ \
    //               | |  | |
    //               | |  | |
    //               | |__| |
    //               |_____/
    //
    //         Delete an item BREA(D)
    //
    //****************************************

    public function destroy(Request $request, $id)
    {
        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        // Check permission
        $this->authorize('delete', app($dataType->model_name));

        // Init array of IDs
        $ids = [];
        if (empty($id)) {
            // Bulk delete, get IDs from POST
            $ids = explode(',', $request->ids);
        } else {
            // Single item delete, get ID from URL
            $ids[] = $id;
        }
        foreach ($ids as $id) {
            $data = call_user_func([$dataType->model_name, 'findOrFail'], $id);

            $model = app($dataType->model_name);
            if (!($model && in_array(SoftDeletes::class, class_uses_recursive($model)))) {
                $this->cleanup($dataType, $data);
            }
        }

        $displayName = count($ids) > 1 ? $dataType->getTranslatedAttribute('display_name_plural') : $dataType->getTranslatedAttribute('display_name_singular');

        $res = $data->destroy($ids);
        $data = $res
            ? [
                'message'    => __('voyager::generic.successfully_deleted')." {$displayName}",
                'alert-type' => 'success',
            ]
            : [
                'message'    => __('voyager::generic.error_deleting')." {$displayName}",
                'alert-type' => 'error',
            ];

        if ($res) {
            event(new BreadDataDeleted($dataType, $data));
        }

        return redirect()->route("voyager.{$dataType->slug}.index")->with($data);
    }

    public function restore(Request $request, $id)
    {
        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        // Check permission
        $this->authorize('delete', app($dataType->model_name));

        // Get record
        $model = call_user_func([$dataType->model_name, 'withTrashed']);
        if ($dataType->scope && $dataType->scope != '' && method_exists($model, 'scope'.ucfirst($dataType->scope))) {
            $model = $model->{$dataType->scope}();
        }
        $data = $model->findOrFail($id);

        $displayName = $dataType->getTranslatedAttribute('display_name_singular');

        $res = $data->restore($id);
        $data = $res
            ? [
                'message'    => __('voyager::generic.successfully_restored')." {$displayName}",
                'alert-type' => 'success',
            ]
            : [
                'message'    => __('voyager::generic.error_restoring')." {$displayName}",
                'alert-type' => 'error',
            ];

        if ($res) {
            event(new BreadDataRestored($dataType, $data));
        }

        return redirect()->route("voyager.{$dataType->slug}.index")->with($data);
    }

    //***************************************
    //
    //  Delete uploaded file
    //
    //****************************************

    public function remove_media(Request $request)
    {
        try {
            // GET THE SLUG, ex. 'posts', 'pages', etc.
            $slug = $request->get('slug');

            // GET file name
            $filename = $request->get('filename');

            // GET record id
            $id = $request->get('id');

            // GET field name
            $field = $request->get('field');

            // GET multi value
            $multi = $request->get('multi');

            $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

            // Load model and find record
            $model = app($dataType->model_name);
            $data = $model::find([$id])->first();

            // Check if field exists
            if (!isset($data->{$field})) {
                throw new Exception(__('voyager::generic.field_does_not_exist'), 400);
            }

            // Check permission
            $this->authorize('edit', $data);

            if (@json_decode($multi)) {
                // Check if valid json
                if (is_null(@json_decode($data->{$field}))) {
                    throw new Exception(__('voyager::json.invalid'), 500);
                }

                // Decode field value
                $fieldData = @json_decode($data->{$field}, true);
                $key = null;

                // Check if we're dealing with a nested array for the case of multiple files
                if (is_array($fieldData[0])) {
                    foreach ($fieldData as $index=>$file) {
                        // file type has a different structure than images
                        if (!empty($file['original_name'])) {
                            if ($file['original_name'] == $filename) {
                                $key = $index;
                                break;
                            }
                        } else {
                            $file = array_flip($file);
                            if (array_key_exists($filename, $file)) {
                                $key = $index;
                                break;
                            }
                        }
                    }
                } else {
                    $key = array_search($filename, $fieldData);
                }

                // Check if file was found in array
                if (is_null($key) || $key === false) {
                    throw new Exception(__('voyager::media.file_does_not_exist'), 400);
                }

                $fileToRemove = $fieldData[$key]['download_link'] ?? $fieldData[$key];

                // Remove file from array
                unset($fieldData[$key]);

                // Generate json and update field
                $data->{$field} = empty($fieldData) ? null : json_encode(array_values($fieldData));
            } else {
                if ($filename == $data->{$field}) {
                    $fileToRemove = $data->{$field};

                    $data->{$field} = null;
                } else {
                    throw new Exception(__('voyager::media.file_does_not_exist'), 400);
                }
            }

            $row = $dataType->rows->where('field', $field)->first();

            // Remove file from filesystem
            if (in_array($row->type, ['image', 'multiple_images'])) {
                $this->deleteBreadImages($data, [$row], $fileToRemove);
            } else {
                $this->deleteFileIfExists($fileToRemove);
            }

            $data->save();

            return response()->json([
               'data' => [
                   'status'  => 200,
                   'message' => __('voyager::media.file_removed'),
               ],
            ]);
        } catch (Exception $e) {
            $code = 500;
            $message = __('voyager::generic.internal_error');

            if ($e->getCode()) {
                $code = $e->getCode();
            }

            if ($e->getMessage()) {
                $message = $e->getMessage();
            }

            return response()->json([
                'data' => [
                    'status'  => $code,
                    'message' => $message,
                ],
            ], $code);
        }
    }

    /**
     * Remove translations, images and files related to a BREAD item.
     *
     * @param \Illuminate\Database\Eloquent\Model $dataType
     * @param \Illuminate\Database\Eloquent\Model $data
     *
     * @return void
     */
    protected function cleanup($dataType, $data)
    {
        // Delete Translations, if present
        if (is_bread_translatable($data)) {
            $data->deleteAttributeTranslations($data->getTranslatableAttributes());
        }

        // Delete Images
        $this->deleteBreadImages($data, $dataType->deleteRows->whereIn('type', ['image', 'multiple_images']));

        // Delete Files
        foreach ($dataType->deleteRows->where('type', 'file') as $row) {
            if (isset($data->{$row->field})) {
                foreach (json_decode($data->{$row->field}) as $file) {
                    $this->deleteFileIfExists($file->download_link);
                }
            }
        }

        // Delete media-picker files
        $dataType->rows->where('type', 'media_picker')->where('details.delete_files', true)->each(function ($row) use ($data) {
            $content = $data->{$row->field};
            if (isset($content)) {
                if (!is_array($content)) {
                    $content = json_decode($content);
                }
                if (is_array($content)) {
                    foreach ($content as $file) {
                        $this->deleteFileIfExists($file);
                    }
                } else {
                    $this->deleteFileIfExists($content);
                }
            }
        });
    }

    /**
     * Delete all images related to a BREAD item.
     *
     * @param \Illuminate\Database\Eloquent\Model $data
     * @param \Illuminate\Database\Eloquent\Model $rows
     *
     * @return void
     */
    public function deleteBreadImages($data, $rows, $single_image = null)
    {
        $imagesDeleted = false;

        foreach ($rows as $row) {
            if ($row->type == 'multiple_images') {
                $images_to_remove = json_decode($data->getOriginal($row->field), true) ?? [];
            } else {
                $images_to_remove = [$data->getOriginal($row->field)];
            }

            foreach ($images_to_remove as $image) {
                // Remove only $single_image if we are removing from bread edit
                if ($image != config('voyager.user.default_avatar') && (is_null($single_image) || $single_image == $image)) {
                    $this->deleteFileIfExists($image);
                    $imagesDeleted = true;

                    if (isset($row->details->thumbnails)) {
                        foreach ($row->details->thumbnails as $thumbnail) {
                            $ext = explode('.', $image);
                            $extension = '.'.$ext[count($ext) - 1];

                            $path = str_replace($extension, '', $image);

                            $thumb_name = $thumbnail->name;

                            $this->deleteFileIfExists($path.'-'.$thumb_name.$extension);
                        }
                    }
                }
            }
        }

        if ($imagesDeleted) {
            event(new BreadImagesDeleted($data, $rows));
        }
    }

    /**
     * Order BREAD items.
     *
     * @param string $table
     *
     * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
     */
    public function order(Request $request)
    {
        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        // Check permission
        $this->authorize('edit', app($dataType->model_name));

        if (!isset($dataType->order_column) || !isset($dataType->order_display_column)) {
            return redirect()
            ->route("voyager.{$dataType->slug}.index")
            ->with([
                'message'    => __('voyager::bread.ordering_not_set'),
                'alert-type' => 'error',
            ]);
        }

        $model = app($dataType->model_name);
        if ($model && in_array(SoftDeletes::class, class_uses_recursive($model))) {
            $model = $model->withTrashed();
        }
        $results = $model->orderBy($dataType->order_column, $dataType->order_direction)->get();

        $display_column = $dataType->order_display_column;

        $dataRow = Voyager::model('DataRow')->whereDataTypeId($dataType->id)->whereField($display_column)->first();

        $view = 'voyager::bread.order';

        if (view()->exists("voyager::$slug.order")) {
            $view = "voyager::$slug.order";
        }

        return Voyager::view($view, compact(
            'dataType',
            'display_column',
            'dataRow',
            'results'
        ));
    }

    public function update_order(Request $request)
    {
        $slug = $this->getSlug($request);

        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        // Check permission
        $this->authorize('edit', app($dataType->model_name));

        $model = app($dataType->model_name);

        $order = json_decode($request->input('order'));
        $column = $dataType->order_column;
        foreach ($order as $key => $item) {
            if ($model && in_array(SoftDeletes::class, class_uses_recursive($model))) {
                $i = $model->withTrashed()->findOrFail($item->id);
            } else {
                $i = $model->findOrFail($item->id);
            }
            $i->$column = ($key + 1);
            $i->save();
        }
    }

    public function action(Request $request)
    {
        $slug = $this->getSlug($request);
        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        $action = new $request->action($dataType, null);

        return $action->massAction(explode(',', $request->ids), $request->headers->get('referer'));
    }

    /**
     * Get BREAD relations data.
     *
     * @param Request $request
     *
     * @return mixed
     */
    public function relation(Request $request)
    {
        $slug = $this->getSlug($request);
        $page = $request->input('page');
        $on_page = 50;
        $search = $request->input('search', false);
        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        $method = $request->input('method', 'add');

        $model = app($dataType->model_name);
        if ($method != 'add') {
            $model = $model->find($request->input('id'));
        }

        $this->authorize($method, $model);

        $rows = $dataType->{$method.'Rows'};
        foreach ($rows as $key => $row) {
            if ($row->field === $request->input('type')) {
                $options = $row->details;
                $model = app($options->model);
                $skip = $on_page * ($page - 1);

                // If search query, use LIKE to filter results depending on field label
                if ($search) {
                    // If we are using additional_attribute as label
                    if (in_array($options->label, $model->additional_attributes ?? [])) {
                        $relationshipOptions = $model->all();
                        $relationshipOptions = $relationshipOptions->filter(function ($model) use ($search, $options) {
                            return stripos($model->{$options->label}, $search) !== false;
                        });
                        $total_count = $relationshipOptions->count();
                        $relationshipOptions = $relationshipOptions->forPage($page, $on_page);
                    } else {
                        $total_count = $model->where($options->label, 'LIKE', '%'.$search.'%')->count();
                        $relationshipOptions = $model->take($on_page)->skip($skip)
                            ->where($options->label, 'LIKE', '%'.$search.'%')
                            ->get();
                    }
                } else {
                    $total_count = $model->count();
                    $relationshipOptions = $model->take($on_page)->skip($skip)->get();
                }

                $results = [];

                if (!$row->required && !$search) {
                    $results[] = [
                        'id'   => '',
                        'text' => __('voyager::generic.none'),
                    ];
                }

                foreach ($relationshipOptions as $relationshipOption) {
                    $results[] = [
                        'id'   => $relationshipOption->{$options->key},
                        'text' => $relationshipOption->{$options->label},
                    ];
                }

                return response()->json([
                    'results'    => $results,
                    'pagination' => [
                        'more' => ($total_count > ($skip + $on_page)),
                    ],
                ]);
            }
        }

        // No result found, return empty array
        return response()->json([], 404);
    }
}
