<?php

namespace App\Console\Commands\Generator;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Artisan;

class GenerateModelScaffold extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'generator:generate-model-scaffold  {name}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Generate a model, migration, service, and repository';

    /**
     * Execute the console command.
     */
    public function handle(): void
    {
        $name = $this->argument('name');

        // Generate Model & Migrations
        Artisan::call("make:model {$name} -m");

        // Generate Repository
        $this->call('generator:generate-repository', [
            'model' => $name,
        ]);

        // Generate Service
        $this->call('generator:generate-service', [
            'model' => $name,
        ]);

        $this->info('Model, migration, service, and repository generated successfully.');
    }
}
