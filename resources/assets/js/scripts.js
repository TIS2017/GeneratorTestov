$(document).ready(function () {

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