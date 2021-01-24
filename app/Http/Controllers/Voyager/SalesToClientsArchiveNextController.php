<?php

namespace App\Http\Controllers\Voyager;

use TCG\Voyager\Http\Controllers\VoyagerBaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use ReflectionClass;
use TCG\Voyager\Database\Schema\SchemaManager;
use TCG\Voyager\Database\Schema\Table;
use TCG\Voyager\Database\Types\Type;
use TCG\Voyager\Events\BreadAdded;
use TCG\Voyager\Events\BreadDeleted;
use TCG\Voyager\Events\BreadUpdated;
use TCG\Voyager\Facades\Voyager;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;

class SalesToClientsArchiveNextController extends VoyagerBaseController
{
    public function index(Request $request)
    {  
        // Check permission 
        $this->checkPermission();
        
        $slug = "sales-to-clients-archive"; 
        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first(); 

        // if not the same client show him a message to select the same client
        $ids = [];
        if (empty($id)) {
            // get IDs from POST
            $ids = explode(',', $request->ids);
        } else {
            // Single item, get ID from URL
            $ids[] = $id;
        }   
        $dataTypeRows = [];
        $firstClientId = 0;
        $count = 0;
        $saleTotal = 0;
        $cash = "";
        $cc = "";
        foreach ($ids as $id) {
            
            $distinctSuggestedOrder = call_user_func([$dataType->model_name, 'findOrFail'], $id);
             
            
            $suggestedOrders = DB::table('suggested_orders')
                    // ->join('orders', 'orders.id', '=', 'suggested_orders.order_id')
                    // ->where("orders.pharmacy_id", Auth::user()->pharmacy_id)
                    ->where("suggested_orders.status", "5")
                    ->where("suggested_orders.pharmacy_id", Auth::user()->pharmacy_id) 
                    ->where('client_id', $distinctSuggestedOrder->client_id)
                    ->where('timestamp_sold', $distinctSuggestedOrder->timestamp_sold)
                    ->get(); 

            foreach ($suggestedOrders as $suggestedOrder) { 

                // $dataTypeContent = call_user_func([$dataType->model_name, 'findOrFail'], $id);
                $dataTypeContent = $suggestedOrder;
                            
                if($suggestedOrder->cash == 1) $cash = "checked";
                else $cc = "checked";
                
                $clientModel = call_user_func(['App\Client', 'findOrFail'], $dataTypeContent->client_id); 

                $medicationModel = call_user_func(['App\Medication', 'findOrFail'], $dataTypeContent->medication_id);

                $saleTotal += ($medicationModel->retail_price * $dataTypeContent->quantity);
                
                if($firstClientId == 0)
                    $firstClientId = $dataTypeContent->client_id;
                else if($firstClientId != $dataTypeContent->client_id)
                    return $this->returnWarning("You should choose the same client");
                        
                $dataTypeRows[$count] = [
                    'salesToClient' => $dataTypeContent,
                    'client' => $clientModel,
                    'medication' => $medicationModel
                ];
                $count++;
            }


           
        } 
 
        return Voyager::view('voyager::sales-to-clients-archive.next', compact('dataType', 'dataTypeRows', 'clientModel', 'saleTotal', 'cash', 'cc'));
    }

    public function returnWarning($message)
    { 
        $code = 500;   
        return response()->json([
            'data' => [
                'status'  => $code,
                'message' => $message,
            ],
        ], $code);
    } 
 
    public function checkPermission(){
        // Check permission 
        $permission = DB::table('permissions')
        ->where('key', 'browse_sales_to_clients_archive')
        ->get();  
        $permissionRole = DB::table('permission_role')
        ->where('role_id', Auth::user()->role_id)
        ->where('permission_id', $permission[0]->id)
        ->get(); 
        if(count($permissionRole) == 0)
            return abort('403');
    }
}
