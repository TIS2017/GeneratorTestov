<?php

namespace App\Http\Controllers;

use App\Question;
use Illuminate\Http\Request;

class AdminController extends Controller
{
    public function listQuestions(Request $request)
    {
        $questions = Question::paginate(20);
        return view('all_questions', ['questions' => $questions]);
    }

    public function addQuestion(Request $request)
    {
        var_dump('addQuestions');
    }

    public function editQuestion(Request $request)
    {
        var_dump('editQuestions', $request->id);
    }

    public function storeQuestion(Request $request)
    {
        var_dump('storeQuestions');
    }

    public function deleteQuestion(Request $request)
    {
        var_dump('deleteQuestions');
    }

    public function findKeywords(Request $request)
    {
        var_dump('findKeywords');
    }
}