<?php

namespace App\View\Composers;

use App\Enums\PublishStatusEnum;
use App\Services\ClientCategoryService;
use Illuminate\View\View;

final class ClientComposer
{
    /**
     * Create a new profile composer.
     */
    public function __construct(protected ClientCategoryService $service)
    {
    }

    /**
     * Bind data to the view.
     */
    public function compose(View $view): void
    {
        $clientCategories = $this->service->allWhere([
            ['status', '=', PublishStatusEnum::PUBLISHED->value],
        ], ['clients' => fn ($query) => $query->where('status', PublishStatusEnum::PUBLISHED->value)->orderBy('order')])
            ?->sortBy('order');

        $view->with('clientCategories', $clientCategories);
    }
}
