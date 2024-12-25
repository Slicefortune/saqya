<?php

namespace App\Services;

use App\Repositories\DonationRepository;

class DonationService extends BaseService
{
    public function __construct(DonationRepository $repository)
    {
        parent::__construct($repository);
    }
}