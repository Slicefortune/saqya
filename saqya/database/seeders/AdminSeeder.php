<?php

namespace Database\Seeders;

use App\Services\UserService;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class AdminSeeder extends Seeder
{
    private UserService $service;

    public function __construct(UserService $service)
    {
        $this->service = $service;
    }

    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $admin = $this->service->firstWhere([
            ['email', '=', 'admin@admin.com'],
        ]);

        if ( ! $admin) {
            $admin = $this->service->create([
                'name' => 'admin',
                'email' => 'admin@admin.com',
                'password' => Hash::make('11223344'),
                'email_verified_at' => now(),
            ]);
        }
    }
}
