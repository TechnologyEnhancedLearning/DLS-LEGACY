function doModal(e) {
    //alert(e);
    modal.open({ content: e });
}

var modal = (function () {
    var
    method = {},
    $overlay,
    $modal,
    $content,
    $close;

    // Center the modal in the viewport
    method.center = function () {
        var top, left;

        top = Math.max($(window).height() - $modal.outerHeight(), 0) / 2;
        left = Math.max($(window).width() - $modal.outerWidth(), 0) / 2;

        $modal.css({
            top: top + $(window).scrollTop(),
            left: left + $(window).scrollLeft()
        });
    };

    // Open the modal
    method.open = function (settings) {
        $content.empty().append(settings.content);

        $modal.css({
            maxwidth: settings.width || 'auto',
            maxheight: settings.height || 'auto'
        });

        method.center();
        $(window).bind('resize.modal', method.center);
        $modal.show();
        $overlay.show();
    };

    // Close the modal
    method.close = function () {
        $modal.hide();
        $overlay.hide();
        $content.empty();
        $(window).unbind('resize.modal');
    };

    // Generate the HTML and add it to the document
    $overlay = $('<div id="overlay"></div>');
    $modal = $('<div id="modal"></div>');
    $content = $('<div id="content"></div>');
    $close = $('<a id="close" href="#">close</a>');

    $modal.hide();
    $overlay.hide();
    $modal.append($content, $close);

    $(document).ready(function () {
        $('body').append($overlay, $modal);
        doJRating();
    });

    $close.click(function (e) {
        e.preventDefault();
        method.close();
    });

    return method;
}());
function closeMpe() {
    modal.close();
}
// the following takes the source url and embeds it in an iFrame and is used to play YouTube content:
function doModalInIFrame(url) {
    var innerHTML = "<iframe id='ytplayer' type='text/html' width='690px'  scrolling='no' seamless='seamless' height='500px' align='middle' src='https://www.youtube-nocookie.com/embed/" + url + "?rel=0'  frameborder='0' allow='autoplay; encrypted-media' allowfullscreen></iframe>";
    doModal(innerHTML);
}