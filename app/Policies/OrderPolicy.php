<?php

namespace App\Policies;

use App\Models\Order;
use App\Models\User;
use Illuminate\Auth\Access\Response;

class OrderPolicy
{
    /**
     * Kullanıcı siparişleri listeleyebilir mi?
     */
    public function viewAny(User $user): bool
    {
        return true; // Authenticated kullanıcılar kendi siparişlerini görebilir
    }

    /**
     * Kullanıcı belirli bir siparişi görüntüleyebilir mi?
     */
    public function view(User $user, Order $order): bool
    {
        return $user->id === $order->user_id;
    }

    /**
     * Kullanıcı sipariş oluşturabilir mi?
     */
    public function create(User $user): bool
    {
        return true; // Authenticated kullanıcılar sipariş oluşturabilir
    }

    /**
     * Kullanıcı siparişi güncelleyebilir mi?
     */
    public function update(User $user, Order $order): bool
    {
        // Sadece pending durumdaki kendi siparişlerini güncelleyebilir
        return $user->id === $order->user_id && $order->status === 'pending';
    }

    /**
     * Kullanıcı siparişi silebilir mi?
     */
    public function delete(User $user, Order $order): bool
    {
        // Sadece pending durumdaki kendi siparişlerini iptal edebilir
        return $user->id === $order->user_id && $order->status === 'pending';
    }

    /**
     * Kullanıcı siparişi geri yükleyebilir mi?
     */
    public function restore(User $user, Order $order): bool
    {
        return $user->id === $order->user_id;
    }

    /**
     * Kullanıcı siparişi kalıcı olarak silebilir mi?
     */
    public function forceDelete(User $user, Order $order): bool
    {
        return $user->id === $order->user_id;
    }
}
