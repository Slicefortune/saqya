<?php

namespace App\View\Composers;

use App\Enums\PublishStatusEnum;
use App\Services\HomeBannerService;
use Illuminate\View\View;

final class HomeBannerComposer
{
    /**
     * Create a new profile composer.
     */
    public function __construct(protected HomeBannerService $service)
    {
    }

    /**
     * Bind data to the view.
     */
    public function compose(View $view): void
    {
        $banners = $this->service->allWhere([
            ['status', '=', PublishStatusEnum::PUBLISHED->value],
        ]);
        $view->with('banners', $banners);
    }
}
