<?php

namespace App\Http\Requests;

use App\Enums\BusinessSettingEnum;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class BusinessSettingRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return Auth::check();
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        $rules = [
            BusinessSettingEnum::PRIVACY_POLICY_EN->value => 'nullable',
            BusinessSettingEnum::PRIVACY_POLICY_AR->value => 'nullable',

            BusinessSettingEnum::TERMS_CONDITIONS_AR->value => 'nullable',
            BusinessSettingEnum::TERMS_CONDITIONS_EN->value => 'nullable',


        ];
       
        return $rules;
    }
}
