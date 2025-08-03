<?php

use App\Models\Category;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;

uses(RefreshDatabase::class);

beforeEach(function () {
    // Test için roller ve kullanıcıları oluştur
    $this->artisan('db:seed', ['--class' => 'RoleSeeder']);
    $this->artisan('db:seed', ['--class' => 'UserSeeder']);
});

test('guest user can list categories', function () {
    Category::factory(3)->create();

    $response = $this->getJson('/api/categories');

    $response->assertStatus(200)
        ->assertJsonStructure([
            'success',
            'message',
            'data' => [
                '*' => [
                    'id',
                    'name',
                    'description',
                    'created_at',
                    'updated_at',
                ]
            ],
            'errors'
        ])
        ->assertJson([
            'success' => true,
            'message' => 'Kategoriler başarıyla listelendi',
        ]);

    expect($response->json('data'))->toHaveCount(3);
});

test('guest user can view single category', function () {
    $category = Category::factory()->create();

    $response = $this->getJson("/api/categories/{$category->id}");

    $response->assertStatus(200)
        ->assertJsonStructure([
            'success',
            'message',
            'data' => [
                'id',
                'name',
                'description',
                'created_at',
                'updated_at',
            ],
            'errors'
        ])
        ->assertJson([
            'success' => true,
            'message' => 'Kategori başarıyla getirildi',
            'data' => [
                'id' => $category->id,
                'name' => $category->name,
                'description' => $category->description,
            ]
        ]);
});

test('guest user cannot view non-existent category', function () {
    $response = $this->getJson('/api/categories/999');

    $response->assertStatus(404);
});

test('admin can create category', function () {
    $user = User::factory()->create();
    $user->assignRole('admin');

    $categoryData = [
        'name' => fake()->words(2, true),
        'description' => fake()->paragraph(),
    ];

    $response = $this->actingAs($user)
        ->postJson('/api/categories', $categoryData);

    $response->assertStatus(201)
        ->assertJsonStructure([
            'success',
            'message',
            'data' => [
                'id',
                'name',
                'description',
                'created_at',
                'updated_at',
            ],
            'errors'
        ])
        ->assertJson([
            'success' => true,
            'message' => 'Kategori başarıyla oluşturuldu',
            'data' => [
                'name' => $categoryData['name'],
                'description' => $categoryData['description'],
            ]
        ]);

    $this->assertDatabaseHas('categories', $categoryData);
});

test('normal user cannot create category', function () {
    $user = User::factory()->create();

    $categoryData = [
        'name' => fake()->words(2, true),
        'description' => fake()->paragraph(),
    ];

    $response = $this->actingAs($user)
        ->postJson('/api/categories', $categoryData);

    $response->assertStatus(403)
        ->assertJson([
            'success' => false,
            'message' => 'Bu işlem için admin yetkisi gerekli.',
        ]);
});

test('guest user cannot create category', function () {
    $categoryData = [
        'name' => fake()->words(2, true),
        'description' => fake()->paragraph(),
    ];

    $response = $this->postJson('/api/categories', $categoryData);

    $response->assertStatus(401);
});

test('category creation validation works', function () {
    $user = User::factory()->create();
    $user->assignRole('admin');

    $response = $this->actingAs($user)
        ->postJson('/api/categories', []);

    $response->assertStatus(422)
        ->assertJsonValidationErrors(['name']);
});

test('category name must be unique', function () {
    $user = User::factory()->create();
    $user->assignRole('admin');

    $existingCategory = Category::factory()->create();

    $response = $this->actingAs($user)
        ->postJson('/api/categories', [
            'name' => $existingCategory->name,
            'description' => fake()->paragraph(),
        ]);

    $response->assertStatus(422)
        ->assertJsonValidationErrors(['name']);
});

test('admin can update category', function () {
    $user = User::factory()->create();
    $user->assignRole('admin');

    $category = Category::factory()->create();

    $updateData = [
        'name' => fake()->words(2, true),
        'description' => fake()->paragraph(),
    ];

    $response = $this->actingAs($user)
        ->putJson("/api/categories/{$category->id}", $updateData);

    $response->assertStatus(200)
        ->assertJson([
            'success' => true,
            'message' => 'Kategori başarıyla güncellendi',
            'data' => [
                'id' => $category->id,
                'name' => $updateData['name'],
                'description' => $updateData['description'],
            ]
        ]);

    $this->assertDatabaseHas('categories', [
        'id' => $category->id,
        'name' => $updateData['name'],
        'description' => $updateData['description'],
    ]);
});

test('normal user cannot update category', function () {
    $user = User::factory()->create();

    $category = Category::factory()->create();

    $updateData = [
        'name' => fake()->words(2, true),
        'description' => fake()->paragraph(),
    ];

    $response = $this->actingAs($user)
        ->putJson("/api/categories/{$category->id}", $updateData);

    $response->assertStatus(403);
});

test('admin can delete category', function () {
    $user = User::factory()->create();
    $user->assignRole('admin');

    $category = Category::factory()->create();

    $response = $this->actingAs($user)
        ->deleteJson("/api/categories/{$category->id}");

    $response->assertStatus(200)
        ->assertJson([
            'success' => true,
            'message' => 'Kategori başarıyla silindi',
            'data' => null,
        ]);

    $this->assertDatabaseMissing('categories', [
        'id' => $category->id,
    ]);
});

test('normal user cannot delete category', function () {
    $user = User::factory()->create();

    $category = Category::factory()->create();

    $response = $this->actingAs($user)
        ->deleteJson("/api/categories/{$category->id}");

    $response->assertStatus(403);
});

test('non-existent category cannot be deleted', function () {
    $user = User::factory()->create();
    $user->assignRole('admin');

    $response = $this->actingAs($user)
        ->deleteJson('/api/categories/999');

    $response->assertStatus(404);
});

test('empty category list returns correct format', function () {
    $response = $this->getJson('/api/categories');

    $response->assertStatus(200)
        ->assertJson([
            'success' => true,
            'message' => 'Kategoriler başarıyla listelendi',
            'data' => [],
        ]);
});
