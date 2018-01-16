<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreQuestion;
use App\Keyword;
use App\Question;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class AdminController extends Controller
{
    public function listQuestions(Request $request)
    {
        $questions = Question::paginate(20);
        $question_images = [];
        foreach ($questions as $question) {
            $images = Storage::files('public/question_images/' . $question->id);
            $question_images[$question->id] = $images;
        }
        return view('all_questions', ['questions' => $questions, 'question_images' => $question_images]);
    }

    public function addQuestion(Request $request)
    {
        return view('upsert_question', ['question' => null]);
    }

    public function editQuestion(Request $request)
    {
        $q = Question::find($request->id);
        if ($q != null) {
            return view('upsert_question', ['question' => $q]);
        }
        return null;
    }

    public function storeQuestion(StoreQuestion $request)
    {
        // udaje z formulara
        $question = $request->question;
        $points = $request->points;
        $keywords = explode(',', $request->keywords);
        $practical = $request->has('practical') ? true : false;
        // ulozenie otazky do DB
        $q = Question::create(['question' => $question, 'points' => $points, 'practical' => $practical]);
        // pripojenie klucovych slov k otazke
        foreach ($keywords as $keyword) {
            $k = Keyword::create(['keyword' => $keyword]);
            $q->keywords()->attach($k->id);
        }
        // ulozenie obrazkov
        if ($request->hasFile('images')) {
            $files = $request->file('images');
            // vytvorenie priecinka pre otazku
            // ak je vytvoreny, novy nevytvara
            Storage::makeDirectory('public/question_images/' . $q->id);
            foreach ($files as $file) {
                $file->store('public/question_images/' . $q->id);
            }
        }
        return view('store_question', ['question' => $q]);
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