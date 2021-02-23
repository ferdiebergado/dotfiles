<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Blade;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        $this->app->bind('path.public', function () {
            return base_path('public_html');
        });
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        // Render ViewComponent Blade Directive
         Blade::directive('render', function ($component) {
            return "<?php echo (app($component))->toHtml(); ?>";
         });
        // Render ViewComponent
        //@render(\App\Http/ViewComponents\ViewComponent::class)
    }
}
