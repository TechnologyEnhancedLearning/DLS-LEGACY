<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="quotespreview.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.quotespreview" %>

<%@ Register Src="~/controls/quotes.ascx" TagPrefix="uc1" TagName="quotes" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <link href="~/Content/plugins.min.css" rel="stylesheet" />
    <link href="~/Content/landing.css" rel="stylesheet" />
    <script src="~/Scripts/plugins.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <uc1:quotes runat="server" ID="quotes" ResultCount="100" BrandID="0" ProductID="0"  />
        </div>
    </form>
</body>
</html>
