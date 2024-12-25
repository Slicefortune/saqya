<?php

namespace App\Models;

use App\Enums\PaymentMethodEnum;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasOne;

class Donation extends Model
{
    use HasFactory;

     /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'receiver_name',
        'receiver_contact',
        'description',
        'mosque_name',
        'product_id',
        'mosque_address',
        'quantity',
        'total',
        'sub_total',
        'donated_at',
        'payment_method',
    ];
    protected $casts = [
        'payment_method' => PaymentMethodEnum::class,
        'donated_at' => "datetime:Y-m-d (H:i a)",
        'created_at' => "datetime:Y-m-d (H:i a)",
        'updated_at' => "datetime:Y-m-d (H:i a)",
    ];

    public function product(): BelongsTo
    {
        return $this->belongsTo(Product::class,'product_id');
    }
}
