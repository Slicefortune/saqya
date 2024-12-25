<?php

namespace App\View\Composers;

use App\Enums\PublishStatusEnum;
use App\Services\TeamService;
use Illuminate\View\View;

final class TeamComposer
{
    /**
     * Create a new profile composer.
     */
    public function __construct(protected TeamService $service)
    {
    }

    /**
     * Bind data to the view.
     */
    public function compose(View $view): void
    {
        $teams = $this->service->allWhere([
            ['status', '=', PublishStatusEnum::PUBLISHED->value],
        ]);
        $teams = $teams->sortBy('order');
        $view->with('teams', $teams);
    }
}
