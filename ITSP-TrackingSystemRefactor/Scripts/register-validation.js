function validateRegFields() {
    var retVal = true;
    var matchArray;
    $('#fnamevalidate, #lnamevalidate, #emailvalidate, #centrevalidate, #pwvalidate, #pw2validate, #jgvalidate, #termsvalidate').removeClass('d-none').addClass('d-none');
    if ($('#tbFNameReg').val() === '') {
        $('#fnamevalidate').removeClass('d-none');
        retVal = false;
    }
    if ($('#tbLNameReg').val() === '') {
        $('#lnamevalidate').removeClass('d-none');
        retVal = false;
    }
    if ($('#tbLNameReg').val() === '') {
        $('#lnamevalidate').removeClass('d-none');
        retVal = false;
    }
    if ($('#tbEmailReg').val() === '') {
        $('#emailvalidate').removeClass('d-none');
        retVal = false;
    }
    else {
        var emailPat = /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
        matchArray = $('#tbEmailReg').val().match(emailPat);
        if (matchArray === null) {
            $('#emailvalidate').removeClass('d-none');
            retVal = false;
        }
    }
    if ($('#ddCentre').val() === 0) {
        $('#centrevalidate').removeClass('d-none');
        retVal = false;
    }
    if ($('#tbPasswordReg').val() === '') {
        $('#pwvalidate').removeClass('d-none');
        retVal = false;
    }
    else {
        var pwPat = /(?=.{8,})(?=.*?[^\w\s])(?=.*?[0-9])(?=.*?[A-Za-z]).*/;
        matchArray = $('#tbPasswordReg').val().match(pwPat);
        if (matchArray === null) {
            $('#pwvalidate').removeClass('d-none');
            retVal = false;
        }
    }
    if ($('#tbPasswordConfirm').val() === '' || $('#tbPasswordConfirm').val() !== $('#tbPasswordReg').val()) {
        $('#pw2validate').removeClass('d-none');
        retVal = false;
    }
    if ($('#ddJobGroup').val() === 0) {
        $('#jgvalidate').removeClass('d-none');
        retVal = false;
    }
    if ($('#cbTerms').is(":not(:checked)")) {
        $('#termsvalidate').removeClass('d-none');
        retVal = false;
    }
    return retVal;
}
function validateCustomFields() {
    var retVal = true;
    $('#f1validate, #f2validate, #f3validate, #f4validate, #f5validate, #f6validate').removeClass('d-none').addClass('d-none');
    if ($('#hfField1Mand').val() == 1) {
        if ($('#tbField1').val() == '') {
            $('#f1validate').removeClass('d-none');
            retVal = false;
        }
    }
    else if ($('#hfField1Mand').val() == 2) {
        if ($('#ddField1').val() == 0) {
            $('#f1validate').removeClass('d-none');
            retVal = false;
        }
    }
    if ($('#hfField2Mand').val() == 1) {
        if ($('#tbField2').val() == '') {
            $('#f2validate').removeClass('d-none');
            retVal = false;
        }
    }
    else if ($('#hfField2Mand').val() == 2) {
        if ($('#ddField2').val() == 0) {
            $('#f2validate').removeClass('d-none');
            retVal = false;
        }
    }
    if ($('#hfField3Mand').val() == 1) {
        if ($('#tbField3').val() == '') {
            $('#f3validate').removeClass('d-none');
            retVal = false;
        }
    }
    else if ($('#hfField3Mand').val() == 2) {
        if ($('#ddField3').val() == 0) {
            $('#f3validate').removeClass('d-none');
            retVal = false;
        }
    }

    if ($('#hfField4Mand').val() == 1) {
        if ($('#tbField4').val() == '') {
            $('#f4validate').removeClass('d-none');
            retVal = false;
        }
    }
    else if ($('#hfField4Mand').val() == 2) {
        if ($('#ddField4').val() == 0) {
            $('#f4validate').removeClass('d-none');
            retVal = false;
        }
    }
    if ($('#hfField5Mand').val() == 1) {
        if ($('#tbField5').val() == '') {
            $('#f5validate').removeClass('d-none');
            retVal = false;
        }
    }
    else if ($('#hfField5Mand').val() == 2) {
        if ($('#ddField5').val() == 0) {
            $('#f5validate').removeClass('d-none');
            retVal = false;
        }
    }
    if ($('#hfField6Mand').val() == 1) {
        if ($('#tbField6').val() == '') {
            $('#f6validate').removeClass('d-none');
            retVal = false;
        }
    }
    else if ($('#hfField6Mand').val() == 2) {
        if ($('#ddField6').val() == 0) {
            $('#f6validate').removeClass('d-none');
            return false;
        }
    }
    return retVal;
}