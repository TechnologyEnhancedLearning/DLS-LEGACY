<%@ Page Title="Customer Stories" Language="vb" AutoEventWireup="false" MasterPageFile="~/Landing.Master" CodeBehind="customerstories.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.customerstories" %>

<%@ Register Src="~/controls/cstories.ascx" TagPrefix="uc1" TagName="cstories" %>
<%@ Register Src="~/controls/cstory.ascx" TagPrefix="uc1" TagName="cstory" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:MultiView ID="mvStories" runat="server">
        <asp:View ID="vStories" runat="server">
            <uc1:cstories runat="server" ID="cstories" />
        </asp:View>
        <asp:View ID="vStory" runat="server">
            
            <uc1:cstory runat="server" ID="cstory" />
            <div class="container">
            <a href="customerstories" class="btn btn-default centre-text"><i class="fas fa-arrow-left"></i> Back</a></div>
        </asp:View>
    </asp:MultiView>
</asp:Content>
