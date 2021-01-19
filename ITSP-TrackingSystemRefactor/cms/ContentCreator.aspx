<%@ Page Language="vb" Title="Content Creator" AutoEventWireup="false" MasterPageFile="~/cms/CMS.Master" CodeBehind="ContentCreator.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.ContentCreator" %>


<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
     <h2>Content Creator</h2>
    <hr />
    <div class="card card-primary">
        <div class="card-header">
            Your Content Creator Licence
        </div>
        <div class="card-body">
  <p>Content Creator Licence Issued <asp:Label ID="lblLicenceStart" runat="server" Text="Label"></asp:Label></p>
            <p><b>Licence code</b> (copy to clipboard before installing):</p>
   <div class="alert alert-info"> <asp:Label ID="lblLicenceCode" runat="server" Text="Label"></asp:Label></div>
    <p>For Content Creator installation help, click <a href="https://www.dls.nhs.uk/CCHelp/Installation.html" target="_blank">here</a>.</p>
    <asp:HyperLink ID="hlDownloadCC" NavigateUrl="#" CssClass="btn btn-primary" Target="_blank" runat="server"><i aria-hidden="true" class="fas fa-download"></i> Download Content Creator (v<asp:Label ID="lblCCVersion" runat="server" Text="Label"></asp:Label>)</asp:HyperLink>
            <br /><br />
            <div class="well small"><h5>Latest Release Notes</h5>
                <asp:Literal ID="litReleaseNotes" runat="server"></asp:Literal>
            </div>
        </div>
    </div>
   
    </asp:Content>