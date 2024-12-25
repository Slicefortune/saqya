<?php

namespace App\View\Composers;

use App\Enums\PublishStatusEnum;
use App\Services\FaqService;
use Illuminate\View\View;

final class FaqComposer
{
    /**
     * Create a new profile composer.
     */
    public function __construct(protected FaqService $service)
    {
    }

    /**
     * Bind data to the view.
     */
    public function compose(View $view): void
    {
        $data = $this->service->allWhere([
            ['status', '=', PublishStatusEnum::PUBLISHED->value],
        ]);
        $data = $data->sortBy('order');
        $view->with('faqs', $data);
    }
}
