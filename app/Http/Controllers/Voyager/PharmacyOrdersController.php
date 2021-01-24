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
use App\Http\Controllers\Voyager\SuggestedOrdersController;
use App\Order;

class PharmacyOrdersController extends VoyagerBaseController
{
    use BreadRelationshipParser;

    public function pending (Request $request) 
    {
        // GET THE SLUG, ex. 'posts', 'pages', etc.
        $slug = 'pending_orders';

        // GET THE DataType based on the slug
        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        // Check permission
        $this->checkPermission('browse_' . $slug);

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
                // Status = Confirmed
                $query = $model::select('*')->where(['status' => 1, 'pharmacy_id' => Auth::user()->pharmacy_id]);
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

        // Rhea, only allow view orders
        $action = "TCG\Voyager\Actions\ViewAction";
        $action = new $action($dataType, $dataTypeContent->first());

        if ($action->shouldActionDisplayOnDataType()) {
            $actions[] = $action;
        }

        // Status of the order formatted for display.
        $orderStatusForDisplay = ucfirst($request->get('ordersType'));

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

        $view = 'voyager::pending_orders.browse';

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
            'orderStatusForDisplay'
        ));
    }

    public function view_pending_order ($order_id)
    {
        // $slug = $this->getSlug($request);
        $slug = "orders";

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
            $dataTypeContent = call_user_func([$model, 'findOrFail'], $order_id);
        } else {
            // If Model doest exist, get data from table name
            $dataTypeContent = DB::table($dataType->name)->where('id', $order_id)->first();
        }

        foreach ($dataType->editRows as $key => $row) {
            $dataType->editRows[$key]['col_width'] = isset($row->details->width) ? $row->details->width : 100;
        }

        // If a column has a relationship associated with it, we do not want to show that field
        $this->removeRelationshipField($dataType, 'edit');

        // Check permission
        $this->authorize('read', $dataTypeContent);

        // Check if BREAD is Translatable
        $isModelTranslatable = is_bread_translatable($dataTypeContent);

        // Order medications
        $medications =  DB::table('ordered_medications')
                            ->leftJoin('orders', 'orders.id', '=', 'ordered_medications.order_id')
                            ->leftJoin('medications', 'medications.id', '=', 'ordered_medications.medication_id')
                            ->select(DB::raw('
                                ordered_medications.id,
                                medications.brand AS `medication`,
                                medications.dose_per_tablet AS `dose`,
                                medications.quantity_of_tablets AS `units`,
                                medications.type AS `type`,
                                ordered_medications.qty_delivered,
                                ordered_medications.qty_ordered,
                                orders.timestamp_delivered,
                                orders.status'
                            ))
                            ->where('ordered_medications.order_id', '=', $order_id)
                            ->get();


        $view = 'voyager::pending_orders.view-order';

        return Voyager::view($view, compact('dataType', 'dataTypeContent', 'isModelTranslatable', 'medications'));
    }

    public function confirm_delivery (Request $request)
    {
        $delivered = $request['delivered'];

        $value_delivered = 0;
        foreach ($delivered as $key => $value) {
            // Using wholesale price to calculate the total value of the order
            $ordmed_upd = \App\OrderedMedication::find($key);

            $med = \App\Medication::find($ordmed_upd->medication_id);
            $price = $med->wholesale_price;

            $value_delivered += $price * $value;

            $ordmed_upd->qty_delivered = $value;

            $ordmed_upd->save();

            // Add to stock
            $stock = \App\Stock::select('qty_manual', 'qty_auto')
                            ->where(['medication_id' => $ordmed_upd->medication_id, 'pharmacy_id' => Auth::user()->pharmacy_id])
                            ->orderBy('created_at', 'desc')
                            ->first();


            $new_stock = new \App\Stock;
            $new_stock->pharmacy_id = Auth::user()->pharmacy_id;
            $new_stock->medication_id = $ordmed_upd->medication_id;

            if ($stock) {
                $new_stock->qty_manual = $stock->qty_manual;
                $new_stock->qty_auto = $stock->qty_auto + $value; // Value is the quantity delivered

            } else {
                $new_stock->qty_manual = 0;
                $new_stock->qty_auto = $value; // Value is the quantity delivered
            }

            $new_stock->save();

            $sugg_ord = \App\SuggestedOrder::select('*')
                            ->where('medication_id', $ordmed_upd->medication_id)
                            ->where('order_id', $ordmed_upd->order_id)
                            ->where('pharmacy_id', Auth::user()->pharmacy_id)
                            ->get();

            $i = 0;
            foreach ($sugg_ord as $sugg) {

                if ($i < $value) 
                    $sugg->status = 3; // Pickup pending 
                else
                    $sugg->status = 6; // Mismatch in delivery

                $sugg->save();

                $i += $sugg->quantity;
            }

        }

        $ord_upd = \App\Order::find($ordmed_upd->order_id);
        $ord_upd->timestamp_delivered = now();
        $ord_upd->total_value_delivered = $value_delivered;
        $ord_upd->status = 2;
        $ord_upd->save();
        
        $redirect = redirect()->route("pending-orders");

        return $redirect->with([
            'message'    => __('voyager::generic.successfully_updated'),
            'alert-type' => 'success',
        ]);
    }

    public function delivered (Request $request) 
    {
        // GET THE SLUG, ex. 'posts', 'pages', etc.
        $slug = 'delivered_orders';

        // GET THE DataType based on the slug
        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first();

        // Check permission
        $this->checkPermission('browse_' . $slug);

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
                // Delivered
                $query = $model::select('*')->where(['status' => 2, 'pharmacy_id' => Auth::user()->pharmacy_id]);
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

        // Rhea, only allow view orders
        $action = "TCG\Voyager\Actions\ViewAction";
        $action = new $action($dataType, $dataTypeContent->first());

        if ($action->shouldActionDisplayOnDataType()) {
            $actions[] = $action;
        }

        // Status of the order formatted for display.
        $orderStatusForDisplay = ucfirst($request->get('ordersType'));

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

        $view = 'voyager::delivered_orders.browse';

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
            'orderStatusForDisplay'
        ));
    }

    public function view_delivered ($order_id)
    {
        // $slug = $this->getSlug($request);
        $slug = "orders";

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
            $dataTypeContent = call_user_func([$model, 'findOrFail'], $order_id);
        } else {
            // If Model doest exist, get data from table name
            $dataTypeContent = DB::table($dataType->name)->where('id', $order_id)->first();
        }

        foreach ($dataType->editRows as $key => $row) {
            $dataType->editRows[$key]['col_width'] = isset($row->details->width) ? $row->details->width : 100;
        }

        // If a column has a relationship associated with it, we do not want to show that field
        $this->removeRelationshipField($dataType, 'edit');

        // Check permission
        $this->authorize('read', $dataTypeContent);

        // Check if BREAD is Translatable
        $isModelTranslatable = is_bread_translatable($dataTypeContent);

        // Order medications
        $medications =  DB::table('ordered_medications')
                            ->leftJoin('orders', 'orders.id', '=', 'ordered_medications.order_id')
                            ->leftJoin('medications', 'medications.id', '=', 'ordered_medications.medication_id')
                            ->select(DB::raw('
                                ordered_medications.id,
                                medications.brand AS `medication`,
                                medications.dose_per_tablet AS `dose`,
                                medications.quantity_of_tablets AS `units`,
                                medications.type AS `type`,
                                ordered_medications.qty_delivered,
                                ordered_medications.qty_ordered,
                                orders.timestamp_delivered,
                                orders.status'
                            ))
                            ->where('ordered_medications.order_id', '=', $order_id)
                            ->get();


        $view = 'voyager::delivered_orders.read';

        return Voyager::view($view, compact('dataType', 'dataTypeContent', 'isModelTranslatable', 'medications'));
    }

    public function stock ()
    {
        $this->checkPermission('browse_stock');

        $pharmacy_id = Auth::user()->pharmacy_id;

        $results = DB::select('
                    SELECT s.med_id, s.medication, stock.qty_auto, stock.qty_manual
                    FROM `stock` 
                    INNER JOIN (
                        SELECT `med`.`id` as med_id, CONCAT(med.brand, " ", med.dose_per_tablet, " x ", med.quantity_of_tablets) AS `medication`, max(stock.created_at) as last_date
                        FROM stock
                        INNER JOIN `suggested_orders` as `sugg` on `sugg`.`medication_id` = `stock`.`medication_id` 
                                and `sugg`.`status` = 3 -- Pending pickups
                        INNER JOIN `medications` as `med` on `med`.`id` = `sugg`.`medication_id` 
                        WHERE stock.pharmacy_id = ?
                        GROUP BY `stock`.`medication_id`
                    ) as s on s.med_id = stock.medication_id and s.last_date = stock.created_at
                    WHERE pharmacy_id = ?', [$pharmacy_id, $pharmacy_id]);


        $view = 'voyager::stock.browse';

        return Voyager::view($view, compact('results'));

    }

    public function save_stock (Request $request)
    {
        $qty_manual = $request['quantity'];

        foreach ($qty_manual as $med => $qty) {
            $stock = \App\Stock::select('*')
                            ->where(['medication_id' => $med, 'pharmacy_id' => Auth::user()->pharmacy_id])
                            ->orderBy('created_at', 'desc')
                            ->first();

            $stock->qty_manual = $qty;
            $stock->save();
        }

        $redirect = redirect()->route("stock");

        return $redirect->with([
            'message'    => __('voyager::generic.successfully_updated'),
            'alert-type' => 'success',
        ]);
    }

    public function checkPermission ($slug)
    {
        // Check permission 
        $permission = DB::table('permissions')->where('key', $slug)->first();
        $role = DB::table('permission_role')
                                ->where('role_id', Auth::user()->role_id)
                                ->where('permission_id', $permission->id)
                                ->first();

        if (!$role)
            return abort('403');
    }
}
