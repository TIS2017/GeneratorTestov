<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="{{ asset('css/styly.css') }}" media="all">
        <script src="{{ asset('/js/app.js') }}"></script>
        <title>Generátor testov</title>
    </head>
    <body>
        <div class="bodyStyle">
            <header>
                <h1>Generátor testov</h1>
            </header>
            <nav>
                <a href="index.html">Domov</a>
                <a href="pridajOtazku.html">Pridaj otázku</a>
                <a href="generator.html">Generátor</a>
                <a href="administracia.html">Administrácia</a>
            </nav>

            <section>
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
                    <textarea name="question" id="question">{{ $errors->any() ? old('question') : ($question != null ? $question->question : '')  }}</textarea>
                    <label for="points">Bodové ohodnotenie otázky</label>
                    <input type="text" name="points" id="points" value="{{ old('points') }}">
                    <label for="images">Nahraj obrázok</label>
                    <input name="images[]" type="file" accept="image/*" id="images" multiple>
                    @isset($questionImages)
                        @foreach($questionImages as $image)
                            <image src="{{ Storage::url($image) }}" />
                            <button image="{{ $image }}" class="delete-question-image">Vymazat obrazok</button>
                        @endforeach
                    @endisset
                    <label for="keywords">Kľúčové slová</label>
                    <input type="text" name="keywords" id="keywords" value="{{ old('keywords') }}">
                    <input type="checkbox" name="practical" value="1" id="practical" {{ old('practical') ? 'checked' : '' }}><label for="practical">Praktická</label>
                    <input type="submit" value="Pridaj otázku">
                </form>
            </section>

            <footer>
                &copy;Vytvoril tím RMC 2017
            </footer>
        </div>
    </body>
</html>