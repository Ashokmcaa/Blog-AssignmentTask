<?php

namespace App\Policies;

use App\Models\Post;
use App\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class PostPolicy
{
    use HandlesAuthorization;

    public function viewAny(User $user)
    {
        return true;
    }

    public function view(User $user, Post $post)
    {
        return true;
    }

    public function create(User $user)
    {
        // Any authenticated user can create posts
        return true;
    }

    public function update(User $user, Post $post)
    {
        return $user->isAdmin() || $user->id === $post->user_id;
    }

    public function delete(User $user, Post $post)
    {
        return $user->isAdmin() || $user->id === $post->user_id;
    }

    public function restore(User $user, Post $post)
    {
        return $user->isAdmin();
    }

    public function forceDelete(User $user, Post $post)
    {
        return $user->isAdmin();
    }
}
