<?php

namespace App\View\Composers;

use App\Enums\PublishStatusEnum;
use App\Services\DivisionService;
use Illuminate\View\View;

final class NavbarComposer
{
    /**
     * Create a new profile composer.
     */
    public function __construct(protected DivisionService $divisionService)
    {
    }

    /**
     * Bind data to the view.
     */
    public function compose(View $view): void
    {
        $divisions = $this->divisionService->allWhere([
            ['status', '=', PublishStatusEnum::PUBLISHED->value],
            ['parent_id', '=', null]
        ]);
        $view->with('divisions', $divisions);
    }
}
