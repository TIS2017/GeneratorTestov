<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Keyword extends Model
{

    protected $table = 'keywords';

    public function question() {
        return $this->belongsTo('App\Question');
    }

}
