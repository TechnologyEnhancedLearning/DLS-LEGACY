<%@ Page Title="Admin - Delegates" Language="vb" AutoEventWireup="false" MasterPageFile="~/tracking/Site.Master" CodeBehind="admin-delegates.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.admin_delegates" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Data.Linq" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="breadtray" runat="server">
     <ol class="breadcrumb breadcrumb-slash">
        <li class="breadcrumb-item"><a href="admin-configuration">Admin </a></li>
        <li class="breadcrumb-item active">Delegates</li>
    </ol>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <dx:BootstrapGridView ID="BootstrapGridView1" runat="server" CssClasses-Table="table table-striped small" KeyFieldName="CandidateID" AutoGenerateColumns="False" DataSourceID="dsAdminDelegates">
        <CssClasses Table="table table-striped small" />

                        <Settings ShowHeaderFilterButton="True" />
                        <SettingsCookies Enabled="True" Version="0.12" />
                        <SettingsPager PageSize="25">
                        </SettingsPager>
        <Columns>
            <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="6">
            </dx:BootstrapGridViewCheckColumn>
            <dx:BootstrapGridViewTextColumn FieldName="CentreID" VisibleIndex="8" Visible="False">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="Centre" VisibleIndex="9">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="FirstName" SortIndex="2" SortOrder="Ascending" VisibleIndex="3">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="LastName" SortIndex="1" SortOrder="Ascending" VisibleIndex="2">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewDateColumn FieldName="DateRegistered" SortIndex="3" SortOrder="Ascending" VisibleIndex="10" Caption="Registered">
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewTextColumn FieldName="CandidateNumber" VisibleIndex="1" Caption="Del ID">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="AliasID" VisibleIndex="5" Visible="False">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewCheckColumn FieldName="Approved" VisibleIndex="7">
            </dx:BootstrapGridViewCheckColumn>
            <dx:BootstrapGridViewTextColumn FieldName="EmailAddress" VisibleIndex="4">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewCheckColumn FieldName="ExternalReg" VisibleIndex="12" Visible="False">
            </dx:BootstrapGridViewCheckColumn>
            <dx:BootstrapGridViewCheckColumn FieldName="SelfReg" VisibleIndex="13" Visible="False">
            </dx:BootstrapGridViewCheckColumn>
            <dx:BootstrapGridViewTextColumn FieldName="CourseCount" VisibleIndex="11" Caption="Courses">
            </dx:BootstrapGridViewTextColumn>
        </Columns>
        <Toolbars>
        <dx:BootstrapGridViewToolbar Position="Top">
            <Items>
                <dx:BootstrapGridViewToolbarItem Command="ClearGrouping" IconCssClass="fa fa-caret-square-o-down" />
                <dx:BootstrapGridViewToolbarItem Command="ClearSorting" IconCssClass="fa fa-sort" />
                <dx:BootstrapGridViewToolbarItem Command="ClearFilter" />
                <dx:BootstrapGridViewToolbarItem Command="ShowCustomizationDialog" Text="Customise Grid"/>
              
                                  
            </Items>
        </dx:BootstrapGridViewToolbar>
    </Toolbars>
                        <SettingsCustomizationDialog Enabled="True" />
        <SettingsSearchPanel Visible="True" />
    </dx:BootstrapGridView>
    <asp:ObjectDataSource ID="dsAdminDelegates" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPStatsTableAdapters.adminDelegatesTableAdapter"></asp:ObjectDataSource>

</asp:Content>
