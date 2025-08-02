<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Api\LoginRequest;
use App\Http\Requests\Api\RegisterRequest;
use App\Http\Resources\UserResource;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    /**
     * Kullanıcı Kaydı
     *
     * Yeni bir kullanıcı hesabı oluşturur ve access token döndürür.
     *
     * @tags Kimlik Doğrulama
     * @operationId registerUser
     * @summary Yeni kullanıcı kaydı
     * @description Bu endpoint ile yeni bir kullanıcı hesabı oluşturabilirsiniz. Başarılı kayıt sonrasında kullanıcı bilgileri ve access token döndürülür.
     *
     * @response 201 {
     *   "success": true,
     *   "message": "Kullanıcı başarıyla kaydedildi",
     *   "data": {
     *     "user": {
     *       "id": 1,
     *       "name": "John Doe",
     *       "email": "john@example.com",
     *       "roles": [],
     *       "permissions": []
     *     },
     *     "access_token": "1|abc123...",
     *     "token_type": "Bearer"
     *   }
     * }
     *
     * @response 422 {
     *   "message": "The given data was invalid.",
     *   "errors": {
     *     "name": ["The name field is required."],
     *     "email": ["The email has already been taken."],
     *     "password": ["The password must be at least 8 characters."]
     *   }
     * }
     */
    public function register(RegisterRequest $request): JsonResponse
    {
        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        $token = $user->createToken('auth_token')->plainTextToken;

        return apiSuccess([
            'user' => new UserResource($user),
            'access_token' => $token,
            'token_type' => 'Bearer',
        ], 'Kullanıcı başarıyla kaydedildi', 201);
    }

    /**
     * Kullanıcı Girişi
     *
     * Mevcut kullanıcı hesabına giriş yapar ve access token döndürür.
     *
     * @tags Kimlik Doğrulama
     * @operationId loginUser
     * @summary Kullanıcı girişi
     * @description Email ve şifre ile giriş yaparak access token alabilirsiniz. Bu token ile korumalı endpoint'lere erişim sağlayabilirsiniz.
     *
     * @response 200 {
     *   "success": true,
     *   "message": "Giriş başarılı",
     *   "data": {
     *     "user": {
     *       "id": 1,
     *       "name": "John Doe",
     *       "email": "john@example.com",
     *       "roles": [],
     *       "permissions": []
     *     },
     *     "access_token": "1|abc123...",
     *     "token_type": "Bearer"
     *   }
     * }
     *
     * @response 422 {
     *   "message": "The given data was invalid.",
     *   "errors": {
     *     "email": ["Girilen bilgiler hatalı."]
     *   }
     * }
     */
    public function login(LoginRequest $request): JsonResponse
    {
        if (!Auth::attempt($request->only('email', 'password'))) {
            throw ValidationException::withMessages([
                'email' => ['Girilen bilgiler hatalı.'],
            ]);
        }

        $user = User::where('email', $request->email)->first();
        $token = $user->createToken('auth_token')->plainTextToken;

        return apiSuccess([
            'user' => new UserResource($user),
            'access_token' => $token,
            'token_type' => 'Bearer',
        ], 'Giriş başarılı');
    }
}
