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
        // vyprazdenie tabuliek
        DB::table('questions')->delete();
        DB::table('keywords')->delete();
        DB::table('keywords_questions')->delete();

        $this->command->info('Tabulky vyprazdnene');

        // 50 nahodnych otazok
        factory(App\Question::class, 50)->create();

        $this->command->info('Otazky vygenerovane');

        // 100 nahodnych klucovych slov
        factory(App\Keyword::class, 100)->create();

        $this->command->info('Klucove slova vygenerovane');

        foreach (\App\Question::all() as $question) {
            // nahodny pocet klucovych slov
            $count = rand(0, 15);
            $keywords = \App\Keyword::orderBy(DB::raw('RAND()'))->take($count)->get();
            foreach ($keywords as $keyword) {
                // pridanie klucoveho slova k otazke
                $question->keywords()->attach($keyword->id);
            }
        }

        $this->command->info('Hotovo!');

    }
}
