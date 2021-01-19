<%@ Page Title="Resources" Language="vb" AutoEventWireup="false" MasterPageFile="~/tracking/Site.Master" CodeBehind="resources.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.resources" %>
<%@ Register assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.Bootstrap" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="breadtray" runat="server">
   <ol class="breadcrumb breadcrumb-slash">
        <li  class="breadcrumb-item active">Resources</li>
    </ol>
    <link href="../Content/resources.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ObjectDataSource ID="dsDownloads" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActive" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.DownloadsTableAdapter"></asp:ObjectDataSource>
    <dx:BootstrapGridView ID="bsgvDownloads" SettingsSearchcard-Visible="true" SettingsBehavior-AutoExpandAllGroups="False" CssClasses-GroupRow="success font-bold" Settings-GridLines="None" runat="server" AutoGenerateColumns="False" DataSourceID="dsDownloads" KeyFieldName="DownloadID">
        <SettingsPager PageSize="100"></SettingsPager>
     <Settings ShowColumnHeaders="false" />
        <SettingsBootstrap Striped="true" />
        <Columns> 
            <dx:BootstrapGridViewTextColumn FieldName="Category" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="0">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="Description" VisibleIndex="1">
                <DataItemTemplate>
                    <asp:HyperLink ID="hlDownload" CssClass="btn" ToolTip="Click to download" NavigateUrl='<%# "https://www.dls.nhs.uk/tracking/download?content=" & Eval("Tag") %>' runat="server"><i aria-hiden="true" runat="server" class='<%# GetIconClass(Eval("Filename")) %>'></i>&nbsp; <asp:Label ID="Label2" runat="server" Text='<%# Eval("Description") %>'></asp:Label></asp:HyperLink>
                    
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewDateColumn FieldName="UploadDTT" VisibleIndex="2">
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewTextColumn FieldName="FileSize" VisibleIndex="3">
                <DataItemTemplate>
                    <asp:Label EnableViewState="false" ID="Label1" runat="server" Text='<%# Numeric2Bytes(Eval("FileSize")) %>'></asp:Label>
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
           
        </Columns>
    </dx:BootstrapGridView>
</asp:Content>
