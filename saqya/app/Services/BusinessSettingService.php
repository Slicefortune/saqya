<?php

namespace App\Services;

use App\Repositories\BusinessSettingRepository;

class BusinessSettingService extends BaseService
{
    public function __construct(BusinessSettingRepository $repository)
    {
        parent::__construct($repository);
    }

    public function updateGeneralContent(array $data): void
    {
        $keys = array_keys($data);
        $contents = $this->repository->whereIn('key', $keys);
        foreach ($contents as $content) {
            $this->repository->update($content->id, [
                'value' => $data[$content->key]
            ]);
        }
    }
}