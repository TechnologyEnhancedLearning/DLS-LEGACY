<%@ Page Title="Configuration" Language="vb" AutoEventWireup="false" MasterPageFile="~/cms/CMS.Master" CodeBehind="Config.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.Config" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ObjectDataSource ID="dsCategories" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetByCentreID" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.CourseCategoriesTableAdapter" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_CourseCategoryID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CentreID" Type="Int32" />
            <asp:Parameter Name="CategoryName" Type="String" />
            <asp:Parameter Name="CategoryContactEmail" Type="String" />
            <asp:Parameter Name="CategoryContactPhone" Type="String" />
            <asp:Parameter Name="Active" Type="Boolean" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="CentreID" Type="Int32" />
            <asp:Parameter Name="CategoryName" Type="String" />
            <asp:Parameter Name="CategoryContactEmail" Type="String" />
            <asp:Parameter Name="CategoryContactPhone" Type="String" />
            <asp:Parameter Name="Active" Type="Boolean" />
            <asp:Parameter Name="Original_CourseCategoryID" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsTopics" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetByCentreID" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.CourseTopicsTableAdapter" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_CourseTopicID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CentreID" Type="Int32" />
            <asp:Parameter Name="CourseTopic" Type="String" />
            <asp:Parameter Name="Active" Type="Boolean" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="CentreID" Type="Int32" />
            <asp:Parameter Name="CourseTopic" Type="String" />
            <asp:Parameter Name="Active" Type="Boolean" />
            <asp:Parameter Name="Original_CourseTopicID" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <h2>Centre Content Management Configuration</h2>
    <hr />
    <div class="row">
        <div class="col col-lg-12">
            <div id="pnlUsage" runat="server" class="alert alert-info">
                <h5 class="mb-2">Server space used: 
                    <asp:Label ID="lblUsed" runat="server" Text="Used"></asp:Label>
                    /
                    <asp:Label ID="lblAvailable" runat="server" Text="Available"></asp:Label></h5>
                <div class="progress">
                    <div class="progress-bar progress-bar-info" runat="server" id="progbar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
                        <asp:Label ID="lblPercent" runat="server" Text="60%"></asp:Label>
                    </div>
                </div>
            </div>
            <div class="card mb-2 card-default">

                <div class="card-header">
                    <h4>Manage Centre Course Categories</h4>
                </div>
                <dx:BootstrapGridView ID="bsgvCategories" OnInitNewRow="InitNewRow_DefaultActive" runat="server" AutoGenerateColumns="False" DataSourceID="dsCategories" KeyFieldName="CourseCategoryID">
                    <SettingsDataSecurity AllowDelete="True" AllowEdit="True" AllowInsert="True" />
                    <SettingsBootstrap Striped="True"></SettingsBootstrap>
                    <SettingsCommandButton>
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="fas fa-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary float-right" IconCssClass="fas fa-check" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-outline-secondary mr-auto" IconCssClass="fas fa-times" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-outline-secondary" IconCssClass="fas fa-pencil-alt" RenderMode="Button" Text=" " />
                        <DeleteButton ButtonType="Button" CssClass="btn btn-danger" IconCssClass="fas fa-trash" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsEditing Mode="PopupEditForm">
                    </SettingsEditing>
                    <SettingsPopup>
                        <EditForm AllowResize="True" Modal="True">
                        </EditForm>
                    </SettingsPopup>
                    <Columns>
                        <dx:BootstrapGridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="CentreID" Caption="Centre" Visible="False" VisibleIndex="1">
                            <SettingsEditForm Visible="True" ColumnSpan="12" />
                            <EditItemTemplate>
                                <asp:HiddenField ID="hfCentreID" Value='<%# Bind("CentreID") %>' runat="server" />
                                <asp:Label ID="Label1" CssClass="form-control" disabled="disabled" runat="server" Text='<%# Session("UserCentreName") %>'></asp:Label>
                            </EditItemTemplate>
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewTextColumn Caption="Category" FieldName="CategoryName" VisibleIndex="2">
                            <SettingsEditForm ColumnSpan="12" />
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewTextColumn Caption="Contact Email" FieldName="CategoryContactEmail" VisibleIndex="3">
                            <SettingsEditForm ColumnSpan="12" />
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewTextColumn Caption="Contact Phone" FieldName="CategoryContactPhone" VisibleIndex="4">
                            <SettingsEditForm ColumnSpan="12" />
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="5">
                            <SettingsEditForm ColumnSpan="12" />
                        </dx:BootstrapGridViewCheckColumn>
                        <dx:BootstrapGridViewCommandColumn ShowDeleteButton="True" Caption=" " VisibleIndex="6">
                        </dx:BootstrapGridViewCommandColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
        </div>
        <div class="col col-lg-12">
            <div class="card mb-2 card-default">

                <div class="card-header">
                    <h4>Manage Centre Course Topics</h4>
                </div>
                <dx:BootstrapGridView ID="bsgvTopics" runat="server" OnInitNewRow="InitNewRow_DefaultActive" AutoGenerateColumns="False" DataSourceID="dsTopics" KeyFieldName="CourseTopicID">
                    <SettingsDataSecurity AllowDelete="True" AllowEdit="True" AllowInsert="True" />
                    <SettingsBootstrap Striped="True"></SettingsBootstrap>
                    <SettingsCommandButton>
                        <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="fas fa-plus" RenderMode="Button" />
                        <UpdateButton ButtonType="Button" CssClass="btn btn-primary float-right" IconCssClass="fas fa-check" RenderMode="Button" Text="Submit" />
                        <CancelButton ButtonType="Button" CssClass="btn btn-outline-secondary" IconCssClass="fas fa-times" RenderMode="Button" />
                        <EditButton ButtonType="Button" CssClass="btn btn-outline-secondary" IconCssClass="fas fa-pencil-alt" RenderMode="Button" Text=" " />
                        <DeleteButton ButtonType="Button" CssClass="btn btn-danger" IconCssClass="fas fa-trash" RenderMode="Button" Text=" " />
                    </SettingsCommandButton>
                    <SettingsEditing Mode="PopupEditForm">
                    </SettingsEditing>
                    <SettingsPopup>
                        <EditForm AllowResize="True" Modal="True">
                        </EditForm>
                    </SettingsPopup>
                    <Columns>
                        <dx:BootstrapGridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="CentreID" Caption="Centre" Visible="False" VisibleIndex="2">
                            <SettingsEditForm Visible="True" ColumnSpan="12" />
                            <EditItemTemplate>
                                <asp:HiddenField ID="HiddenField1" Value='<%# Bind("CentreID") %>' runat="server" />
                                <asp:Label ID="Label2" CssClass="form-control" disabled="disabled" runat="server" Text='<%# Session("UserCentreName") %>'>></asp:Label>
                            </EditItemTemplate>
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewTextColumn Caption="Topic" FieldName="CourseTopic" VisibleIndex="3">
                            <SettingsEditForm ColumnSpan="9" />
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="4">
                            <SettingsEditForm ColumnSpan="3" />
                        </dx:BootstrapGridViewCheckColumn>
                        <dx:BootstrapGridViewCommandColumn ShowDeleteButton="True" Caption=" " VisibleIndex="5">
                        </dx:BootstrapGridViewCommandColumn>
                    </Columns>
                </dx:BootstrapGridView>
            </div>
        </div>
    </div>
</asp:Content>
