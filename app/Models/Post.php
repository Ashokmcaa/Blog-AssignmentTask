<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Post extends Model
{
    use HasFactory;

    protected $fillable = [
        'title',
        'content',
        'user_id',
        'slug',
        'published'
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function comments()
    {
        return $this->hasMany(Comment::class);
    }

    public function tags()
    {
        return $this->belongsToMany(Tag::class);
    }

    public function scopePublished($query)
    {
        return $query->where('published', true);
    }

    // public function scopeWithFilters($query, $filters)
    // {
    //     return $query->when(isset($filters['tag']), function ($query) use ($filters) {
    //         $query->whereHas('tags', function ($query) use ($filters) {
    //             $query->where('slug', $filters['tag']);
    //         });
    //     })
    //         ->when(isset($filters['author']), function ($query) use ($filters) {
    //             $query->whereHas('user', function ($query) use ($filters) {
    //                 $query->where('id', $filters['author']);
    //             });
    //         })
    //         ->when(isset($filters['search']), function ($query) use ($filters) {
    //             $query->where(function ($query) use ($filters) {
    //                 $query->where('title', 'like', '%' . $filters['search'] . '%')
    //                     ->orWhere('content', 'like', '%' . $filters['search'] . '%');
    //             });
    //         });
    // }

    // app/Models/Post.php
    public function scopeWithFilters($query, $filters)
    {
        return $query->when(isset($filters['tag']), function ($query) use ($filters) {
            $query->whereHas('tags', function ($query) use ($filters) {
                $query->where('slug', $filters['tag'])
                    ->orWhere('id', $filters['tag']);
            });
        })
            ->when(isset($filters['author']), function ($query) use ($filters) {
                $query->where('user_id', $filters['author']);
            })
            ->when(isset($filters['search']), function ($query) use ($filters) {
                $query->where(function ($query) use ($filters) {
                    $query->where('title', 'like', '%' . $filters['search'] . '%')
                        ->orWhere('content', 'like', '%' . $filters['search'] . '%');
                });
            });
    }
}
