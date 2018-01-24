$(document).ready(function () {
    $(".delete-question-image").on("click", function (e) {
        e.preventDefault();
        let imagePath = $(this).attr("image");
        console.log(imagePath);
        $.ajax({
            type: "POST",
            url: "/delete_question_image",
            data: {
                imagePath: imagePath
            },
            error: function (e) {
                console.error(e);
            }
        }).fail(function (jqXHR, textStatus) {
            console.log('fail');
        }).done(function (msg) {
            console.log('done');
            console.log(msg);
        })
    });

    $(".delete-question").on("click", function (e) {
        e.preventDefault();
        if (!confirm('Naozaj chcete vymazať otázku?')) {
            return;
        }
        let questionRow = $(this).parent('div').parent('div');
        if (questionRow) {
            let questionId = questionRow.attr('id').split('-')[1];
            if (questionId) {
                $.ajax({
                    type: 'POST',
                    url: '/questions/delete',
                    data: {
                        id: questionId
                    }
                }).done(function (e) {
                    console.log('done');
                    questionRow.remove();
                }).fail(function (e) {
                    console.log('fail');
                    console.log(e);
                })
            }
        }

    });
});