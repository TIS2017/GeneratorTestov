<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Input;

class GeneratorController extends Controller
{
    public function index(Request $request)
    {
        return view('generator');
    }

    public function generateTest(Request $request)
    {
        if ($request->ajax()) {
            return response()->json([
                'status' => 'success',
                'msg' => 'OK',
                'request' => $request->all(),
                'optionQuestions' => json_decode($request->optionQuestions)
            ]);
        }
        return null;
    }
}