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
            error:function (e) {
                console.error(e);
            }
        }).fail(function(jqXHR, textStatus){
            console.log('fail');
        }).done(function (msg) {
            console.log('done');
            console.log(msg);
        })
    })
})