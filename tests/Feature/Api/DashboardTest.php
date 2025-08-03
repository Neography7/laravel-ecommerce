<?php

use App\Models\User;
use App\Models\Order;
use App\Models\Product;
use Illuminate\Foundation\Testing\RefreshDatabase;

uses(RefreshDatabase::class);

beforeEach(function () {
    $this->artisan('db:seed', ['--class' => 'RoleSeeder']);
    $this->artisan('db:seed', ['--class' => 'UserSeeder']);
});

it('allows admin to access dashboard', function () {
    // Seeder'dan admin kullanıcıyı al (ID: 1)
    $admin = User::find(1);

    // Test verileri oluştur
    Order::factory()->count(5)->create();
    Product::factory()->count(10)->create();

    // Dashboard endpoint'ini test et
    $response = $this->actingAs($admin, 'sanctum')
        ->getJson('/api/dashboard');

    $response->assertStatus(200)
        ->assertJsonStructure([
            'data' => [
                'summary' => [
                    'total_orders',
                    'total_revenue',
                    'total_users',
                    'total_products'
                ],
                'recent_orders',
                'top_products',
                'orders_by_status'
            ]
        ]);
});

it('denies non-admin access to dashboard', function () {
    // Seeder'dan normal kullanıcıyı al (ID: 2)
    $user = User::find(2);

    // Dashboard endpoint'ini test et
    $response = $this->actingAs($user, 'sanctum')
        ->getJson('/api/dashboard');

    $response->assertStatus(403);
});

it('denies unauthenticated access to dashboard', function () {
    $response = $this->getJson('/api/dashboard');

    $response->assertStatus(401);
});

it('returns correct dashboard data structure with concurrency', function () {
    // Seeder'dan admin kullanıcıyı al
    $admin = User::find(1);

    // Test verileri oluştur
    Order::factory()->count(3)->create();
    Product::factory()->count(5)->create();

    $response = $this->actingAs($admin, 'sanctum')
        ->getJson('/api/dashboard');

    $response->assertStatus(200)
        ->assertJsonCount(4, 'data') // summary, recent_orders, top_products, orders_by_status
        ->assertJsonPath('data.summary.total_orders', 3)
        ->assertJsonPath('data.summary.total_products', 5);
});
