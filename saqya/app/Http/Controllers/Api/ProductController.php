<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Product;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ProductController extends Controller
{
     /**
     * Products List
     */
    public function get_products(): JsonResponse
    {
        try {
            return response()->json(Product::active()->get(), 200);
        } catch (\Exception $e) {
            return response()->json([], 200);
        }
    }
}
