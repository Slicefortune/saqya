<?php

namespace Database\Seeders;

use App\Models\BusinessSetting;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class BusinessSettingSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $settings = [
            'terms_condition_en' => 'terms_condition_en',
            'privacy_policy_en' => 'privacy_policy_en',

            'terms_condition_ar' => 'terms_condition_ar',
            'privacy_policy_ar' => 'privacy_policy_ar',
            'maintenance_mode' => 0,
            'software_version' => '1.0.1',
            'whatsapp' => '33123456',
            'map_api_server_key' => 'AIzaSyAwEmv3whQry4abe7SnIuPS4ttniNdkLuI',

        ];

        foreach ($settings as $key => $value) {
            BusinessSetting::updateOrCreate(['key' => $key], ['value' => $value]);
        }
    }
}
