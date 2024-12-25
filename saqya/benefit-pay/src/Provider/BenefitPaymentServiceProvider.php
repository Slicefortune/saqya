<?php

namespace BenefitPay\Provider;

use Illuminate\Support\ServiceProvider;

class BenefitPaymentServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     *
     * @return void
     */
    public function register()
    {
    }

    /**
     * Bootstrap services.
     *
     * @return void
     */
    public function boot()
    {
        $this->publishes([
            __DIR__ . '/../config/benefit.php' => config_path('benefit.php'),
        ], 'config');

        // Merge the default configuration
        $this->mergeConfigFrom(__DIR__ . '/../config/benefit.php', 'benefit');

        // Load routes
        $this->loadRoutesFrom(__DIR__ . '/../routes/routes.php');

        // Load the migrations from the package
        $this->loadMigrationsFrom(__DIR__.'/../migrations');
    }
}
