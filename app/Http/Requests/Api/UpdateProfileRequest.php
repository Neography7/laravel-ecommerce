<?php

namespace App\Http\Requests\Api;

use Illuminate\Foundation\Http\FormRequest;

/**
 * Profil Güncelleme İsteği
 *
 * @property string|null $name Kullanıcının adı (opsiyonel, minimum 2 karakter)
 * @property string|null $email E-posta adresi (opsiyonel, benzersiz olmalı)
 * @property string|null $password Yeni şifre (opsiyonel, minimum 8 karakter)
 * @property string|null $password_confirmation Şifre onayı
 * @property string|null $current_password Mevcut şifre (şifre değiştiriliyorsa zorunlu)
 */
class UpdateProfileRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     */
    public function rules(): array
    {
        $userId = $this->user()->id;

        return [
            'name' => ['sometimes', 'string', 'min:2', 'max:255'],
            'email' => ['sometimes', 'string', 'email', 'max:255', 'unique:users,email,' . $userId],
            'password' => ['sometimes', 'string', 'min:8', 'confirmed'],
            'current_password' => ['required_with:password', 'string', 'current_password'],
        ];
    }

    /**
     * Get the error messages for the defined validation rules.
     */
    public function messages(): array
    {
        return [
            'name.string' => 'Ad geçerli bir metin olmalıdır.',
            'name.min' => 'Ad en az 2 karakter olmalıdır.',
            'name.max' => 'Ad en fazla 255 karakter olabilir.',
            'email.email' => 'Geçerli bir e-posta adresi giriniz.',
            'email.unique' => 'Bu e-posta adresi zaten kullanılmaktadır.',
            'password.min' => 'Şifre en az 8 karakter olmalıdır.',
            'password.confirmed' => 'Şifre onayı eşleşmiyor.',
            'current_password.required_with' => 'Şifre değiştirmek için mevcut şifrenizi girmelisiniz.',
            'current_password.current_password' => 'Mevcut şifre hatalı.',
        ];
    }
}
