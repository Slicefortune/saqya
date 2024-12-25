<?php

namespace App\Repositories;

use App\Models\Donation;

class DonationRepository extends BaseRepository
{
    /**
     * Constructor
     */
    public function __construct(Donation $model)
    {
        parent::__construct($model);
    }
}