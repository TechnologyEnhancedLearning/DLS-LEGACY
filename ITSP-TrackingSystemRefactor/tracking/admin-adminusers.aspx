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
   
    <asp:MultiView ID="mvAdminUsers" ActiveViewIndex="0" runat="server">
        <asp:View ID="vAdminUserList" runat="server">
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
                            <dx:BootstrapGridViewTextColumn ShowInCustomizationDialog="false" Name="Edit" ReadOnly="True" VisibleIndex="0">
                                <Settings AllowHeaderFilter="False" />
                                <SettingsEditForm Visible="False" />
                                <DataItemTemplate>
                                     <asp:LinkButton EnableViewState="false" ID="lbtEditAdminUser" CssClass="btn btn-outline-secondary btn-sm" ToolTip="Edit User" OnCommand="EditUser_Click" CommandArgument='<%# Eval("AdminID") %>' runat="server"><i aria-hidden="true" class="fas fa-pencil-alt"></i></asp:LinkButton>
                                </DataItemTemplate>
                            </dx:BootstrapGridViewTextColumn>
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
                <DataItemTemplate>
                    <asp:LinkButton ID="lbtUnlock" ToolTip="Click to unlock" OnCommand="Unlock_Click" CommandArgument='<%#  Eval("AdminID")%>' Visible='<%#  Eval("FailedLoginCount") >= 5 %>' EnableViewState="false" CssClass="btn btn-primary" runat="server"><i aria-hidden="true" class="fas fa-unlock-alt"></i></asp:LinkButton>
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>                       
                            <dx:BootstrapGridViewTextColumn Name="Inactivate" ShowInCustomizationDialog="false" VisibleIndex="14">
                                <Settings AllowHeaderFilter="False" />
                                <DataItemTemplate>
                                      <asp:LinkButton EnableViewState="false" ID="lbtInactivateUser" Visible='<%# Eval("Active") %>' OnClientClick="return confirm('Are you sure that you wish to Inactivate / Delete this admin user?');" CssClass="btn btn-danger btn-sm" ToolTip="Inactivate / Delete User" OnCommand="InactivateUser_Click" CommandArgument='<%# Eval("AdminID") %>' runat="server"><i aria-hidden="true" class="fas fa-times"></i></asp:LinkButton>
                                </DataItemTemplate>
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
        </asp:View>
        <asp:View ID="vEditAdminUser" runat="server">
            <asp:HiddenField ID="hfEditUserID" runat="server" />
            <asp:ObjectDataSource ID="dsEditUser" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetForEdit" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.AdminUsersTableAdapter" UpdateMethod="UpdateWithoutProfile" DeleteMethod="Delete" InsertMethod="Insert">
                
                <DeleteParameters>
                    <asp:Parameter Name="Original_AdminID" Type="Int32" />
                </DeleteParameters>
               
                
                <SelectParameters>
                    <asp:ControlParameter ControlID="hfEditUserID" DefaultValue="0" Name="AdminID" PropertyName="Value" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Login" Type="String" />
                    <asp:Parameter Name="CentreID" Type="Int32" />
                    <asp:Parameter Name="CentreAdmin" Type="Boolean" />
                    <asp:Parameter Name="ConfigAdmin" Type="Boolean" />
                    <asp:Parameter Name="Forename" Type="String" />
                    <asp:Parameter Name="Surname" Type="String" />
                    <asp:Parameter Name="Email" Type="String" />
                    <asp:Parameter Name="IsCentreManager" Type="Boolean" />
                    <asp:Parameter Name="Approved" Type="Boolean" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="ContentManager" Type="Boolean" />
                    <asp:Parameter Name="PublishToAll" Type="Boolean" />
                    <asp:Parameter Name="ImportOnly" Type="Boolean" />
                    <asp:Parameter Name="ContentCreator" Type="Boolean" />
                    <asp:Parameter Name="Original_AdminID" Type="Int32" />
                    <asp:Parameter Name="IsFrameworkDeveloper" Type="Boolean" />
                </UpdateParameters>
            </asp:ObjectDataSource>


            <asp:FormView ID="fvEditUser" DefaultMode="Edit" runat="server" RenderOuterTable="False" DataKeyNames="AdminID" DataSourceID="dsEditUser">
                <EditItemTemplate>
                    <div class="card card-primary">
                        <div class="card-header">
                            <h3>Edit Admin User</h3>
                        </div>
                        <div class="card-body">
                            <div class="m-3">
                                <%--<div class="form-group row">
                                    <asp:Label ID="Label3" AssociatedControlID="LoginTextBox" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">User name:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:TextBox ID="LoginTextBox" CssClass="form-control" runat="server" Text='<%# Bind("Login") %>' />
                                    </div>
                                </div>--%>
                                <asp:HiddenField ID="hfLogin" Value='<%# Bind("Login") %>' runat="server" />
                                <div class="form-group row">
                                    <asp:Label ID="Label4" AssociatedControlID="ForenameTextBox" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">First name:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:TextBox ID="ForenameTextBox" CssClass="form-control" runat="server" Text='<%# Bind("Forename") %>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label5" AssociatedControlID="SurnameTextBox" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Last name:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:TextBox ID="SurnameTextBox" CssClass="form-control" runat="server" Text='<%# Bind("Surname") %>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label8" AssociatedControlID="EmailTextBox" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">E-mail:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:TextBox ID="EmailTextBox" CssClass="form-control" runat="server" Text='<%# Bind("Email") %>' />
                                    </div>
                                </div>
                                
                                <div class="form-group row">
                                    <asp:Label ID="Label6" AssociatedControlID="ddUserCentre" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Centre:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:DropDownList ID="ddUserCentre" CssClass="form-control" runat="server" SelectedValue='<%# Bind("CentreID") %>' DataSourceID="CentresSortedByNameDataSource" DataTextField="CentreName" DataValueField="CentreID"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label17" AssociatedControlID="pnlStatus" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Status:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:Panel ID="pnlStatus" CssClass="cb-panel" runat="server">
                                            <div class="checkbox">
                                                <asp:Label ID="Label18" runat="server"><asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Bind("Active") %>' /> Active</asp:Label>
                                            </div>
                                            <div class="checkbox">
                                                <asp:Label ID="Label19" runat="server"><asp:CheckBox ID="ApprovedCheckBox" runat="server" Checked='<%# Bind("Approved") %>' /> Approved</asp:Label>
                                            </div>
                                        </asp:Panel>
                                         </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label7" AssociatedControlID="pnlPerms" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Permissions:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:Panel ID="pnlPerms" CssClass="cb-panel" runat="server">
                                            <div class="checkbox">
                                                <asp:Label ID="Label9" runat="server">
                                                    <asp:CheckBox ID="CentreAdminCheckBox" runat="server" Checked='<%# Bind("CentreAdmin") %>' />
                                                    Centre Administrator</asp:Label>
                                            </div>
                                            <div class="checkbox">
                                                <asp:Label ID="Label10" runat="server">
                                                    <asp:CheckBox ID="IsCentreManagerCheckBox" runat="server" Checked='<%# Bind("IsCentreManager") %>' />
                                                    Centre Manager</asp:Label>
                                            </div>
                                            <div class="checkbox">
                                                <asp:Label ID="Label11" runat="server">
                                                    <asp:CheckBox ID="ConfigAdminCheckBox" runat="server" Checked='<%# Bind("ConfigAdmin") %>' />
                                                    Super Administrator</asp:Label>
                                            </div>
                                            <div class="checkbox">
                                                <asp:Label ID="Label12" runat="server">
                                                    <asp:CheckBox ID="ImportOnlyCheckBox" runat="server" Checked='<%# Bind("ImportOnly") %>' />
                                                    Content Editor</asp:Label>
                                            </div>
                                            <div class="checkbox">
                                                <asp:Label ID="Label13" runat="server">
                                                    <asp:CheckBox ID="ContentManagerCheckBox" runat="server" Checked='<%# Bind("ContentManager") %>' />
                                                    Content Manager</asp:Label>
                                            </div>
                                            <div class="checkbox">
                                                <asp:Label ID="Label14" runat="server">
                                                   <asp:CheckBox ID="ContentCreatorCheckBox" runat="server" Checked='<%# Bind("ContentCreator") %>' />
                                                    Content Creator</asp:Label>
                                            </div>
                                            <div class="checkbox">
                                                <asp:Label ID="Label15" runat="server"><asp:CheckBox ID="PublishToAllCheckBox" runat="server" Checked='<%# Bind("PublishToAll") %>' /> CMS Publish to All Centres</asp:Label>
                                            </div>
                                            <div class="checkbox">
                                                <asp:Label ID="Label1" runat="server">
                                                   <asp:CheckBox ID="cbFrameworkDeveloper" runat="server" Checked='<%# Bind("IsFrameworkDeveloper") %>' />
                                                    Framework Developer</asp:Label>
                                            </div>
                                        </asp:Panel>
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                        <div class="card-footer clearfix">
                            <asp:LinkButton ID="UpdateCancelButton" CssClass="btn btn-outline-secondary mr-auto" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                            <asp:LinkButton ID="UpdateButton" runat="server" CssClass="btn btn-primary float-right" CausesValidation="True" CommandName="Update" Text="Update" />
                            
                        </div>
                    </div>
                   <%-- <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("SummaryReports") %>' />
                    <asp:HiddenField ID="HiddenField2" runat="server" Value='<%# Bind("UserAdmin") %>' />
                    <asp:HiddenField ID="HiddenField4" runat="server" Value='<%# Bind("PasswordReminder") %>' />      --%>
                </EditItemTemplate>

            </asp:FormView>
        </asp:View>
    </asp:MultiView>

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