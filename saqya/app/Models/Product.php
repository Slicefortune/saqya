<?php

namespace App\Models;

use App\Enums\StatusEnum;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\Storage;

class Product extends Model
{
    use HasFactory;
    use SoftDeletes;

    public const STORAGE_DIRECTORY = 'products';
 /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'name_ar',
        'size',
        'price',
        'image',
        'status',
    ];
    protected $casts = [
        'status' => StatusEnum::class,
        'created_at' => "datetime:Y-m-d (H:i a)",
        'updated_at' => "datetime:Y-m-d (H:i a)",
    ];

     /**
     * Get the user's first name.
     */
    protected function getImageUrlAttribute(): string
    {
        return asset(Storage::url($this->image));
    }

    public function scopeActive($query)
    {
        return $query->where('status', '=', 1);
    }

    // public function donation(): BelongsTo
    // {
    //     return $this->belongsTo(Donation::class,);
    // }
}
