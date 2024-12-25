<?php

use App\Http\Controllers\Api\BannerController as ApiBannerController;
use App\Http\Controllers\Api\ConfigController;
use App\Http\Controllers\Api\DonationController;
use App\Http\Controllers\Api\ProductController;
use Illuminate\Support\Facades\Route;

    // TODO::Remove this api after testing token generation with cron


    // Non Authenticated Routes
    Route::get('/products', [ProductController::class,'get_products']);
    Route::get('/banners', [ApiBannerController::class,'get_banners']);
    Route::post('/donation', [DonationController::class,'place_donation']);
    Route::get('/config', [ConfigController::class,'configuration']);
