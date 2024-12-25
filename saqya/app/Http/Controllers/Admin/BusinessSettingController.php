<?php

namespace App\Http\Controllers\Admin;

use App\DataTables\BusinessSettingDatatable;
use App\Enums\BusinessSettingEnum;
use App\Http\Controllers\Controller;
use App\Http\Requests\BusinessSettingRequest;
use App\Services\BusinessSettingService;
use Illuminate\Http\Request;

class BusinessSettingController extends Controller
{
    /**
     * @var BusinessSettingService $service
     */
    protected BusinessSettingService $service;

    /**
     * @param BusinessSettingService $service
     */
    public function __construct(BusinessSettingService $service)
    {
        $this->service = $service;
    }
    /**
     * Display a listing of the resource.
     */
    public function index(): mixed
    {
        $content = $this->service->all();
        return view('admin.business-setting.index')
            ->with('content', $content);
    }

    /**
     * Show the form for creating a new resource.
     * @return JsonResponse|void
     */
    public function create() {}

    /**
     * Store a newly created resource in storage.
     * @param BusinessSettingRequest $request
     * @return JsonResponse|void
     */
    public function store(BusinessSettingRequest $request) {}
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
     
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(BusinessSettingRequest $request)
    {
        if (request()->ajax()) {
            $validateData = $request->validated();        
            $this->service->updateGeneralContent($validateData);
            return $this->returnSuccessJsonResponse('Record Updated Successfully');
        }
        abort(404);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        if (request()->ajax()) {
            $this->service->delete($id);
            return $this->returnSuccessJsonResponse('Record Updated Successfully');
        }
        abort(404);
    }
}
