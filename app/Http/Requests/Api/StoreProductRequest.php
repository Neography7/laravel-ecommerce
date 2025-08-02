<?php

namespace App\Http\Requests\Api;

use Illuminate\Foundation\Http\FormRequest;

/**
 * Ürün Oluşturma İsteği
 *
 * @property string $name Ürün adı (minimum 3 karakter)
 * @property string|null $description Ürün açıklaması
 * @property float $price Ürün fiyatı (0'dan büyük olmalı)
 * @property int $stock_quantity Stok miktarı (negatif olamaz)
 * @property int $category_id Kategori ID'si
 */
class StoreProductRequest extends FormRequest
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
            'name' => ['required', 'string', 'min:3', 'max:255', 'unique:products,name'],
            'description' => ['nullable', 'string'],
            'price' => ['required', 'numeric', 'gt:0'],
            'stock_quantity' => ['required', 'integer', 'min:0'],
            'category_id' => ['required', 'exists:categories,id'],
        ];
    }

    /**
     * Get custom validation error messages.
     *
     * @return array<string, string>
     */
    public function messages(): array
    {
        return [
            'name.required' => 'Ürün adı gereklidir.',
            'name.min' => 'Ürün adı en az 3 karakter olmalıdır.',
            'name.unique' => 'Bu ürün adı zaten kullanılıyor.',
            'name.max' => 'Ürün adı en fazla 255 karakter olabilir.',
            'description.string' => 'Açıklama metin formatında olmalıdır.',
            'price.required' => 'Fiyat gereklidir.',
            'price.numeric' => 'Fiyat sayısal değer olmalıdır.',
            'price.gt' => 'Fiyat 0\'dan büyük olmalıdır.',
            'stock_quantity.required' => 'Stok miktarı gereklidir.',
            'stock_quantity.integer' => 'Stok miktarı tam sayı olmalıdır.',
            'stock_quantity.min' => 'Stok miktarı negatif olamaz.',
            'category_id.required' => 'Kategori seçimi gereklidir.',
            'category_id.exists' => 'Seçilen kategori bulunamadı.',
        ];
    }
}
