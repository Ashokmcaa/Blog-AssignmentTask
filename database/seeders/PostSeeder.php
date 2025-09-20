<?php

namespace Database\Seeders;

use App\Models\Post;
use App\Models\User;
use App\Models\Tag;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class PostSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Clear existing posts
        DB::table('posts')->truncate();

        $users = User::all();
        $tags = Tag::all();

        if ($users->isEmpty()) {
            $this->command->error('No users found. Please run UserSeeder first.');
            return;
        }

        if ($tags->isEmpty()) {
            $this->command->error('No tags found. Please run TagSeeder first.');
            return;
        }

        $posts = [
            // Programming Posts
            [
                'title' => 'Getting Started with Laravel',
                'content' => $this->generateContent('Laravel'),
                'user_id' => $users->random()->id,
                'published' => true,
                'tags' => ['Laravel', 'PHP', 'Web Development']
            ],
            [
                'title' => 'Vue.js Components Tutorial',
                'content' => $this->generateContent('Vue.js'),
                'user_id' => $users->random()->id,
                'published' => true,
                'tags' => ['Vue.js', 'JavaScript', 'Frontend']
            ],
            [
                'title' => 'Building RESTful APIs with PHP',
                'content' => $this->generateContent('REST API'),
                'user_id' => $users->random()->id,
                'published' => true,
                'tags' => ['PHP', 'API', 'Backend']
            ],
            [
                'title' => 'React Hooks Explained',
                'content' => $this->generateContent('React Hooks'),
                'user_id' => $users->random()->id,
                'published' => true,
                'tags' => ['React', 'JavaScript', 'Frontend']
            ],
            [
                'title' => 'Database Optimization Techniques',
                'content' => $this->generateContent('Database Optimization'),
                'user_id' => $users->random()->id,
                'published' => true,
                'tags' => ['MySQL', 'Database', 'Performance']
            ],

            // Web Development Posts
            [
                'title' => 'CSS Grid vs Flexbox',
                'content' => $this->generateContent('CSS Layout'),
                'user_id' => $users->random()->id,
                'published' => true,
                'tags' => ['CSS', 'Frontend', 'Web Development']
            ],
            [
                'title' => 'JavaScript ES6 Features',
                'content' => $this->generateContent('JavaScript ES6'),
                'user_id' => $users->random()->id,
                'published' => true,
                'tags' => ['JavaScript', 'ES6', 'Programming']
            ],
            [
                'title' => 'Docker for Development',
                'content' => $this->generateContent('Docker'),
                'user_id' => $users->random()->id,
                'published' => true,
                'tags' => ['Docker', 'DevOps', 'Containers']
            ],

            // Draft Posts
            [
                'title' => 'Advanced Laravel Techniques',
                'content' => $this->generateContent('Advanced Laravel'),
                'user_id' => $users->random()->id,
                'published' => false,
                'tags' => ['Laravel', 'PHP', 'Advanced']
            ],
            [
                'title' => 'Upcoming Web Technologies',
                'content' => $this->generateContent('Future Web'),
                'user_id' => $users->random()->id,
                'published' => false,
                'tags' => ['Web Development', 'Future', 'Technology']
            ]
        ];

        foreach ($posts as $postData) {
            $slug = Str::slug($postData['title']) . '-' . Str::random(6);

            $post = Post::create([
                'title' => $postData['title'],
                'content' => $postData['content'],
                'user_id' => $postData['user_id'],
                'slug' => $slug,
                'published' => $postData['published'],
                'created_at' => now()->subDays(rand(0, 30)),
                'updated_at' => now()
            ]);

            // Attach tags
            $tagIds = [];
            foreach ($postData['tags'] as $tagName) {
                $tag = $tags->firstWhere('name', $tagName);
                if ($tag) {
                    $tagIds[] = $tag->id;
                }
            }

            if (!empty($tagIds)) {
                $post->tags()->attach($tagIds);
            }
        }

        $this->command->info('Posts seeded successfully!');
        $this->command->info('Total posts created: ' . Post::count());
        $this->command->info('Published posts: ' . Post::where('published', true)->count());
        $this->command->info('Draft posts: ' . Post::where('published', false)->count());
    }

    /**
     * Generate realistic post content
     */
    private function generateContent(string $topic): string
    {
        $contents = [
            "In this comprehensive guide, we'll explore $topic and how it can transform your development workflow. Whether you're a beginner or an experienced developer, this post will provide valuable insights.",

            "$topic has revolutionized the way we think about web development. In this post, we'll dive deep into its core concepts, best practices, and practical examples.",

            "Are you struggling with $topic? This tutorial will walk you through everything you need to know, from basic concepts to advanced techniques.",

            "In the world of modern development, $topic plays a crucial role. Let's explore its features, benefits, and how to implement it effectively.",

            "This post covers everything about $topic - from installation and setup to real-world applications and troubleshooting common issues."
        ];

        $content = $contents[array_rand($contents)];

        // Add multiple paragraphs
        $content .= "\n\n## Introduction\n\n" . fake()->paragraphs(3, true);
        $content .= "\n\n## Main Content\n\n" . fake()->paragraphs(5, true);
        $content .= "\n\n## Conclusion\n\n" . fake()->paragraphs(2, true);

        // Add code examples for programming topics
        if (in_array($topic, ['Laravel', 'PHP', 'JavaScript', 'Vue.js', 'React'])) {
            $content .= "\n\n## Code Example\n\n```php\n<?php\n// Example code for " . $topic . "\nclass Example {\n    public function demo() {\n        return 'Hello World!';\n    }\n}\n```";
        }

        return $content;
    }
}
