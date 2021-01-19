﻿window.onresize = introFull;
var handler = window.onresize;

function introFull() {
    var n = $(".intro-full-next"),
        o = $(".intro-full"),
        l = (o.height(), $(".intro-full-content"));
    l.height();
    $(window).width() < 768 ? (n.css("marginTop", "0px"), $("#intro-video").addClass("d-none"), l.addClass("intro-full-content-static")) : $("#intro-video").removeClass("d-none")
}

function navbarScroll() {
    var n = $(".intro-full").height();
    $(window).scrollTop() > n ? $(".navbar").addClass("navbar-scroll") : $(".navbar").removeClass("navbar-scroll")
}
handler.apply(window, [" On"]), $(document).ready(introFull), $(window).resize(introFull), $(window).scroll(navbarScroll), $(function () {
    var n = $("#go-intro-full-next"),
        o = $("#intro-next");
    n.click(function () {
        $("html, body").stop().animate({
            scrollTop: o.offset().top - 96
        }, 1e3)
    }), $("body").scrollspy({
        target: "#navbar-lead",
        offset: 200
    }), $('[data-spy="scroll"]').each(function () {
        $(this).scrollspy("refresh")
    }), setTimeout(function () {
        introFull()
    }, 200)
});