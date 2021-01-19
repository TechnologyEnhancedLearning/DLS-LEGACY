function validateRegFields() {
    var retVal = true;
    var matchArray;
    if ($('#tbSetPassword').val() === '' || $('#EmailCheckBox').prop("checked") == true) {
        retVal = true;
    }
    else {
        var pwPat = /(?=.{8,})(?=.*?[^\w\s])(?=.*?[0-9])(?=.*?[A-Za-z]).*/;
        matchArray = $('#tbSetPassword').val().match(pwPat);
        if (matchArray === null) {
            $('#pwvalidate').removeClass('d-none');
            retVal = false;
        }
    }
    return retVal;
}
function validateCustomFields() {
    var retVal = true;
    $('#f1validate, #f2validate, #f3validate, #f4validate, #f5validate, #f6validate, #fnamevalidate, #lnamevalidate, #emailvalidate').removeClass('d-none').addClass('d-none');
    if ($('#FirstNameTextBox').val() == '') {
        $('#fnamevalidate').removeClass('d-none');
        retVal = false;
    }
    if ($('#LastNameTextBox').val() == '') {
        $('#lnamevalidate').removeClass('d-none');
        retVal = false;
    }
    if ($('#EmailAddressTextBox').val() == '') {
        $('#emailvalidate').removeClass('d-none');
        retVal = false;
    }
    if ($('#hfField1Mand').val() == 1) {
        if ($('#txtAnswer1').val() == '') {
            $('#f1validate').removeClass('d-none');
            retVal = false;
        }
    }
    else if ($('#hfField1Mand').val() == 2) {
        if ($('#Answer1DropDown').val() == 0) {
            $('#f1validate').removeClass('d-none');
            retVal = false;
        }
    }
    if ($('#hfField2Mand').val() == 1) {
        if ($('#txtAnswer2').val() == '') {
            $('#f2validate').removeClass('d-none');
            retVal = false;
        }
    }
    else if ($('#hfField2Mand').val() == 2) {
        if ($('#Answer2DropDown').val() == 0) {
            $('#f2validate').removeClass('d-none');
            retVal = false;
        }
    }
    if ($('#hfField3Mand').val() == 1) {
        if ($('#txtAnswer3').val() == '') {
            $('#f3validate').removeClass('d-none');
            retVal = false;
        }
    }
    else if ($('#hfField3Mand').val() == 2) {
        if ($('#Answer3DropDown').val() == 0) {
            $('#f3validate').removeClass('d-none');
            retVal = false;
        }
    }

    if ($('#hfField4Mand').val() == 1) {
        if ($('#txtAnswer4').val() == '') {
            $('#f4validate').removeClass('d-none');
            retVal = false;
        }
    }
    else if ($('#hfField4Mand').val() == 2) {
        if ($('#Answer4DropDown').val() == 0) {
            $('#f4validate').removeClass('d-none');
            retVal = false;
        }
    }
    if ($('#hfField5Mand').val() == 1) {
        if ($('#txtAnswer5').val() == '') {
            $('#f5validate').removeClass('d-none');
            retVal = false;
        }
    }
    else if ($('#hfField5Mand').val() == 2) {
        if ($('#Answer5DropDown').val() == 0) {
            $('#f5validate').removeClass('d-none');
            retVal = false;
        }
    }
    if ($('#hfField6Mand').val() == 1) {
        if ($('#txtAnswer6').val() == '') {
            $('#f6validate').removeClass('d-none');
            retVal = false;
        }
    }
    else if ($('#hfField6Mand').val() == 2) {
        if ($('#Answer6DropDown').val() == 0) {
            $('#f6validate').removeClass('d-none');
            return false;
        }
    }
    return retVal;
}
function validateCustomFieldsUpdate() {
    var retVal = true;
    $('#f1validate_U, #f2validate_U, #f3validate_U, #f4validate_U, #f5validate_U, #f6validate_U, #fnamevalidate_U, #lnamevalidate_U, #emailvalidate_U').removeClass('d-none').addClass('d-none');
    if ($('#FirstNameTextBox_U').val() == '') {
        $('#fnamevalidate_U').removeClass('d-none');
        retVal = false;
    }
    if ($('#LastNameTextBox_U').val() == '') {
        $('#lnamevalidate_U').removeClass('d-none');
        retVal = false;
    }
    if ($('#EmailAddressTextBox_U').val() == '') {
        $('#emailvalidate_U').removeClass('d-none');
        retVal = false;
    }
    if ($('#hfField1Mand_U').val() == 1) {
        if ($('#txtAnswer1_U').val() == '') {
            $('#f1validate_U').removeClass('d-none');
            retVal = false;
        }
    }
    else if ($('#hfField1Mand_U').val() == 2) {
        if ($('#Answer1DropDown_U').val() == 0) {
            $('#f1validate_U').removeClass('d-none');
            retVal = false;
        }
    }
    if ($('#hfField2Mand_U').val() == 1) {
        if ($('#txtAnswer2_U').val() == '') {
            $('#f2validate_U').removeClass('d-none');
            retVal = false;
        }
    }
    else if ($('#hfField2Mand_U').val() == 2) {
        if ($('#Answer2DropDown_U').val() == 0) {
            $('#f2validate_U').removeClass('d-none');
            retVal = false;
        }
    }
    if ($('#hfField3Mand_U').val() == 1) {
        if ($('#txtAnswer3_U').val() == '') {
            $('#f3validate_U').removeClass('d-none');
            retVal = false;
        }
    }
    else if ($('#hfField3Mand_U').val() == 2) {
        if ($('#Answer3DropDown_U').val() == 0) {
            $('#f3validate_U').removeClass('d-none');
            retVal = false;
        }
    }

    if ($('#hfField4Mand_U').val() == 1) {
        if ($('#txtAnswer4_U').val() == '') {
            $('#f4validate_U').removeClass('d-none');
            retVal = false;
        }
    }
    else if ($('#hfField4Mand_U').val() == 2) {
        if ($('#Answer4DropDown_U').val() == 0) {
            $('#f4validate_U').removeClass('d-none');
            retVal = false;
        }
    }
    if ($('#hfField5Mand_U').val() == 1) {
        if ($('#txtAnswer5_U').val() == '') {
            $('#f5validate_U').removeClass('d-none');
            retVal = false;
        }
    }
    else if ($('#hfField5Mand_U').val() == 2) {
        if ($('#Answer5DropDown_U').val() == 0) {
            $('#f5validate_U').removeClass('d-none');
            retVal = false;
        }
    }
    if ($('#hfField6Mand_U').val() == 1) {
        if ($('#txtAnswer6_U').val() == '') {
            $('#f6validate_U').removeClass('d-none');
            retVal = false;
        }
    }
    else if ($('#hfField6Mand_U').val() == 2) {
        if ($('#Answer6DropDown_U').val() == 0) {
            $('#f6validate_U').removeClass('d-none');
            return false;
        }
    }
    return retVal;
}
function validateSetPW() {
    var pwPat = /(?=.{8,})(?=.*?[^\w\s])(?=.*?[0-9])(?=.*?[A-Za-z]).*/;
    var retVal = true;
    var matchArray;
    matchArray = $('#tbSetPassword1').val().match(pwPat);
    if (matchArray === null) {
        $('#pwvalidate1').removeClass('d-none');
        retVal = false;
    }

    return retVal;
}