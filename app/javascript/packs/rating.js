document.addEventListener("turbolinks:load", function() {
    $(document).ready(function () {
        if($('#article_link').length) {
            $('.article-btn').on('click', function (event) {
                if ($('#article_link').val().length > 0) {
                    event.preventDefault();
                    let article_link = $('#article_link').val();

                    $.ajax({
                        url: "/articles",
                        type: "post",
                        dataType: "json",
                        contentType: "application/json",
                        data: JSON.stringify({
                            article: {
                                link: article_link
                            }
                        }),
                        success: function ({original_comments, translated_comments, article_id}) {
                            $.ajax({
                                url: "/comments",
                                type: "post",
                                dataType: "json",
                                contentType: "application/json",
                                data: JSON.stringify({
                                    comment: {
                                        original_comments: original_comments,
                                        translated_comments: translated_comments,
                                        article_id: article_id
                                    }
                                }),
                                success: function (data) {
                                    document.location.href = "/?success=true";
                                },
                                error: function (data) {
                                    document.location.href = "/?success=false";
                                }
                            })
                        },
                        error: function (data) {
                            document.location.href = "/?success=false";
                        }
                    })
                }
            });
        }
    });
});
