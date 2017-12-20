<?php

namespace App\Http\Controllers;

use App\Question as Question;
use App\Keyword;
use App\Http\Controllers\Controller;

class PageController extends Controller
{
    /**
     * Show the profile for the given user.
     *
     * @param  int  $id
     * @return Response
     */
    public function show()
    {
        $q = Question::find(1);

        var_dump($q);

        return view('test');
    }
    
    
}