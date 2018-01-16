<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreQuestion extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'question' => 'required',
            'points' => 'integer',
            'images.*' => 'image'
        ];
    }

    public function messages()
    {
        return [
            'question.required' => 'Znenie otázky nesmie byť prázdne',
            'points.integer' => 'Bodové ohodnotenie otázky musí byť celé číslo',
            'images.*' => 'Obrázky nemajú povolený formát'
        ];
    }
}
