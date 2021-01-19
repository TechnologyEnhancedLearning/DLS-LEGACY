<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="productspreview.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.productspreview" %>

<%@ Register Src="~/controls/products.ascx" TagPrefix="uc1" TagName="products" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Products Preview</title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
            <link href="../Content/plugins.min.css" rel="stylesheet" />
    <link href="../Content/landing.css" rel="stylesheet" />
    <script src="../Scripts/plugins.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <uc1:products runat="server" ID="products" />
        </div>
    </form>
</body>
    <script src="../Scripts/app.min.js"></script>
</html>
