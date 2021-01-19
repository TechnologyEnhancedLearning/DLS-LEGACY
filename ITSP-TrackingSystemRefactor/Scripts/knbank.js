//Add the owl carousel to the results dom elements when the document has loaded:
//$(document).ready(function () {
//    $('#ca-container').owlCarousel();
//});
//Function for loading a video. This function will be called when the Watch video link is clicked. The OnClick event will be dynamically generated to pass this the url for the video to be viewed.
//We will check for the existence of an mp4 video and use swf if not.
//var g_serviceurl = window.location.protocol + '//' + window.location.host + "/" + '../services.asmx';
var tutid;
var canid;
var videorating;
var videostats;
var g_warned;
//console.log(document.domain);
if (!window.screenTop && !window.screenY) { g_warned = 1; } else { g_warned = 0; }
function playThisVideo(vidurl, tid, cid, vidrate, vidrates) {
    //set up string for mp4 version of video:
    //console.log('Attempting to play: ' + vidurl)
    vidurl = vidurl.replace(".jpg", "");
    var vidhtml = "";
    tutid = tid;
    canid = cid;
    videorates = vidrates;
    videorating = vidrate;
    //we need to check for the existence of the mp4 file, we'll do it using a jQuery ajax call:
    if (vidurl.indexOf('https://youtu.be/') !== -1) {
        //it's a youtube video:
        vidurl = vidurl.replace("https://youtu.be/", "https://www.youtube.com/embed/");
        vidhtml = "<iframe id='YouTubeEmbed' width='640' height='480' src='" + vidurl + "' frameborder='0' allow='accelerometer; autoplay; encrypted - media; gyroscope; picture -in -picture' allowfullscreen></iframe>";
    }
    else if
    (vidurl.indexOf('https://vimeo.com/') !== -1) {
        vidurl = vidurl.replace("https://vimeo.com/", "https://player.vimeo.com/video/") + "? title = 0 & byline=0 & portrait=0";
        vidhtml = "<iframe src='" + vidurl + "' width='640' height='480' frameborder='0' allow='autoplay; fullscreen' allowfullscreen></iframe>";
    }
    else {
        vidhtml += "<div class='videostats'><label id='vidstats'><label></div>";
        vidhtml += "<video controls='controls' autoplay='autoplay' width='640' height='480'> ";
        vidhtml += "<source src='" + vidurl + "' type='video/mp4'/> ";
        vidhtml += "<object type='application/x-shockwave-flash' data='swf/VideoPlayer.swf' width='640' height='480'> ";
        vidhtml += "<param name='movie' value='swf/VideoPlayer.swf'/> ";
        vidhtml += "<param name='allowFullScreen' value='true'/><param name='wmode' value='transparent'/> ";
        vidhtml += "<param name='flashVars' value='src=" + vidurl + "&amp;autoPlay=true'/> ";
        vidhtml += "<span>Video not supported</span></object></video>";
    }
    vidhtml += "<table><tr><td><div class='ratevid' data-average='" + videorating + "' data-id='" + tutid + ',' + canid + "'></div></td><td><label id='lblRated' for='rateDiv'></label></td></tr></table>";
    doModal(vidhtml);
    //add the video rating control to the ratevid div:
    doJRating();
    //increment the video count and update the stats label at the top right of the video modal:
    //console.log("TutorialID = " + tutid);
    //console.log("CandidateID = " + canid);
    $.ajax({
        url: "../services.asmx/IncrementVideo",
        type: "POST",
        data: "tid=" + tutid + "&candidateid=" + canid,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "text",
        error: function () {
            //console.log("Failed!! call to ../services.asmx/IncrementVideo with parameters tid=" + tutid + "&candidateid=" + canid + " FAILED");
        },
        success: function (data) {
            //console.log("Success!! call to ../services.asmx/IncrementVideo with parameters tid=" + tutid + "&candidateid=" + canid + " SUCCEEDED");
            //use the returned data (view count) to update the video stats label
            if (data.indexOf('DOCTYPE') >= 0) {
                $("#vidstats").html("Rated " + videorating.replace(".0", "") + "/5 (" + videorates + " ratings) ");
            }
            else {
                $("#vidstats").html("Rated " + videorating.replace(".0", "") + "/5 (" + videorates + " ratings) " + data + " views");
            }

            //console.log(data);
        }
    });


    return false;
}
//Add the owl carousel to results repeater items
function doCarousel() {
    var ww = $(window).width();
    if (ww >= 840) {
        $('.ca-container').owlCarousel({

            // Most important owl features
            items: 4,
            itemsCustom: false,
            itemsDesktop: [1199, 3],
            itemsDesktopSmall: [980, 3],
            itemsTablet: [768, 2],
            itemsTabletSmall: false,
            itemsMobile: [479, 1],
            singleItem: false,
            itemsScaleUp: true,

            //Basic Speeds
            slideSpeed: 200,
            paginationSpeed: 800,
            rewindSpeed: 1000,

            //Autoplay
            autoPlay: false,
            stopOnHover: false,

            // Navigation
            navigation: false,
            navigationText: ["prev", "next"],
            rewindNav: true,
            scrollPerPage: false,

            //Pagination
            pagination: true,
            paginationNumbers: true,

            // Responsive 
            responsive: true,
            responsiveRefreshRate: 200,
            responsiveBaseWidth: window,

            // CSS Styles
            baseClass: "owl-carousel",
            theme: "owl-theme",

            //Lazy load
            lazyLoad: false,
            lazyFollow: true,
            lazyEffect: "fade",

            //Auto height
            autoHeight: false

        });
    }
    else {
        $('.ca-container').owlCarousel({

            // Most important owl features
            items: 3,
            itemsCustom: false,
            itemsDesktop: [1199, 3],
            itemsDesktopSmall: [980, 3],
            itemsTablet: [768, 2],
            itemsTabletSmall: false,
            itemsMobile: [479, 1],
            singleItem: false,
            itemsScaleUp: true,

            //Basic Speeds
            slideSpeed: 200,
            paginationSpeed: 800,
            rewindSpeed: 1000,

            //Autoplay
            autoPlay: false,
            stopOnHover: false,

            // Navigation
            navigation: true,
            navigationText: ["prev", "next"],
            rewindNav: true,
            scrollPerPage: false,

            //Pagination
            pagination: false,
            paginationNumbers: true,

            // Responsive 
            responsive: true,
            responsiveRefreshRate: 200,
            responsiveBaseWidth: window,

            // CSS Styles
            baseClass: "owl-carousel",
            theme: "owl-theme",

            //Lazy load
            lazyLoad: false,
            lazyFollow: true,
            lazyEffect: "fade",

            //Auto height
            autoHeight: false

        });
    }
    //do jqueryui tooltips for launch video and tutorial links:
    $(function () {
        $(document).tooltip({
            content: function () {
                return $(this).prop('title');
            }
        });
    });

}
function doJRating() {
    $(".ratevid").jRating({
        bigStarsPath: 'Images/stars.png',
        smallStarsPath: 'Images/small.png',
        step: true,
        sendRequest: false,
        length: 5,
        rateMax: 5,
        onClick: function (e, rate) {
            var iddata = e.dataset.id;
            var idarray = iddata.split(',');
            $.ajax({
                url: "../services.asmx/RateVideo",
                type: "POST",
                data: "tid=" + idarray[0] + '&rating=' + rate + '&candidateid=' + idarray[1],
                contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                dataType: "text",
                success: function (data) {
                    //alert('successfully rated:' + rate);
                    var lbl = document.getElementById('lblRated');
                    lbl.innerHTML = rate + "* rating submitted. Thank you.";

                }
            });
        }
    });
}
var desWidth;
var desHeight;
var sWidth;
var sHeight;
var sMovie;
// the following plays the correct tutorial by embedding eits.aspx in an iFrame and passing it sufficient parameters:
function playThisTutorial(sMoviePath, nCandidateID, nWidth, nHeight, tid) {
    //the following was added because the function parameters don't seem to be available when creating the learnHTML string otherwise:
    canid = nCandidateID;
    desHeight = nHeight;
    desWidth = nWidth;

    //********************************************************//

    var nRatio = desHeight / desWidth;

    //get current iFrame width and height
    var width = $(window).width(),
        height = $(window).height();
    width = width - 56;
    height = height - 56;
    //get current iFrame  width : height ratio
    var nThisRatio = height / width;
    //check if iFrame is smaller than required:
    if (width < desWidth | height < desHeight) {
        //check actual ratio against required ratio to determine how to resize (is it too tall or too narrow)
        if (nThisRatio > nRatio) {
            sWidth = width;
            sHeight = width * nRatio;
        }
        else if (nRatio > nThisRatio) {

            sHeight = height;
            sWidth = height * (desWidth / desHeight);

        }
        else {
            //on the off chance that the actual ratio and required ratio are the same, set both width and height
            sWidth = width;
            sHeight = height;
        }
    }

    else {
        //window is big enough so set width and height to desired values
        sWidth = desWidth;
        sHeight = desHeight;
    }

    //************************************************//



    sMovie = sMoviePath;
    tutid = tid;
    var learnHTML;
    //setup the html for embedding learning.aspx in an iFrame:
    if (sMovie.indexOf("imsmanifest.xml") > -1) {
        learnHTML = "<iframe width='100%'  scrolling='no' seamless='seamless' height='" + sHeight + "' align='middle' id='frame1' src='https://www.dls.nhs.uk/cms/scoplayer/sco.aspx?tutpath=" + sMovie + "' frameborder='0' marginwidth='0' marginheight='0' scrolling='auto'></iframe>";

        // win = window.open('scoplayer/sco.aspx?tutpath=' + sMovie);
    }
    else if (sMovie.indexOf(".dcr") > -1) {
        learnHTML = "<iframe width='" + sWidth + "'  scrolling='no' seamless='seamless' height='" + sHeight + "' align='middle' id='frame1' src='learning.aspx?CandidateID=" + canid + "&tutpath=" + sMovie + "&width=" + nWidth + "&height=" + nHeight + "' frameborder='0' marginwidth='0' marginheight='0' scrolling='auto' style='width: " + sWidth + "px; height: " + sHeight + "px;'></iframe>";
    }
    else {
        //win = window.open(sMovie, '_blank');
        learnHTML = "<iframe width='100%'  scrolling='no' seamless='seamless' height='" + sHeight + "' align='middle' id='frame1' src='" + sMovie + "' frameborder='0' marginwidth='0' marginheight='0' scrolling='auto'></iframe>";

        //win.focus();
    }
    

    //call doMoDal to open a modal popup with the iFrame:
    //doModal(learnHTML);
    $('#modalContent').html(learnHTML);
    $('#modalViewTut').modal('show');

    //Call web service to record the launch of tutorial
    $.ajax({
        url: "../services.asmx/IncrementLearn",
        type: "POST",
        data: "tid=" + tutid + "&candidateid=" + canid,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "text",
        success: function (data) {
            ////console.log("Success!!");
        }
    });


    return false;
}
window.onresize = function () {
    sizeLearnPanel();
};
//Learning dcr and modal popup sizing functions:
function sizeLearnPanel() {
    if ($('#frame1').length)         // use this if you are using id to check
    {
        // it exists
        var width = $(window).width();
        var height = $(window).height();
        dhm = parseInt(desHeight) + 56;
        dwm = parseInt(desWidth) + 56;
        if (height > dhm) {
            // $("#modal").height(dhm);
            $("#frame1").height(desHeight);
        }
        else {
            // $("#modal").height(height);
            $("#frame1").height(height - 56);
        }
        if (width > dwm) {
            // $("#modal").width(dwm);
            $("#frame1").width(desWidth);
        }
        else {
            //  $("#modal").width(width);
            $("#frame1").width(width - 56);
        }

    }

}
function sizeModal(objid) {
    var height = $(window).height();
    var myDiv = document.getElementById(objid);
    if (myDiv !== null) {
        myDiv.style.maxHeight = height * 0.9 + "px";
        //alert('Sized to: ' + height * 0.9 + "px");
    }
}

//Function to play youtube videos and track their launch to the database for reporting:

function LogYouTube(cid, playurl, title) {
    $.ajax({
        url: "../services.asmx/LogYouTube",
        type: "POST",
        data: "cid=" + cid + "&vurl=" + encodeURI(playurl) + "&vtitle=" + title,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "text",
        error: function () {
            //console.log("Failed!! call to ../services.asmx/LogYouTube with parameters "cid=" + cid + "&vurl=" + encodeURI(playurl) + "&vtitle=" + title + " FAILED");
        },
        success: function (data) {
            //console.log("Success!! call to ../services.asmx/IncrementVideo with parameters "cid=" + cid + "&vurl=" + encodeURI(playurl) + "&vtitle=" + title + " SUCCEEDED");


            //console.log(data);
        }
    });
    //now play the video:

    doModalInIFrame(playurl);
}