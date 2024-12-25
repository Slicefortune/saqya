<?php

namespace App\Repositories;

use App\Models\BusinessSetting;

class BusinessSettingRepository extends BaseRepository
{
    /**
     * Constructor
     */
    public function __construct(BusinessSetting $model)
    {
        parent::__construct($model);
    }
}