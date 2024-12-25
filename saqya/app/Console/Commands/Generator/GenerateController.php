<?php

namespace App\Console\Commands\Generator;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Str;

class GenerateController extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'generator:generate-controller {model}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Generate a controller for the specified model';

    /**
     * Execute the console command.
     */
    public function handle(): void
    {
        $model = $this->argument('model');
        $modelName = ucwords($model);
        $viewDir = Str::kebab($model);
        $routePrefix = Str::kebab($model);
        $controllerName = "{$modelName}Controller";

        // Generate the controller file
        $stub = File::get(__DIR__ . "/stubs/controller.stub");
        $stub = str_replace(
            ['{{ modelName }}', '{{ controllerName }}', '{{ viewDir }}', '{{ routePrefix }}'],
            [$modelName, $controllerName, $viewDir, $routePrefix],
            $stub
        );
        $controllerPath = app_path("Http/Controllers/Admin/{$controllerName}.php");
        File::ensureDirectoryExists(app_path("Http/Controllers"));
        File::put($controllerPath, $stub);

        // Optionally, create any required views or resources here

        $this->info("Controller generated successfully for {$modelName}.");
    }
}
