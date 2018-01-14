<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Input;

class GeneratorController extends Controller
{
    public function index(Request $request) {
        return view('generator');
    }

    public function generateTest(Request $request) {
        if (\Illuminate\Support\Facades\Request::ajax()) {
            $optionQuestions = Input::get('optionQuestions');
            $optionPracticalCount = Input::get('optionPracticalCount');
            $optionTestsCount = Input::get('optionTestsCount');
            return response()->json([
                'status' => 'success',
                'msg' => 'OK'
            ]);
        }
        return null;
    }
}