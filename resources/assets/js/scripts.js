$(document).ready(function () {

    $("#generator-options").submit(function (e) {
        e.preventDefault();
        let questionOptions = new Map();
        for (let i = 1; i <= $("#option-questions fieldset").length; i++) {
            let count = $("#questions-" + i + "-count").val();
            let points = $("#questions-" + i + "-points").val();
            if (count !== undefined && points !== undefined)
                questionOptions.set(points, count);
        }
        console.log(questionOptions);
        let practicalCount = $("#option-practical-count").val();
        console.log(practicalCount);
        let testsCount = $("#option-tests-count").val();
        console.log(testsCount);
        $.ajax({
            type: "post",
            url: "http://generator.local/generator/run",
            data: {
                optionQuestions: questionOptions,
                optionPracticalCount: practicalCount,
                optionTestsCount: testsCount,
                _token: $("input[name='_token']").val()
            },
            dataType: 'json'
        }).done(function (msg) {
            console.log(msg);
        })
    });

    $("#add-questions").on("click", function (e) {
        let fieldsetCount = $("#option-questions fieldset").length;
        let i = fieldsetCount + 1;
        let $fieldset = "<fieldset id='" + i + "'>" +
            "               <label for='questions-" + i + "-count'>Počet otázok</label>" +
            "               <input type='text' name='questions[" + i + "][count]' id='questions-" + i + "-count'>" +
            "               <label for='questions-" + i + "-points'>Body</label>" +
            "               <input type='text' name='questions[" + i + "][points]' id='questions-" + i + "-points'>" +
            "             </fieldset>";
        $("#option-questions").append($fieldset);
    })

});

