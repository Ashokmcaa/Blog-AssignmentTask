<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Clear existing users
        DB::table('users')->truncate();

        $users = [
            // Admin Users
            [
                'name' => 'Admin User',
                'email' => 'admin@blog.com',
                'password' => Hash::make('password'),
                'role' => 'admin',
                'email_verified_at' => now(),
                'remember_token' => Str::random(10),
                'created_at' => now()->subMonths(2),
                'updated_at' => now(),
            ],
            [
                'name' => 'Super Admin',
                'email' => 'superadmin@blog.com',
                'password' => Hash::make('password'),
                'role' => 'admin',
                'email_verified_at' => now(),
                'remember_token' => Str::random(10),
                'created_at' => now()->subMonths(3),
                'updated_at' => now(),
            ],

            // Regular Users - Authors
            [
                'name' => 'John Doe',
                'email' => 'john.doe@example.com',
                'password' => Hash::make('password'),
                'role' => 'user',
                'email_verified_at' => now(),
                'remember_token' => Str::random(10),
                'created_at' => now()->subDays(45),
                'updated_at' => now(),
            ],
            [
                'name' => 'Jane Smith',
                'email' => 'jane.smith@example.com',
                'password' => Hash::make('password'),
                'role' => 'user',
                'email_verified_at' => now(),
                'remember_token' => Str::random(10),
                'created_at' => now()->subDays(30),
                'updated_at' => now(),
            ],
            [
                'name' => 'Mike Johnson',
                'email' => 'mike.johnson@example.com',
                'password' => Hash::make('password'),
                'role' => 'user',
                'email_verified_at' => now(),
                'remember_token' => Str::random(10),
                'created_at' => now()->subDays(60),
                'updated_at' => now(),
            ],
            [
                'name' => 'Sarah Wilson',
                'email' => 'sarah.wilson@example.com',
                'password' => Hash::make('password'),
                'role' => 'user',
                'email_verified_at' => now(),
                'remember_token' => Str::random(10),
                'created_at' => now()->subDays(25),
                'updated_at' => now(),
            ],
            [
                'name' => 'David Brown',
                'email' => 'david.brown@example.com',
                'password' => Hash::make('password'),
                'role' => 'user',
                'email_verified_at' => now(),
                'remember_token' => Str::random(10),
                'created_at' => now()->subDays(15),
                'updated_at' => now(),
            ],
            [
                'name' => 'Emily Davis',
                'email' => 'emily.davis@example.com',
                'password' => Hash::make('password'),
                'role' => 'user',
                'email_verified_at' => now(),
                'remember_token' => Str::random(10),
                'created_at' => now()->subDays(10),
                'updated_at' => now(),
            ],
            [
                'name' => 'Robert Miller',
                'email' => 'robert.miller@example.com',
                'password' => Hash::make('password'),
                'role' => 'user',
                'email_verified_at' => now(),
                'remember_token' => Str::random(10),
                'created_at' => now()->subDays(50),
                'updated_at' => now(),
            ],
            [
                'name' => 'Lisa Taylor',
                'email' => 'lisa.taylor@example.com',
                'password' => Hash::make('password'),
                'role' => 'user',
                'email_verified_at' => now(),
                'remember_token' => Str::random(10),
                'created_at' => now()->subDays(20),
                'updated_at' => now(),
            ],
            [
                'name' => 'Alex Chen',
                'email' => 'alex.chen@example.com',
                'password' => Hash::make('password'),
                'role' => 'user',
                'email_verified_at' => now(),
                'remember_token' => Str::random(10),
                'created_at' => now()->subDays(35),
                'updated_at' => now(),
            ],
            [
                'name' => 'Maria Garcia',
                'email' => 'maria.garcia@example.com',
                'password' => Hash::make('password'),
                'role' => 'user',
                'email_verified_at' => now(),
                'remember_token' => Str::random(10),
                'created_at' => now()->subDays(40),
                'updated_at' => now(),
            ]
        ];

        foreach ($users as $userData) {
            User::create($userData);
        }

        $this->command->info('✅ Users seeded successfully!');
        $this->command->info('📊 Total users created: ' . User::count());
        $this->command->info('👑 Admin users: ' . User::where('role', 'admin')->count());
        $this->command->info('👥 Regular users: ' . User::where('role', 'user')->count());

        // Display login credentials
        $this->command->line('');
        $this->command->line('🔐 Login Credentials:');
        $this->command->line('   Admin: admin@blog.com / password');
        $this->command->line('   Super Admin: superadmin@blog.com / password');
        $this->command->line('   User: john.doe@example.com / password');
        $this->command->line('   User: jane.smith@example.com / password');
        $this->command->line('');
    }
}
