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

class SalesToClientsNextController extends VoyagerBaseController
{
    public function index(Request $request)
    {  
        // Check permission 
        $this->checkPermission();
        
        $slug = "sales-to-clients"; 
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

        foreach ($ids as $id) {
            
            $dataTypeContent = call_user_func([$dataType->model_name, 'findOrFail'], $id);
            
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
 
        return Voyager::view('voyager::sales-to-clients.next', compact('dataType', 'dataTypeRows', 'clientModel', 'saleTotal'));
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

    public function save(Request $request)
    { 
        // Check permission 
        $this->checkPermission();
        
        $slug = "sales-to-clients"; 
        $dataType = Voyager::model('DataType')->where('slug', '=', $slug)->first(); 

        $ids = [];
        if (empty($id)) {
            // get IDs from POST
            $ids = explode(',', $request->ids);
        } else {
            // Single item, get ID from URL
            $ids[] = $id;
        }  
        
        $unitActualPrices = [];
        if (empty($unitActualPrice)) {
            // get IDs from POST
            $unitActualPrices = explode(',', $request->unitActualPrices);
        } else {
            // Single item, get ID from URL
            $unitActualPrices[] = $unitActualPrice;
        }  
        
        if(count($ids) != count($unitActualPrices))
            return $this->returnWarning("Wrong request body");

        $cash = 0;
        if($request->payMethod == 'cash')
            $cash = 1; 
 
        $currentDate = Carbon::now()->toDateTimeString();
        for ($i=0; $i < count($ids); $i++) {

            $salesToClient = call_user_func([$dataType->model_name, 'findOrFail'], $ids[$i]);

            if($salesToClient != null){  
                // update sales_to_clients table row to Sold  
                DB::table('suggested_orders')
                        ->where('id', $ids[$i])
                        ->update([ 'status' => 5, 'cash' => $cash, 'timestamp_sold' => $currentDate]);
 
                // update retail_price in medications table
                DB::table('medications')
                            ->where('id', $salesToClient->medication_id)
                            ->update([ 'retail_price' => $unitActualPrices[$i]]); 

                // Add to stock -- Added by Rhea
                $stock = \App\Stock::select('qty_manual', 'qty_auto')
                                ->where(['medication_id' => $salesToClient->medication_id, 
                                            'pharmacy_id' => Auth::user()->pharmacy_id])
                                ->orderBy('created_at', 'desc')
                                ->first();


                $new_stock = new \App\Stock;
                $new_stock->pharmacy_id = Auth::user()->pharmacy_id;
                $new_stock->medication_id = $salesToClient->medication_id;

                if ($stock) {
                    $new_stock->qty_manual = $stock->qty_manual;
                    $new_stock->qty_auto = $stock->qty_auto - $salesToClient->quantity;

                } else {
                    $new_stock->qty_manual = 0;
                    $new_stock->qty_auto = -($salesToClient->quantity);
                }

                $new_stock->save();
            } 
        } 
        ////////////////////////////////
        return redirect('/admin/sales-to-clients'); 

    }
 
    public function checkPermission(){
        // Check permission 
        $permission = DB::table('permissions')
        ->where('key', 'browse_sales_to_clients')
        ->get();  
        $permissionRole = DB::table('permission_role')
        ->where('role_id', Auth::user()->role_id)
        ->where('permission_id', $permission[0]->id)
        ->get(); 
        if(count($permissionRole) == 0)
            return abort('403');
    }
}
