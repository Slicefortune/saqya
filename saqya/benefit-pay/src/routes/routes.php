<?php

use Illuminate\Support\Facades\Route;
use BenefitPay\Controller\BenefitController;

Route::prefix('benefit')->name('benefit.')->group(function () {
    Route::any('/response', [BenefitController::class, 'benefitValidate']);
    Route::any('/approved', [BenefitController::class, 'approved']);
    Route::any('/error', [BenefitController::class, 'error']);
});
