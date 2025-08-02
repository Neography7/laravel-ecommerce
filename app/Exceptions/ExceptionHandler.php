<?php

namespace App\Exceptions;

use Exception;
use Illuminate\Auth\AuthenticationException;
use Illuminate\Auth\Access\AuthorizationException;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Foundation\Exceptions\Handler as BaseExceptionHandler;
use Illuminate\Validation\ValidationException;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use Throwable;

class ExceptionHandler extends BaseExceptionHandler
{
    /**
     * The list of the inputs that are never flashed to the session on validation exceptions.
     *
     * @var array<int, string>
     */
    protected $dontFlash = [
        'current_password',
        'password',
        'password_confirmation',
    ];

    /**
     * Register the exception handling callbacks for the application.
     */
    public function register(): void
    {
        $this->reportable(function (Throwable $e) {
            //
        });
    }

    /**
     * Render an exception into an HTTP response.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Throwable  $exception
     * @return \Illuminate\Http\JsonResponse|\Illuminate\Http\Response
     */
    public function render($request, Throwable $exception)
    {
        // API istekleri için JSON response döndür
        if ($request->expectsJson() || $request->is('api/*')) {
            return $this->handleApiException($exception);
        }

        // Diğer durumlarda parent method'u çağır
        return parent::render($request, $exception);
    }

    /**
     * Handle API exceptions and return JSON response.
     *
     * @param  \Throwable  $exception
     * @return \Illuminate\Http\JsonResponse
     */
    protected function handleApiException(Throwable $exception): JsonResponse
    {
        // AuthenticationException hatalarını ele al
        if ($exception instanceof AuthenticationException) {
            return apiError('Unauthenticated.', [], 401);
        }

        // AuthorizationException hatalarını ele al
        if ($exception instanceof AuthorizationException) {
            return apiError('This action is unauthorized.', [], 403);
        }

        // ValidationException hatalarını ele al
        if ($exception instanceof ValidationException) {
            return apiError('Validasyon hatası', $exception->errors(), 422);
        }

        // ModelNotFoundException hatalarını ele al
        if ($exception instanceof ModelNotFoundException) {
            return apiError('Veri bulunamadı', [], 404);
        }

        // API route bulunamadı hatası
        if ($exception instanceof NotFoundHttpException) {
            return apiError('API yolu bulunamadı', [], 404);
        }

        // Diğer tüm hatalar için genel hata mesajı döndür
        return apiError($exception->getMessage(), [], 500);
    }
}
