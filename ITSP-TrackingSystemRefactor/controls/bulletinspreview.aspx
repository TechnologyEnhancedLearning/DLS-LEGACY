<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="bulletinspreview.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.bulletinspreview" %>

<%@ Register Src="~/controls/brands.ascx" TagPrefix="uc1" TagName="brands" %>
<%@ Register Src="~/controls/bulletins.ascx" TagPrefix="uc1" TagName="bulletins" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
        <link href="../Content/plugins.min.css" rel="stylesheet" />
    <link href="../Content/landing.css" rel="stylesheet" />
    <script src="../Scripts/plugins.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <uc1:bulletins runat="server" id="bulletins" />
        </div>
    </form>
</body>
</html>
