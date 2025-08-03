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
                'products' => [
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
                'pagination' => [
                    'current_page',
                    'per_page',
                    'total',
                    'last_page',
                    'from',
                    'to',
                    'has_more_pages',
                ],
                'filters'
            ],
            'errors'
        ])
        ->assertJson([
            'success' => true,
            'message' => 'Ürünler başarıyla listelendi',
        ]);

    expect($response->json('data.products'))->toHaveCount(3);
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
            'data' => [
                'products' => [],
                'pagination' => [
                    'current_page' => 1,
                    'per_page' => 15,
                    'total' => 0,
                    'last_page' => 1,
                    'has_more_pages' => false,
                ],
                'filters' => [
                    'sort_by' => 'name',
                    'sort_order' => 'asc',
                ]
            ],
        ]);
});

// Yeni gelişmiş arama ve filtreleme testleri
test('products can be searched by name', function () {
    $category = Category::factory()->create();
    Product::factory()->create(['name' => 'iPhone 15', 'category_id' => $category->id]);
    Product::factory()->create(['name' => 'Samsung Galaxy', 'category_id' => $category->id]);
    Product::factory()->create(['name' => 'MacBook Pro', 'category_id' => $category->id]);

    $response = $this->getJson('/api/products?search=iPhone');

    $response->assertStatus(200)
        ->assertJsonPath('data.pagination.total', 1)
        ->assertJsonPath('data.products.0.name', 'iPhone 15')
        ->assertJsonPath('data.filters.search', 'iPhone');
});

test('products can be searched by description', function () {
    $category = Category::factory()->create();
    Product::factory()->create(['name' => 'Test Product', 'description' => 'This is an iPhone description', 'category_id' => $category->id]);
    Product::factory()->create(['name' => 'Another Product', 'description' => 'Samsung device', 'category_id' => $category->id]);

    $response = $this->getJson('/api/products?search=iPhone');

    $response->assertStatus(200)
        ->assertJsonPath('data.pagination.total', 1)
        ->assertJsonPath('data.products.0.name', 'Test Product');
});

test('search requires minimum 2 characters', function () {
    $response = $this->getJson('/api/products?search=a');

    $response->assertStatus(422)
        ->assertJsonValidationErrors(['search']);
});

test('products can be filtered by category', function () {
    $category1 = Category::factory()->create(['name' => 'Electronics']);
    $category2 = Category::factory()->create(['name' => 'Books']);

    Product::factory(2)->create(['category_id' => $category1->id]);
    Product::factory(3)->create(['category_id' => $category2->id]);

    $response = $this->getJson("/api/products?category_id={$category1->id}");

    $response->assertStatus(200)
        ->assertJsonPath('data.pagination.total', 2)
        ->assertJsonPath('data.filters.category_id', $category1->id);
});

test('products can be filtered by price range', function () {
    $category = Category::factory()->create();
    Product::factory()->create(['price' => 50, 'category_id' => $category->id]);
    Product::factory()->create(['price' => 150, 'category_id' => $category->id]);
    Product::factory()->create(['price' => 250, 'category_id' => $category->id]);

    $response = $this->getJson('/api/products?min_price=100&max_price=200');

    $response->assertStatus(200)
        ->assertJsonPath('data.pagination.total', 1)
        ->assertJsonPath('data.products.0.price', '150.00')
        ->assertJsonPath('data.filters.min_price', 100)
        ->assertJsonPath('data.filters.max_price', 200);
});

test('max_price must be greater than or equal to min_price', function () {
    $response = $this->getJson('/api/products?min_price=200&max_price=100');

    $response->assertStatus(422)
        ->assertJsonValidationErrors(['max_price']);
});

test('products can be filtered by stock availability', function () {
    $category = Category::factory()->create();
    Product::factory()->create(['stock_quantity' => 0, 'category_id' => $category->id]);
    Product::factory()->create(['stock_quantity' => 5, 'category_id' => $category->id]);
    Product::factory()->create(['stock_quantity' => 10, 'category_id' => $category->id]);

    $response = $this->getJson('/api/products?in_stock=1');

    $response->assertStatus(200)
        ->assertJsonPath('data.pagination.total', 2)
        ->assertJsonPath('data.filters.in_stock', true);
});

test('products can be sorted by price ascending', function () {
    $category = Category::factory()->create();
    Product::factory()->create(['name' => 'Expensive', 'price' => 300, 'category_id' => $category->id]);
    Product::factory()->create(['name' => 'Cheap', 'price' => 100, 'category_id' => $category->id]);
    Product::factory()->create(['name' => 'Medium', 'price' => 200, 'category_id' => $category->id]);

    $response = $this->getJson('/api/products?sort_by=price&sort_order=asc');

    $response->assertStatus(200)
        ->assertJsonPath('data.products.0.name', 'Cheap')
        ->assertJsonPath('data.products.1.name', 'Medium')
        ->assertJsonPath('data.products.2.name', 'Expensive')
        ->assertJsonPath('data.filters.sort_by', 'price')
        ->assertJsonPath('data.filters.sort_order', 'asc');
});

test('products can be sorted by price descending', function () {
    $category = Category::factory()->create();
    Product::factory()->create(['name' => 'Expensive', 'price' => 300, 'category_id' => $category->id]);
    Product::factory()->create(['name' => 'Cheap', 'price' => 100, 'category_id' => $category->id]);
    Product::factory()->create(['name' => 'Medium', 'price' => 200, 'category_id' => $category->id]);

    $response = $this->getJson('/api/products?sort_by=price&sort_order=desc');

    $response->assertStatus(200)
        ->assertJsonPath('data.products.0.name', 'Expensive')
        ->assertJsonPath('data.products.1.name', 'Medium')
        ->assertJsonPath('data.products.2.name', 'Cheap');
});

test('products pagination works correctly', function () {
    $category = Category::factory()->create();
    Product::factory(25)->create(['category_id' => $category->id]);

    $response = $this->getJson('/api/products?per_page=10&page=1');

    $response->assertStatus(200)
        ->assertJsonPath('data.pagination.per_page', 10)
        ->assertJsonPath('data.pagination.current_page', 1)
        ->assertJsonPath('data.pagination.total', 25)
        ->assertJsonPath('data.pagination.last_page', 3)
        ->assertJsonPath('data.pagination.has_more_pages', true);

    expect($response->json('data.products'))->toHaveCount(10);
});

test('per_page cannot exceed 50', function () {
    $response = $this->getJson('/api/products?per_page=100');

    $response->assertStatus(422)
        ->assertJsonValidationErrors(['per_page']);
});

test('invalid sort field returns validation error', function () {
    $response = $this->getJson('/api/products?sort_by=invalid_field');

    $response->assertStatus(422)
        ->assertJsonValidationErrors(['sort_by']);
});

test('invalid sort order returns validation error', function () {
    $response = $this->getJson('/api/products?sort_order=invalid_order');

    $response->assertStatus(422)
        ->assertJsonValidationErrors(['sort_order']);
});

test('combined filters work together', function () {
    $category1 = Category::factory()->create(['name' => 'Electronics']);
    $category2 = Category::factory()->create(['name' => 'Books']);

    // Electronics kategorisinde iPhone ürünleri
    Product::factory()->create([
        'name' => 'iPhone 15 Pro',
        'price' => 1200,
        'stock_quantity' => 5,
        'category_id' => $category1->id
    ]);
    Product::factory()->create([
        'name' => 'iPhone 15',
        'price' => 999,
        'stock_quantity' => 0,
        'category_id' => $category1->id
    ]);

    // Books kategorisinde iPhone kitabı
    Product::factory()->create([
        'name' => 'iPhone Development Book',
        'price' => 50,
        'stock_quantity' => 10,
        'category_id' => $category2->id
    ]);

    $response = $this->getJson("/api/products?search=iPhone&category_id={$category1->id}&min_price=900&in_stock=1&sort_by=price&sort_order=desc");

    $response->assertStatus(200)
        ->assertJsonPath('data.pagination.total', 1)
        ->assertJsonPath('data.products.0.name', 'iPhone 15 Pro')
        ->assertJsonPath('data.filters.search', 'iPhone')
        ->assertJsonPath('data.filters.category_id', $category1->id)
        ->assertJsonPath('data.filters.min_price', 900)
        ->assertJsonPath('data.filters.in_stock', true)
        ->assertJsonPath('data.filters.sort_by', 'price')
        ->assertJsonPath('data.filters.sort_order', 'desc');
});

test('non-existent category returns validation error', function () {
    $response = $this->getJson('/api/products?category_id=999');

    $response->assertStatus(422)
        ->assertJsonValidationErrors(['category_id']);
});
