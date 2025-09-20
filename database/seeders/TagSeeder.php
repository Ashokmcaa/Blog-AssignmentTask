<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Tag;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class TagSeeder extends Seeder
{
    public function run(): void
    {
        // Clear existing tags
        DB::table('tags')->truncate();

        $tags = [
            // Programming Languages
            'PHP',
            'Laravel',
            'JavaScript',
            'Vue.js',
            'React',
            'Python',
            'Java',
            'C#',
            'Ruby',
            'Go',
            'Rust',
            'TypeScript',

            // Web Development
            'Web Development',
            'Frontend',
            'Backend',
            'Full Stack',
            'API Development',
            'REST API',
            'GraphQL',

            // Databases
            'MySQL',
            'PostgreSQL',
            'MongoDB',
            'SQLite',
            'Redis',

            // DevOps & Tools
            'Docker',
            'Kubernetes',
            'AWS',
            'Azure',
            'Git',
            'CI/CD',
            'Linux',
            'Nginx',
            'Apache',

            // Frameworks
            'Express.js',
            'Django',
            'Flask',
            'Spring Boot',
            'ASP.NET',

            // Mobile Development
            'React Native',
            'Flutter',
            'iOS',
            'Android',
            'Swift',
            'Kotlin',

            // Other Technologies
            'Machine Learning',
            'AI',
            'Blockchain',
            'Cybersecurity',
            'Cloud Computing',
            'Microservices',
            'Serverless',

            // Concepts & Methodologies
            'Object-Oriented Programming',
            'Functional Programming',
            'Test-Driven Development',
            'Agile',
            'Scrum',
            'Design Patterns',
            'Clean Code',
            'Refactoring',

            // Personal & Career
            'Career Advice',
            'Programming Tips',
            'Learning',
            'Productivity',
            'Remote Work',
            'Freelancing'
        ];

        foreach ($tags as $tagName) {
            Tag::create([
                'name' => $tagName,
                'slug' => Str::slug($tagName),
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }

        $this->command->info('Tags seeded successfully!');
        $this->command->info('Total tags created: ' . Tag::count());
    }
}
