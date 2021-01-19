$('.collapse').on('shown.bs.collapse', function () {
    $(this).parent().find(".fa-plus").removeClass("fa-plus").addClass("fa-minus");
}).on('hidden.bs.collapse', function () {
    $(this).parent().find(".fa-minus").removeClass("fa-minus").addClass("fa-plus");
});
$('.sec-diag').click(function (e) {
    parentpanel = $(this).closest('.card-header');
    collapse = parentpanel.next('.collapse')
    collapse.find('.diag-check input:first-child').prop('checked', $(this).children('input').prop('checked'));
    if (!$(this).children('input').prop('checked')) {
        $('#cbDiagnostic').prop('checked', false)
    }
    e.stopPropagation();
});
$('.sec-learn').click(function (e) {
    parentpanel = $(this).closest('.card-header');
    collapse = parentpanel.next('.collapse')
   collapse.find('.learn-check input:first-child').prop('checked', $(this).children('input').prop('checked'));
   if (!$(this).children('input').prop('checked')) {
       $('#cbLearning').prop('checked', false);
   }
    e.stopPropagation();
});
$('#cbPostLearning').change(function () {
    if (this.checked) {
        $('#pnlThresh').collapse('hide');
    }
    else {
        $('#pnlThresh').collapse('show');
    }
});

$("#cbDiagnostic").click(function (e) {
    $('.diag-check input:first-child').prop('checked', $(this).prop('checked'));
});
$("#cbLearning").click(function (e) {
    $('.learn-check input:first-child').prop('checked', $(this).prop('checked'));
});
function checkBeforeSubmit() {
    var nAssessed = $get('hfPostLearn').value;
    var nComps = $get('hfCompletions').value;
    var nLearners = $get('hfLearners').value;
    var bPL = $get('cbPostLearning').checked;
    if (nAssessed == "False" && bPL == true && parseInt(nComps) > 0) {
        return confirm("There are " + nLearners + " active learners and " + nComps + " completions against this customisation. If you switch post learning assessments on, all completions will be reset. This is not recommended. Continue?");
    }
    else if (parseInt(nComps) > 0 && bPL == false && nAssessed == "True") {
        return confirm("There are " + nLearners + " active learners and " + nComps + " completions against this customisation. If you switch the post learning assessments off, learners will no longer be able to access certificates. This is not recommended. Continue?");
    }
    else if (parseInt(nLearners) > 0) {
        return confirm("There are " + nLearners + " active learners and " + nComps + " completions against this customisation. Any active learners will be affected by your changes. Continue?");
    }
    else {
        return true;
    }
}