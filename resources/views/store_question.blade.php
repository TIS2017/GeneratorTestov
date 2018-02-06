@extends('layouts.app')

@section('title', 'Uloženie otázky')

@section('content')
    <p>Otázka bola úspešne pridaná</p>
    <br>
    <div class="center">
        <a href="/questions/add" class="question-action">Pridaj ďalšiu otázku</a>
    </div>
@endsection