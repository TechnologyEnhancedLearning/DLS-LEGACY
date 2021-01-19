$('#NewCommentPanel').on('shown.bs.collapse', function () {
    htmlAdd.SetHtml("");
    htmlAdd.SetVisible(true);
});
$('#NewCommentPanel').on('hidden.bs.collapse', function () {
    htmlAdd.SetVisible(false);
    htmlAdd.SetHtml("");
});
$('#ddTicketType').change(function () {
    var newval = document.getElementById("ddTicketType").value;
    if (newval == 4) {
        $('#deviceInfoModal').modal('show');
        $('#ProblemDetails').collapse('show');
    }
    else {
        $('#ProblemDetails').collapse('hide');
    }
    if (parseInt(newval) > 0) {
        $('#descriptiongroup').collapse('show');
    }
    else {
        $('#descriptiongroup').collapse('hide');
    }
});

$('#lbtGetDetails').click(function () {
    var os = (function () {
        var ua = navigator.userAgent.toLowerCase();
        return {
            isXP: /windows nt 5.1/.test(ua),
            isVista: /windows nt 6.0/.test(ua),
            isWin7: /windows nt 6.1/.test(ua),
            isWin8: /windows nt 6.2/.test(ua),
            isWin10: /windows nt 10.0/.test(ua),
            isWow64: /wow64/.test(ua),
            isWin64: /win64/.test(ua)
        };
    }());
    if ($.browser.msie) {
        $('#ddBrowser').val("2").parents('div').eq(1).addClass("has-success");
    };
    if ($.browser.webkit) {
        $('#ddBrowser').val("3").parents('div').eq(1).addClass("has-success");
    };
    if ($.browser.mozilla) {
        $('#ddBrowser').val("4").parents('div').eq(1).addClass("has-success");
    };
    if ($.browser.msedge) {
        $('#ddBrowser').val("7").parents('div').eq(1).addClass("has-success");
    };
    if ($.browser.desktop) {
        $('#ddDeviceType').val("2").parents('div').eq(1).addClass("has-success");
    }
    else if ($.browser.mobile) {
        $('#ddDeviceType').val("3").parents('div').eq(1).addClass("has-success");
    };
    if(os.isWin10){
        if (os.isWin64 | os.isWow64) {
            $('#ddOS').val("2").parents('div').eq(1).addClass("has-success");
        }
        else{
            $('#ddOS').val("3").parents('div').eq(1).addClass("has-success");
        }
    };
    if(os.isWin7){
        if (os.isWin64 | os.isWow64) {
            $('#ddOS').val("4").parents('div').eq(1).addClass("has-success");
        }
        else{
            $('#ddOS').val("5").parents('div').eq(1).addClass("has-success");
        }
    };
    if(os.isWin8){
        $('#ddOS').val("6").parents('div').eq(1).addClass("has-success");
    };
    if(os.isXP){
        $('#ddOS').val("7").parents('div').eq(1).addClass("has-success");
    };

    if(os.isVista){
        $('#ddOS').val("8").parents('div').eq(1).addClass("has-success");
    };
    if($.browser.android){
        $('#ddOS').val("9").parents('div').eq(1).addClass("has-success");
    };
    if ($.browser.blackberry) {
        $('#ddOS').val("10").parents('div').eq(1).addClass("has-success");
    };
    if ($.browser.ipad | $.browser.iphone | $.browser.ipod | $.browser.mac ) {
        $('#ddOS').val("11").parents('div').eq(1).addClass("has-success");
    };
    if ($.browser.kindle) {
        $('#ddOS').val("12").parents('div').eq(1).addClass("has-success");
    };
    if ($.browser.linux) {
        $('#ddOS').val("13").parents('div').eq(1).addClass("has-success");
    };
    if ($.browser["windows phone"]) {
        $('#ddOS').val("14").parents('div').eq(1).addClass("has-success");
    };
    $('#tbBrowserVersion').val($.browser.versionNumber);
    getShockwave();
});
/*Shockwave detection stuff*/
function getShockwave() {


    // Return text message based on plugin detection result
    var getStatusMsg = function (obj) {
        if (obj.status == 1) return "Installed & enabled";
        if (obj.status == 0) return "Installed & enabled";
        if (obj.status == -0.1) return "Installed & enabled";
        if (obj.status == -0.2) return "Installed but not enabled";
        if (obj.status == -1) return "Not installed or enabled";
        if (obj.status == -3) return "Error getting status";
        return "unknown";
    };   // end of function

    var txt = ''
    // Add text to output node
    var docWrite = function (text) {
            if (text) {
                text = text.replace(/&nbsp;/g, "\u00a0");
                txt = txt + text + ". ";

            };
    };  // end of function


    // Object that holds all data on the plugin
    var P = { name: "Shockwave", status: -1, version: "not installed or enabled", minVersion: "12,0,0,0" };


    var $$ = PluginDetect;
    if ($$.isMinVersion) {
        P.status = $$.isMinVersion(P.name, P.minVersion);
        docWrite(getStatusMsg(P));
    };
    
    if ($$.getVersion) {
        P.version = $$.getVersion(P.name);
        if (P.version != null) { docWrite("Version: " +  P.version.replace(/,/g,'.')) }

    };
    


    if ($$.browser.isIE) {
        if(!$$.browser.ActiveXEnabled){docWrite("ActiveX disabled")};
        if ($$.browser.ActiveXFilteringEnabled) { docwrite("ActiveX Filtering enabled") };
    };
    $('#tbShockwave').val(txt).parents('div').eq(1).addClass("has-success");

};   // end of function
