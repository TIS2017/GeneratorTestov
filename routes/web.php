<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

// homepage
Route::get('/', function () {
    return view('index');
})->name('home');

// zoznam otazok
Route::get('/questions', 'AdminController@listQuestions')
    ->name('administration');

// formular na pridanie otazky
Route::get('/questions/add', 'AdminController@addQuestion')
    ->name('add_question');

// ulozenie otazky do DB
Route::post('/questions/store', 'AdminController@storeQuestion');

// formular na editaciu otazky
Route::get('/questions/edit/{id}', 'AdminController@editQuestion')->where('id', '^[1-9]\d*$')
    ->name('edit_question');

// vymazanie otazky, ajax
Route::post('/questions/delete', 'AdminController@deleteQuestion')
    ->name('delete_question');

// najdenie klucovych slov, ajax
Route::get('/questions/find_keywords', 'AdminController@findKeywords');



// formular na zadanie parametrov
Route::get('/generator', 'GeneratorController@index')
    ->name('generator');

// generovanie, ajax
Route::post('/generator/run', 'GeneratorController@generateTest');

Route::post('/delete_question_image', 'AdminController@deleteQuestionImage');