<?php

namespace App\Repositories;

use App\Models\Banner;

class BannerRepository extends BaseRepository
{
    /**
     * Constructor
     */
    public function __construct(Banner $model)
    {
        parent::__construct($model);
    }
}