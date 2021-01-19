var apiHandle = null;
var findAPITries = 0;
var noAPIFound = "false";
var isLMS = null;
var terminated = "false";


_debug = false;

function OpenHTML( name )
  {
  var win=window.open( name ,'wintwo',"fullscreen=no,toolbar=yes,menubar=no,status=no,scrollbars=yes,resizable=yes,width=800,height=600");
}

  
function findAPI( win )
{
   if (typeof(win) != 'undefined' ? typeof(win.API) != 'undefined' : false)
  {
    if (win.API != null )  return win.API;
  }
   if (win.frames.length > 0)  for (var i = 0 ; i < win.frames.length ; i++);
  {
    if (typeof(win.frames[i]) != 'undefined' ? typeof(win.frames[i].API) != 'undefined' : false)
    {
	     if (win.frames[i].API != null)  return win.frames[i].API;
    }
  }
  return null;
}

function getAPI()
{
	var myAPI = SCORM_GrabAPI();
  if (myAPI == null)
  {
    window.status = 'Tracking to ITSP Tracking System';
    isLMS = false;
   // alert('JavaScript Warning: API object not found in window or opener. (' + tries + ')');
  }
  else
  {
    mm_adl_API = myAPI;
    isLMS = true;
    window.status = 'Tracking to ITSP Tracking System and LMS';
	//mm_adl_API.LMSSetValue("cmi.core.lesson_status", "incomplete");
   startTimer();
  }
  return myAPI;
}

function getAPIHandle()
{
   if ( apiHandle == null )
   {
      if ( noAPIFound == "false" )
      {
         apiHandle = getAPI();
      }
   }

   return apiHandle;
}

function retrieveDataValue( name )
{
     {
         var value = mm_adl_API.LMSGetValue( name );

         var errCode = mm_adl_API.LMSGetLastError();

         if ( errCode != "0" )
         {
            errCode = retrieveLastErrorCode();

            displayErrorInfo( errCode );

            // may want to do some error handling
         }
         else
         {
            return value;
         }
      }

   return;
}

function storeDataValue( name, value )
{

      {
        result = mm_adl_API.LMSSetValue( name, value );

         if ( result != "true" )
         {
            var errCode = retrieveLastErrorCode();

            //displayErrorInfo( errCode );

            // may want to do some error handling
         }
   }
mm_adl_API.LMSCommit("")
   return result;
}

function initializeAPICommunication() {
  	var result = "false";
		
	if ( apiHandle == null )
	{
   	var mm_adl_API = getAPIHandle();

	   if ( mm_adl_API != null )
	   {
		  result = mm_adl_API.LMSInitialize("");
	
		  if ( result != "true" )
		  {
			 var errCode = retrieveLastErrorCode();
	
			 displayErrorInfo( errCode );
	
			 // may want to do some error handling
		}
	   }
	}
	
   return result;
}
function startTimer()
{
   startDate = new Date().getTime();
}
function mm_adlOnunload()
{
if ( apiHandle != null )
{
	if ( startDate != 0 )
   {
      var currentDate = new Date().getTime();
      var elapsedSeconds = ( (currentDate - startDate) / 1000 );
      var formattedTime = convertTotalSeconds( elapsedSeconds );
   }
   else
   {
      formattedTime = "00:00:00.0";
   }
   mm_adl_API.LMSSetValue( "cmi.core.session_time", formattedTime );
   
  if (mm_adl_API != null)
  {
    // set status
    mm_adl_API.LMSCommit("");
    mm_adl_API.LMSFinish("");
  }
  }
}
function mm_adlUpdate(stat) {
  if (isLMS == true) {
    if (startDate != 0) {
      var currentDate = new Date().getTime();
      var elapsedSeconds = ((currentDate - startDate) / 1000);
      var formattedTime = convertTotalSeconds(elapsedSeconds);
    }
    else {
      formattedTime = "00:00:00.0";
    }
    mm_adl_API.LMSSetValue("cmi.core.lesson_status", stat);
    mm_adl_API.LMSSetValue("cmi.core.session_time", formattedTime);

    if (mm_adl_API != null) {
      // set status
      mm_adl_API.LMSCommit("");
    } 
  }
}
function mm_adlComplete(stat)
{
	if ( startDate != 0 )
   {
      var currentDate = new Date().getTime();
      var elapsedSeconds = ( (currentDate - startDate) / 1000 );
      var formattedTime = convertTotalSeconds( elapsedSeconds );
   }
   else
   {
      formattedTime = "00:00:00.0";
   }
   mm_adl_API.LMSSetValue("cmi.core.lesson_status", stat);
   mm_adl_API.LMSSetValue( "cmi.core.session_time", formattedTime );
   
  if (mm_adl_API != null)
  {
    // set status
    mm_adl_API.LMSCommit("");
    mm_adl_API.LMSFinish("");
  }
}
function convertTotalSeconds(ts)
{
   var sec = (ts % 60);

   ts -= sec;
   var tmp = (ts % 3600);  //# of seconds in the total # of minutes
   ts -= tmp;              //# of seconds in the total # of hours

   // convert seconds to conform to CMITimespan type (e.g. SS.00)
   sec = Math.round(sec*100)/100;
   
   var strSec = new String(sec);
   var strWholeSec = strSec;
   var strFractionSec = "";

   if (strSec.indexOf(".") != -1)
   {
      strWholeSec =  strSec.substring(0, strSec.indexOf("."));
      strFractionSec = strSec.substring(strSec.indexOf(".")+1, strSec.length);
   }
   
   if (strWholeSec.length < 2)
   {
      strWholeSec = "0" + strWholeSec;
   }
   strSec = strWholeSec;
   
   if (strFractionSec.length)
   {
      strSec = strSec+ "." + strFractionSec;
   }


   if ((ts % 3600) != 0 )
      var hour = 0;
   else var hour = (ts / 3600);
   if ( (tmp % 60) != 0 )
      var min = 0;
   else var min = (tmp / 60);

   if ((new String(hour)).length < 2)
      hour = "0"+hour;
   if ((new String(min)).length < 2)
      min = "0"+min;

   var rtnVal = hour+":"+min+":"+strSec;

   return rtnVal;
}
function retrieveLastErrorCode()
{
   // It is permitted to call GetLastError() after Terminate()

         return mm_adl_API.LMSGetLastError();
}

	function setupFunction(aCommand)
	{			
	 	//Uncomment the line below to see the string that was built in Lingo get passed into this function.
	 
	    var tCommand = 'executeCommand(\"' + aCommand + '\")'
	    //Set a delay to avoid synchronous problems on some systems.
		window.setTimeout( tCommand, 100);
	   }     
   
   
   function executeCommand(aCommand)
   {
       	var result = eval(aCommand);
       	window.document.EITSMovie.EvalScript(result);
   }
   function OpenMail( name )
  {
  var win=window.open( name ,'wintwo',"fullscreen=no,toolbar=no,menubar=no,status=no,scrollbars=no,resizable=yes,width=500,height=380");
 }

 //---------------------------------------------------------------------------------
 //API Locating Functions

 function SCORM_GrabAPI() {

 	WriteToDebug("In SCORM_GrabAPI");

 	//if we haven't already located the API, find it using our improved ADL algorithm
 	if (typeof (SCORM_objAPI) == "undefined" || SCORM_objAPI == null) {
 		WriteToDebug("Searching with improved ADL algorithm");
 		SCORM_objAPI = SCORM_GetAPI();
 	}

 	//if it's still not found, look in every concievable spot...some older LMS's bury it in wierd places
 	//drop this because it can cause problems when the content is launched in a cross domain envrionment...for instance the 
 	//standard detection algorithm could come upon a frame from a different domain using this algorithm when the content is
 	//launched under AICC

 	//TODO: a better solution might be to wrap this in a try/catch block

 	//if (typeof(SCORM_objAPI) == "undefined" || SCORM_objAPI == null){
 	//	WriteToDebug("Searching everywhere with Rustici Software algorithm");
 	//	SCORM_objAPI = SCORM_SearchForAPI(window);
 	//}

 	if (typeof (SCORM_objAPI) == "undefined" || SCORM_objAPI == null) {
 		SCORM_objAPI = SCORM_SearchForAPI(window);
 	}

 	WriteToDebug("SCORM_GrabAPI, returning");

 	return SCORM_objAPI;

 }


 function SCORM_SearchForAPI(wndLookIn) {

 	WriteToDebug("SCORM_SearchForAPI");

 	var objAPITemp = null;
 	var strDebugID = "";

 	strDebugID = "Name=" + wndLookIn.name + ", href=" + wndLookIn.location.href

 	objAPITemp = wndLookIn.API;

 	if (SCORM_APIFound(objAPITemp)) {
 		WriteToDebug("Found API in this window - " + strDebugID);
 		return objAPITemp;
 	}

 	if (SCORM_WindowHasParent(wndLookIn)) {
 		WriteToDebug("Searching Parent - " + strDebugID);
 		objAPITemp = SCORM_SearchForAPI(wndLookIn.parent);
 	}

 	if (SCORM_APIFound(objAPITemp)) {
 		WriteToDebug("Found API in a parent - " + strDebugID);
 		return objAPITemp;
 	}

 	if (SCORM_WindowHasOpener(wndLookIn)) {
 		WriteToDebug("Searching Opener - " + strDebugID);
 		objAPITemp = SCORM_SearchForAPI(wndLookIn.opener);
 	}

 	if (SCORM_APIFound(objAPITemp)) {
 		WriteToDebug("Found API in an opener - " + strDebugID);
 		return objAPITemp;
 	}

 	//look in child frames individually, don't call this function recursively
 	//on them to prevent an infinite loop when it looks back up to the parents
 	WriteToDebug("Looking in children - " + strDebugID);
 	objAPITemp = SCORM_LookInChildren(wndLookIn);

 	if (SCORM_APIFound(objAPITemp)) {
 		WriteToDebug("Found API in Children - " + strDebugID);
 		return objAPITemp;
 	}

 	WriteToDebug("Didn't find API in this window - " + strDebugID);
 	return null;
 }


 function SCORM_LookInChildren(wnd) {

 	WriteToDebug("SCORM_LookInChildren");

 	var objAPITemp = null;

 	var strDebugID = "";

 	strDebugID = "Name=" + wnd.name + ", href=" + wnd.location.href

 	for (var i = 0; i < wnd.frames.length; i++) {

 		WriteToDebug("Looking in child frame " + i);

 		objAPITemp = wnd.frames[i].API;

 		if (SCORM_APIFound(objAPITemp)) {
 			WriteToDebug("Found API in child frame of " + strDebugID);
 			return objAPITemp;
 		}

 		WriteToDebug("Looking in this child's children " + strDebugID);
 		objAPITemp = SCORM_LookInChildren(wnd.frames[i]);

 		if (SCORM_APIFound(objAPITemp)) {
 			WriteToDebug("API found in this child's children " + strDebugID);
 			return objAPITemp;
 		}
 	}

 	return null;
 }

 function SCORM_WindowHasOpener(wnd) {
 	WriteToDebug("In SCORM_WindowHasOpener");
 	if ((wnd.opener != null) && (wnd.opener != wnd) && (typeof (wnd.opener) != "undefined")) {
 		WriteToDebug("Window Does Have Opener");
 		return true;
 	}
 	else {
 		WriteToDebug("Window Does Not Have Opener");
 		return false;
 	}
 }

 function SCORM_WindowHasParent(wnd) {
 	WriteToDebug("In SCORM_WindowHasParent");
 	if ((wnd.parent != null) && (wnd.parent != wnd) && (typeof (wnd.parent) != "undefined")) {
 		WriteToDebug("Window Does Have Parent");
 		return true;
 	}
 	else {
 		WriteToDebug("Window Does Not Have Parent");
 		return false;
 	}
 }


 function SCORM_APIFound(obj) {
 	WriteToDebug("In SCORM_APIFound");
 	if (obj == null || typeof (obj) == "undefined") {
 		WriteToDebug("API NOT Found");
 		return false;
 	}
 	else {
 		WriteToDebug("API Found");
 		return true;
 	}
 }




 /*******************************************************************
 * SCORM 2004 API Search Algorithm
 * Description - Improvement of the algorithm developed by ADL to 
 find the SCORM 2004 API Adapter. The improvements eliminate 
 errors, improve code clarity and eliminate the dependence
 on global variables. The errors removed include:
 - The "win" variable was never declared in a scope 
 accessible to the GetAPI function
 - A call to API.version which is not part of the SCORM
 2004 specification
 - The previous algorithm was not able to find the API
 if it was located in the window's parent's opener
 * Original Author - ADL & Concurrent Technologies Corporation
 * Author -  Mike Rustici (April 1, 2004)
 Rustici Software, LLC
 http://www.scorm.com
 mike@scorm.com
 *******************************************************************/




 /*
 ScanParentsForApi
 -Searches all the parents of a given window until
 it finds an object named "API". If an
 object of that name is found, a reference to it
 is returned. Otherwise, this function returns null.
 */
 function SCORM_ScanParentsForApi(win) {

// 	WriteToDebug("In SCORM_ScanParentsForApi, win=" + win.location);

 	/*
 	Establish an outrageously high maximum number of
 	parent windows that we are will to search as a
 	safe guard against an infinite loop. This is 
 	probably not strictly necessary, but different 
 	browsers can do funny things with undefined objects.
 	*/
 	var MAX_PARENTS_TO_SEARCH = 500;
 	var nParentsSearched = 0;

 	/*
 	Search each parent window until we either:
 	-find the API, 
 	-encounter a window with no parent (parent is null 
 	or the same as the current window)
 	-or, have reached our maximum nesting threshold
 	*/
 	while ((win.API == null || win.API === undefined) &&
			(win.parent != null) && (win.parent != win) &&
			(nParentsSearched <= MAX_PARENTS_TO_SEARCH)
		  ) {

 		nParentsSearched++;
 		win = win.parent;
 	}

 	/*
 	If the API doesn't exist in the window we stopped looping on, 
 	then this will return null.
 	*/
 	return win.API;
 }


 /*
 GetAPI
 -Searches all parent and opener windows relative to the
 current window for the SCORM API Adapter.
 Returns a reference to the API Adapter if found or null
 otherwise.
 */
 function SCORM_GetAPI() {
 	WriteToDebug("In SCORM_GetAPI");

 	var API = null;

 	//Search all the parents of the current window if there are any
 	if ((window.parent != null) && (window.parent != window)) {
 		WriteToDebug("SCORM_GetAPI, searching parent");
 		API = SCORM_ScanParentsForApi(window.parent);
 	}

 	/*
 	If we didn't find the API in this window's chain of parents, 
 	then search all the parents of the opener window if there is one
 	*/
 	if ((API == null) && (window.top.opener != null)) {
 		WriteToDebug("SCORM_GetAPI, searching opener");
 		API = SCORM_ScanParentsForApi(window.top.opener);
 	}

 	return API;
 }

 function WriteToDebug(logstr) {
 	if (typeof console !== "undefined") {
 		console.log(logstr);
 	}
 }