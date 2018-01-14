<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="css/styly.css" media="all">

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
                <p>Generátor nového testu</p>
                <form id="generator-options" method="post" action="/generator/run">
                    {{ csrf_field() }}
                    <div id="option-questions">
                        <fieldset id="1">
                            <label for="questions-1-count">Počet otázok</label>
                            <input type="text" class="questions" name="questions[1][count]" id="questions-1-count">
                            <label for="questions-1-points">Body</label>
                            <input type="text" class="questions" name="questions[1][points]" id="questions-1-points">
                        </fieldset>
                    </div>

                    <input type="button" id="add-questions" value="+">

                    <label for="option-practical-count">Počet praktických otázok</label>
                    <input type="text" name="option-practical-count" id="option-practical-count">

                    <label for="option-tests-count">Počet testov</label>
                    <input type="text" name="option-tests-count" id="option-tests-count">

                    <input type="submit" value="Vygeneruj test">
                </form>
            </section>
            <footer>
                &copy;Vytvoril tím RMC 2017
            </footer>

        </div>
    </body>
</html>