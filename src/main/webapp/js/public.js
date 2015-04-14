$(function () {
    $(document).on("click", ".choice li", function () {
        var str = $(this).text().trim();
        str += "<span class='caret'></span>";
        $(".choice button").html(str);
    });
});