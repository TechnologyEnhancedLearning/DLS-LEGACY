﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="brandpreview.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.brandpreview" %>

<%@ Register Src="~/controls/brand.ascx" TagPrefix="uc1" TagName="brand" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <link href="~/Content/plugins.min.css" rel="stylesheet" />
    <link href="~/Content/landing.css" rel="stylesheet" />
    <script src="../Scripts/plugins.min.js"></script>
    <script src="../Scripts/app.min.js"></script>
</head>
<body>
    
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div>
            <uc1:brand runat="server" ID="brand" />
        </div>
       <div class="btn-back-top back-show">
        <a href="#" data-scroll="" id="back-top" class="btn-circle btn-circle-primary btn-circle-sm btn-circle-raised ">
          <i class="fas fa-arrow-up"></i>
        </a>
      </div>
    </form>
</body>
</html>

