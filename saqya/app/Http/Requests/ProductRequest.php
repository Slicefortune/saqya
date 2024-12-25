<?php

namespace App\Http\Requests;

use App\Enums\StatusEnum;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\Rules\Enum;

class ProductRequest extends FormRequest
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
            'name' => 'required|string',
            'name_ar' => 'required|string',
            'size' => 'required|string',
            'price' => 'required',
            'status' => ['required', new Enum(StatusEnum::class)],
            'image' => 'required|image|max:1024',
        ];
        if ($this->product) {
            $rules['image'] = 'image|max:1024';
        }
        return $rules;
    }
}
