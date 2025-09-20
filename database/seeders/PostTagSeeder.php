<?php

namespace Database\Seeders;

use App\Models\Post;
use App\Models\Tag;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PostTagSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Clear existing post-tag relationships
        DB::table('post_tag')->truncate();

        $posts = Post::all();
        $tags = Tag::all();

        if ($posts->isEmpty()) {
            $this->command->error('No posts found. Please run PostSeeder first.');
            return;
        }

        if ($tags->isEmpty()) {
            $this->command->error('No tags found. Please run TagSeeder first.');
            return;
        }

        $postTagRelationships = [];

        // Define common tag patterns for different post types
        $tagPatterns = [
            // Programming posts
            'laravel' => ['Laravel', 'PHP', 'Web Development', 'Backend'],
            'php' => ['PHP', 'Backend', 'Web Development'],
            'vue' => ['Vue.js', 'JavaScript', 'Frontend'],
            'react' => ['React', 'JavaScript', 'Frontend'],
            'javascript' => ['JavaScript', 'Frontend', 'Web Development'],

            // Database posts
            'database' => ['MySQL', 'Database', 'Backend', 'Performance'],
            'mysql' => ['MySQL', 'Database', 'Backend'],

            // DevOps posts
            'docker' => ['Docker', 'DevOps', 'Containers'],
            'devops' => ['DevOps', 'Containers', 'Deployment'],

            // CSS/Design posts
            'css' => ['CSS', 'Frontend', 'Web Development'],
            'design' => ['CSS', 'Frontend', 'Web Development'],

            // General web development
            'web' => ['Web Development', 'Frontend', 'Backend'],
            'api' => ['API', 'Backend', 'Web Development'],
        ];

        foreach ($posts as $post) {
            // Determine appropriate tags based on post title and content
            $postTitle = strtolower($post->title);
            $assignedTags = [];

            // Match tags based on post content
            foreach ($tagPatterns as $keyword => $tagNames) {
                if (str_contains($postTitle, $keyword)) {
                    foreach ($tagNames as $tagName) {
                        $tag = $tags->firstWhere('name', $tagName);
                        if ($tag && !in_array($tag->id, $assignedTags)) {
                            $assignedTags[] = $tag->id;
                        }
                    }
                }
            }

            // If no specific tags matched, assign random tags
            if (empty($assignedTags)) {
                $randomTagCount = rand(2, 4);
                $randomTags = $tags->random($randomTagCount);
                $assignedTags = $randomTags->pluck('id')->toArray();
            }

            // Ensure we have at least 1 and at most 5 tags
            $assignedTags = array_slice($assignedTags, 0, min(5, count($assignedTags)));

            if (count($assignedTags) < 1) {
                $assignedTags = [$tags->random()->id];
            }

            // Create relationships
            foreach ($assignedTags as $tagId) {
                $postTagRelationships[] = [
                    'post_id' => $post->id,
                    'tag_id' => $tagId,
                    'created_at' => $post->created_at,
                    'updated_at' => now(),
                ];
            }
        }

        // Insert all relationships
        foreach (array_chunk($postTagRelationships, 50) as $chunk) {
            DB::table('post_tag')->insert($chunk);
        }

        $this->command->info('✅ Post-Tag relationships seeded successfully!');
        $this->command->info('📊 Total relationships created: ' . count($postTagRelationships));
        $this->command->info('📝 Average tags per post: ' . number_format(count($postTagRelationships) / $posts->count(), 1));

        // Display statistics
        $this->command->line('');
        $this->command->line('📈 Tag Usage Statistics:');

        $tagUsage = DB::table('post_tag')
            ->select('tag_id', DB::raw('COUNT(*) as post_count'))
            ->groupBy('tag_id')
            ->orderBy('post_count', 'desc')
            ->get()
            ->map(function ($item) use ($tags) {
                $tag = $tags->firstWhere('id', $item->tag_id);
                return [
                    'tag' => $tag ? $tag->name : 'Unknown',
                    'post_count' => $item->post_count
                ];
            });

        foreach ($tagUsage as $usage) {
            $this->command->line("   🏷️  {$usage['tag']}: {$usage['post_count']} posts");
        }

        // Show sample posts with their tags
        $this->command->line('');
        $this->command->line('📋 Sample Posts with Tags:');
        $samplePosts = Post::with('tags')
            ->inRandomOrder()
            ->limit(3)
            ->get();

        foreach ($samplePosts as $post) {
            $tagNames = $post->tags->pluck('name')->join(', ');
            $this->command->line("   📝 '{$post->title}':");
            $this->command->line("      🏷️  Tags: {$tagNames}");
            $this->command->line('');
        }
    }
}
