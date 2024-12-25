<?php

namespace App\Enums;

enum PaymentMethodEnum: int
{
    case DEBIT = 1;
    case APPLE_PAY = 2;

    /**
     * @return string
     */
    public function label(): string
    {
        return match ($this) {
            self::DEBIT => 'Debit card',
            self::APPLE_PAY => 'Apple Pay',
        };
    }

    /**
     * @return string
     */
    public function color(): string
    {
        return match ($this) {
            self::DEBIT => 'bg-success',
            self::APPLE_PAY => 'bg-danger',
        };
    }
}