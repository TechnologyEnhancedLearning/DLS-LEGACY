<%@ Page Title="Products" Language="vb" AutoEventWireup="false" MasterPageFile="~/Landing.Master" CodeBehind="product.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.product1" %>

<%@ Register Src="~/controls/product.ascx" TagPrefix="uc1" TagName="product" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <uc1:product runat="server" ID="product" />
</asp:Content>
