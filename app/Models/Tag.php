<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Support\Str;

class Tag extends Model
{
    use HasFactory;


    protected $fillable = [
        'name',
        'slug',
        'description',
        'color',
        'is_active'
    ];


    protected $casts = [
        'is_active' => 'boolean',
        'created_at' => 'datetime',
        'updated_at' => 'datetime'
    ];


    protected static function boot()
    {
        parent::boot();

        static::creating(function ($tag) {
            if (empty($tag->slug)) {
                $tag->slug = Str::slug($tag->name);
            }
        });

        static::updating(function ($tag) {
            if ($tag->isDirty('name') && empty($tag->slug)) {
                $tag->slug = Str::slug($tag->name);
            }
        });
    }


    public function posts(): BelongsToMany
    {
        return $this->belongsToMany(Post::class)
            ->withTimestamps()
            ->withPivot(['created_at', 'updated_at'])
            ->where('published', true) // Only published posts
            ->orderBy('posts.created_at', 'desc');
    }


    public function allPosts(): BelongsToMany
    {
        return $this->belongsToMany(Post::class)
            ->withTimestamps()
            ->withPivot(['created_at', 'updated_at']);
    }

    public function scopeActive($query)
    {
        return $query->where('is_active', true);
    }


    public function scopePopular($query, $limit = 10)
    {
        return $query->withCount('posts')
            ->orderBy('posts_count', 'desc')
            ->limit($limit);
    }


    public function scopeSearch($query, $searchTerm)
    {
        return $query->where('name', 'like', "%{$searchTerm}%")
            ->orWhere('slug', 'like', "%{$searchTerm}%");
    }

    /**
     * Scope: Tags with at least one post.
     */
    public function scopeHasPosts($query)
    {
        return $query->whereHas('posts');
    }

    /**
     * Scope: Tags with no posts.
     */
    public function scopeHasNoPosts($query)
    {
        return $query->whereDoesntHave('posts');
    }

    /**
     * Accessor: Get the post count.
     */
    public function getPostCountAttribute(): int
    {
        if (!$this->relationLoaded('posts')) {
            return $this->posts()->count();
        }

        return $this->posts->count();
    }

    /**
     * Accessor: Get the formatted created date.
     */
    public function getCreatedAtFormattedAttribute(): string
    {
        return $this->created_at->format('M d, Y');
    }

    /**
     * Accessor: Get the tag URL.
     */
    public function getUrlAttribute(): string
    {
        return route('tags.show', $this->slug);
    }

    /**
     * Mutator: Set the name and auto-generate slug.
     */
    public function setNameAttribute($value): void
    {
        $this->attributes['name'] = ucfirst(trim($value));

        if (empty($this->attributes['slug'])) {
            $this->attributes['slug'] = Str::slug($value);
        }
    }


    public function setSlugAttribute($value): void
    {
        $this->attributes['slug'] = Str::lower(Str::slug($value));
    }


    public function hasPosts(): bool
    {
        return $this->posts()->exists();
    }

    /**
     * Get recent posts for this tag.
     */
    public function recentPosts($limit = 5)
    {
        return $this->posts()
            ->orderBy('created_at', 'desc')
            ->limit($limit)
            ->get();
    }

    /**
     * Attach posts to tag with optional timestamps.
     */
    public function attachPosts(array $postIds, array $pivotData = []): void
    {
        $this->posts()->attach($postIds, $pivotData);
    }

    /**
     * Sync posts for this tag.
     */
    public function syncPosts(array $postIds): void
    {
        $this->posts()->sync($postIds);
    }

    /**
     * Detach all posts from this tag.
     */
    public function detachAllPosts(): void
    {
        $this->posts()->detach();
    }

    /**
     * Detach specific posts from this tag.
     */
    public function detachPosts(array $postIds): void
    {
        $this->posts()->detach($postIds);
    }

    /**
     * Find tag by slug.
     */
    public static function findBySlug($slug)
    {
        return static::where('slug', $slug)->first();
    }

    /**
     * Get tags with post count for sidebar.
     */
    public static function getPopularTags($limit = 15)
    {
        return static::withCount('posts')
            ->orderBy('posts_count', 'desc')
            ->limit($limit)
            ->get();
    }

    /**
     * Get tags for select dropdown.
     */
    public static function getForSelect()
    {
        return static::active()
            ->orderBy('name')
            ->pluck('name', 'id')
            ->toArray();
    }

    /**
     * Create a new tag with validation.
     */
    public static function createTag(array $data)
    {
        // Check if tag already exists
        $existingTag = static::where('name', $data['name'])
            ->orWhere('slug', Str::slug($data['name']))
            ->first();

        if ($existingTag) {
            return $existingTag;
        }

        return static::create([
            'name' => $data['name'],
            'slug' => $data['slug'] ?? Str::slug($data['name']),
            'description' => $data['description'] ?? null,
            'color' => $data['color'] ?? null,
            'is_active' => $data['is_active'] ?? true
        ]);
    }


    public function getRouteKeyName(): string
    {
        return 'slug';
    }
}
