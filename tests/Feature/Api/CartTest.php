<?php

use App\Models\User;
use App\Models\Product;
use App\Models\Category;
use App\Models\Cart;
use App\Models\CartItem;
use Illuminate\Foundation\Testing\RefreshDatabase;

uses(RefreshDatabase::class);

beforeEach(function () {
    // Test için roller ve kullanıcıları oluştur
    $this->artisan('db:seed', ['--class' => 'RoleSeeder']);
    $this->artisan('db:seed', ['--class' => 'UserSeeder']);

    // Create user
    $this->user = User::find(2);

    // Create category and products
    $this->category = Category::factory()->create();
    $this->product = Product::factory()->create([
        'category_id' => $this->category->id,
        'stock_quantity' => 10,
        'price' => 99.99
    ]);
    $this->product2 = Product::factory()->create([
        'category_id' => $this->category->id,
        'stock_quantity' => 5,
        'price' => 149.99
    ]);
});

test('guest cannot access cart endpoints', function () {
    $this->getJson('/api/cart')
        ->assertStatus(401);

    $this->postJson('/api/cart/add')
        ->assertStatus(401);

    $this->putJson('/api/cart/update')
        ->assertStatus(401);

    $this->deleteJson('/api/cart/remove/1')
        ->assertStatus(401);

    $this->deleteJson('/api/cart/clear')
        ->assertStatus(401);
});

test('user can view empty cart', function () {
    $this->actingAs($this->user, 'sanctum')
        ->getJson('/api/cart')
        ->assertStatus(200)
        ->assertJsonStructure([
            'success',
            'message',
            'data' => [
                'id',
                'user_id',
                'items',
                'total',
                'total_items',
                'created_at',
                'updated_at'
            ]
        ])
        ->assertJson([
            'success' => true,
            'message' => 'Sepet başarıyla getirildi'
        ]);
});

test('user can add product to cart', function () {
    $response = $this->actingAs($this->user, 'sanctum')
        ->postJson('/api/cart/add', [
            'product_id' => $this->product->id,
            'quantity' => 2
        ]);

    $response->assertStatus(201)
        ->assertJson([
            'success' => true,
            'message' => 'Ürün sepete eklendi'
        ]);

    $this->assertDatabaseHas('carts', [
        'user_id' => $this->user->id
    ]);

    $this->assertDatabaseHas('cart_items', [
        'product_id' => $this->product->id,
        'quantity' => 2
    ]);
});

test('user can add same product multiple times - quantity increases', function () {
    // First add
    $this->actingAs($this->user, 'sanctum')
        ->postJson('/api/cart/add', [
            'product_id' => $this->product->id,
            'quantity' => 2
        ]);

    // Second add
    $this->actingAs($this->user, 'sanctum')
        ->postJson('/api/cart/add', [
            'product_id' => $this->product->id,
            'quantity' => 3
        ])
        ->assertStatus(201)
        ->assertJson([
            'success' => true,
            'message' => 'Ürün miktarı artırıldı'
        ]);

    $this->assertDatabaseHas('cart_items', [
        'product_id' => $this->product->id,
        'quantity' => 5
    ]);
});

test('user cannot add more than stock quantity', function () {
    $this->actingAs($this->user, 'sanctum')
        ->postJson('/api/cart/add', [
            'product_id' => $this->product->id,
            'quantity' => 15 // More than stock (10)
        ])
        ->assertStatus(400)
        ->assertJson([
            'success' => false,
            'message' => 'Yetersiz stok. Mevcut stok: 10'
        ]);

    $this->assertDatabaseMissing('cart_items', [
        'product_id' => $this->product->id
    ]);
});

test('user cannot exceed stock when adding to existing cart item', function () {
    // Add 8 items first
    $this->actingAs($this->user, 'sanctum')
        ->postJson('/api/cart/add', [
            'product_id' => $this->product->id,
            'quantity' => 8
        ]);

    // Try to add 5 more (total would be 13, but stock is 10)
    $this->actingAs($this->user, 'sanctum')
        ->postJson('/api/cart/add', [
            'product_id' => $this->product->id,
            'quantity' => 5
        ])
        ->assertStatus(400)
        ->assertJsonFragment([
            'message' => 'Yetersiz stok. Mevcut stok: 10, sepetteki miktar: 8'
        ]);

    // Quantity should remain 8
    $this->assertDatabaseHas('cart_items', [
        'product_id' => $this->product->id,
        'quantity' => 8
    ]);
});

test('add to cart validation works', function () {
    $this->actingAs($this->user, 'sanctum')
        ->postJson('/api/cart/add', [])
        ->assertStatus(422)
        ->assertJsonValidationErrors(['product_id', 'quantity']);

    $this->actingAs($this->user, 'sanctum')
        ->postJson('/api/cart/add', [
            'product_id' => 999, // Non-existent product
            'quantity' => 0 // Invalid quantity
        ])
        ->assertStatus(422)
        ->assertJsonValidationErrors(['product_id', 'quantity']);
});

test('user can view cart with items', function () {
    // Add items to cart
    Cart::factory()->create(['user_id' => $this->user->id]);
    CartItem::factory()->create([
        'cart_id' => $this->user->cart->id,
        'product_id' => $this->product->id,
        'quantity' => 2
    ]);

    $this->actingAs($this->user, 'sanctum')
        ->getJson('/api/cart')
        ->assertStatus(200)
        ->assertJsonStructure([
            'data' => [
                'items' => [
                    '*' => [
                        'id',
                        'product_id',
                        'quantity',
                        'total_price',
                        'product' => [
                            'id',
                            'name',
                            'price',
                            'category'
                        ]
                    ]
                ]
            ]
        ]);
});

test('user can update cart item quantity', function () {
    // Create cart with item
    $cart = Cart::factory()->create(['user_id' => $this->user->id]);
    CartItem::factory()->create([
        'cart_id' => $cart->id,
        'product_id' => $this->product->id,
        'quantity' => 2
    ]);

    $this->actingAs($this->user, 'sanctum')
        ->putJson('/api/cart/update', [
            'product_id' => $this->product->id,
            'quantity' => 5
        ])
        ->assertStatus(200)
        ->assertJson([
            'success' => true,
            'message' => 'Sepet güncellendi'
        ]);

    $this->assertDatabaseHas('cart_items', [
        'product_id' => $this->product->id,
        'quantity' => 5
    ]);
});

test('user cannot update cart item beyond stock', function () {
    // Create cart with item
    $cart = Cart::factory()->create(['user_id' => $this->user->id]);
    CartItem::factory()->create([
        'cart_id' => $cart->id,
        'product_id' => $this->product->id,
        'quantity' => 2
    ]);

    $this->actingAs($this->user, 'sanctum')
        ->putJson('/api/cart/update', [
            'product_id' => $this->product->id,
            'quantity' => 15 // More than stock (10)
        ])
        ->assertStatus(400)
        ->assertJsonFragment([
            'message' => 'Yetersiz stok. Mevcut stok: 10'
        ]);

    // Quantity should remain unchanged
    $this->assertDatabaseHas('cart_items', [
        'product_id' => $this->product->id,
        'quantity' => 2
    ]);
});

test('user cannot update non-existent cart item', function () {
    $this->actingAs($this->user, 'sanctum')
        ->putJson('/api/cart/update', [
            'product_id' => $this->product->id,
            'quantity' => 5
        ])
        ->assertStatus(404)
        ->assertJson([
            'success' => false,
            'message' => 'Sepet bulunamadı'
        ]);
});

test('user cannot update cart item not in cart', function () {
    // Create empty cart
    Cart::factory()->create(['user_id' => $this->user->id]);

    $this->actingAs($this->user, 'sanctum')
        ->putJson('/api/cart/update', [
            'product_id' => $this->product->id,
            'quantity' => 5
        ])
        ->assertStatus(404)
        ->assertJson([
            'success' => false,
            'message' => 'Ürün sepette bulunamadı'
        ]);
});

test('update cart validation works', function () {
    $this->actingAs($this->user, 'sanctum')
        ->putJson('/api/cart/update', [])
        ->assertStatus(422)
        ->assertJsonValidationErrors(['product_id', 'quantity']);
});

test('user can remove item from cart', function () {
    // Create cart with item
    $cart = Cart::factory()->create(['user_id' => $this->user->id]);
    CartItem::factory()->create([
        'cart_id' => $cart->id,
        'product_id' => $this->product->id,
        'quantity' => 2
    ]);

    $this->actingAs($this->user, 'sanctum')
        ->deleteJson("/api/cart/remove/{$this->product->id}")
        ->assertStatus(200)
        ->assertJson([
            'success' => true,
            'message' => 'Ürün sepetten çıkarıldı'
        ]);

    $this->assertDatabaseMissing('cart_items', [
        'product_id' => $this->product->id
    ]);
});

test('user cannot remove item from empty cart', function () {
    $this->actingAs($this->user, 'sanctum')
        ->deleteJson("/api/cart/remove/{$this->product->id}")
        ->assertStatus(404)
        ->assertJson([
            'success' => false,
            'message' => 'Sepet bulunamadı'
        ]);
});

test('user cannot remove non-existent item from cart', function () {
    // Create empty cart
    Cart::factory()->create(['user_id' => $this->user->id]);

    $this->actingAs($this->user, 'sanctum')
        ->deleteJson("/api/cart/remove/{$this->product->id}")
        ->assertStatus(404)
        ->assertJson([
            'success' => false,
            'message' => 'Ürün sepette bulunamadı'
        ]);
});

test('user can clear entire cart', function () {
    // Create cart with multiple items
    $cart = Cart::factory()->create(['user_id' => $this->user->id]);
    CartItem::factory()->create([
        'cart_id' => $cart->id,
        'product_id' => $this->product->id,
        'quantity' => 2
    ]);
    CartItem::factory()->create([
        'cart_id' => $cart->id,
        'product_id' => $this->product2->id,
        'quantity' => 1
    ]);

    $this->actingAs($this->user, 'sanctum')
        ->deleteJson('/api/cart/clear')
        ->assertStatus(200)
        ->assertJson([
            'success' => true,
            'message' => 'Sepet temizlendi'
        ]);

    // All cart items should be deleted
    $this->assertDatabaseMissing('cart_items', [
        'cart_id' => $cart->id
    ]);

    // But cart itself should remain
    $this->assertDatabaseHas('carts', [
        'id' => $cart->id
    ]);
});

test('user cannot clear empty cart', function () {
    $this->actingAs($this->user, 'sanctum')
        ->deleteJson('/api/cart/clear')
        ->assertStatus(404)
        ->assertJson([
            'success' => false,
            'message' => 'Sepet bulunamadı'
        ]);
});

test('cart total calculation works correctly', function () {
    // Create cart with items
    $cart = Cart::factory()->create(['user_id' => $this->user->id]);
    CartItem::factory()->create([
        'cart_id' => $cart->id,
        'product_id' => $this->product->id, // price: 99.99
        'quantity' => 2
    ]);
    CartItem::factory()->create([
        'cart_id' => $cart->id,
        'product_id' => $this->product2->id, // price: 149.99
        'quantity' => 1
    ]);

    $response = $this->actingAs($this->user, 'sanctum')
        ->getJson('/api/cart')
        ->assertStatus(200);

    $data = $response->json('data');

    // Total should be: (99.99 * 2) + (149.99 * 1) = 349.97
    expect($data['total'])->toBe(349.97);
    expect($data['total_items'])->toBe(3);
});
