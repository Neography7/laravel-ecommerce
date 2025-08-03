<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Order extends Model
{
    /** @use HasFactory<\Database\Factories\OrderFactory> */
    use HasFactory;

    const STATUS_PENDING = 'pending';
    const STATUS_PROCESSING = 'processing';
    const STATUS_SHIPPED = 'shipped';
    const STATUS_DELIVERED = 'delivered';
    const STATUS_CANCELLED = 'cancelled';
    const STATUS_REFUNDED = 'refunded';

    const STATUSES = [
        self::STATUS_PENDING,
        self::STATUS_PROCESSING,
        self::STATUS_SHIPPED,
        self::STATUS_DELIVERED,
        self::STATUS_CANCELLED,
        self::STATUS_REFUNDED,
    ];

    const STATUS_LABELS = [
        self::STATUS_PENDING => 'Beklemede',
        self::STATUS_PROCESSING => 'İşleniyor',
        self::STATUS_SHIPPED => 'Kargoya Verildi',
        self::STATUS_DELIVERED => 'Teslim Edildi',
        self::STATUS_CANCELLED => 'İptal Edildi',
        self::STATUS_REFUNDED => 'İade Edildi',
    ];

    protected $fillable = [
        'user_id',
        'total_amount',
        'status',
    ];

    protected $casts = [
        'total_amount' => 'decimal:2',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function orderItems(): HasMany
    {
        return $this->hasMany(OrderItem::class);
    }

    public function getTotalItemsAttribute(): int
    {
        return $this->orderItems->sum('quantity');
    }

    public function isPending(): bool
    {
        return $this->status === self::STATUS_PENDING;
    }

    public function isProcessing(): bool
    {
        return $this->status === self::STATUS_PROCESSING;
    }

    public function isShipped(): bool
    {
        return $this->status === self::STATUS_SHIPPED;
    }

    public function isDelivered(): bool
    {
        return $this->status === self::STATUS_DELIVERED;
    }

    public function isCancelled(): bool
    {
        return $this->status === self::STATUS_CANCELLED;
    }

    public function isRefunded(): bool
    {
        return $this->status === self::STATUS_REFUNDED;
    }

    public function isCompleted(): bool
    {
        return $this->status === self::STATUS_DELIVERED;
    }

    public function markAsProcessing(): void
    {
        $this->update(['status' => self::STATUS_PROCESSING]);
    }

    public function markAsShipped(): void
    {
        $this->update(['status' => self::STATUS_SHIPPED]);
    }

    public function markAsDelivered(): void
    {
        $this->update(['status' => self::STATUS_DELIVERED]);
    }

    public function markAsCancelled(): void
    {
        $this->update(['status' => self::STATUS_CANCELLED]);
    }

    public function markAsCompleted(): void
    {
        $this->update(['status' => self::STATUS_DELIVERED]);
    }

    public function markAsRefunded(): void
    {
        $this->update(['status' => self::STATUS_REFUNDED]);
    }

    public function getStatusLabelAttribute(): string
    {
        return self::STATUS_LABELS[$this->status] ?? $this->status;
    }

    public function canBeUpdatedTo(string $newStatus): bool
    {
        // İptal edilmiş, iade edilmiş veya teslim edilmiş siparişlerin durumu değiştirilemez
        if ($this->isCancelled() || $this->isDelivered() || $this->isRefunded()) {
            return false;
        }

        // Geçersiz status kontrolü
        if (!in_array($newStatus, self::STATUSES)) {
            return false;
        }

        // Status progression logic
        $statusOrder = [
            self::STATUS_PENDING => 0,
            self::STATUS_PROCESSING => 1,
            self::STATUS_SHIPPED => 2,
            self::STATUS_DELIVERED => 3,
            self::STATUS_CANCELLED => 99, // İptal her zaman mümkün (final durumlar hariç)
            self::STATUS_REFUNDED => 99, // İade teslim edildikten sonra mümkün
        ];

        $currentOrder = $statusOrder[$this->status];
        $newOrder = $statusOrder[$newStatus];

        // İptal veya iade her zaman mümkün (final durumlar hariç)
        if ($newStatus === self::STATUS_CANCELLED || $newStatus === self::STATUS_REFUNDED) {
            return true;
        }

        // Geriye doğru güncelleme yapılamaz
        return $newOrder > $currentOrder;
    }
}
