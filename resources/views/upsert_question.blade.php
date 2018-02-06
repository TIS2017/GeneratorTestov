@extends('layouts.app')

@section('title', 'Editácia otázky')

@section('content')
    <p>Formulár na pridanie novej otázky</p>
    @if ($errors->any())
        <ul>
            @foreach ($errors->all() as $error)
                <li>{{ $error }}</li>
            @endforeach
        </ul>
    @endif
    <form method="post" action="/questions/store" enctype="multipart/form-data">
        {{ csrf_field() }}
        <input type="hidden" value="{{ $question != null ? $question->id : '' }}" name="id">
        <label for="question">Znenie otázky</label>
        <textarea name="question" id="question">{{ $errors->any() ? old('question') : ($question ? $question->question : '')  }}</textarea>
        <label for="points">Bodové ohodnotenie otázky</label>
        <input type="text" name="points" id="points" value="{{ $errors->any() ? old('points') : ($question ? $question->points : '')  }}">
        <label for="images">Nahraj obrázok</label>
        <input name="images[]" type="file" accept="image/*" id="images" multiple>
        @isset($questionImages)
            @foreach($questionImages as $key => $image)
                <div class="question-image" id="image-{{ $key }}">
                    <button image="{{ $image }}" class="delete-question-image question-action">Vymazať obrázok</button><br>
                    <image src="{{ Storage::url($image) }}" />
                </div>
            @endforeach
        @endisset
        <br>
        <label for="keywords">Kľúčové slová</label>
        <input type="text" name="keywords" id="keywords" value="{{ $errors->any() ? old('keywords') : ($question ? $question_keywords : '')  }}">
        <input type="checkbox" name="practical" value="1" id="practical" {{ ($errors->any()&&old('practical')||$question&&$question->practical) ? 'checked' : ''  }}><label for="practical">Praktická</label>
        <br>
        <input type="submit" value="{{ $question ? 'Uprav otázku' : 'Pridaj otázku' }}">
    </form>
@endsection