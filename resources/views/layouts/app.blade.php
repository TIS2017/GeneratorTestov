<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="{{ asset('css/styly.css') }}" media="all">
        <script src="{{ asset('/js/app.js') }}"></script>
        <title>@yield('title')</title>
    </head>
    <body>
        <div class="bodyStyle">
            <header>
                <h1>Generátor testov</h1>
            </header>
            <nav>
                <a href="{{ route('home') }}">Domov</a>
                <a href="{{ route('add_question') }}">Pridaj otázku</a>
                <a href="{{ route('generator') }}">Generátor</a>
                <a href="{{ route('administration') }}">Administrácia</a>
            </nav>
            <section>
                @yield('content')
            </section>
            <footer>
                &copy;Vytvoril tím RMC 2017
            </footer>
        </div>
    </body>
</html>