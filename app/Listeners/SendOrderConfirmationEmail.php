<?php

namespace App\Listeners;

use App\Events\OrderCreated;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;

class SendOrderConfirmationEmail implements ShouldQueue
{
    use InteractsWithQueue;

    /**
     * Create the event listener.
     */
    public function __construct()
    {
        //
    }

    /**
     * Handle the event.
     */
    public function handle(OrderCreated $event): void
    {
        $order = $event->order;
        $user = $order->user;

        try {
            // Email gönderme simülasyonu (Mailtrap kullanıyorsunuz)
            Log::info('Sipariş onay emaili gönderiliyor', [
                'order_id' => $order->id,
                'user_id' => $user->id,
                'user_email' => $user->email,
                'total_amount' => $order->total_amount
            ]);

            // Gerçek email gönderimi burada olacak
            // Mail::to($user->email)->send(new OrderConfirmation($order));

            // Mailtrap test için basit mail gönderimi
            Mail::raw(
                "Merhaba {$user->name},\n\n" .
                    "Siparişiniz başarıyla oluşturuldu!\n\n" .
                    "Sipariş No: {$order->id}\n" .
                    "Toplam Tutar: " . number_format((float) $order->total_amount, 2) . " TL\n" .
                    "Sipariş Tarihi: {$order->created_at->format('d.m.Y H:i')}\n\n" .
                    "Siparişinizi takip edebilirsiniz.\n\n" .
                    "Teşekkürler!",
                function ($message) use ($user, $order) {
                    $message->to($user->email, $user->name)
                        ->subject("Sipariş Onayı - #{$order->id}");
                }
            );

            Log::info('Sipariş onay emaili başarıyla gönderildi', [
                'order_id' => $order->id,
                'user_email' => $user->email
            ]);
        } catch (\Exception $e) {
            Log::error('Sipariş onay emaili gönderilemedi', [
                'order_id' => $order->id,
                'user_email' => $user->email,
                'error' => $e->getMessage()
            ]);

            // Email gönderimi başarısız olsa da sipariş işlemi devam etsin
            // Bu nedenle exception'ı yeniden fırlatmıyoruz
        }
    }

    /**
     * Handle a job failure.
     */
    public function failed(OrderCreated $event, \Throwable $exception): void
    {
        Log::error('Email gönderme job\'ı başarısız oldu', [
            'order_id' => $event->order->id,
            'error' => $exception->getMessage()
        ]);
    }
}
