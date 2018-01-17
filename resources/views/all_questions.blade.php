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
                <p>Administrácia otázok</p>
                <br>
                @foreach($questions as $question)
                    <div class="questionBlock">
                        {{ $question->id }} - {{ $question->question }}
                    </div>
                    <div class="btn-group">
                        <a href="/questions/edit/{{ $question->id }}">Uprav</a>
                        <button>Zmaž</button>
                    </div>
                    {{--@foreach($question_images[$question->id] as $image)--}}
                        {{--<img src="{{ Storage::url($image) }}">--}}
                    {{--@endforeach--}}
                    {{--<ul>--}}
                        {{--@foreach($question->keywords as $keyword)--}}
                            {{--<li>{{ $keyword->keyword }}</li>--}}
                        {{--@endforeach--}}
                    {{--</ul>--}}
                @endforeach
                {{ $questions->links() }}
            </section>
            <footer>
                &copy;Vytvoril tím RMC 2017
            </footer>
        </div>
    </body>
</html>





