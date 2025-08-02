<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class AdminMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        if (!$request->user()) {
            return apiError(
                'Kimlik doğrulama gerekli.',
                ['auth' => ['Giriş yapmanız gerekiyor.']],
                401
            );
        }

        if (!$request->user()->hasRole('admin')) {
            return apiError(
                'Bu işlem için admin yetkisi gerekli.',
                ['permission' => ['Admin yetkisi gerekli.']],
                403
            );
        }

        return $next($request);
    }
}
