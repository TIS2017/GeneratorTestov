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
            $questionImages = Storage::files('public/question_images/' . $q->id);
            return view('upsert_question', ['question' => $q, 'questionImages' => $questionImages]);
        }
        return null;
    }

    public function storeQuestion(StoreQuestion $request)
    {
        $update = $request->id != '';
        if (!$update) {
            $q = new Question;
        } else {
            $q = Question::find($request->id);
            if ($q == null) {
                return null;
            }
        }
        // udaje z formulara
        $question = $request->question;
        $points = $request->points;
        $keywords = explode(',', $request->keywords);
        $practical = $request->has('practical') ? true : false;
        // ulozenie otazky do DB
        $q->question = $question;
        $q->points = $points;
        $q->practical = $practical;
        $oldKeywords = $this->getOldKeywords($q);
        $newKeywordsIDs = [];
        // pripojenie klucovych slov k otazke
        foreach ($keywords as $keyword) {
            if (strlen($keyword) > 0) {
                $k = Keyword::where('keyword', $keyword)->first();
                if ($k == null) {
                    $k = Keyword::create(['keyword' => $keyword]);
                } else {
                    $index = array_search($keyword, $oldKeywords);
                    if (!$index) {
                        unset($oldKeywords[$index]);
                    }
                }
                $newKeywordsIDs[] = $k->id;
            }
        }
        $q->save();
        $q->keywords()->sync($newKeywordsIDs);
        $this->tryToDeleteKeywords($oldKeywords);
        // ulozenie obrazkov
        if ($request->hasFile('images')) {
            $this->saveImages($request->file('images'), $q->id);
        }
        return view('store_question');
    }

    private function tryToDeleteKeywords($keywords)
    {
        foreach ($keywords as $keyword) {
            $k = Keyword::where('keyword', $keyword)->first();
            if ($k != null && $k->questions->isEmpty()) {
                $k->delete();
            }
        }
    }

    private function saveImages($files, $questionID)
    {
        // vytvorenie priecinka pre otazku
        // ak je vytvoreny, novy nevytvara
        Storage::makeDirectory('public/question_images/' . $questionID);
        foreach ($files as $file) {
            $file->store('public/question_images/' . $questionID);
        }
    }

    private function getOldKeywords($question)
    {
        $keywords = [];
        foreach ($question->keywords as $keyword) {
            $keywords[] = $keyword->keyword;
        }
        return $keywords;
    }

    public function deleteQuestionImage(Request $request)
    {
        if ($request->ajax()) {
            $imagePath = $request->imagePath;
            Storage::delete($imagePath);
            return response()->json([
                'msg' => 'OK'
            ]);
        }
        return null;
    }

    public function deleteQuestion(Request $request)
    {
        if ($request->ajax()) {
            $question = Question::find($request->id);
            if ($question == null) {
                return null;
            }
            $question->delete();
            return response()->json([
                'msg' => 'deleted'
            ]);
        }
        return null;
    }

    public function findKeywords(Request $request)
    {
        var_dump('findKeywords');
    }
}