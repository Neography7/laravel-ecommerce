<?php

namespace App\Http\Requests\Api;

use App\Models\Order;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

/**
 * Sipariş Durum Güncelleme İsteği
 *
 * Bu sınıf admin kullanıcıları için sipariş durumunu güncelleme
 * isteklerini validate eder. Sadece geçerli durum geçişlerini kabul eder.
 *
 * @property string $status Yeni sipariş durumu (pending, processing, shipped, delivered, cancelled)
 */
class UpdateOrderStatusRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        // Admin middleware tarafından kontrol edilecek
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
            'status' => [
                'required',
                'string',
                Rule::in(Order::STATUSES)
            ],
        ];
    }

    /**
     * Get custom error messages for validation rules.
     */
    public function messages(): array
    {
        return [
            'status.required' => 'Sipariş durumu gereklidir.',
            'status.in' => 'Geçersiz sipariş durumu. Geçerli değerler: ' . implode(', ', Order::STATUSES),
        ];
    }

    /**
     * Get custom attribute names for error messages.
     */
    public function attributes(): array
    {
        return [
            'status' => 'sipariş durumu',
        ];
    }

    /**
     * Configure the validator instance.
     */
    public function withValidator($validator): void
    {
        $validator->after(function ($validator) {
            $order = $this->route('order');
            $newStatus = $this->input('status');

            if ($order && $newStatus && !$order->canBeUpdatedTo($newStatus)) {
                $validator->errors()->add('status', 'Bu sipariş durumu güncellenemez. Mevcut durum: ' . $order->status_label);
            }
        });
    }
}
