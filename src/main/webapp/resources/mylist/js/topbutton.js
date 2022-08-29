$(function () {
    $(window).scroll(function(){
        if ($(this).scrollTop() > 50) {
            $("#movetopbtn").fadeIn();
        }else{
            $("#movetopbtn").fadeOut();
        }
    });
    
    $('#movetopbtn').click(function(){
        $('html,body').animate({
            scrollTop : 0
        },1200);
        return false;
    });
    $('#movetopbtn').hover(function () {
        $(this).attr("src","/resources/board/photo/top1.png");
    },function () {
        $(this).attr("src","/resources/board/photo/top.png");
    });
});

