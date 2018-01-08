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
    return view('welcome');
});

// zoznam otazok
Route::get('/questions', 'AdminController@listQuestions');

// formular na pridanie otazky
Route::get('/questions/add', 'AdminController@addQuestion');

// ulozenie otazky do DB
Route::post('/questions/store', 'AdminController@storeQuestion');

// formular na editaciu otazky
Route::get('/questions/edit/{id}', 'AdminController@editQuestion');

// vymazanie otazky, ajax
Route::get('/questions/delete', 'AdminController@deleteQuestion');

// vymazanie otazky, ajax
Route::get('/questions/find_keywords', 'AdminController@findKeywords');



// formular na zadanie parametrov
Route::get('/generator', 'GeneratorController@index');

// generovanie, ajax
Route::get('/generator/run', 'GeneratorController@generateTest');

