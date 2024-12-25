<?php

namespace App\Http\Controllers\Admin;

use App\DataTables\BannerDatatable;
use App\Http\Controllers\Controller;
use App\Http\Requests\BannerRequest;
use App\Models\Banner;
use App\Services\BannerService;
use Illuminate\Http\Request;

class BannerController extends Controller
{
     /**
     * @var BannerService $service
     */
    protected BannerService $service;

     /**
     * @param BannerService $service
     */
    public function __construct(BannerService $service)
    {
        $this->service = $service;
    }
    /**
     * Display a listing of the resource.
     */
      /**
     * Display a listing of the resource.
     * @param BannerDatatable $dataTable
     * @return mixed
     */
        public function index(BannerDatatable $dataTable): mixed
        {
            return $dataTable->render('admin.banner.index');
        }

    /**
     * Show the form for creating a new resource.
     * @return JsonResponse|void
     */
    public function create()
    {
        if (request()->ajax()) {
            
            return $this->returnSuccessJsonResponse(data: [
                'html' => view('admin.banner.form')
                    ->with('title', "Create New Banner")
                    ->with('actionRoute', route('admin.banner.store'))
                    ->with('actionMethod', 'POST')
                    ->render()
            ]);
        }
        abort(404);
    }

     /**
     * Store a newly created resource in storage.
     * @param BannerRequest $request
     * @return JsonResponse|void
     */
    public function store(BannerRequest $request)
    {
        if (request()->ajax()) {
            $validateData = $request->validated();
            $bannerImage = Banner::STORAGE_DIRECTORY
                . "/image-" . time() . "."
                . $validateData['image']->getClientOriginalExtension();
            $validateData['image']->storeAs('public', $bannerImage);
            $validateData['image'] = $bannerImage;

            $this->service->create($validateData);
            return $this->returnSuccessJsonResponse('New Record Created Successfully');
        }
        abort(404);
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
        if (request()->ajax()) {
            $item = $this->service->findOrFail($id);
           
            return $this->returnSuccessJsonResponse(data: [
                'html' => view('admin.banner.form')
                    ->with('title', "Edit Banner")
                    ->with('item', $item)
                    ->with('actionRoute', route('admin.banner.update', $item->id))
                    ->with('actionMethod', 'PATCH')
                    ->render()
            ]);
        }
        abort(404);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(BannerRequest $request, string $id)
    {
        if (request()->ajax()) {
            $validateData = $request->validated();
            if ( !empty($validateData['image'])) {
                $bannerImage = Banner::STORAGE_DIRECTORY
                    . "/image-" . time() . "."
                    . $validateData['image']->getClientOriginalExtension();
                $validateData['image']->storeAs('public', $bannerImage);
                $validateData['image'] = $bannerImage;
            }

            $this->service->update($id, $validateData);
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
