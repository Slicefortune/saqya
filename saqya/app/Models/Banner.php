<?php

namespace App\Models;

use App\Enums\StatusEnum;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\Storage;

class Banner extends Model
{
    use HasFactory;

    use SoftDeletes;

    public const STORAGE_DIRECTORY = 'banners';
 /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'image',
        'status',
    ];
    protected $casts = [
        'status' => StatusEnum::class,
        'created_at' => "datetime:Y-m-d (H:i a)",
        'updated_at' => "datetime:Y-m-d (H:i a)",
    ];

    protected function getImageUrlAttribute(): string
    {
        return asset(Storage::url($this->image));
    }

    public function scopeActive($query)
    {
        return $query->where('status', '=', 1);
    }
}
