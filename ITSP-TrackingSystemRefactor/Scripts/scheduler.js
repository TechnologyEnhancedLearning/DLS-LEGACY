function OnCellDoubleClick(s, e) {
    scheduler.RaiseCallback('MNUVIEW|NewAppointment');
}
function OnAppointmentDoubleClick(s, e) {
    scheduler.RaiseCallback('MNUAPT|OpenAppointment');
    e.handled = true;
}

function uriTextChanged(s, e) {
    $('#hfURIModified').val(true);
    if ($('#tbCallUri_I').val().length >= 7) {
        $('.launch-link').removeClass('d-none');
    } else {
        $('.launch-link').addClass('d-none');
    }
}
function setupFormUriControlVis(s, e) {
    if ($('#tbCallUri_I').val().length === 0) {
            //hide the Test Link button:
        $('.launch-link').addClass('d-none');
        }
   if (s.lastSuccessValue == 4) {
        $('.urirow').removeClass('d-none');
        $('#lblCallUri').text('Teams Link:');
        $('#tbCallUri_I').attr('readonly', false);
        $('#tbCallUri_I').attr('placeholder', 'Paste the link to your meeting here');
    }
    else if (s.lastSuccessValue == 8) {
        $('.urirow').removeClass('d-none');
        $('#lblCallUri').text('Meeting Link:');
        $('#tbCallUri_I').attr('readonly', true);
        $('#tbCallUri_I').attr('placeholder', 'Generated after adding/updating the appointment');
    } else {
        $('.urirow').addClass('d-none');
    }
    
}

function launchConference() {
    var uri = $('#tbCallUri_I').val();
    if (uri.startsWith("http")) {
        window.open(uri);
    } 
}
function onFileUploadComplete(s, e) {
    setTimeout(function () { WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions('btnDone', '', true, '', '', false, true)); }, 1);
}
function onSchedulerEndCallBack(s, e) {
    if (typeof s.cpAptInserted !== 'undefined') {
        if (s.cpAptInserted === true) {
            s.cpAptInserted = false;
            $('#sendInvitesModal').modal('show');

        }
    }
    if (typeof s.cpCallUri !== 'undefined') {
        var sURL = s.cpCallUri;
        if (sURL != null) {
            if (sURL.length >= 4) {
                $('#linkTestSFB').attr('href', sURL);
            }
        }
    }
    if (typeof s.cpNotLoggedIn !== 'undefined') {
        if (s.cpNotLoggedIn === true) {
            s.cpNotLoggedIn = false;
            $('#messageModal').modal('show');
        }
    }
}