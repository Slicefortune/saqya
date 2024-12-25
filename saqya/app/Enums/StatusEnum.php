<?php

namespace App\Enums;

enum StatusEnum: int
{
    case PUBLISHED = 1;
    case UNPUBLISHED = 2;

    /**
     * @return string
     */
    public function label(): string
    {
        return match ($this) {
            self::PUBLISHED => 'Published',
            self::UNPUBLISHED => 'Unpublished',
        };
    }

    /**
     * @return string
     */
    public function color(): string
    {
        return match ($this) {
            self::PUBLISHED => 'bg-success',
            self::UNPUBLISHED => 'bg-danger',
        };
    }
}