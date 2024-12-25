<?php

namespace App\Http\Controllers\Admin\User;

use App\DataTables\User\UsersDataTable;
use App\Http\Controllers\Controller;
use App\Http\Requests\User\UserRequest;
use App\Services\UserService;
use Illuminate\Http\JsonResponse;

class UserController extends Controller
{
    /**
     * @var UserService $service
     */
    protected UserService $service;

    public function __construct(UserService $service)
    {
        $this->service = $service;
    }

    /**
     * Display a listing of the resource.
     * @param UsersDataTable $dataTable
     * @return mixed
     */
    public function index(UsersDataTable $dataTable): mixed
    {
        return $dataTable->render('admin.user.index');
    }

    /**
     * Show the form for creating a new resource.
     * @return JsonResponse|void
     */
    public function create()
    {
        if (request()->ajax()) {
            return $this->returnSuccessJsonResponse(data: [
                'html' => view('admin.user.form')
                    ->with('title', "Create New")
                    ->with('actionRoute', route('admin.user.store'))
                    ->with('actionMethod', 'POST')
                    ->render()
            ]);
        }
        abort(404);
    }

    /**
     * Store a newly created resource in storage.
     * @param UserRequest $request
     * @return JsonResponse|void
     */
    public function store(UserRequest $request)
    {
        if (request()->ajax()) {
            $this->service->create($request->validated());
            return $this->returnSuccessJsonResponse('New Record Created Successfully');
        }
        abort(404);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id): void
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
                'html' => view('admin.user.form')
                    ->with('title', "Edit")
                    ->with('item', $item)
                    ->with('actionRoute', route('admin.user.update', $item->id))
                    ->with('actionMethod', 'PATCH')
                    ->render()
            ]);
        }
        abort(404);
    }

    /**
     * @param UserRequest $request
     * @param string $id
     * @return JsonResponse|void
     */
    public function update(UserRequest $request, string $id)
    {
        if (request()->ajax()) {
            $this->service->update($id, $request->validated());
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
