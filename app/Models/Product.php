<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Product extends Model
{
    /** @use HasFactory<\Database\Factories\ProductFactory> */
    use HasFactory;

    protected $fillable = [
        'name',
        'description',
        'price',
        'stock_quantity',
        'category_id',
    ];

    protected $casts = [
        'price' => 'decimal:2',
    ];

    public function category(): BelongsTo
    {
        return $this->belongsTo(Category::class);
    }

    public function orderItems()
    {
        return $this->hasMany(OrderItem::class);
    }

    /**
     * En çok satılan ürünleri getir
     */
    public function scopeTopSelling($query, $limit = 5)
    {
        return $query->select('id', 'name')
            ->withSum('orderItems', 'quantity')
            ->orderByDesc('order_items_sum_quantity')
            ->limit($limit);
    }

    /**
     * Toplam satış miktarı accessor
     */
    public function getTotalSoldAttribute(): int
    {
        return $this->order_items_sum_quantity ?: 0;
    }

    /**
     * Ürün adında arama yap
     */
    public function scopeSearch($query, $search)
    {
        if ($search) {
            return $query->where('name', 'LIKE', "%{$search}%")
                ->orWhere('description', 'LIKE', "%{$search}%");
        }
        return $query;
    }
    /**
     * Kategoriye göre filtreleme
     */
    public function scopeByCategory($query, $categoryId)
    {
        if ($categoryId) {
            return $query->where('category_id', $categoryId);
        }
        return $query;
    }

    /**
     * Fiyat aralığına göre filtreleme
     */
    public function scopePriceRange($query, $minPrice = null, $maxPrice = null)
    {
        if ($minPrice !== null) {
            $query->where('price', '>=', $minPrice);
        }
        if ($maxPrice !== null) {
            $query->where('price', '<=', $maxPrice);
        }
        return $query;
    }

    /**
     * Stokta olan ürünler
     */
    public function scopeInStock($query)
    {
        return $query->where('stock_quantity', '>', 0);
    }

    /**
     * Sıralama scope'u
     */
    public function scopeSortBy($query, $sortBy = 'name', $sortOrder = 'asc')
    {
        $allowedSorts = ['name', 'price', 'created_at', 'stock_quantity'];
        $allowedOrders = ['asc', 'desc'];

        if (in_array($sortBy, $allowedSorts) && in_array($sortOrder, $allowedOrders)) {
            return $query->orderBy($sortBy, $sortOrder);
        }

        return $query->orderBy('name', 'asc');
    }
}
