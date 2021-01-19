<%@ Page Title="Bulletins" Language="vb" AutoEventWireup="false" MasterPageFile="~/Landing.Master" CodeBehind="bulletin.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.bulletins" %>
<%@ Register Src="~/controls/bulletins.ascx" TagPrefix="uc1" TagName="bulletins" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <uc1:bulletins runat="server" id="bulletins" />
</asp:Content>
