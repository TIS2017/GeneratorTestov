<?php

namespace App\Http\Controllers;

use App\Question;
use Hamcrest\Core\Set;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Input;
use Illuminate\Support\Facades\Log;
use PhpParser\Node\Expr\Cast\Object_;
use Illuminate\Support\Facades\Storage;
use function Sodium\add;
use TCPDF;

class GeneratorController extends Controller
{
    public function index(Request $request)
    {
        return view('generator');
    }

    # generuje testy podla parametrov
    public function generateTest(Request $request)
    {
        if ($request->ajax()) {
            $practicalCount = intval($request->optionPracticalCount);
            $questiosOptions = json_decode($request->optionQuestions);
            $testCount = intval($request->optionTestsCount);
            $result = array();

            # ak je pocet mensi ako 1 tak koniec
            if ($testCount < 1) {
                return response()->json([
                    'status' => 'failed',
                    'msg' => 'FAILED',
                    'request' => $request->all(),
                    'optionQuestions' => json_decode($request->optionQuestions)
                ]);
            }

            # generovanie testov podla zadaneho poctu
            while ($testCount > 0) {
                # funkcia, ktora sa stara o generovanie
                array_push($result, $this->generateTestQuestions($questiosOptions, $practicalCount));
                $testCount--;
            }

            # vygeneruje PDF subor
            $this->generatePDF($result);

            # resposne ak vsetko prebehlo OK
            return response()->json([
                'result' => $result,
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

            #nebol vybraty pozadovany celkovy pocet otazok pre test
            if (count($testQuestions) < $temporatyCount + $questionCount) {
                return null;
            }
        }

        # vrati pole s vygenerovanymi testami
        return $testQuestions;
    }

    # generovanie PDF suboru s otazkami
    private function generatePDF($tests)
    {

        # zakladne nastavenia pre generovanie PDF
        $pdf = new TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'utf-8', false);
        $pdf->setCreator(PDF_CREATOR);
        $pdf->setPrintHeader(false);
        $pdf->setPrintFooter(false);

        # pre kazdy vygenerovany test prida otazky do PDF
        foreach ($tests as $test){
            $pdf->AddPage();
            $questionNumber = 1;
            foreach ($test as $questions){
                $question = (string)$questionNumber . ".    ";
                $question .= (string)$questions->question. '    ';
                $question .= "[" . (string)$questions->points . "]\n";
                # cesta v obrazkom
                # pozrie ci cesta existuje
                try {
                    $path = Storage::files('public/question_images/' . $questions->id . '/');
                    # ak ano prejde vsetky obrazky v zlozke a prida ich do PDF suboru
                    foreach ($path as $image) {
                        Log::info($image);
                        #TODO nepridava obrazok do PDF
                        $pdf->Image($image, "10", "20", "100", "100");
                    }
                }catch (\Exception $e){
                    Log::info($e);
                }

                $pdf->Write(0, $question);
                $questionNumber++;
            }
        }
        # ulozi subor na disk
        # TODO fixnut ukladanie do /storage/app/public/
        $pdf->Output(__DIR__.'/test.pdf', 'F');
    }
}