<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});


// Sales to client
Route::get('/admin/sales-to-clients', function () {
    return view('vendor\voyager\sales-to-clients\browse');
});  
Route::post('admin/sales-to-clients/next', ['uses' => 'Voyager\SalesToClientsNextController@index', 'as' => 'voyager.next.index']);
Route::post('admin/sales-to-clients/next/save', ['uses' => 'Voyager\SalesToClientsNextController@save', 'as' => 'voyager.next.save']);
// -------------------


// Sales to client archive
Route::get('/admin/sales-to-clients-archive', function () {
    return view('vendor\voyager\sales-to-clients-archive\browse');
});  
Route::post('admin/sales-to-clients-archive/next', ['uses' => 'Voyager\SalesToClientsArchiveNextController@index', 'as' => 'voyager.next.index']);
// -------------------

Route::group(['prefix' => 'admin'], function () {
    Voyager::routes();
});

Route::post('admin/suggested-orders/updateIDs', ['uses' => 'Voyager\SuggestedOrdersController@updateIDs', 'as' => 'voyager.suggested-orders.updateIDs']);
Route::post('admin/suggested-orders/sendOrders', ['uses' => 'Voyager\SuggestedOrdersController@sendOrders', 'as' => 'voyager.suggested-orders.sendOrders']);

// Pending Orders
Route::get('admin/pending_orders', ['uses' => 'Voyager\PharmacyOrdersController@pending', 'as' => 'pending-orders']);
Route::get('admin/view_order/{id}', ['uses' => 'Voyager\PharmacyOrdersController@view_pending_order', 'as' => 'view_confirmed_order']);
Route::post('admin/confirm_delivery', ['uses' => 'Voyager\PharmacyOrdersController@confirm_delivery', 'as' => 'confirm_delivery']);
// -------------------

// Delivered Order
Route::get('admin/delivered_orders', ['uses' => 'Voyager\PharmacyOrdersController@delivered', 'as' => 'delivered-orders']);
Route::get('admin/view_delivered/{id}', ['uses' => 'Voyager\PharmacyOrdersController@view_delivered', 'as' => 'view_delivered']);
// -------------------

// Stock
Route::get('admin/stock', ['uses' => 'Voyager\PharmacyOrdersController@stock', 'as' => 'stock']);
Route::post('admin/save_stock', ['uses' => 'Voyager\PharmacyOrdersController@save_stock', 'as' => 'save_stock']);
// -------------------

// Calls
Route::get('admin/pending_pickups', ['uses' => 'Voyager\CallsController@pending_pickups', 'as' => 'pending_pickups']);
// -------------------