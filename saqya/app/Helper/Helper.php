<?php

namespace App\Helper;

use App\Models\BusinessSetting;

class Helper
{
    public static function get_business_settings($name)
    {
        $config = null;
        $data =BusinessSetting::where(['key' => $name])->first();
        if (isset($data)) {
            $config = json_decode($data['value'], true);
            if (is_null($config)) {
                $config = $data['value'];
            }
        }
        return $config;

    }

}
