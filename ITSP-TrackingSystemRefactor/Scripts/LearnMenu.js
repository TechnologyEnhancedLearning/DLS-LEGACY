$('.collapse').on('shown.bs.collapse', function () {
    $(this).parent().find(".fas fa-plus").removeClass("fas fa-plus").addClass("fas fa-minus");
}).on('hidden.bs.collapse', function () {
    $(this).parent().find(".fas fa-minus").removeClass("fas fa-minus").addClass("fas fa-plus");
});
$('#videoModal').on('hidden.bs.modal', function () {
    pauseVideo();
})
function pauseVideo() {
    document.getElementById('introVid').pause();
}
function closeMpe() {
    setTimeout(function () { WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions("btnPost", "", true, "", "", false, true)); }, 1000);
   
}
function onFileUploadComplete(s, e) {
    setTimeout(function () { WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions('btnDone', '', true, '', '', false, true)); }, 100);
}
function closeLearning() {
    closeMpe();
}
function ShowSupportPopup(sPage) {
    var wnd = window.open(sPage, 'Support', 'width=1000,resizable=yes,scrollbars=yes');
    wnd.focus();
};
var activePanels = [];
function UpdateProgressText(sSectionNum, nProgressID, bShown) {
    //check that the element is not in the array
    var elementIndex = $.inArray(sSectionNum.toString(), activePanels);
    if (bShown) {
        if (elementIndex == -1) {
            activePanels.push(sSectionNum);
        }

    }
    else {
        if (elementIndex !== -1) //check the array
        {
            activePanels.splice(elementIndex, 1); //remove item from array   
        }
    }

    $.ajax({
        url: "../services.asmx/SetProgressText",
        type: "POST",
        data: "sProgText=" + activePanels.toString() + "&nProgressID=" + nProgressID,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "text",
        error: function () {
            console.log("Failed!! call to ../services.asmx/SetProgressText with parameters sProgText=" + activePanels.toString() + "&nProgressID=" + nProgressID + " FAILED");
        },
        success: function (data) {
            //console.log("Success!! call to ../services.asmx/SetProgressText with parameters sProgText=" + activePanels.toString() + "&nProgressID=" + nProgressID + " SUCCEEDED");
        },
    });
}
function LoadProgressText(nProgressID) {

    $.ajax({
        url: "../services.asmx/GetProgressText",
        type: "POST",
        data: "nProgressID=" + nProgressID,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        success: function (data) {
            if (typeof data.firstChild.innerHTML === "undefined") {
                sProg = data.firstChild.firstChild.data;
            }
            else {
                sProg = data.firstChild.innerHTML;
            }
            
            sProg = sProg.replace('[', '');
            sProg = sProg.replace(']', '');
            $('#hfProg').val(sProg);
            //console.log("Success!! call to ../services.asmx/GetProgressText with parameters nProgressID=" + nProgressID + " SUCCEEDED");
            SetSectionCollapseState()
        },
    });

}
function SetSectionCollapseState() {
    sProg = $('#hfProg').val();
    if (sProg.length > 0) {
        activePanels = sProg.split(',');
        for (var i in activePanels) {
            if ($(".Accordion" + activePanels[i]).hasClass('section-panel')) // check if this is a panel
            {
                $(".Accordion" + activePanels[i]).collapse("show");
            }
        }
    }
}

function LaunchAssessment(nSectionID, nCustomisationID, nCentreID, bAll, bShowSelect, bPostLearning, sDiagURL, sTrackerURL, nCustomisationID, nProgressID, nVersion, nThreshold, nCandidateID) {
    $('#objectives-list-box').empty();
    if (bPostLearning) {
        $('.diag-only').addClass('d-none');
        $('#AssessTitle').text('Launch Post Learning Assessment');
    }
    if (!bShowSelect) {
        $('#DiagSelectForm').addClass('d-none');
    }
    else {
        $('#DiagSelectForm').removeClass('d-none');
    };
    var sType = 'diag';
    if (bPostLearning) { sType = 'pl' };
    $("#btnStartAssess").attr("onclick", "StartAssessment(" + nSectionID + ", " + nCustomisationID + ", " + nCentreID + ", '" + sDiagURL + "', '" + sTrackerURL + "', " + nCustomisationID + ", " + nProgressID + ", " + nVersion + ", " + nThreshold + ", " + nCandidateID + ", '" + sType + "');");
    $.ajax({
        type: "POST",
        url: "../services.asmx/GetDiagnosticObjectives",
        data: "{'nSecID': '" + nSectionID + "', 'nCustomisationID': '" + nCustomisationID + "', 'bGetAll': '"+bAll+ "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        xhrFields: {
            withCredentials: true
        },
        beforeSend: function (xhr) {
            xhr.withCredentials = true;
        },
       
        success: function (data) {
            
            var parsed = $.parseJSON(data.d);
            for (var i in parsed) {
                var item = parsed[i];
                var nID = item.TutorialID
                if (sDiagURL.indexOf('.dcr') >= 0) { nID = item.ObjectiveNum }
                var objstring = "<li class='list-group-item'><div class='form-check'><input class='form-check-input diag-check' checked type='checkbox' value='" + nID + "' id='DiagCheck" + item.TutorialID + "'><label class='form-check-label ml-2' for='DiagCheck" + item.TutorialID + "'>" + item.TutorialName + "</label></div></li>";
                $('#objectives-list-box').append(objstring);
                $('#diagObjectivesModal').modal('show');
            }
        }
    });
}
function StartAssessment(nSectionID, nCustomisationID, nCentreID, sDiagURL, sTrackerURL, nCustomisationID, nProgressID, nVersion, nThreshold, nCandidateID, sType) {
    var objList = [];
    var sObjList = []
    var n = 0;
    var sSrc = '';
    $('.diag-check').each(function (i, obj) {
        //test
        n++;
        if (obj.checked) {
            objList.push(obj.value);
        };
    });
    sObjList = '[' + objList.toString() + ']';
    if (sDiagURL.indexOf('itspplayer.html') >= 0) {
        sSrc = sDiagURL.toString() + '?CentreID=' + nCentreID.toString() + '&CustomisationID=' + nCustomisationID.toString() + '&CandidateID=' + nCandidateID.toString() + '&SectionID=' + nSectionID.toString() + '&Version=' + nVersion.toString() + '&type=' + sType.toString() + '&objlist=' + sObjList.toString() + '&ProgressID=' + nProgressID.toString() + '&plathresh=' + nThreshold.toString() + '&TrackURL=' + sTrackerURL.toString()
    } else if (sDiagURL.indexOf('imsmanifest.xm') >= 0) {
        sSrc = "../scoplayer/sco?CentreID=" + nCentreID + "&CustomisationID=" + nCustomisationID.toString() + "&CandidateID=" + nCandidateID.toString() + "&SectionID=" + nSectionID.toString() + "&Version=" + nVersion.toString() + "&tutpath=" + sDiagURL.toString() + "&type=" + sType.toString()
    } else {
        sSrc = "eitslm?CentreID=" + nCentreID + "&CustomisationID=" + nCustomisationID.toString() + "&CandidateID=" + nCandidateID.toString() + "&SectionID=" + nSectionID.toString() + "&Version=" + nVersion.toString() + "&tutpath=" + sDiagURL.toString() + "&objlist=" + sObjList.toString()
    };
    $('#hfAssessSrc').val(sSrc);
    WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions('btnSwitchView', '', true, '', '', false, true));
}

//Multiselect drop downs for log item linked tutorials:

var textSeparator = ", ";
function updateTutLogItemText() {
    var selectedItems = listTutorialsForCompleteLogItem.GetSelectedItems();
    msTutorialsLogItem.SetText(getSelectedItemsText(selectedItems));
}
function updateTutLogItemTextPlanned() {
    var selectedItems = listTutorialsForCompleteLogItemPlanned.GetSelectedItems();
    msTutorialsLogItemPlanned.SetText(getSelectedItemsText(selectedItems));
}
function getSelectedItemsText(items) {
    var texts = [];
    if (items.length >= 4) { texts.push(items.length.toString() + ' skills / objectives selected') } else {
 for (var i = 0; i < items.length; i++)
        texts.push(items[i].text);
    }
   
    return texts.join(textSeparator);
}
function ddTutLogItemGotFocus() {
    msTutorialsLogItem.ShowDropDown();
}
function ddTutLogItemPlannedGotFocus() {
    msTutorialsLogItemPlanned.ShowDropDown();
}
//Resizing the learning panel:
window.onresize = function () {
    sizeLearnPanel();
}
function sizeLearnPanel() {
    var width = $(window).width();
    var height = $(window).height();
    $("#pnlLearnframe").width(width);
    $("#frame1").width(width);
    $("#pnlLearnframe").height(height);
    $("#frame1").height(height);
    //if (height < 1000) {
    //    document.getElementById("frame1").style.overflow = "auto";
    //}
    //else {
    //    document.getElementById("frame1").style.overflow = "";
    //}
}