<?php

namespace App\Console\Commands\Generator;

use Faker\Core\File;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Str;

class GenerateCrudScaffold extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'generator:generate-crud-scaffold  {model}';

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

        // Generate Datatable
        Artisan::call("datatables:make {$model}");

        // Generate Request
        Artisan::call("make:request {$model}Request");

        // Generate Controller
        $this->call('generator:generate-controller', [
            'model' => $model
        ]);

        // Generate views
        $this->call('generator:generate-views', [
            'model' => $model
        ]);


        $controllerName = 'App\\Http\\Controllers\\Admin\\' . ucwords($model) . 'Controller';
        $routeName = Str::kebab($model) . 's';

        // Define the route definition string
        $routeDefinition = "Route::resource('{$routeName}', {$controllerName}::class)->except('show');";

        /// Read content of the web.php file
        $webFile = base_path('routes/web.php');
        $webContent = file_get_contents($webFile);

        // Search for the comment line
        $commentLine = '//Generated Routes Above';
        $position = mb_strpos($webContent, $commentLine);

        // If the comment line is found, insert the route definition just above it
        if (false !== $position) {
            $webContent = substr_replace($webContent, PHP_EOL . $routeDefinition, $position, 0);
            file_put_contents($webFile, $webContent);
            $this->info("Route generated successfully for {$controllerName}.");
        } else {
            $this->error("Failed to locate the specified comment line in web.php.");
        }
    }
}
