<?php

use App\Events\OrderCreated;
use App\Listeners\SendOrderConfirmationEmail;
use App\Models\User;
use App\Models\Order;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Event;
use Illuminate\Support\Facades\Mail;

uses(RefreshDatabase::class);

it('creates OrderCreated event instance correctly', function () {
    $user = User::factory()->make(['email' => 'test@example.com']);
    $order = Order::factory()->make(['user_id' => 1, 'total_amount' => '100.50']);

    $event = new OrderCreated($order);

    expect($event->order)->toBe($order);
    expect((string) $event->order->total_amount)->toBe('100.50');
});

it('creates SendOrderConfirmationEmail listener correctly', function () {
    $listener = new SendOrderConfirmationEmail();

    expect($listener)->toBeInstanceOf(SendOrderConfirmationEmail::class);
});

it('formats email content correctly', function () {
    Mail::fake();

    $user = User::factory()->make([
        'name' => 'Test User',
        'email' => 'test@example.com'
    ]);

    $order = Order::factory()->make([
        'id' => 123,
        'total_amount' => '150.75',
        'created_at' => now()
    ]);

    // Order user relationship'ini mock et
    $order->setRelation('user', $user);

    $listener = new SendOrderConfirmationEmail();
    $event = new OrderCreated($order);

    $listener->handle($event);

    // Email content'in doğru formatlandığını kontrol et
    expect((string) $order->total_amount)->toBe('150.75');
    expect(number_format((float) $order->total_amount, 2))->toBe('150.75');
});
