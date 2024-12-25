<?php

namespace App\Http\Controllers\Admin\User;

use App\DataTables\User\UsersActivityDataTable;
use App\Http\Controllers\Controller;

class UserActivityController extends Controller
{
    /**
     * Handle the incoming request.
     */
    public function __invoke(UsersActivityDataTable $dataTable)
    {
        return $dataTable->render('admin.user.activities.index');
    }

}
