<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="learning.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.learningnt" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/jquery-1.11.1.min.js"></script>
    <script src="Scripts/jQueryResizeStop.js"></script>
    <script>
        var QueryString = function () {
            // This function is anonymous, is executed immediately and 
            // the return value is assigned to QueryString!
            var query_string = {};
            var query = window.location.search.substring(1);
            var vars = query.split("&");
            for (var i = 0; i < vars.length; i++) {
                var pair = vars[i].split("=");
                // If first entry with this name
                if (typeof query_string[pair[0]] === "undefined") {
                    query_string[pair[0]] = pair[1];
                    // If second entry with this name
                } else if (typeof query_string[pair[0]] === "string") {
                    var arr = [query_string[pair[0]], pair[1]];
                    query_string[pair[0]] = arr;
                    // If third or later entry with this name
                } else {
                    query_string[pair[0]].push(pair[1]);
                }
            }
            return query_string;
        }();
        var desWidth;
        var desHeight;
        window.onload = function () {
            // set desired width and height:
            desWidth = QueryString.width
            desHeight = QueryString.height;
            // size the DCR:
            sizeDCR();
        }
        //This uses jQuery custom event setup in jQueryResizeStop.js to resize DCR when user has resized window (if window.onresize is used, it gets called repeatedly while user is resizing):
        $(window).bind('resizestop', function (e) {
            sizeDCR();
        });
        function sizeDCR() {
            //check that frameelement exists (IE triggers two window onload events - one for outer window and one for window in iFrame so frameElement may not yet exist):
            if (window.frameElement) {
                //set variable for required width : height ratio
                var nRatio = desHeight / desWidth;

                //get current iFrame width and height
                var width = window.frameElement.offsetWidth,
height = window.frameElement.offsetHeight;
                //get current iFrame  width : height ratio
                var nThisRatio = height / width;
                //check if iFrame is smaller than required:
                if (width < desWidth | height < desHeight) {
                    //check actual ratio against required ratio to determine how to resize (is it too tall or too narrow)
                    if (nThisRatio > nRatio) {
                        document.getElementById('EITSMovie').width = width;
                        document.getElementById('EITSMovie').height = width * nRatio;
                    }
                    else if (nRatio > nThisRatio) {

                        document.getElementById('EITSMovie').height = height;
                        document.getElementById('EITSMovie').width = height * (desWidth / desHeight);

                    }
                    else {
                        //on the off chance that the actual ratio and required ratio are the same, set both width and height
                        document.getElementById('EITSMovie').width = width;
                        document.getElementById('EITSMovie').height = height;
                    };
                    //the window isn't big enough - warn user:
                    //need to check that the iFrame hasn't just been closed (returns size 0 x 0 if it has):
                    if (width > 0 | height > 0 && window.parent.g_warned == 0) {
                        //also check that the browser is IE - if it isn't the message window (in Chrome) causes a glitch in the Shockwave movie
                        //If they have already gone full screen let's not warn them, either
                        var isChromium = window.chrome,
vendorName = window.navigator.vendor;
                        if (isChromium !== null && vendorName === "Google Inc." ) {
                            // is Google chrome or window is full screen
                        } else {
                            // not Google chrome
                            alert('Your browser window is too small to display these materials properly. Try increasing your screen resolution, maximising your browser and / or pressing F11 to view full screen.');
                            window.parent.g_warned = 1;
                        }

                    }
                }

                else {
                    //window is big enough so set width and height to desired values
                    document.getElementById('EITSMovie').width = desWidth;
                    document.getElementById('EITSMovie').height = desHeight;
                };

            }
        }
        function closeLearning() {
            if (typeof window.parent.closeMpe === "function") {
                window.parent.closeMpe();
            }
            else {
                window.open('', '_self', ''); window.close();
            }
        }
    </script>
</head>
<body runat="server" id="LMBody">
    <form id="form1" runat="server">
      <div>
              <asp:Literal ID="LMMovie" runat="server"></asp:Literal>
      </div>
    </form>
  </body>
</html>