<?php

namespace App\Http\Requests\Api;

use Illuminate\Foundation\Http\FormRequest;

class ProductListRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true; // Herkese açık endpoint
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'search' => 'nullable|string|min:2|max:100',
            'category_id' => 'nullable|integer|exists:categories,id',
            'min_price' => 'nullable|numeric|min:0',
            'max_price' => 'nullable|numeric|min:0|gte:min_price',
            'in_stock' => 'nullable|boolean',
            'sort_by' => 'nullable|in:name,price,created_at,stock_quantity',
            'sort_order' => 'nullable|in:asc,desc',
            'per_page' => 'nullable|integer|min:1|max:50',
            'page' => 'nullable|integer|min:1',
        ];
    }

    /**
     * Get custom error messages for validation rules.
     */
    public function messages(): array
    {
        return [
            'search.min' => 'Arama terimi en az 2 karakter olmalıdır.',
            'search.max' => 'Arama terimi en fazla 100 karakter olabilir.',
            'category_id.exists' => 'Seçilen kategori bulunamadı.',
            'min_price.min' => 'Minimum fiyat 0\'dan küçük olamaz.',
            'max_price.min' => 'Maksimum fiyat 0\'dan küçük olamaz.',
            'max_price.gte' => 'Maksimum fiyat minimum fiyattan küçük olamaz.',
            'sort_by.in' => 'Sıralama alanı name, price, created_at veya stock_quantity olmalıdır.',
            'sort_order.in' => 'Sıralama yönü asc veya desc olmalıdır.',
            'per_page.min' => 'Sayfa başına en az 1 ürün gösterilmelidir.',
            'per_page.max' => 'Sayfa başına en fazla 50 ürün gösterilebilir.',
            'page.min' => 'Sayfa numarası 1\'den küçük olamaz.',
        ];
    }

    /**
     * Get custom attribute names for error messages.
     */
    public function attributes(): array
    {
        return [
            'search' => 'arama terimi',
            'category_id' => 'kategori',
            'min_price' => 'minimum fiyat',
            'max_price' => 'maksimum fiyat',
            'in_stock' => 'stok durumu',
            'sort_by' => 'sıralama alanı',
            'sort_order' => 'sıralama yönü',
            'per_page' => 'sayfa başına ürün sayısı',
            'page' => 'sayfa numarası',
        ];
    }
}
