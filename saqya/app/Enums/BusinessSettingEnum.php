<?php

namespace App\Enums;

enum BusinessSettingEnum: string
{
    case PRIVACY_POLICY_EN = 'privacy_policy_en';
    case TERMS_CONDITIONS_EN = 'terms_condition_en';
   
    case PRIVACY_POLICY_AR = 'privacy_policy_ar';
    case TERMS_CONDITIONS_AR = 'terms_condition_ar';
    /**
     * @return string
     */
    public function label(): string
    {
        return match ($this) {
            self::PRIVACY_POLICY_EN => 'Privacy Policy (EN)',
            self::TERMS_CONDITIONS_EN => 'Terms & Conditions (EN)',

            self::PRIVACY_POLICY_AR => 'Privacy Policy (AR)',
            self::TERMS_CONDITIONS_AR => 'Terms & Conditions (AR)',
        };
    }
}