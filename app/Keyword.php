<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Keyword extends Model
{

    protected $table = 'keywords';

    protected $fillable = ['keyword'];

    public $timestamps = false;

    public function questions() {
        return $this->belongsToMany('App\Question', 'keywords_questions', 'keyword_id', 'question_id');
    }

}
