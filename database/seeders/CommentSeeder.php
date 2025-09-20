<?php

namespace Database\Seeders;

use App\Models\Comment;
use App\Models\Post;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class CommentSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Clear existing comments
        DB::table('comments')->truncate();

        $users = User::all();
        $posts = Post::all();

        if ($users->isEmpty()) {
            $this->command->error('No users found. Please run UserSeeder first.');
            return;
        }

        if ($posts->isEmpty()) {
            $this->command->error('No posts found. Please run PostSeeder first.');
            return;
        }

        $comments = [];

        // Create comments for each post
        foreach ($posts as $post) {
            // Each post gets 2-8 comments
            $commentCount = rand(2, 8);

            for ($i = 0; $i < $commentCount; $i++) {
                $randomUser = $users->random();
                $commentDate = $post->created_at->addDays(rand(0, 7))->addHours(rand(1, 12));

                $comments[] = [
                    'content' => $this->generateCommentContent($post->title, $randomUser->name),
                    'user_id' => $randomUser->id,
                    'post_id' => $post->id,
                    'created_at' => $commentDate,
                    'updated_at' => $commentDate,
                ];
            }
        }

        // Insert all comments
        foreach (array_chunk($comments, 50) as $chunk) {
            Comment::insert($chunk);
        }

        $this->command->info('✅ Comments seeded successfully!');
        $this->command->info('📊 Total comments created: ' . Comment::count());
        $this->command->info('📝 Average comments per post: ' . number_format(Comment::count() / $posts->count(), 1));

        // Display sample comments
        $this->command->line('');
        $this->command->line('💬 Sample Comments:');
        $sampleComments = Comment::with(['user', 'post'])
            ->inRandomOrder()
            ->limit(3)
            ->get();

        foreach ($sampleComments as $comment) {
            $this->command->line("   👤 {$comment->user->name} on '{$comment->post->title}':");
            $this->command->line("      \"{$comment->content}\"");
            $this->command->line('');
        }
    }

    /**
     * Generate realistic comment content
     */
    private function generateCommentContent(string $postTitle, string $userName): string
    {
        $commentTemplates = [
            "Great post about {$postTitle}! This was really helpful for my project.",
            "I've been struggling with {$postTitle} for a while. Thanks for the clear explanation!",
            "Excellent tutorial! The examples were easy to follow and implement.",
            "This is exactly what I needed for understanding {$postTitle}. Well written!",
            "I appreciate the depth you went into with {$postTitle}. Many tutorials skip important details.",
            "Thanks for sharing your knowledge about {$postTitle}. Looking forward to more content!",
            "I implemented this in my project and it worked perfectly. Great job!",
            "This helped me solve a problem I've been having for days. Thank you!",
            "Clear and concise explanation of {$postTitle}. Bookmarked for future reference.",
            "I never understood {$postTitle} until I read this post. Thank you for breaking it down!",
            "The code examples are very practical. I was able to adapt them to my use case easily.",
            "This is one of the best explanations of {$postTitle} I've come across. Well done!",
            "I particularly liked how you explained the concept behind {$postTitle}. Very insightful.",
            "Thanks for the detailed walkthrough. The step-by-step approach made it easy to follow.",
            "I've shared this with my team. We're all learning {$postTitle} together now!",
            "The real-world examples really helped me understand how to apply {$postTitle} in practice.",
            "I appreciate the tips and best practices you included. Very comprehensive!",
            "This post answered all my questions about {$postTitle}. Perfect timing!",
            "The visuals and code snippets made complex concepts easy to understand. Great work!",
            "I've been looking for a good resource on {$postTitle}. This exceeded my expectations!"
        ];

        $negativeTemplates = [
            "I think there might be an error in the code example for {$postTitle}. Could you double-check?",
            "The explanation of {$postTitle} was good, but I wish there were more examples.",
            "I'm having trouble implementing this. Are there any common pitfalls with {$postTitle}?",
            "The post was helpful, but I think the section about {$postTitle} could be expanded.",
            "I followed the tutorial but got stuck at the part about {$postTitle}. Any suggestions?",
            "Good overview, but I think some parts of {$postTitle} were oversimplified.",
            "I expected more advanced techniques for {$postTitle}. This seems geared toward beginners.",
            "The code works, but I'm concerned about performance implications with {$postTitle}.",
            "I think there's a better way to handle {$postTitle}. Have you considered alternative approaches?",
            "The post was okay, but I've seen better explanations of {$postTitle} elsewhere."
        ];

        // 80% positive comments, 20% constructive/negative comments
        $templates = rand(1, 10) <= 8 ? $commentTemplates : $negativeTemplates;

        return $templates[array_rand($templates)];
    }
}
