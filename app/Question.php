<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Question extends Model
{

    protected $table = 'questions';

    public function keywords() {
        return $this->hasMany('App\Keyword');
    }

}
