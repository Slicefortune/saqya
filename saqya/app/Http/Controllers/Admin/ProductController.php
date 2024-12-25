<?php

namespace App\Http\Controllers\Admin;

use App\DataTables\ProductDataTable;
use App\Enums\StatusEnum;
use App\Http\Controllers\Controller;
use App\Http\Requests\ProductRequest;
use App\Models\Product;
use App\Services\ProductService;
use Illuminate\Http\Request;

class ProductController extends Controller
{
     /**
     * @var ProductService $service
     */
    protected ProductService $service;

     /**
     * @param ProductService $service
     */
    public function __construct(ProductService $service)
    {
        $this->service = $service;
    }
    

     /**
     * Display a listing of the resource.
     * @param ProductDataTable $dataTable
     * @return mixed
     */
    public function index(ProductDataTable $dataTable): mixed
    {
        return $dataTable->render('admin.product.index');
    }

     /**
     * Show the form for creating a new resource.
     * @return JsonResponse|void
     */
    public function create()
    {
        if (request()->ajax()) {
            
            return $this->returnSuccessJsonResponse(data: [
                'html' => view('admin.product.form')
                    ->with('title', "Create New Product")
                    ->with('actionRoute', route('admin.products.store'))
                    ->with('actionMethod', 'POST')
                    ->render()
            ]);
        }
        abort(404);
    }


     /**
     * Store a newly created resource in storage.
     * @param ProductRequest $request
     * @return JsonResponse|void
     */
    public function store(ProductRequest $request)
    {
        if (request()->ajax()) {
            $validateData = $request->validated();
            $productImage = Product::STORAGE_DIRECTORY
                . "/image-" . time() . "."
                . $validateData['image']->getClientOriginalExtension();
            $validateData['image']->storeAs('public', $productImage);
            $validateData['image'] = $productImage;

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
                'html' => view('admin.product.form')
                    ->with('title', "Edit Product")
                    ->with('item', $item)
                    ->with('actionRoute', route('admin.products.update', $item->id))
                    ->with('actionMethod', 'PATCH')
                    ->render()
            ]);
        }
        abort(404);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(ProductRequest $request, string $id)
    {
        if (request()->ajax()) {
            $validateData = $request->validated();
            if ( !empty($validateData['image'])) {
                $productImage = Product::STORAGE_DIRECTORY
                    . "/image-" . time() . "."
                    . $validateData['image']->getClientOriginalExtension();
                $validateData['image']->storeAs('public', $productImage);
                $validateData['image'] = $productImage;
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
