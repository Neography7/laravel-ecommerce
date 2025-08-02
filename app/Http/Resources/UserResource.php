<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * Kullanıcı Kaynağı
 *
 * Kullanıcı verilerini API response formatında döndürür
 *
 * @property int $id Kullanıcı ID'si
 * @property string $name Kullanıcının adı
 * @property string $email E-posta adresi
 * @property string|null $email_verified_at E-posta doğrulama tarihi
 * @property array $roles Kullanıcının rolleri
 * @property array $permissions Kullanıcının yetkileri
 * @property string $created_at Hesap oluşturma tarihi
 * @property string $updated_at Son güncelleme tarihi
 */
class UserResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'email' => $this->email,
            'email_verified_at' => $this->email_verified_at,
            'roles' => $this->getRoleNames(),
            'permissions' => $this->getAllPermissions()->pluck('name'),
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
