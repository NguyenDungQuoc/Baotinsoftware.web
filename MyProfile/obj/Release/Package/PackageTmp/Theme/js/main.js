$(document).ready(function () {
    // Show or hide the sticky footer button
    $(window).scroll(function () {
        if ($(this).scrollTop() > 200) {
            $(".go-top").fadeIn(200);
        } else {
            $(".go-top").fadeOut(200);
        }
    });

    // Animate the scroll to top
    $(".go-top").click(function (event) {
        event.preventDefault();
        $("html, body").animate({ scrollTop: 0 }, 300);
    });

    // Call Js ZoomPic
    //$(".productinfo").ZoomPic();    
    //--- Show-Off Read More ---
    var xDiv = $(".introduction-article");
    var mHeight = xDiv.height() + "px";
    var flagShow = "show";
    if (parseInt(xDiv.height()) > 140) {
        xDiv.css("height", "138px");
        flagShow = "hide";
        $("#readMore").show();
        $("#readMore > i").addClass("fa fa-arrow-circle-down");        
    } else {
        $("#readMore").hide();
    }

    $("#readMore").click(function (event) {
        event.preventDefault();
        $(this).find("i").removeClass();
        if (flagShow === "hide") {
            $(this).find("i").addClass("fa fa-arrow-circle-up");
            xDiv.animate({ height: mHeight });
            flagShow = "show";
        } else {
            $(this).find("i").addClass("fa fa-arrow-circle-down");
            xDiv.animate({ height: "138px" });
            flagShow = "hide";
        }
    });

    $(".fancybox-thumb").fancybox({
        helpers: {
            title: {
                type: 'inside'
            },
            overlay: {
                css: {
                    'background': 'rgba(1,1,1,0.65)'
                }
            }
        }
    });

    //Owl Carousel
    $(".jCarouselLite .owl-carousel").owlCarousel({
        loop: true,
        nav: true,
        dots: false,
        items: 1,
        autoplay: true,
        autoplayTimeout: 3000,
        autoplayHoverPause: true
    });
});
//Clear all 'style' of tag img and add class '.border-image'
$(".article-detail img").each(function () {    
    $(this).removeAttr("style");    
    $(this).addClass("border-image");
});
$(".article-detail table").each(function () {
    $(this).removeAttr("style");
    $(this).addClass("table table-bordered");
});
function fncSearchKeyword(e) {
    if (e.which === 13 || e.keyCode === 13) {
        //code to execute here        
        var keyword = $("#txt-search");
        if (keyword.val() !== "") {
            var sUrl = "/tim-kiem.html?keyword=" + keyword.val().trim();
            window.location.href = encodeURI(sUrl);
            return false;
        } else {
            alert("Please enter keyword???");
            keyword.focus();
            return false;
        }
    }
    return true;
}
