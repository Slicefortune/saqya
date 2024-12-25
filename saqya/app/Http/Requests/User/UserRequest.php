<?php

namespace App\Http\Requests\User;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class UserRequest extends FormRequest
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
     * @return array<string, ValidationRule|array|string>
     */
    public function rules(): array
    {
        $validationRules = [
            'name' => 'required|string',
            'email' => 'required|email|unique:users',
            'password' => 'required',
        ];
        if ($this->user) {
            $validationRules['email'] = 'required|email|unique:users,email,' . $this->user;
        }

        return $validationRules;
    }
}
