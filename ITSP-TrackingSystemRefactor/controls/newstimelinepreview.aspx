<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="newstimelinepreview.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.news_timeline_preview" %>

<%@ Register Src="~/controls/newstimeline.ascx" TagPrefix="uc1" TagName="newstimeline" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Content/plugins.min.css" rel="stylesheet" />
    <link href="../Content/landing.css" rel="stylesheet" />
    <script src="../Scripts/plugins.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <uc1:newstimeline runat="server" ID="newstimeline" ResultCount="100" BrandID="0" ProductID="0" />
        </div>
    </form>
</body>
</html>
