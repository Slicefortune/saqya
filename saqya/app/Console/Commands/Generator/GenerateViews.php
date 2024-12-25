<?php

namespace App\Console\Commands\Generator;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Str;

class GenerateViews extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'generator:generate-views {model}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Execute the console command.
     */
    public function handle(): void
    {
        $model = $this->argument('model');
        $modelName = ucwords($model);
        $viewDir = Str::kebab($model);
        $routePrefix = Str::kebab($model);

        // Generate the view files
        $indexStub = File::get(__DIR__ . "/stubs/views/index.stub");
        $indexStub = str_replace(
            ['{{ modelName }}', '{{ routePrefix }}'],
            [$modelName, $routePrefix],
            $indexStub
        );
        $indexPath = resource_path("views/admin/{$viewDir}/index.blade.php");
        File::ensureDirectoryExists(resource_path("views/admin/{$viewDir}"));
        File::put($indexPath, $indexStub);

        $formStub = File::get(__DIR__ . "/stubs/views/form.stub");
        $formStub = str_replace(
            ['{{ modelName }}', '{{ routePrefix }}'],
            [$modelName, $routePrefix],
            $formStub
        );
        $formPath = resource_path("views/admin/{$viewDir}/form.blade.php");
        File::ensureDirectoryExists(resource_path("views/admin/{$viewDir}"));
        File::put($formPath, $formStub);

        $actionStub = File::get(__DIR__ . "/stubs/views/action.stub");
        $actionStub = str_replace(
            ['{{ modelName }}', '{{ routePrefix }}'],
            [$modelName, $routePrefix],
            $actionStub
        );
        $actionPath = resource_path("views/admin/{$viewDir}/action.blade.php");
        File::ensureDirectoryExists(resource_path("views/admin/{$viewDir}"));
        File::put($actionPath, $actionStub);


        // Optionally, create any required views or resources here

        $this->info("Views generated successfully for {$modelName}.");
    }
}
