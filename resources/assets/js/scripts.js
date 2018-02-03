$(document).ready(function () {
  
    $("#generator-options").submit(function (e) {
        e.preventDefault();
        let generatorOutput = $('.generator-output');
        let questionOptions = {};
        for (let i = 1; i <= $("#option-questions fieldset").length; i++) {
            let count = parseInt($("#questions-" + i + "-count").val());
            let points = parseInt($("#questions-" + i + "-points").val());
            if (count !== undefined && points !== undefined)
                questionOptions[points] = count;
        }
        let practicalCount = $("#option-practical-count").val();
        let testsCount = $("#option-tests-count").val();
        $.ajax({
            type: "post",
            url: "/generator/run",
            data: {
                optionQuestions: JSON.stringify(questionOptions),
                optionPracticalCount: practicalCount,
                optionTestsCount: testsCount,
                _token: $("input[name='_token']").val()
            },
            dataType: 'json'
        }).done(function (msg) {
            console.log(msg);
            generatorOutput.html("<p>" + msg.msg + "</p>");
            if (msg.status) {
                generatorOutput.append("<a href='" + msg.pdf_file + "'>Stiahnuť test</a>")
            }
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
    });

    // mazanie obrazku pri upravovani otazky
    $(".delete-question-image").on("click", function (e) {
        e.preventDefault();
        let imagePath = $(this).attr("image");
        let imageParent = $(this).parent('div');
        $.ajax({
            type: "POST",
            url: "/delete_question_image",
            data: {
                imagePath: imagePath
            },
        }).done(function (msg) {
            if (msg.ok) {
                imageParent.remove();
            }
        }).fail(function (msg) {
            console.error(msg);
        })
    });

    // mazanie otazky
    $(".delete-question").on("click", function (e) {
        e.preventDefault();
        if (!confirm('Naozaj chcete vymazať otázku?')) {
            return;
        }
        let questionRow = $(this).parent('div').parent('div');
        if (questionRow) {
            let questionId = questionRow.attr('id').split('-')[1];
            if (questionId == null) {
                alert("Otázku sa nepodarilo vymazať.");
                return;
            }
            $.ajax({
                type: 'POST',
                url: '/questions/delete',
                data: {
                    id: questionId
                }
            }).done(function (msg) {
                if (msg.ok) {
                    questionRow.remove();
                    alert("Otázka bola úspešne vymazaná.");
                } else {
                    alert("Otázku sa nepodarilo vymazať.");
                }
            }).fail(function (msg) {
                console.error(msg);
            })
        }

    });
});
