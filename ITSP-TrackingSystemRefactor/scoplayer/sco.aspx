<%@ Page Language="vb" Title="Content Player" AutoEventWireup="false" CodeBehind="sco.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.sco" %>

<!DOCTYPE html>

<html lang="en">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title><%: Page.Title %> - Digital Learning Solutions Tracking System</title>
    <script>
        window.onerror = function (message, url, lineNumber) {
            // code to execute on an error  
            return true; // prevents browser error messages  
        };
    </script>
    <style type="text/css">
        * {
            margin: 0px;
        }

        html, body, form, iframe {
            height: 100%;
        }

        html, body {
            overflow-y: auto;
            font-family: Helvetica, "Helvetica Neue", Arial;
            font-size: 12px;
        }

        iframe {
            display: block;
            width: 100%;
        }

        html, body, iframe, a, img, table, tbody, tr, td, table td, table th {
            border: 0px none;
            padding: 0px;
        }

        #btnExitAll {
            display: block;
            position: absolute;
            top: 5px;
            right: 20px;
            font-weight: 400;
            text-align: center;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
            border: 1px solid transparent;
            padding: 0.375rem 0.75rem;
            font-size: 1rem;
            line-height: 1.5;
            border-radius: 0.25rem;
            transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
            color: rgba(255,255,255,0.4);
            background-color: rgba(0,123,255,0.3);
            border-color: rgba(0,123,255,0.3);
        }

            #btnExitAll:hover {
                color: #fff;
                background-color: #0069d9;
                border-color: #0062cc;
            }

            #btnExitAll:focus {
                box-shadow: 0 0 0 0.2rem rgba(38, 143, 255, 0.5);
            }
    </style>
    <script src="../Scripts/jquery-1.12.4.min.js"></script>
    <script src="Lib/sscompat.js"></script>
    <script src="Lib/sscorlib.js"></script>
    <script src="Lib/ssfx.Core.js"></script>
    <script src="../Scripts/sw_page_close.js"></script>
    <script src="Lib/API_BASE.js"></script>
    <script src="Lib/API.js?v=20240117"></script>
    <script src="Lib/Controls.js"></script>
    <script src="Lib/LocalStorage.js"></script>
    <script src="Lib/Player.js"></script>
</head>
<body style="background-color: #3B1979;">

    <form id="form1" runat="server">
        <input id="UsernameDummySco" aria-hidden="true" type="text" autocomplete="username" class="d-none" style="display: none !important;">
        <asp:HiddenField ID="hftrackurl" runat="server" />
        <asp:HiddenField ID="hfSuspendData" runat="server" />
        <asp:HiddenField ID="hfLessonLocation" runat="server" />
        <asp:HiddenField ID="hfcustomisation" runat="server" />
        <asp:HiddenField ID="hfversion" runat="server" />
        <asp:HiddenField ID="hfcandidate" runat="server" />
        <asp:HiddenField ID="hfsection" runat="server" />
        <asp:HiddenField ID="hfprog" runat="server" />
        <asp:HiddenField ID="hfTutorialId" runat="server" />
        <asp:HiddenField ID="hfContentType" runat="server" />
        <div id="placeholder_treeContainer" style="display: none;"></div>
        <div id="placeholder_Debugger" style="display: none;"></div>
        <table width="100%" height="100%" border="1" cellspacing="0" cellpadding="0">

            <tr>
                <td height="100%" valign="top">
                    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="100%" valign="middle" height="100%" valign="top">
                                <div id="placeholder_contentIFrame" style="width: 100%; height: 100%; -webkit-overflow-scrolling: touch;"></div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

        </table>
    </form>
    <%--<script>
        const queryString = window.location.search;
        const urlParams = new URLSearchParams(queryString);
        const tutPath = urlParams.get('tutpath');
            Run.ManifestByURL(tutPath, false);
    </script>--%>
</body>
</html>
