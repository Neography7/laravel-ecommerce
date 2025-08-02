<?php

namespace App\Http\Requests\Api;

use Illuminate\Foundation\Http\FormRequest;

/**
 * Sepete Ürün Ekleme İsteği
 *
 * @property integer $product_id Ürün ID'si
 * @property integer $quantity Ürün miktarı (minimum 1)
 */
class AddToCartRequest extends FormRequest
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
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'product_id' => ['required', 'exists:products,id'],
            'quantity' => ['required', 'integer', 'min:1'],
        ];
    }

    /**
     * Get custom messages for validator errors.
     *
     * @return array<string, string>
     */
    public function messages(): array
    {
        return [
            'product_id.required' => 'Ürün ID gereklidir.',
            'product_id.exists' => 'Ürün bulunamadı.',
            'quantity.required' => 'Miktar gereklidir.',
            'quantity.integer' => 'Miktar sayı olmalıdır.',
            'quantity.min' => 'Miktar en az 1 olmalıdır.',
        ];
    }
}
