<?php

use Faker\Generator as Faker;

/* @var Illuminate\Database\Eloquent\Factory $factory */

$factory->define(App\Question::class, function (Faker $faker) {
    return [
        'question' => $faker->text,
        'points' => $faker->numberBetween(1, 100),
        'practical' => $faker->boolean
    ];
});
