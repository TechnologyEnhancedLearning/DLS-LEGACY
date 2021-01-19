<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="cstoriespreview.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.cstoriespreview" %>

<%@ Register Src="~/controls/cstories.ascx" TagPrefix="uc1" TagName="cstories" %>


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
            <uc1:cstories runat="server" ID="cstories" />
            <script src="../Scripts/app.min.js"></script>
        </div>
        <div class="btn-back-top back-show">
        <a href="#" data-scroll="" id="back-top" class="btn-circle btn-circle-primary btn-circle-sm btn-circle-raised ">
          <i class="fas fa-arrow-up"></i>
        </a>
      </div>
    </form>
</body>
</html>
