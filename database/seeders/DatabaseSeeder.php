<?php

namespace Database\Seeders;

use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $this->call([
            UserSeeder::class,      // Run first
            TagSeeder::class,       // Run second
            PostSeeder::class,      // Run third (needs users and tags)
            CommentSeeder::class,   // Run fourth (needs posts)
            PostTagSeeder::class,   // Optional: if you want additional relationships
        ]);
    }
}
