<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Donation;
use App\Models\Product;
use Illuminate\Contracts\View\View;

class DashboardController extends Controller
{
    /**
     * Show the application dashboard.
     * @return View
     */
    public function index(): View
    {
        $products= Product::get()->count();
        $total_donation = Donation::sum('total');
        return view('admin.dashboard',compact('products','total_donation'));
    }
}
