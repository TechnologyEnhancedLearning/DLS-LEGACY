<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="sco.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.scont" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>ITSP SCO Content Player</title>
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
    </style>
    <script src="../../Scripts/plugins.min.js"></script>
    <script src="Lib/sscompat.js"></script>
    <script src="Lib/sscorlib.js"></script>
    <script src="Lib/ssfx.Core.js"></script>
    <script src="../../Scripts/sw_page_close.js"></script>
    <script src="Lib/API_BASE.js"></script>
    <script src="Lib/API.js"></script>
    <script src="Lib/LocalStorage.js"></script>
    <script src="Lib/Player.js"></script>

</head>
<body style="background-color: #3B1979;">

    <form id="form1" runat="server">
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
</body>
</html>
