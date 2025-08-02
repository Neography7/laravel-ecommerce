<?php

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;

uses(RefreshDatabase::class);

test('authenticated user can view profile', function () {
    $user = User::factory()->create();
    $token = $user->createToken('test-token')->plainTextToken;

    $response = $this->withHeaders([
        'Authorization' => 'Bearer ' . $token,
    ])->getJson('/api/profile');

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
            ],
            'errors'
        ])
        ->assertJson([
            'success' => true,
            'data' => [
                'user' => [
                    'id' => $user->id,
                    'name' => $user->name,
                    'email' => $user->email,
                ],
            ],
        ]);
});

test('unauthenticated user cannot view profile', function () {
    $response = $this->getJson('/api/profile');

    $response->assertStatus(401);
});

test('authenticated user can update name', function () {
    $user = User::factory()->create();
    $token = $user->createToken('test-token')->plainTextToken;

    $newName = fake()->name();

    $response = $this->withHeaders([
        'Authorization' => 'Bearer ' . $token,
    ])->putJson('/api/profile', [
        'name' => $newName,
    ]);

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
            ],
            'errors'
        ])
        ->assertJson([
            'success' => true,
            'message' => 'Profil başarıyla güncellendi',
            'data' => [
                'user' => [
                    'name' => $newName,
                ],
            ],
        ]);

    $this->assertDatabaseHas('users', [
        'id' => $user->id,
        'name' => $newName,
    ]);
});

test('authenticated user can update email', function () {
    $user = User::factory()->create();
    $token = $user->createToken('test-token')->plainTextToken;

    $newEmail = fake()->unique()->safeEmail();

    $response = $this->withHeaders([
        'Authorization' => 'Bearer ' . $token,
    ])->putJson('/api/profile', [
        'email' => $newEmail,
    ]);

    $response->assertStatus(200)
        ->assertJson([
            'success' => true,
            'message' => 'Profil başarıyla güncellendi',
            'data' => [
                'user' => [
                    'email' => $newEmail,
                ],
            ],
        ]);

    $this->assertDatabaseHas('users', [
        'id' => $user->id,
        'email' => $newEmail,
    ]);
});

test('authenticated user can update password', function () {
    $user = User::factory()->create([
        'password' => bcrypt('oldpassword123'),
    ]);
    $token = $user->createToken('test-token')->plainTextToken;

    $response = $this->withHeaders([
        'Authorization' => 'Bearer ' . $token,
    ])->putJson('/api/profile', [
        'current_password' => 'oldpassword123',
        'password' => 'newpassword123',
        'password_confirmation' => 'newpassword123',
    ]);

    $response->assertStatus(200)
        ->assertJson([
            'success' => true,
            'message' => 'Profil başarıyla güncellendi',
        ]);

    // Verify password was changed by trying to login with new password
    $loginResponse = $this->postJson('/api/login', [
        'email' => $user->email,
        'password' => 'newpassword123',
    ]);

    $loginResponse->assertStatus(200);
});

test('user cannot update email to existing email', function () {
    $existingUser = User::factory()->create();
    $user = User::factory()->create();
    $token = $user->createToken('test-token')->plainTextToken;

    $response = $this->withHeaders([
        'Authorization' => 'Bearer ' . $token,
    ])->putJson('/api/profile', [
        'email' => $existingUser->email,
    ]);

    $response->assertStatus(422)
        ->assertJsonValidationErrors(['email']);
});

test('user cannot update password without current password', function () {
    $user = User::factory()->create();
    $token = $user->createToken('test-token')->plainTextToken;

    $response = $this->withHeaders([
        'Authorization' => 'Bearer ' . $token,
    ])->putJson('/api/profile', [
        'password' => 'newpassword123',
        'password_confirmation' => 'newpassword123',
    ]);

    $response->assertStatus(422)
        ->assertJsonValidationErrors(['current_password']);
});

test('user cannot update password with wrong current password', function () {
    $user = User::factory()->create([
        'password' => bcrypt('correctpassword123'),
    ]);
    $token = $user->createToken('test-token')->plainTextToken;

    $response = $this->withHeaders([
        'Authorization' => 'Bearer ' . $token,
    ])->putJson('/api/profile', [
        'current_password' => 'wrongpassword',
        'password' => 'newpassword123',
        'password_confirmation' => 'newpassword123',
    ]);

    $response->assertStatus(422)
        ->assertJsonValidationErrors(['current_password']);
});

test('user cannot update password without confirmation', function () {
    $user = User::factory()->create([
        'password' => bcrypt('oldpassword123'),
    ]);
    $token = $user->createToken('test-token')->plainTextToken;

    $response = $this->withHeaders([
        'Authorization' => 'Bearer ' . $token,
    ])->putJson('/api/profile', [
        'current_password' => 'oldpassword123',
        'password' => 'newpassword123',
    ]);

    $response->assertStatus(422)
        ->assertJsonValidationErrors(['password']);
});

test('unauthenticated user cannot update profile', function () {
    $response = $this->putJson('/api/profile', [
        'name' => 'New Name',
    ]);

    $response->assertStatus(401);
});

test('user cannot update name with short name', function () {
    $user = User::factory()->create();
    $token = $user->createToken('test-token')->plainTextToken;

    $response = $this->withHeaders([
        'Authorization' => 'Bearer ' . $token,
    ])->putJson('/api/profile', [
        'name' => 'A', // 1 karakter
    ]);

    $response->assertStatus(422)
        ->assertJsonValidationErrors(['name'])
        ->assertJsonFragment(['name' => ['Ad en az 2 karakter olmalıdır.']]);
});

test('user cannot update with short password', function () {
    $user = User::factory()->create([
        'password' => bcrypt('oldpassword123'),
    ]);
    $token = $user->createToken('test-token')->plainTextToken;

    $response = $this->withHeaders([
        'Authorization' => 'Bearer ' . $token,
    ])->putJson('/api/profile', [
        'current_password' => 'oldpassword123',
        'password' => '1234567', // 7 karakter
        'password_confirmation' => '1234567',
    ]);

    $response->assertStatus(422)
        ->assertJsonValidationErrors(['password'])
        ->assertJsonFragment(['password' => ['Şifre en az 8 karakter olmalıdır.']]);
});
