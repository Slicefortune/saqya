<?php

namespace App\View\Composers;

use App\Enums\HomePageFeaturedEnum;
use App\Enums\PublishStatusEnum;
use App\Services\NewsService;
use Illuminate\View\View;

final class LatestNewsComposer
{
    /**
     * Create a new profile composer.
     */
    public function __construct(protected NewsService $service)
    {
    }

    /**
     * Bind data to the view.
     */
    public function compose(View $view): void
    {
        $data = $this->service->latestNews([
            ['status', '=', PublishStatusEnum::PUBLISHED->value],
            ['homepage_featured', '=', HomePageFeaturedEnum::YES->value]
        ], 3);
        $view->with('latestNews', $data);
    }
}
