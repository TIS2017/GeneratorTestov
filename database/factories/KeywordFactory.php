<?php

use Faker\Generator as Faker;

/* @var Illuminate\Database\Eloquent\Factory $factory */

$factory->define(App\Keyword::class, function (Faker $faker) {
    return [
        'keyword' => $faker->word
    ];
});
