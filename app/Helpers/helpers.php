<?php

use Illuminate\Http\JsonResponse;

if (! function_exists('apiSuccess')) {
    /**
     * Başarılı işlem sonucu döner.
     *
     * @param mixed $data
     * @param string $message
     * @param int $code
     * @return JsonResponse
     */
    function apiSuccess($data = null, $message = 'İşlem başarılı', $code = 200): JsonResponse
    {
        return response()->json([
            'success' => true,
            'message' => $message,
            'data' => $data ?? (object)[],
            'errors' => []
        ], $code);
    }
}

if (! function_exists('apiError')) {
    /**
     * Hata mesajı ve detayları döner.
     *
     * @param string $message
     * @param array $errors
     * @param int $code
     * @param mixed $data
     * @return JsonResponse
     */
    function apiError($message = 'Bir hata oluştu', $errors = [], $code = 400, $data = null): JsonResponse
    {
        return response()->json([
            'success' => false,
            'message' => $message,
            'data' => $data ?? (object)[],
            'errors' => $errors
        ], $code);
    }
}

if (! function_exists('apiMessage')) {
    /**
     * Sadece mesaj döner.
     *
     * @param string $message
     * @param int $code
     * @return JsonResponse
     */
    function apiMessage(string $message = 'İşlem başarılı', int $code = 200): JsonResponse
    {
        return response()->json([
            'success' => true,
            'message' => $message,
            'data' => (object)[],
            'errors' => []
        ], $code);
    }
}
