<%@ Page Title="Learning Content" Language="vb" AutoEventWireup="false" MasterPageFile="~/Landing.Master" CodeBehind="learning.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.learning" %>

<%@ Register Src="~/controls/brand.ascx" TagPrefix="uc1" TagName="brand" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/brandfilters.js"></script>
    <uc1:brand runat="server" ID="brand" />
</asp:Content>
