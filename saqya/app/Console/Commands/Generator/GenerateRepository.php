<?php

namespace App\Console\Commands\Generator;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\File;

class GenerateRepository extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'generator:generate-repository  {model}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Generate a repository for the specified model';

    /**
     * Execute the console command.
     */
    public function handle(): void
    {
        $model = $this->argument('model');
        $modelName = ucwords($model);
        $repositoryName = $modelName . 'Repository';
        $stub = File::get(__DIR__ . "/stubs/repository.stub");

        $stub = str_replace(
            ['{{ namespace }}', '{{ modelNamespace }}', '{{ modelName }}', '{{ repositoryName }}'],
            ['App\Repositories', 'App\Models\\' . $modelName, $modelName, $repositoryName],
            $stub
        );

        $repositoryPath = app_path("Repositories/{$repositoryName}.php");

        File::put($repositoryPath, $stub);

        $this->info("Repository generated successfully for {$modelName}.");
    }
}
