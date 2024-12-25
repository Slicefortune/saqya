<?php

use App\Http\Controllers\BenefitController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

// Admin Routes
Illuminate\Support\Facades\Auth::routes();
Route::name('admin.')->prefix('admin')->middleware('auth')->group(function (): void {
    // Dashboard
    Route::get('/dashboard', [App\Http\Controllers\Admin\DashboardController::class, 'index'])->name('dashboard');


    // User
    Route::resource('user', App\Http\Controllers\Admin\User\UserController::class)->except('show');
    Route::get('users/activities', App\Http\Controllers\Admin\User\UserActivityController::class)->name('user.activity');
    Route::resource('banner', App\Http\Controllers\Admin\BannerController::class)->except('show');

    Route::resource('products', App\Http\Controllers\Admin\ProductController::class)->except('show');
    Route::resource('donations', App\Http\Controllers\Admin\DonationController::class)->except('show');
    Route::get('business-setting', [App\Http\Controllers\Admin\BusinessSettingController::class,'index'])->name('business-setting.index');
    Route::post('business-setting', [App\Http\Controllers\Admin\BusinessSettingController::class,'update'])->name('business-setting.update');


    //Generated Routes Above
});
