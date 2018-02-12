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
        if (!$request->ajax()) {
            return null;
        }

        // pocet praktickych otazok musi byt cele cislo
        if (!is_numeric($request->optionPracticalCount)) {
            return response()->json([
                'status' => false,
                'msg' => 'Počet praktických otázok musí byť celé číslo!',
                'req' => $request->optionPracticalCount
            ]);
        }
        $practicalCount = intval($request->optionPracticalCount);
        if ($practicalCount < 0) {
            return response()->json([
                'status' => false,
                'msg' => 'Neplatný počet praktických otázok'
            ]);
        }

        if (!is_numeric($request->optionTestsCount)) {
            return response()->json([
                'status' => false,
                'msg' => 'Počet testov musí byť celé číslo!'
            ]);
        }
        $testCount = intval($request->optionTestsCount);
        # ak je pocet mensi ako 1 tak koniec
        if ($testCount < 1) {
            return response()->json([
                'status' => false,
                'msg' => 'Neplatný počet testov!'
            ]);
        }

        $questiosOptions = json_decode($request->optionQuestions);
        $result = array();

        # generovanie testov podla zadaneho poctu
        while ($testCount > 0) {
            # funkcia, ktora sa stara o generovanie
            $generationResult = $this->generateTestQuestions($questiosOptions, $practicalCount);
            # ak generator vrati null (nie je mozne vygenerovat test tak koncim)
            if ($generationResult == null) {
                return response()->json([
                    'status' => false,
                    'msg' => 'Nie je možné vygenerovať test so zadanými parametrami!'
                ]);
            }
            array_push($result, $generationResult);
            $testCount--;
        }

        # vygeneruje PDF subor
        $pdf_file = $this->generatePDF($result);

        # resposne ak vsetko prebehlo OK
        return response()->json([
            'pdf_file' => $pdf_file,
            'status' => true,
            'msg' => 'Test bol úspešne vygenerovaný!'
        ]);

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
                    // vsetky klucove slova otazky
                    // objekt Illuminate\Support\Collection
                    $question_keywords = DB::table('keywords_questions')->select('keyword_id')->where('question_id', '=', $question->id)->get();
                    # pozriem sa ci uz mam otazku s klucovym slovom
                    # ak nie -> poznacim si ho a pridam otazku do testu
                    # ak ano pokracujem v hladani
                    if ($question_keywords->isEmpty()) {
                        // otazka nema klucove slova
                        // prida sa do testu
                        array_push($testQuestions, $question);
                        $questionCount++;
                    } else {
                        // otazka ma klucove slova
                        // kontrola, ci nie je nejake klucove slovo obsadene
                        $accepted = true;
                        foreach ($question_keywords as $keyword) {
                            if (in_array($keyword, $keyWordUsed)) {
                                $accepted = false;
                            }
                        }
                        if ($accepted) {
                            // ak je vsetko OK, tak prida otazku aj jej klucove slova
                            array_push($testQuestions, $question);
                            $questionCount++;
                            foreach ($question_keywords as $keyword) {
                                array_push($keyWordUsed, $keyword);
                            }
                        }
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
            // vsetky prakticke otazky
            // objekt Illuminate\Support\Collection
            $questions = DB::table('questions')->select('id', 'question', 'practical', 'points')->where('practical', '=', 1)->inRandomOrder()->get();
            # ak je pocet prakticky otazok v DB mensi ako zadany pocet na generovanie
            if (count($questions) < $practicalCount) {
                return null;
            }
            $questionCount = 0;
            foreach ($questions as $question) {
                if ($questionCount != $practicalCount) {
                    // vsetky klucove slova otazky
                    // objekt Illuminate\Support\Collection
                    $question_keywords = DB::table('keywords_questions')->select('keyword_id')->where('question_id', '=', $question->id)->get();
                    # pozriem sa ci uz mam otazku s klucovym slovom
                    # ak nie -> poznacim si ho a pridam otazku do testu
                    # ak ano pokracujem v hladani
                    if ($question_keywords->isEmpty()) {
                        // otazka nema klucove slova
                        // prida sa do testu
                        array_push($testQuestions, $question);
                        $questionCount++;
                    } else {
                        // otazka ma klucove slova
                        // kontrola, ci nie je nejake klucove slovo obsadene
                        $accepted = true;
                        foreach ($question_keywords as $keyword) {
                            if (in_array($keyword, $keyWordUsed)) {
                                $accepted = false;
                            }
                        }
                        if ($accepted) {
                            // ak je vsetko OK, tak prida otazku aj jej klucove slova
                            array_push($testQuestions, $question);
                            $questionCount++;
                            foreach ($question_keywords as $keyword) {
                                array_push($keyWordUsed, $keyword);
                            }
                        }
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
        $pdf->SetFont('times', '', 12);
        $pdf->setCreator(PDF_CREATOR);
        $pdf->setPrintHeader(false);
        $pdf->setPrintFooter(false);

        # cela cesta k /storage/app/
        $path = storage_path('app/');

        # pre kazdy vygenerovany test prida otazky do PDF
        foreach ($tests as $test) {
            $pdf->AddPage();
            $questionNumber = 1;
            foreach ($test as $questions) {
                $question = "<html>";
                $question .= (string)$questionNumber . ".    ";
                $question .= "[" . (string)$questions->points . " b.]    ";
                $question .= (string)nl2br($questions->question);

                $question .= '<br>';

                # cesta v obrazkom
                # ak ano prejde vsetky obrazky v zlozke a prida ich do PDF suboru
                try {
                    $images = Storage::files('public/question_images/' . $questions->id);
                    foreach ($images as $image) {
                        $question .= '<br>';
                        Log::info($image);
                        $question .= '<img src="' . $path . (string)$image . '" style="padding-bottom:10px">';

                    }
                }catch (\Exception $e){
                    Log::info("K otazke s id ". $questions->id ." nie su obrazky");
                }
                $question .= "</html>";
                $pdf->WriteHTML($question, true, false, true, false, "");
                $questionNumber++;
            }
        }
        # ulozi subor na disk
        $pdf->Output($path . 'public/testy/test.pdf', 'F');
        return 'storage/testy/test.pdf';
    }
}
