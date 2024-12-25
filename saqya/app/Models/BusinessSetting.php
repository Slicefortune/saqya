<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BusinessSetting extends Model
{
    use HasFactory;

    protected $fillable = [
        'key',
        'value',
    ];
    protected $casts = [
        'created_at' => "datetime:Y-m-d (H:i a)",
        'updated_at' => "datetime:Y-m-d (H:i a)",
    ];
}
