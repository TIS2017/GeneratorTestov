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
                <a href="/questions/edit/{{ $question->id }}" class="question-action">Uprav</a>
                <a href="/questions/delete" class="question-action delete-question">Zmaž</a>
            </div>
        </div>
    @endforeach
    {{ $questions->links() }}
@endsection