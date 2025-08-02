<?php

namespace Tests\Unit\Http\Resources;

use App\Http\Resources\UserResource;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\Request;
use Tests\TestCase;

class UserResourceTest extends TestCase
{
    use RefreshDatabase;

    public function test_user_resource_returns_correct_data(): void
    {
        $user = User::factory()->create([
            'name' => 'John Doe',
            'email' => 'john@example.com',
        ]);

        $request = new Request();
        $resource = new UserResource($user);
        $array = $resource->toArray($request);

        $this->assertEquals($user->id, $array['id']);
        $this->assertEquals('John Doe', $array['name']);
        $this->assertEquals('john@example.com', $array['email']);
        $this->assertArrayHasKey('email_verified_at', $array);
        $this->assertArrayHasKey('roles', $array);
        $this->assertArrayHasKey('permissions', $array);
        $this->assertArrayHasKey('created_at', $array);
        $this->assertArrayHasKey('updated_at', $array);
    }

    public function test_user_resource_includes_roles_and_permissions(): void
    {
        $user = User::factory()->create();

        $request = new Request();
        $resource = new UserResource($user);
        $array = $resource->toArray($request);

        $this->assertIsIterable($array['roles']);
        $this->assertIsIterable($array['permissions']);
    }
}
