<?php

namespace App\Console\Commands\Generator;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\File;

class GenerateService extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'generator:generate-service {model}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Generate a service for the specified model';

    /**
     * Execute the console command.
     */
    public function handle(): void
    {
        $model = $this->argument('model');
        $modelName = ucwords($model);
        $serviceName = $modelName . 'Service';
        $repositoryName = $modelName . 'Repository';
        $stub = File::get(__DIR__ . "/stubs/service.stub");

        $stub = str_replace(
            ['{{ namespace }}', '{{ repositoryNamespace }}', '{{ serviceName }}', '{{ repositoryName }}'],
            ['App\Services', 'App\Repositories\\' . $repositoryName, $serviceName, $repositoryName],
            $stub
        );

        $servicePath = app_path("Services/{$serviceName}.php");

        File::put($servicePath, $stub);

        $this->info("Service generated successfully for {$modelName}.");
    }
}
