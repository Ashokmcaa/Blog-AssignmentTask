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
        return true;
    }


    public function view(User $user, Comment $comment): bool
    {
        return true;
    }


    public function create(User $user): bool
    {
        return true;
    }

    public function update(User $user, Comment $comment): bool
    {

        return $user->id === $comment->user_id;
    }


    public function delete(User $user, Comment $comment): bool
    {
        // Comment owner, post owner, or admin can delete
        return $user->isAdmin() ||
            $user->id === $comment->user_id ||
            $user->id === $comment->post->user_id;
    }


    public function restore(User $user, Comment $comment): bool
    {
        return $user->isAdmin();
    }


    public function forceDelete(User $user, Comment $comment): bool
    {
        return $user->isAdmin();
    }
}
