<?php

/**
 * These are the Tam Configs set them in the ENV of your project
 */

return [
    'base_url' => env('BENEFIT_PAYMENT_URL', 'https://test.benefit-gateway.bh/payment/API/hosted.htm'),

    'terminal_resource_key' => env('BENEFIT_TERMINAL_RESOURCE_KEY', '000000000000000'),

    'transportal_id' => env('BENEFIT_TRANSPORTAL_ID', '00000000'),

    'transportal_password' => env('BENEFIT_TRANSPORTAL_PASSWORD', 'password'),

    'enc_iv' => 'PGKEYENCDECIVSPC',

    'handler' => \App\Http\Controllers\BenefitController::class
];
