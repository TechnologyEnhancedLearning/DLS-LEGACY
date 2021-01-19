//--------------------------------------------------------------------------------
//
// Code to manage page close from Shockwave.
//
//--------------------------------------------------------------------------------
function closeWin() {
//    alert('closeLearning called');
	window.open('', '_self');
	window.close()
	}
window.onLoad = releaseDirtyFlag()
function setDirtyFlag()
	{
	needToConfirm = true; // Call this function if some changes are made to the web page and requires an alert
	}
function releaseDirtyFlag()
	{
	needToConfirm = false; //Call this function if an alert isn't required
}

function closeLearning() {
//    alert('closeLearning called');
    //        __doPostBack('btnCloseLearning', '');

  window.parent.closeMpe();
}
function initializeCommunication() {
    var result = "false";
    return result;
}
function setupFunction(aCommand) {
//    alert('setupFunction ' + aCommand);	
	var tCommand = 'executeCommand(\"' + aCommand + '\")'
	window.setTimeout(tCommand, 100);
	}     
function executeCommand(aCommand)
	{
	var result = eval(aCommand);
	window.document.EITSMovie.EvalScript(result);
	}
window.onbeforeunload = confirmExit;
function confirmExit()
	{
	if (needToConfirm) {
	  window.document.rfm_powerpoint07.EvalScript("closing");
		//return "Your progress will be lost unless you close the materials using the Save and Close button.  Are you sure you want to close this page and lose your progress?";
		}
	}
