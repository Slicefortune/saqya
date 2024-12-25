<?php

namespace App\Http\Controllers\Api;

use App\Helper\Helper;
use App\Http\Controllers\Controller;
use App\Models\BusinessSetting;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ConfigController extends Controller
{
    private $map_key;

    public function __construct(
        private BusinessSetting $business_setting,
    ){
        $this->map_key = Helper::get_business_settings('map_api_client_key');
    }
    public function configuration(): JsonResponse
    {
        return response()->json([
            'base_urls' => [
                'banner_image_url' => asset('storage/banners'),
                'product_image_url' => asset('storage/products'),
              
            ],
            'terms_and_conditions' => $this->business_setting->where(['key' => 'terms_and_conditions'])->first()->value,
            'privacy_policy' => $this->business_setting->where(['key' => 'privacy_policy'])->first()->value,
            'maintenance_mode' => (boolean)Helper::get_business_settings('maintenance_mode') ?? 0,
            'software_version' => $this->business_setting->where(['key' => 'software_version'])->first()->value,
            'whatsapp' => json_decode($this->business_setting->where(['key' => 'whatsapp'])->first()->value, true),
            'map_api_server_key' => $this->business_setting->where(['key' => 'map_api_server_key'])->first()->value,

        ], 200);
    }
}
