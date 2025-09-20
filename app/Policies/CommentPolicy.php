<?php

namespace App\Policies;

use App\Models\Comment;
use App\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class CommentPolicy
{
    use HandlesAuthorization;


    public function viewAny(User $user): bool
    {
        return true; // Anyone can view comments
    }


    public function view(User $user, Comment $comment): bool
    {
        return true; // Anyone can view a comment
    }


    public function create(User $user): bool
    {
        return true; // Any authenticated user can create comments
    }

    public function update(User $user, Comment $comment): bool
    {
        // Only comment owner can update
        return $user->id === $comment->user_id;
    }


    public function delete(User $user, Comment $comment): bool
    {
        // Comment owner, post owner, or admin can delete
        return $user->isAdmin() ||
            $user->id === $comment->user_id ||
            $user->id === $comment->post->user_id;
    }

    /**
     * Determine whether the user can restore the model.
     */
    public function restore(User $user, Comment $comment): bool
    {
        return $user->isAdmin();
    }

    /**
     * Determine whether the user can permanently delete the model.
     */
    public function forceDelete(User $user, Comment $comment): bool
    {
        return $user->isAdmin();
    }
}
