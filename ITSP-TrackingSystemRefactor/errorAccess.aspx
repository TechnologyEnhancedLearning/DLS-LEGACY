<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="errorAccess.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.errorAccess" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <title>Access Error</title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="padding:20%">
    <h2>Page Loading Error</h2>
       <p>
           <asp:Label ID="lblError" runat="server" Text="You appear to have reached this page by mistake. Links to the Digital Learning Solutions Learning Portal are distributed by Digital Learning Solutions Centres."></asp:Label></p>
        <asp:Panel ID="pnlSessionDetail" Visible="false" runat="server">
            <h5>Error context:</h5>
            <div class="row">
  <div class="col-md-6">
            <ul class="list-group">
  <li class="list-group-item d-flex justify-content-between align-items-center">
   Course ID:
    <span class="badge badge-primary badge-pill">
        <asp:Label ID="lblAppID" runat="server" Text="Nothing"></asp:Label></span>
  </li>
  <li class="list-group-item d-flex justify-content-between align-items-center">
    Customisation ID:
    <span class="badge badge-primary badge-pill">
        <asp:Label ID="lblCustomisationID" runat="server" Text="Nothing"></asp:Label></span>
  </li>
  <li class="list-group-item d-flex justify-content-between align-items-center">
    Centre ID:
    <span class="badge badge-primary badge-pill">
        <asp:Label ID="lblCentreID" runat="server" Text="Nothing"></asp:Label></span>
  </li>
</ul>
      </div>
                </div>
        </asp:Panel>
        <p>For more information about the Digital Learning Solutions and to find your nearest centre, visit <a href="https://www.dls.nhs.uk">the Digital Learning Solutions website</a></p>

    </div>
    </form>
</body>
</html>