<?php

namespace App\Observers;

use App\Models\OrderItem;

class OrderItemObserver
{
    /**
     * Handle the OrderItem "created" event.
     */
    public function created(OrderItem $orderItem): void
    {
        // Sipariş kalemi oluşturulduğunda stoktan düş
        $orderItem->product->decrement('stock_quantity', $orderItem->quantity);
    }

    /**
     * Handle the OrderItem "updated" event.
     */
    public function updated(OrderItem $orderItem): void
    {
        // Eğer quantity değişmişse stok farkını hesapla
        if ($orderItem->isDirty('quantity')) {
            $oldQuantity = $orderItem->getOriginal('quantity');
            $newQuantity = $orderItem->quantity;
            $difference = $newQuantity - $oldQuantity;

            // Farkı stoktan düş/ekle
            $orderItem->product->decrement('stock_quantity', $difference);
        }
    }

    /**
     * Handle the OrderItem "deleted" event.
     */
    public function deleted(OrderItem $orderItem): void
    {
        // Sipariş kalemi silindiğinde stoğa geri ekle
        $orderItem->product->increment('stock_quantity', $orderItem->quantity);
    }
}
