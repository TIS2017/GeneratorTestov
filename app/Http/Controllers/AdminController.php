<?php

namespace App\Http\Controllers;

//use App\Http\Controllers\Controller;

use Illuminate\Http\Request;

class AdminController extends Controller
{
    public function listQuestions(Request $request) {
        var_dump('listQuestions');
    }

    public function addQuestion(Request $request) {
        var_dump('addQuestions');
    }

    public function editQuestion(Request $request) {
        var_dump('editQuestions', $request->id);
    }

    public function storeQuestion(Request $request) {
        var_dump('storeQuestions');
    }

    public function deleteQuestion(Request $request) {
        var_dump('deleteQuestions');
    }

    public function findKeywords(Request $request) {
        var_dump('findKeywords');
    }
}