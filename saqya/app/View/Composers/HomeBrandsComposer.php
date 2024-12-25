<?php

namespace App\View\Composers;

use App\Enums\HomePageFeaturedEnum;
use App\Enums\PublishStatusEnum;
use App\Services\DivisionBrandService;
use Illuminate\View\View;

final class HomeBrandsComposer
{
    /**
     * Create a new profile composer.
     */
    public function __construct(protected DivisionBrandService $service)
    {
    }

    /**
     * Bind data to the view.
     */
    public function compose(View $view): void
    {
        $brands = $this->service->allWhere([
            ['status', '=', PublishStatusEnum::PUBLISHED->value],
            ['homepage_featured', '=', HomePageFeaturedEnum::YES->value],
        ], ['division']);

        $sortedBrands = $brands->sortBy('home_page_order'); // Sort by home_page_order in ascending order

        $view->with('brands', $sortedBrands);
    }
}
