<?php

use App\Models\Cart;
use App\Models\CartItem;
use App\Models\Category;
use App\Models\Order;
use App\Models\Product;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;

uses(RefreshDatabase::class);

beforeEach(function () {
    $this->user = User::factory()->create();
    $this->category = Category::factory()->create();
    $this->product = Product::factory()->create([
        'category_id' => $this->category->id,
        'stock_quantity' => 10,
        'price' => 100.00,
    ]);
});

test('user can create an order from cart', function () {
    // Sepete ürün ekleme
    $cart = Cart::create(['user_id' => $this->user->id]);
    CartItem::create([
        'cart_id' => $cart->id,
        'product_id' => $this->product->id,
        'quantity' => 2,
    ]);

    $response = $this->actingAs($this->user, 'sanctum')
        ->postJson('/api/orders');

    $response->assertStatus(201)
        ->assertJsonStructure([
            'data' => [
                'id',
                'user_id',
                'total_amount',
                'status',
                'total_items',
                'order_items' => [
                    '*' => [
                        'id',
                        'product_id',
                        'quantity',
                        'price',
                        'subtotal',
                    ]
                ],
                'created_at',
                'updated_at',
            ]
        ]);

    // Verify order was created
    $this->assertDatabaseHas('orders', [
        'user_id' => $this->user->id,
        'total_amount' => 200.00,
        'status' => 'pending',
    ]);

    // Verify order items were created
    $this->assertDatabaseHas('order_items', [
        'product_id' => $this->product->id,
        'quantity' => 2,
        'price' => 100.00,
    ]);

    // Verify stock was reduced
    $this->product->refresh();
    expect($this->product->stock_quantity)->toBe(8);

    // Verify cart was cleared
    $this->assertDatabaseMissing('carts', ['user_id' => $this->user->id]);
    $this->assertDatabaseMissing('cart_items', ['cart_id' => $cart->id]);
});

test('user cannot create order with empty cart', function () {
    $response = $this->actingAs($this->user, 'sanctum')
        ->postJson('/api/orders');

    $response->assertStatus(400)
        ->assertJson([
            'message' => 'Sepetinizde ürün bulunmuyor.',
        ]);
});

test('user cannot create order when product stock is insufficient', function () {
    // Ürünün stokunu azalt
    $this->product->update(['stock_quantity' => 1]);

    // Sepete stoktan fazla ürün ekleme
    $cart = Cart::create(['user_id' => $this->user->id]);
    CartItem::create([
        'cart_id' => $cart->id,
        'product_id' => $this->product->id,
        'quantity' => 5, // Stock'tan fazla
    ]);

    $response = $this->actingAs($this->user, 'sanctum')
        ->postJson('/api/orders');

    $response->assertStatus(400)
        ->assertJsonFragment([
            'message' => 'Sipariş oluşturulurken bir hata oluştu: Ürün \'' . $this->product->name . '\' için yeterli stok yok.',
        ]);

    // Verify no order was created
    $this->assertDatabaseMissing('orders', ['user_id' => $this->user->id]);
});

test('user can list their orders', function () {
    // Create orders for user
    $order1 = Order::factory()->create([
        'user_id' => $this->user->id,
        'total_amount' => 150.00,
        'status' => 'pending',
        'created_at' => now()->subMinutes(10),
    ]);

    $order2 = Order::factory()->create([
        'user_id' => $this->user->id,
        'total_amount' => 300.00,
        'status' => 'completed',
        'created_at' => now(),
    ]);

    // Create order for another user (should not appear)
    $anotherUser = User::factory()->create();
    Order::factory()->create([
        'user_id' => $anotherUser->id,
        'total_amount' => 200.00,
    ]);

    $response = $this->actingAs($this->user, 'sanctum')
        ->getJson('/api/orders');

    $response->assertStatus(200)
        ->assertJsonStructure([
            'data' => [
                '*' => [
                    'id',
                    'user_id',
                    'total_amount',
                    'status',
                    'total_items',
                    'created_at',
                    'updated_at',
                ]
            ],
            'links',
            'meta',
        ]);

    $responseData = $response->json('data');
    expect($responseData)->toHaveCount(2);
    expect($responseData[0]['total_amount'])->toBe('300.00'); // Latest first
    expect($responseData[1]['total_amount'])->toBe('150.00');
});

test('user can view order details', function () {
    $order = Order::factory()->create([
        'user_id' => $this->user->id,
        'total_amount' => 200.00,
        'status' => 'pending',
    ]);

    $response = $this->actingAs($this->user, 'sanctum')
        ->getJson('/api/orders/' . $order->id);

    $response->assertStatus(200)
        ->assertJsonStructure([
            'data' => [
                'id',
                'user_id',
                'total_amount',
                'status',
                'total_items',
                'order_items',
                'created_at',
                'updated_at',
            ]
        ]);

    expect($response->json('data.id'))->toBe($order->id);
    expect($response->json('data.user_id'))->toBe($this->user->id);
});

test('user cannot view other users orders', function () {
    $anotherUser = User::factory()->create();
    $order = Order::factory()->create(['user_id' => $anotherUser->id]);

    $response = $this->actingAs($this->user, 'sanctum')
        ->getJson('/api/orders/' . $order->id);

    $response->assertStatus(403); // Policy authorization 403 döner
});

test('guest cannot access order endpoints', function () {
    $response = $this->getJson('/api/orders');
    $response->assertStatus(401);

    $response = $this->postJson('/api/orders');
    $response->assertStatus(401);

    $order = Order::factory()->create();
    $response = $this->getJson('/api/orders/' . $order->id);
    $response->assertStatus(401);
});

test('order has correct total items calculation', function () {
    $order = Order::factory()->create(['user_id' => $this->user->id]);

    // Add order items
    $order->orderItems()->create([
        'product_id' => $this->product->id,
        'quantity' => 3,
        'price' => 100.00,
    ]);

    $order->orderItems()->create([
        'product_id' => Product::factory()->create(['category_id' => $this->category->id])->id,
        'quantity' => 2,
        'price' => 50.00,
    ]);

    expect($order->total_items)->toBe(5); // 3 + 2
});

test('order status methods work correctly', function () {
    $order = Order::factory()->create([
        'user_id' => $this->user->id,
        'status' => 'pending',
    ]);

    expect($order->isPending())->toBeTrue();
    expect($order->isCompleted())->toBeFalse();
    expect($order->isCancelled())->toBeFalse();

    $order->markAsCompleted();
    expect($order->isCompleted())->toBeTrue();
    expect($order->isPending())->toBeFalse();

    $order->markAsCancelled();
    expect($order->isCancelled())->toBeTrue();
    expect($order->isCompleted())->toBeFalse();
});
