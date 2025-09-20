<?php


namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Tag;
use Illuminate\Http\Request;

class TagController extends Controller
{
    public function index()
    {
        $tags = Tag::withCount('posts')->get();

        return response()->json([
            'tags' => $tags
        ]);
    }

    public function getPosts($id)
    {
        $tag = Tag::with(['posts' => function ($query) {
            $query->published()->with(['user', 'tags']);
        }])->findOrFail($id);

        return response()->json([
            'tag' => $tag->name,
            'posts' => $tag->posts
        ]);
    }
}
