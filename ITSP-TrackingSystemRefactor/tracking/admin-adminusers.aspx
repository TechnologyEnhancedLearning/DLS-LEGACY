<%@ Page Title="Admin - Admin Users" Language="vb" AutoEventWireup="false" MasterPageFile="~/tracking/Site.Master" CodeBehind="admin-adminusers.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.admin_adminusers" %>

<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="breadtray" runat="server">
   <ol class="breadcrumb breadcrumb-slash">
        <li class="breadcrumb-item"><a href="admin-configuration">Admin </a></li>
        <li class="breadcrumb-item active">Admin Users</li>
    </ol>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
            <asp:ObjectDataSource ID="AdminUsersDataSource" runat="server"
                OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
                TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.AdminUsersTableAdapter">


            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="CentresSortedByNameDataSource" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetDataSortedByName" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.CentresTableAdapter"></asp:ObjectDataSource>
                <div class="table-responsive">
                    <dx:BootstrapGridView ID="bsgvAdminUsers" CssClasses-Table="table table-striped small" runat="server" AutoGenerateColumns="False" DataSourceID="AdminUsersDataSource" KeyFieldName="AdminID" SettingsCustomizationDialog-Enabled="True" OnToolbarItemClick="GridViewCustomToolbar_ToolbarItemClick">
                         <CssClasses Table="table table-striped small" />

                        <Settings ShowHeaderFilterButton="True" />
                        <SettingsCookies Enabled="True" Version="0.122" />
                        <SettingsPager PageSize="15">
                        </SettingsPager>
                        <Columns>
                            <dx:BootstrapGridViewTextColumn Caption="Forename" FieldName="Forename" VisibleIndex="1">
                                <Settings AllowHeaderFilter="False" />
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Surname" VisibleIndex="2">
                                <Settings AllowHeaderFilter="False" />
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Email" VisibleIndex="3">
                                <Settings AllowHeaderFilter="False" />
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="CentreName" ReadOnly="True" VisibleIndex="4" Caption="Centre">
                                <SettingsHeaderFilter Mode="CheckedList">
                                </SettingsHeaderFilter>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewCheckColumn FieldName="CentreAdmin" VisibleIndex="5">
                            </dx:BootstrapGridViewCheckColumn>
                            <dx:BootstrapGridViewCheckColumn FieldName="UserAdmin" Visible="False" VisibleIndex="6" Caption="Super Admin">
                            </dx:BootstrapGridViewCheckColumn>
                            <dx:BootstrapGridViewCheckColumn FieldName="IsCentreManager" VisibleIndex="7" Caption="Centre Manager">
                            </dx:BootstrapGridViewCheckColumn>
                            <dx:BootstrapGridViewCheckColumn FieldName="Approved" VisibleIndex="11">
                            </dx:BootstrapGridViewCheckColumn>
                            <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="12">
                            </dx:BootstrapGridViewCheckColumn> 
                             <dx:BootstrapGridViewTextColumn HorizontalAlign="Left" Caption="Locked" FieldName="FailedLoginCount" Name="Locked" VisibleIndex="13">
            </dx:BootstrapGridViewTextColumn>     
                            <dx:BootstrapGridViewTextColumn FieldName="ContentManager" Visible="False" VisibleIndex="9" HorizontalAlign="Center">
                                <DataItemTemplate>
                                    <%#IIf(Eval("ContentManager") And Not Eval("ImportOnly"), "<span class='dxbs-icon dxbs-icon-check'></span>", "") %>
                                </DataItemTemplate>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewCheckColumn FieldName="ContentCreator" Visible="False" VisibleIndex="10">
                            </dx:BootstrapGridViewCheckColumn>
                            <dx:BootstrapGridViewCheckColumn Caption="Content Editor" FieldName="ImportOnly" Visible="False" VisibleIndex="8">
                            </dx:BootstrapGridViewCheckColumn>
                        </Columns>
                        <ClientSideEvents ToolbarItemClick="onToolbarItemClick" />
                        <Toolbars>
        <dx:BootstrapGridViewToolbar Position="Top">
            <Items>
                <dx:BootstrapGridViewToolbarItem Command="ClearGrouping" IconCssClass="far fa-caret-square-down" />
                <dx:BootstrapGridViewToolbarItem Command="ClearSorting" IconCssClass="fas fa-sort" />
                <dx:BootstrapGridViewToolbarItem Command="ClearFilter" />
                <dx:BootstrapGridViewToolbarItem Command="ShowCustomizationDialog" Text="Customise Grid"/>
                    <dx:BootstrapGridViewToolbarItem Command="Custom" Name="ExcelExport" Text="Excel Export" IconCssClass="fas fa-file-export" />                
            </Items>
        </dx:BootstrapGridViewToolbar></Toolbars>
                         <SettingsCustomizationDialog Enabled="True" />
                        <SettingsSearchPanel Visible="True" AllowTextInputTimer="false" />
                    </dx:BootstrapGridView>
                    <dx:ASPxGridViewExporter ID="AdminUsersGridViewExporter" FileName="ITSP Admin Users Export" GridViewID="bsgvAdminUsers" runat="server"></dx:ASPxGridViewExporter>
                    </div>
            <%--</div>--%>

    <%-- Modal Message Window --%>
 <!-- Modal -->
    <div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                  
                    <h5 class="modal-title" id="myModalLabel">
                        <asp:Label ID="lblModalHeading" runat="server" Text=""></asp:Label></h5>  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <asp:Label ID="lblModalMessage" runat="server" Text=""></asp:Label>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary float-right" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>