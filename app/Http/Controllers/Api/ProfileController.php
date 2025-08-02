<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Api\UpdateProfileRequest;
use App\Http\Resources\UserResource;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class ProfileController extends Controller
{
    /**
     * Profil Bilgilerini Görüntüle
     *
     * Kimlik doğrulaması yapılmış kullanıcının profil bilgilerini getirir.
     *
     * @tags Kullanıcı Profili
     * @operationId getUserProfile
     * @summary Kullanıcı profili görüntüleme
     * @description Giriş yapmış kullanıcının profil bilgilerini (ad, email, roller, yetkiler) döndürür.
     * 
     * @response 200 {
     *   "success": true,
     *   "message": "İşlem başarılı",
     *   "data": {
     *     "user": {
     *       "id": 1,
     *       "name": "John Doe",
     *       "email": "john@example.com",
     *       "roles": [],
     *       "permissions": []
     *     }
     *   }
     * }
     * 
     * @response 401 {
     *   "message": "Unauthenticated."
     * }
     */
    public function show(Request $request): JsonResponse
    {
        return apiSuccess([
            'user' => new UserResource($request->user()),
        ]);
    }

    /**
     * Profil Bilgilerini Güncelle
     *
     * Kimlik doğrulaması yapılmış kullanıcının profil bilgilerini günceller.
     *
     * @tags Kullanıcı Profili
     * @operationId updateUserProfile
     * @summary Kullanıcı profili güncelleme
     * @description Kullanıcının adını, email'ini veya şifresini güncelleyebilirsiniz. Şifre değişikliği için mevcut şifre gereklidir.
     * 
     * @response 200 {
     *   "success": true,
     *   "message": "Profil başarıyla güncellendi",
     *   "data": {
     *     "user": {
     *       "id": 1,
     *       "name": "John Updated",
     *       "email": "john.updated@example.com",
     *       "roles": [],
     *       "permissions": []
     *     }
     *   }
     * }
     * 
     * @response 401 {
     *   "message": "Unauthenticated."
     * }
     * 
     * @response 422 {
     *   "message": "The given data was invalid.",
     *   "errors": {
     *     "email": ["The email has already been taken."],
     *     "current_password": ["Mevcut şifre hatalı."]
     *   }
     * }
     */
    public function update(UpdateProfileRequest $request): JsonResponse
    {
        $user = $request->user();

        $data = $request->validated();

        if (isset($data['password'])) {
            $data['password'] = Hash::make($data['password']);
        }

        $user->update($data);

        return apiSuccess([
            'user' => new UserResource($user->fresh()),
        ], 'Profil başarıyla güncellendi');
    }
}
