<?php

namespace App\Http\Controllers\Admin;

use App\DataTables\DonationDataTable;
use App\Http\Controllers\Controller;
use App\Services\DonationService;
use Illuminate\Http\Request;

class DonationController extends Controller
{
    protected DonationService $service;

    public function __construct(DonationService $service)
    {
        $this->service = $service;
    }
    /**
     * Display a listing of the resource.
     */
    public function index(DonationDataTable $dataTable): mixed
    {
        return $dataTable->render('admin.donation.index');
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
