<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Contracts\Debug\ExceptionHandler;
use App\Exceptions\ExceptionHandler as CustomExceptionHandler;
use App\Events\OrderCreated;
use App\Listeners\SendOrderConfirmationEmail;
use App\Models\OrderItem;
use App\Observers\OrderItemObserver;
use Dedoc\Scramble\Scramble;
use Dedoc\Scramble\Support\Generator\SecurityScheme;
use Illuminate\Support\Facades\Event;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        // Custom Exception Handler'ı Laravel'e kaydet
        $this->app->singleton(ExceptionHandler::class, CustomExceptionHandler::class);
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        // Event/Listener kaydı
        Event::listen(
            OrderCreated::class,
            SendOrderConfirmationEmail::class,
        );

        // Scramble Bearer Authentication konfigürasyonu
        Scramble::configure()
            ->withDocumentTransformers(function (\Dedoc\Scramble\Support\Generator\OpenApi $openApi) {
                $openApi->secure(
                    SecurityScheme::http('bearer')
                );
            });
    }
}
