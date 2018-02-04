@extends('layouts.app')

@section('title', 'Administrácia')

@section('content')
    <p>Administrácia otázok</p>
    <br>
    @foreach($questions as $question)
        <div class="question" id="question-{{ $question->id }}">
            <div class="questionBlock">
                {{ $question->id }} - {{ $question->question }}
            </div>
            <div class="btn-group">
                <a href="/questions/edit/{{ $question->id }}">Uprav</a>
                <a href="/questions/delete" class="delete-question">Zmaž</a>
            </div>
        </div>
    @endforeach
    {{ $questions->links() }}
@endsection