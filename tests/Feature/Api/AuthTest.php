<?php

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;

uses(RefreshDatabase::class);

test('user can register', function () {
    $userData = [
        'name' => fake()->name(),
        'email' => fake()->unique()->safeEmail(),
        'password' => 'password123',
        'password_confirmation' => 'password123',
    ];

    $response = $this->postJson('/api/register', $userData);

    $response->assertStatus(201)
        ->assertJsonStructure([
            'success',
            'message',
            'data' => [
                'user' => [
                    'id',
                    'name',
                    'email',
                    'email_verified_at',
                    'roles',
                    'permissions',
                    'created_at',
                    'updated_at',
                ],
                'access_token',
                'token_type',
            ],
            'errors'
        ])
        ->assertJson([
            'success' => true,
            'message' => 'Kullanıcı başarıyla kaydedildi',
        ]);

    $this->assertDatabaseHas('users', [
        'name' => $userData['name'],
        'email' => $userData['email'],
    ]);
});

test('user cannot register with invalid data', function () {
    $userData = [
        'name' => 'A', // 1 karakter (minimum 2 gerekli)
        'email' => 'invalid-email',
        'password' => '123', // 3 karakter (minimum 8 gerekli)
        'password_confirmation' => '456',
    ];

    $response = $this->postJson('/api/register', $userData);

    $response->assertStatus(422)
        ->assertJsonValidationErrors(['name', 'email', 'password']);
});

test('user cannot register with short name', function () {
    $userData = [
        'name' => 'A', // 1 karakter
        'email' => fake()->unique()->safeEmail(),
        'password' => 'password123',
        'password_confirmation' => 'password123',
    ];

    $response = $this->postJson('/api/register', $userData);

    $response->assertStatus(422)
        ->assertJsonValidationErrors(['name'])
        ->assertJsonFragment([
            'errors' => [
                'name' => ['Ad en az 2 karakter olmalıdır.']
            ]
        ]);
});

test('user cannot register with short password', function () {
    $userData = [
        'name' => fake()->name(),
        'email' => fake()->unique()->safeEmail(),
        'password' => '1234567', // 7 karakter
        'password_confirmation' => '1234567',
    ];

    $response = $this->postJson('/api/register', $userData);

    $response->assertStatus(422)
        ->assertJsonValidationErrors(['password'])
        ->assertJsonFragment(['password' => ['Şifre en az 8 karakter olmalıdır.']]);
});

test('user cannot register with existing email', function () {
    $user = User::factory()->create();

    $userData = [
        'name' => fake()->name(),
        'email' => $user->email,
        'password' => 'password123',
        'password_confirmation' => 'password123',
    ];

    $response = $this->postJson('/api/register', $userData);

    $response->assertStatus(422)
        ->assertJsonValidationErrors(['email']);
});

test('user can login', function () {
    $user = User::factory()->create([
        'password' => bcrypt('password123'),
    ]);

    $loginData = [
        'email' => $user->email,
        'password' => 'password123',
    ];

    $response = $this->postJson('/api/login', $loginData);

    $response->assertStatus(200)
        ->assertJsonStructure([
            'success',
            'message',
            'data' => [
                'user' => [
                    'id',
                    'name',
                    'email',
                    'email_verified_at',
                    'roles',
                    'permissions',
                    'created_at',
                    'updated_at',
                ],
                'access_token',
                'token_type',
            ],
            'errors'
        ])
        ->assertJson([
            'success' => true,
            'message' => 'Giriş başarılı',
        ]);
});

test('user cannot login with invalid credentials', function () {
    $user = User::factory()->create([
        'password' => bcrypt('password123'),
    ]);

    $loginData = [
        'email' => $user->email,
        'password' => 'wrongpassword',
    ];

    $response = $this->postJson('/api/login', $loginData);

    $response->assertStatus(422)
        ->assertJsonValidationErrors(['email']);
});

test('user cannot login with invalid data', function () {
    $loginData = [
        'email' => 'invalid-email',
        'password' => '',
    ];

    $response = $this->postJson('/api/login', $loginData);

    $response->assertStatus(422)
        ->assertJsonValidationErrors(['email', 'password']);
});
