<?php

namespace App\Http\Controllers;

use App\Question;
use Hamcrest\Core\Set;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Input;
use PhpParser\Node\Expr\Cast\Object_;
use function Sodium\add;
use tcpdf;

class GeneratorController extends Controller
{
    public function index(Request $request)
    {
        return view('generator');
    }

    public function generateTest(Request $request)
    {
        if ($request->ajax()) {
            $practicalCount = intval($request->optionPracticalCount);
            $questiosOptions = json_decode($request->optionQuestions);
            $testCount = intval($request->optionTestsCount);
            $result = array();
            # generuje testy podla zadaneho poctu
            if ($testCount < 1) {
                return response()->json([
                    'status' => 'failed',
                    'msg' => 'FAILED',
                    'request' => $request->all(),
                    'optionQuestions' => json_decode($request->optionQuestions)
                ]);
            }

            while ($testCount > 0) {
                # funkcia, ktora sa stara o generovanie
                array_push($result, $this->generateTestQuestions($questiosOptions, $practicalCount));
                $testCount--;
            }


            return response()->json([
                'test' => $result,
                'status' => 'success',
                'msg' => 'OK',
                'request' => $request->all(),
                'optionQuestions' => json_decode($request->optionQuestions)
            ]);
        }

        return null;
    }

    # funkcia generuje test podla zadanych parametrov
    private function generateTestQuestions($questionOptions, $practicalCount)
    {
        # keyWordUsed drzi zaznam o klucovom slove, ktore sa uz v teste vyskytuje
        $keyWordUsed = array();
        $testQuestions = [];
        foreach ($questionOptions as $key => $value) { # key = body za otazku, value = pocet otazok
            # inRandomOrder zaruci ze sa poradie otazok pri kazdom generovani zmeni
            $questions = DB::table('questions')->select('id', 'question', 'practical', 'points')->where('points', '=', $key)->inRandomOrder()->get();
            # ak je pocet otazok v DB mensi ako zadany pocet na generovanie
            if (count($questions) < $value) {
                return null;
            }

            $questionCount = 0;
            foreach ($questions as $question) {
                if ($questionCount != $value) {
                    $keyword_id = DB::table('keywords_questions')->select('keyword_id')->where('question_id', '=', $question->id)->get();
                    # pozriem sa ci uz mam otazku s klucovym slovom
                    # ak nie -> poznacim si ho a pridam otazku do testu
                    # ak ano pokracujem v hladani
                    if (!in_array($keyword_id, $keyWordUsed)) {
                        array_push($keyWordUsed, $keyword_id);
                        array_push($testQuestions, $question);
                        $questionCount++;
                    }
                } else {
                    # uz mam urceny pocet mozem vyskocit
                    break;
                }
            }
            # ak som presiel vsetky otazky ale pocet vybranych je mensi ako pocet pozadovanych
            if ($questionCount < $value) {
                return null;
            }
            $temporatyCount = $questionCount;
        }

        if ($practicalCount > 0) {
            $questions = DB::table('questions')->select('id', 'question', 'practical', 'points')->where('practical', '=', 1)->inRandomOrder()->get();
            # ak je pocet prakticky otazok v DB mensi ako zadany pocet na generovanie
            if (count($questions) < $practicalCount) {
                return null;
            }
            $questionCount = 0;
            foreach ($questions as $question) {
                if ($questionCount != $practicalCount) {
                    $keyword_id = DB::table('keywords_questions')->select('keyword_id')->where('question_id', '=', $question->id)->get();
                    # pozriem sa ci uz mam otazku s klucovym slovom
                    # ak nie -> poznacim si ho a pridam otazku do testu
                    # ak ano pokracujem v hladani
                    if (!in_array($keyword_id, $keyWordUsed)) {
                        array_push($keyWordUsed, $keyword_id);
                        array_push($testQuestions, $question);
                        $questionCount++;
                    }
                } else {
                    # uz mam urceny pocet mozem vyskocit
                    break;
                }
            }
        }

        #nebol vybraty pozadovany celkovy pocet otazok pre test
        if (count($testQuestions) < $temporatyCount + $questionCount) {
            return null;
        }

        return $testQuestions;
    }

    # pripravena dummy funkcia na generovanie pdf
    private function generatePDF()
    {

        # zakladne nastavenia pre generovanie PDF
        $pdf = new TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'utf-8', false);
        $pdf->setCreator(PDF_CREATOR);
        $pdf->setPrintHeader(false);
        $pdf->setPrintFooter(false);

        $pdf->AddPage();
        $txt = "NEJAKY TEXT";

        $pdf->Write(0, $txt);

        $pdf->Output('/storage/app/public/testy/test.pdf', 'F');
    }
}