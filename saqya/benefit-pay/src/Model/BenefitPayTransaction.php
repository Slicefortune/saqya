<?php

namespace BenefitPay\Model;


use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BenefitPayTransaction extends Model
{
    use HasFactory;

    const STATUS_PENDING = 'pending';

    const STATUS_SUCCESS = 'success';

    const STATUS_FAILED = 'failed';
    /**
     * Cast Data before accessing them
     *
     * @var string[] $casts
     */
    protected $casts = [
        'return_response' => 'array',
        'order_request' => 'array',
        'cart_data' => 'array',
    ];


    /**
     * These Attributes ara mass assignable
     *
     * @var string[] $fillable
     */
    protected $fillable = [
        'trackId',
        'amount',
        'return_response',
        'status',
        'order_request',
        'cart_data',
        'user_id'
    ];

    public function getReturnResponseAttribute($value)
    {
        return json_decode(json_decode($value));
    }
}
