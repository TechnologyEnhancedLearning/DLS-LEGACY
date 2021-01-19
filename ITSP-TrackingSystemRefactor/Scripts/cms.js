// <reference path="C:\Users\admin\Desktop\ITSP-CMS\ITSP-CMS\ITSP-CMS\dataserve.asmx" />
// <reference path="C:\Users\admin\Desktop\ITSP-CMS\ITSP-CMS\ITSP-CMS\dataserve.asmx" />
function playThisVideo(vidurl) {
    //set up string for mp4 version of video:
    //console.log('Attempting to play: ' + vidurl)
    var vidhtml = "";
    if (vidurl.indexOf('http') === -1) {
        vidurl = 'https://www.dls.nhs.uk/tracking' + vidurl;
    };
    if (vidurl.indexOf('https://youtu.be/') !== -1){
        //it's a youtube video:
        vidurl = vidurl.replace("https://youtu.be/", "https://www.youtube.com/embed/");
        vidhtml = "<iframe id='YouTubeEmbed' width='640' height='480' src='" + vidurl + "' frameborder='0' allow='accelerometer; autoplay; encrypted - media; gyroscope; picture -in -picture' allowfullscreen></iframe>";
    }
    else if
    (vidurl.indexOf('https://vimeo.com/') !== -1) {
        vidurl = vidurl.replace("https://vimeo.com/", "https://player.vimeo.com/video/") + "? title = 0 & byline=0 & portrait=0";
        vidhtml = "<iframe src='" + vidurl + "' width='640' height='480' frameborder='0' allow='autoplay; fullscreen' allowfullscreen></iframe>";
    }
    else
    {
        vidurl = vidurl.replace("swf", "mp4");
        vidurl = vidurl.replace("swf", "mp4");
        vidhtml += "<video controls='controls' autoplay='autoplay' width='640' height='480'> ";
        vidhtml += "<source src='" + vidurl + "' type='video/mp4'/> ";
        vidhtml += "<object type='application/x-shockwave-flash' data='swf/VideoPlayer.swf' width='640' height='480'> ";
        vidhtml += "<param name='movie' value='swf/VideoPlayer.swf'/> ";
        vidhtml += "<param name='allowFullScreen' value='true'/><param name='wmode' value='transparent'/> ";
        vidhtml += "<param name='flashVars' value='src=" + vidurl + "&amp;autoPlay=true'/> ";
        vidhtml += "<span>Video not supported</span></object></video>";
    };
    $(".videodiv").empty();
    $(".videodiv").append(vidhtml);
    $('#videoModal').modal('show');
    $('#videoModal').on('hidden.bs.modal', function () {
        // do something…
        $(".videodiv").empty();
    });
    return false;
}
function showThisObjective(obj) {
    $(".objective-html").empty();
    $(".objective-html").append(obj);
    $('#objectivesModal').modal('show');
}
function doChart(cid) {
    $.ajax({
        type: "POST",
        url: "../services.asmx/GetCourseName",
        data: "{'CID': '" + cid + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: titleSuccess,
        error: titleFail
    });

    $.ajax({
        type: "POST",
        url: "../services.asmx/GetUsageData",
        data: "{'CID': '" + cid + "', 'NumCols':'4'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: chartSuccess,
        error: chartFail
    });
}
function chartFail() {
    alert('Chart data service failed.');
}
function titleFail() {
    alert('Course title data service failed.');
}
function chartSuccess(e, d)
{
    
    $('#activity-chart').empty();
   
    $('#modalStats').modal('show');
    $('#modalStats').on('shown.bs.modal', function () {
        doActivityChart('activity-chart', e);
    });
    
}
function titleSuccess(e)
{
    var title =  e.d;
    $('#lblChartHeading').text(title);
}
//Create a Google Charts activity chart:
function doActivityChart(elem, chartdata) {
    
   google.charts.setOnLoadCallback(drawUsageStats(elem, chartdata.d));
function drawUsageStats(elem, chartdata) {
    var array = JSON.parse(chartdata);
    var data = google.visualization.arrayToDataTable(array);
    var options = {
            animation: { duration: 1000, easing: 'out', startup: true },
            explorer: {
                actions: ['dragToZoom', 'rightClickToReset'],
                axis: 'horizontal',
                keepInBounds: true
            },
           
            chartArea: { 'width': '95%', 'height': '80%' },
            legend: { position: 'bottom', textStyle: { fontSize: 9 } },
            hAxis: { slantedTextAngle: 90, textStyle: { color: '#333', fontSize: 8 } },
            vAxis: { textStyle: { color: '#333', fontSize: 8 }, minValue: 0, viewWindow: { min: 0 } },
            pointSize: 3,
            curveType: 'function'
        };

        var chart = new google.visualization.LineChart(document.getElementById(elem));
        chart.draw(data, options);
};
}
    //$('#modalStats').on('shown.bs.modal', function (e) {
    //    Morris.Area({
    //        element: elem,
    //        data: chartdata,
    //        xkey: 'period',
    //        ykeys: ['registrations', 'completions', 'evaluations'],
    //        labels: ['Course registrations', 'Course completions', 'Course evaluations'], behaveLikeLine: true, hideHover: true, fillOpacity: 0.3, resize: true
    //    });
    //}) 
var sWidth;
var sHeight;
var sMovie;
var sType;
var win;
function playThisTutorial(sMoviePath, nWidth, nHeight, sType) {
    //the following was added because the function parameters don't seem to be available when creating the learnHTML string otherwise:
    sWidth = nWidth;
    sHeight = nHeight;
    sMovie = sMoviePath;
    sType = sType;
    if (sMovie.indexOf("imsmanifest.xml") > -1)
    {
        win = window.open('scoplayer/sco.aspx?tutpath=' +sMovie);
    }
    else if (sMovie.indexOf("http") > -1)
    {
        win = window.open(sMovie, '_blank');
        //win.focus();
    }
    else
    {
        win = window.open('learning?CandidateID=0&tutpath=/Tracking' + sMovie + '&width=' + nWidth + '&height=' + nHeight, '_blank');
    }
    if (win !== null) {
        win.focus();
    }
    return false;
}
function openThisPage(url) {
    if (url.indexOf("http") < 0) {
        url = '../' + url;
    }
    win = window.open(url, '_blank');
    
    
}
function setEditFormControlVis() {
    var dd = $('#ddContentType');
    var ev = $('#pnlEvidenceText');
    var vid = $('#pnlVideoTutorialCtrls');
    var olc = $('#pnlOfflineConfig');
    var kw = $('#pnlKeyWords');
    var tn = $('#lblTutName');
    var obj = $('#lblObjectives');
    var evl = $('#lblEvidence');
    if (dd.val() == 1) {
        vid.removeClass('d-none');
        ev.addClass('d-none');
        olc.addClass('d-none');
        kw.removeClass('d-none');
        tn.text('Tutorial Name:');
        obj.text('Objectives:');
    }
    else if (dd.val() == 2) {
        vid.addClass('d-none');
        ev.removeClass('d-none');
        olc.removeClass('d-none');
        kw.addClass('d-none');
        tn.text('Learning Requirement Name:');
        obj.text('Objectives:');
        evl.text('Examples Text:');
    }
    //else if (dd.val() == 3) {

    //}
    else if (dd.val() == 4) {
        vid.addClass('d-none');
        ev.removeClass('d-none');
        olc.removeClass('d-none');
        kw.addClass('d-none');
        tn.text('Skill / Competency:');
        obj.text('Competency Requirements:');
        evl.text('Evidence Text:');
    }
}
function setDiagnosticControlVisibility() {
    var dd = $('#ddAssessmentTypeID');
    var olc = $('#pnlOfflineConfig');
    var dc = $('#pnlDiagnosticConfig');
    if (dd.val() == 0) {
        dc.removeClass('d-none');
        olc.addClass('d-none');
    }
    else if (dd.val() >= 1) {
        olc.removeClass('d-none');
        dc.addClass('d-none');
    }
}
