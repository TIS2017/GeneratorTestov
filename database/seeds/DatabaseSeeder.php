<?php

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {

        DB::table('questions')->delete();
        DB::table('keywords')->delete();
        DB::table('keywords_questions')->delete();

        $q1 = \App\Question::create([
            'question' => 'question 1',
            'points' => 10,
            'practical' => true
        ]);

        $q2 = \App\Question::create([
            'question' => 'question 2',
            'points' => 20,
            'practical' => false
        ]);

        $q3 = \App\Question::create([
            'question' => 'question 3',
            'points' => 30,
            'practical' => true
        ]);

        $this->command->info('Questions added!');

        $k1 = \App\Keyword::create([
            'keyword' => 'keyword 1'
        ]);

        $k2 = \App\Keyword::create([
            'keyword' => 'keyword 2'
        ]);

        $k3 = \App\Keyword::create([
            'keyword' => 'keyword 3'
        ]);

        $this->command->info('Keywords added!');

        $q1->keywords()->attach($k1->id);
        $q1->keywords()->attach($k2->id);
        $q1->keywords()->attach($k3->id);

        $q2->keywords()->attach($k3->id);

        $q3->keywords()->attach($k1->id);
        $q3->keywords()->attach($k2->id);

        $k3->questions()->attach($q1->id);

        $this->command->info('Relations added!');

    }
}
