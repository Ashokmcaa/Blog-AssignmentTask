<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Post;
use App\Models\Tag;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;


class PostController extends Controller
{
    use AuthorizesRequests;




    public function index(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'tag' => ['sometimes', 'string', 'max:255'],
                'author' => ['sometimes', 'integer', 'exists:users,id'],
                'search' => ['sometimes', 'string', 'max:255'],
                'per_page' => ['sometimes', 'integer', 'min:1', 'max:100'],
                'page' => ['sometimes', 'integer', 'min:1'],
                'sort' => ['sometimes', 'string', 'in:newest,oldest,popular'],
                'status' => ['sometimes', 'string', 'in:published,draft,all']
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'message' => 'Validation failed',
                    'errors' => $validator->errors()
                ], 422);
            }

            $perPage = $request->per_page ?? 10;

            // Build query with eager loading
            $query = Post::with([
                'user:id,name,email',
                'tags:id,name,slug',
                'comments' => function ($query) {
                    $query->with('user:id,name')
                        ->latest()
                        ->limit(5);
                }
            ]);


            $query = $this->applyFilters($query, $request);


            $posts = $query->paginate($perPage);

            return response()->json([
                'message' => 'Posts retrieved successfully',
                'filters' => $request->only(['tag', 'author', 'search', 'sort', 'status', 'per_page']),
                'meta' => [
                    'current_page' => $posts->currentPage(),
                    'per_page' => $posts->perPage(),
                    'total' => $posts->total(),
                    'last_page' => $posts->lastPage(),
                    'from' => $posts->firstItem(),
                    'to' => $posts->lastItem()
                ],
                'posts' => $posts->items()
            ]);
        } catch (\Exception $e) {
            // \Log::error('Posts index error: ' . $e->getMessage());

            return response()->json([
                'message' => 'Failed to retrieve posts',
                'error' => config('app.debug') ? $e->getMessage() : 'Internal server error'
            ], 500);
        }
    }


    public function store(Request $request)
    {
        try {

            $this->authorize('create', Post::class);

            // Validation
            $validator = Validator::make($request->all(), [
                'title' => ['required', 'string', 'max:255'],
                'content' => ['required', 'string'],
                'tags' => ['sometimes', 'array'],
                'tags.*' => ['exists:tags,id'],
                'published' => ['sometimes', 'boolean'],
                'slug' => ['sometimes', 'string', 'max:255', 'unique:posts,slug']
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'message' => 'Validation failed',
                    'errors' => $validator->errors()
                ], 422);
            }


            $slug = $request->slug ?? Str::slug($request->title);

            $originalSlug = $slug;
            $counter = 1;
            while (Post::where('slug', $slug)->exists()) {
                $slug = $originalSlug . '-' . $counter;
                $counter++;
            }

            // Create the post
            $post = Post::create([
                'title' => $request->title,
                'content' => $request->content,
                'user_id' => $request->user()->id,
                'slug' => $slug,
                'published' => $request->published ?? true
            ]);


            if ($request->has('tags')) {
                $post->tags()->sync($request->tags);
            }


            $post->load(['user', 'tags']);

            return response()->json([
                'message' => 'Post created successfully',
                'post' => $post
            ], 201);
        } catch (\Illuminate\Auth\Access\AuthorizationException $e) {
            return response()->json([
                'message' => 'You are not authorized to create posts'
            ], 403);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to create post',
                'error' => $e->getMessage()
            ], 500);
        }
    }


    public function show($id)
    {
        try {
            $post = Post::with(['user', 'tags', 'comments.user'])
                ->withCount('comments')
                ->findOrFail($id);

            if (!$post->published && (!auth()->user() || !auth()->user()->isAdmin())) {
                return response()->json([
                    'message' => 'Post not found or not published'
                ], 404);
            }

            return response()->json([
                'message' => 'Post retrieved successfully',
                'post' => $post
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'message' => 'Post not found'
            ], 404);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to retrieve post',
                'error' => $e->getMessage()
            ], 500);
        }
    }



    public function update(Request $request, $id)
    {

        try {
            $post = Post::findOrFail($id);

            $this->authorize('update', $post);


            $validator = Validator::make($request->all(), [
                'title' => ['sometimes', 'string', 'max:255'],
                'content' => ['sometimes', 'string'],
                'tags' => ['sometimes', 'array'],
                'tags.*' => ['exists:tags,id'],
                'published' => ['sometimes', 'boolean'],
                'slug' => [
                    'sometimes',
                    'string',
                    'max:255',
                    Rule::unique('posts')->ignore($post->id)
                ]

            ]);


            if ($validator->fails()) {
                return response()->json([
                    'message' => 'Validation failed',
                    'errors' => $validator->errors()
                ], 422);
            }


            $updateData = $request->only(['title', 'content', 'published', 'slug']);

            $post->update($updateData);


            if ($request->has('tags')) {
                $post->tags()->sync($request->tags);
            }

            $post->load(['user', 'tags']);

            return response()->json([
                'message' => 'Post updated successfully',
                'post' => $post
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'message' => 'Post not found'
            ], 404);
        } catch (\Illuminate\Auth\Access\AuthorizationException $e) {
            return response()->json([
                'message' => 'You are not authorized to update this post'
            ], 403);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to update post',
                'error' => $e->getMessage()
            ], 500);
        }
    }


    public function destroy($id)
    {
        try {
            $post = Post::findOrFail($id);

            $this->authorize('delete', $post);

            $post->delete();

            return response()->json([
                'message' => 'Post deleted successfully'
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'message' => 'Post not found'
            ], 404);
        } catch (\Illuminate\Auth\Access\AuthorizationException $e) {
            return response()->json([
                'message' => 'You are not authorized to delete this post'
            ], 403);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to delete post',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function showBySlug($slug)
    {
        try {
            $post = Post::with(['user', 'tags', 'comments.user'])
                ->withCount('comments')
                ->where('slug', $slug)
                ->firstOrFail();

            // Check if post is published, unless user is admin
            if (!$post->published && (!auth()->user() || !auth()->user()->isAdmin())) {
                return response()->json([
                    'message' => 'Post not found or not published'
                ], 404);
            }

            return response()->json([
                'message' => 'Post retrieved successfully',
                'post' => $post
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'message' => 'Post not found'
            ], 404);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to retrieve post',
                'error' => $e->getMessage()
            ], 500);
        }
    }


    public function myPosts(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'per_page' => ['sometimes', 'integer', 'min:1', 'max:100'],
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'message' => 'Validation failed',
                    'errors' => $validator->errors()
                ], 422);
            }

            $perPage = $request->per_page ?? 10;

            $posts = Post::with(['user', 'tags', 'comments' => function ($query) {
                $query->with('user')->latest()->limit(5);
            }])
                ->where('user_id', $request->user()->id)
                ->latest()
                ->paginate($perPage);

            return response()->json([
                'message' => 'User posts retrieved successfully',
                'posts' => $posts
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to retrieve user posts',
                'error' => $e->getMessage()
            ], 500);
        }
    }



    private function applyFilters($query, Request $request)
    {
        // Filter by tag (slug or ID)

        if ($request->has('tag')) {
            $query->whereHas('tags', function ($q) use ($request) {
                $q->where('tags.slug', $request->tag)
                    ->orWhere('tags.id', $request->tag);
            });
        }

        // Filter by author
        if ($request->has('author')) {
            $query->where('user_id', $request->author);
        }

        // Search in title and content
        if ($request->has('search')) {
            $searchTerm = '%' . $request->search . '%';
            $query->where(function ($q) use ($searchTerm) {
                $q->where('title', 'like', $searchTerm)
                    ->orWhere('content', 'like', $searchTerm);
            });
        }

        // Filter by status
        if ($request->has('status')) {
            if ($request->status === 'published') {
                $query->where('published', true);
            } elseif ($request->status === 'draft') {
                $query->where('published', false);
            }
            // 'all' shows both published and draft
        } else {
            // Default: only show published posts to non-admins
            $user = Auth::user();
            if (!$user || !method_exists($user, 'isAdmin') || !$user->isAdmin()) {
                $query->where('published', true);
            }
        }

        return $query;
    }



    ///end filter
}
