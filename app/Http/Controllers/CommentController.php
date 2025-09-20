<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Comment;
use App\Models\Post;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Support\Facades\Log;

class CommentController extends Controller
{
    use AuthorizesRequests;


    public function index($postId)
    {
        try {
            // Verify the post exists
            Post::findOrFail($postId);

            $comments = Comment::with(['user', 'post'])
                ->where('post_id', $postId)
                ->latest()
                ->paginate(10);

            return response()->json([
                'message' => 'Comments retrieved successfully',
                'comments' => $comments
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'message' => 'Post not found'
            ], 404);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to retrieve comments',
                'error' => $e->getMessage()
            ], 500);
        }
    }




    public function store(Request $request, $postId)
    {
        try {
            // Check if post exists and is published
            $post = Post::find($postId);

            if (!$post) {
                return response()->json([
                    'message' => 'Post not found'
                ], 404);
            }

            // Check if post is published (unless user is admin)
            if (!$post->published && (!auth()->user() || !auth()->user()->isAdmin())) {
                return response()->json([
                    'message' => 'Cannot comment on unpublished post'
                ], 403);
            }

            // Validate comment content
            $validator = Validator::make($request->all(), [
                'content' => ['required', 'string', 'max:1000', 'min:1']
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'message' => 'Validation failed',
                    'errors' => $validator->errors()
                ], 422);
            }

            // Create the comment
            $comment = Comment::create([
                'content' => $request->content,
                'user_id' => $request->user()->id,
                'post_id' => $postId
            ]);

            // Load user relationship for response
            $comment->load('user');

            return response()->json([
                'message' => 'Comment added successfully',
                'comment' => $comment
            ], 201);
        } catch (\Exception $e) {
            // Log the error properly
            Log::error('Comment creation failed: ' . $e->getMessage());
            Log::error('Stack trace: ' . $e->getTraceAsString());

            return response()->json([
                'message' => 'Failed to create comment',
                'error' => config('app.debug') ? $e->getMessage() : 'Internal server error'
            ], 500);
        }
    }


    public function update(Request $request, $id)
    {
        try {
            $comment = Comment::with(['user', 'post'])->findOrFail($id);


            $this->authorize('update', $comment);

            $validator = Validator::make($request->all(), [
                'content' => ['required', 'string', 'max:1000', 'min:1']
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'message' => 'Validation failed',
                    'errors' => $validator->errors()
                ], 422);
            }

            $comment->update([
                'content' => $request->content
            ]);

            // Refresh the model to get updated relationships
            $comment->refresh()->load('user');

            return response()->json([
                'message' => 'Comment updated successfully',
                'comment' => $comment
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'message' => 'Comment not found'
            ], 404);
        } catch (\Illuminate\Auth\Access\AuthorizationException $e) {
            return response()->json([
                'message' => 'You are not authorized to update this comment'
            ], 403);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to update comment',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Delete a comment
     *
     * @param int $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy($id)
    {
        try {
            $comment = Comment::with(['user', 'post'])->findOrFail($id);

            // Authorize the delete action
            $this->authorize('delete', $comment);

            $comment->delete();

            return response()->json([
                'message' => 'Comment deleted successfully'
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'message' => 'Comment not found'
            ], 404);
        } catch (\Illuminate\Auth\Access\AuthorizationException $e) {
            return response()->json([
                'message' => 'You are not authorized to delete this comment'
            ], 403);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to delete comment',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get a single comment
     *
     * @param int $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function show($id)
    {
        try {
            $comment = Comment::with(['user', 'post'])->findOrFail($id);

            return response()->json([
                'message' => 'Comment retrieved successfully',
                'comment' => $comment
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'message' => 'Comment not found'
            ], 404);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to retrieve comment',
                'error' => $e->getMessage()
            ], 500);
        }
    }


    public function userComments(Request $request)
    {
        try {
            $comments = Comment::with(['user', 'post'])
                ->where('user_id', $request->user()->id)
                ->latest()
                ->paginate(10);

            return response()->json([
                'message' => 'User comments retrieved successfully',
                'comments' => $comments
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to retrieve user comments',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
