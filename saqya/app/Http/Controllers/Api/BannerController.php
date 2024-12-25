<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Banner;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class BannerController extends Controller
{
    public function get_banners(): JsonResponse
    {
        try {
            return response()->json(Banner::active()->get(), 200);
        } catch (\Exception $e) {
            return response()->json([], 200);
        }
    }
}
