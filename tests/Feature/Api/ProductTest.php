<?php

use App\Models\Category;
use App\Models\Product;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;

uses(RefreshDatabase::class);

beforeEach(function () {
    // Test için roller ve kullanıcıları oluştur
    $this->artisan('db:seed', ['--class' => 'RoleSeeder']);
    $this->artisan('db:seed', ['--class' => 'UserSeeder']);
});

test('guest user can list products', function () {
    $category = Category::factory()->create();
    Product::factory(3)->create(['category_id' => $category->id]);

    $response = $this->getJson('/api/products');

    $response->assertStatus(200)
        ->assertJsonStructure([
            'success',
            'message',
            'data' => [
                '*' => [
                    'id',
                    'name',
                    'description',
                    'price',
                    'stock_quantity',
                    'category_id',
                    'category',
                    'created_at',
                    'updated_at',
                ]
            ],
            'errors'
        ])
        ->assertJson([
            'success' => true,
            'message' => 'Ürünler başarıyla listelendi',
        ]);

    expect($response->json('data'))->toHaveCount(3);
});

test('guest user can view single product', function () {
    $category = Category::factory()->create();
    $product = Product::factory()->create(['category_id' => $category->id]);

    $response = $this->getJson("/api/products/{$product->id}");

    $response->assertStatus(200)
        ->assertJsonStructure([
            'success',
            'message',
            'data' => [
                'id',
                'name',
                'description',
                'price',
                'stock_quantity',
                'category_id',
                'category',
                'created_at',
                'updated_at',
            ],
            'errors'
        ])
        ->assertJson([
            'success' => true,
            'message' => 'Ürün başarıyla getirildi',
            'data' => [
                'id' => $product->id,
                'name' => $product->name,
                'price' => $product->price,
            ]
        ]);
});

test('guest user cannot view non-existent product', function () {
    $response = $this->getJson('/api/products/999');

    $response->assertStatus(404);
});

test('admin can create product', function () {
    $user = User::factory()->create();
    $user->assignRole('admin');
    $category = Category::factory()->create();

    $productData = [
        'name' => fake()->words(3, true),
        'description' => fake()->sentence(10),
        'price' => fake()->randomFloat(2, 10, 1000),
        'stock_quantity' => fake()->numberBetween(1, 100),
        'category_id' => $category->id,
    ];

    $response = $this->actingAs($user)
        ->postJson('/api/products', $productData);

    $response->assertStatus(201)
        ->assertJsonStructure([
            'success',
            'message',
            'data' => [
                'id',
                'name',
                'description',
                'price',
                'stock_quantity',
                'category_id',
                'category',
                'created_at',
                'updated_at',
            ],
            'errors'
        ])
        ->assertJson([
            'success' => true,
            'message' => 'Ürün başarıyla oluşturuldu',
            'data' => [
                'name' => $productData['name'],
                'price' => $productData['price'],
            ]
        ]);

    $this->assertDatabaseHas('products', [
        'name' => $productData['name'],
        'price' => $productData['price'],
    ]);
});

test('normal user cannot create product', function () {
    $user = User::factory()->create();
    $category = Category::factory()->create();

    $productData = [
        'name' => fake()->words(3, true),
        'description' => fake()->sentence(10),
        'price' => fake()->randomFloat(2, 10, 1000),
        'stock_quantity' => fake()->numberBetween(1, 100),
        'category_id' => $category->id,
    ];

    $response = $this->actingAs($user)
        ->postJson('/api/products', $productData);

    $response->assertStatus(403)
        ->assertJson([
            'success' => false,
            'message' => 'Bu işlem için admin yetkisi gerekli.',
        ]);
});

test('guest user cannot create product', function () {
    $category = Category::factory()->create();

    $productData = [
        'name' => fake()->words(3, true),
        'description' => fake()->sentence(10),
        'price' => fake()->randomFloat(2, 10, 1000),
        'stock_quantity' => fake()->numberBetween(1, 100),
        'category_id' => $category->id,
    ];

    $response = $this->postJson('/api/products', $productData);

    $response->assertStatus(401);
});

test('product creation validation works', function () {
    $user = User::factory()->create();
    $user->assignRole('admin');

    $response = $this->actingAs($user)
        ->postJson('/api/products', []);

    $response->assertStatus(422)
        ->assertJsonValidationErrors(['name', 'price', 'stock_quantity', 'category_id']);
});

test('product name must be at least 3 characters', function () {
    $user = User::factory()->create();
    $user->assignRole('admin');
    $category = Category::factory()->create();

    $response = $this->actingAs($user)
        ->postJson('/api/products', [
            'name' => 'ab', // 2 karakter
            'price' => 100,
            'stock_quantity' => 10,
            'category_id' => $category->id,
        ]);

    $response->assertStatus(422)
        ->assertJsonValidationErrors(['name']);
});

test('product price must be positive', function () {
    $user = User::factory()->create();
    $user->assignRole('admin');
    $category = Category::factory()->create();

    $response = $this->actingAs($user)
        ->postJson('/api/products', [
            'name' => 'Test Product',
            'price' => 0, // sıfır
            'stock_quantity' => 10,
            'category_id' => $category->id,
        ]);

    $response->assertStatus(422)
        ->assertJsonValidationErrors(['price']);
});

test('product stock cannot be negative', function () {
    $user = User::factory()->create();
    $user->assignRole('admin');
    $category = Category::factory()->create();

    $response = $this->actingAs($user)
        ->postJson('/api/products', [
            'name' => 'Test Product',
            'price' => 100,
            'stock_quantity' => -1, // negatif
            'category_id' => $category->id,
        ]);

    $response->assertStatus(422)
        ->assertJsonValidationErrors(['stock_quantity']);
});

test('product name must be unique', function () {
    $user = User::factory()->create();
    $user->assignRole('admin');
    $category = Category::factory()->create();
    $existingProduct = Product::factory()->create(['category_id' => $category->id]);

    $response = $this->actingAs($user)
        ->postJson('/api/products', [
            'name' => $existingProduct->name,
            'price' => 100,
            'stock_quantity' => 10,
            'category_id' => $category->id,
        ]);

    $response->assertStatus(422)
        ->assertJsonValidationErrors(['name']);
});

test('admin can update product', function () {
    $user = User::factory()->create();
    $user->assignRole('admin');
    $category = Category::factory()->create();
    $product = Product::factory()->create(['category_id' => $category->id]);

    $updateData = [
        'name' => fake()->words(3, true),
        'price' => fake()->randomFloat(2, 10, 1000),
        'stock_quantity' => fake()->numberBetween(1, 100),
    ];

    $response = $this->actingAs($user)
        ->putJson("/api/products/{$product->id}", $updateData);

    $response->assertStatus(200)
        ->assertJson([
            'success' => true,
            'message' => 'Ürün başarıyla güncellendi',
            'data' => [
                'id' => $product->id,
                'name' => $updateData['name'],
                'price' => $updateData['price'],
            ]
        ]);

    $this->assertDatabaseHas('products', [
        'id' => $product->id,
        'name' => $updateData['name'],
        'price' => $updateData['price'],
    ]);
});

test('normal user cannot update product', function () {
    $user = User::factory()->create();
    $category = Category::factory()->create();
    $product = Product::factory()->create(['category_id' => $category->id]);

    $updateData = [
        'name' => fake()->words(3, true),
        'price' => fake()->randomFloat(2, 10, 1000),
    ];

    $response = $this->actingAs($user)
        ->putJson("/api/products/{$product->id}", $updateData);

    $response->assertStatus(403);
});

test('admin can delete product', function () {
    $user = User::factory()->create();
    $user->assignRole('admin');
    $category = Category::factory()->create();
    $product = Product::factory()->create(['category_id' => $category->id]);

    $response = $this->actingAs($user)
        ->deleteJson("/api/products/{$product->id}");

    $response->assertStatus(200)
        ->assertJson([
            'success' => true,
            'message' => 'Ürün başarıyla silindi',
            'data' => null,
        ]);

    $this->assertDatabaseMissing('products', [
        'id' => $product->id,
    ]);
});

test('normal user cannot delete product', function () {
    $user = User::factory()->create();
    $category = Category::factory()->create();
    $product = Product::factory()->create(['category_id' => $category->id]);

    $response = $this->actingAs($user)
        ->deleteJson("/api/products/{$product->id}");

    $response->assertStatus(403);
});

test('non-existent product cannot be deleted', function () {
    $user = User::factory()->create();
    $user->assignRole('admin');

    $response = $this->actingAs($user)
        ->deleteJson('/api/products/999');

    $response->assertStatus(404);
});

test('empty product list returns correct format', function () {
    $response = $this->getJson('/api/products');

    $response->assertStatus(200)
        ->assertJson([
            'success' => true,
            'message' => 'Ürünler başarıyla listelendi',
            'data' => [],
        ]);
});
