<%@ Page Title="Centre Logins" Language="vb" AutoEventWireup="false" MasterPageFile="~/tracking/Site.Master" CodeBehind="centrelogins.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.centrelogins" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="breadtray" runat="server">
    <div class="row">
        <div class="col-md-6">
 <ol class="breadcrumb breadcrumb-slash">
        <li class="breadcrumb-item"><a href="dashboard">Centre </a></li>
        <li class="breadcrumb-item active">Administrators</li>
    </ol>
        </div>
         <asp:ObjectDataSource ID="dsContractDash" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.ContractUsageDashTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
                <asp:Repeater ID="rptContractDash" DataSourceID="dsContractDash" runat="server">
              <ItemTemplate>
        <div class="col-md-3">
        <ul class="list-group">
                      <div class="list-group-item list-group-item-info">
                        
                          
                          <i class="mr-1 fas fa-user-cog"></i>
                          Administrators<div class="float-right"><b><%# Eval("CentreAdmins") %></b></div>
                      </div>
                     <div class="list-group-item list-group-item-info">
                        
                          
                          <i class="mr-1 fas fa-id-card-alt"></i>
                          Supervisors<div class="float-right"><b><%# Eval("Supervisors") %></b></div>
                      </div>
                 
                      <li class="list-group-item list-group-item-<%#IIf(Eval("TrainersLimit") = -1, "info", IIf(Eval("Trainers") >= Eval("TrainersLimit"), "danger", IIf(Eval("Trainers") >= (Eval("TrainersLimit") / 2), "warning", "success"))) %>">
                        
                          
                          <i class="mr-1 fas fa-chalkboard-teacher"></i>
                          Trainers<div class="float-right"><b><%# Eval("Trainers") & IIf(Eval("TrainersLimit") = -1, "", "/" & Eval("TrainersLimit")) %></b></div>
                        
                      </li>
                
                      
                  </ul>  
           </div>
                  <div class="col-md-3">
                       <ul class="list-group">
 <li class="list-group-item list-group-item-<%#IIf(Eval("CMSAdministratorsLimit") = -1, "info", IIf(Eval("CMSAdmins") >= Eval("CMSAdministratorsLimit"), "danger", IIf(Eval("CMSAdmins") >= (Eval("CMSAdministratorsLimit") / 2), "warning", "success"))) %>">
                        
                          
                          <i class="mr-1 fas fa-cog"></i>
                          CMS Administrators
                            <div class="float-right"><b><%# Eval("CMSAdmins") & IIf(Eval("CMSAdministratorsLimit") = -1, "", "/" & Eval("CMSAdministratorsLimit")) %></b></div>
                      
                      </li>
                  
                      <li class="list-group-item list-group-item-<%#IIf(Eval("CMSManagersLimit") = -1, "info", IIf(Eval("CMSManagers") >= Eval("CMSManagersLimit"), "danger", IIf(Eval("CMSManagers") >= (Eval("CMSManagersLimit") / 2), "warning", "success"))) %>">
                        
                          
                          <i class="mr-1 fas fa-cogs"></i>
                          CMS Managers
                            <div class="float-right"><b><%# Eval("CMSManagers") & IIf(Eval("CMSManagersLimit") = -1, "", "/" & Eval("CMSManagersLimit")) %></b></div>
                   
                      </li>
                           <li class="list-group-item list-group-item-<%#IIf(Eval("CCLicencesLimit") = -1, "info", IIf(Eval("CCLicences") >= Eval("CCLicencesLimit"), "danger", IIf(Eval("CCLicences") >= (Eval("CCLicencesLimit") / 2), "warning", "success"))) %>">
                        
                          
                          <i class="mr-1 fas fa-pencil-ruler"></i>
                          Content Creators
                        <div class="float-right"><b><%# Eval("CCLicences") & IIf(Eval("CCLicencesLimit") = -1, "", "/" & Eval("CCLicencesLimit")) %></b></div>
                      </li>
                       </ul>
                      </div>
                  </ItemTemplate>
                    </asp:Repeater>
   </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ObjectDataSource ID="dsAdminUsers" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetByCentre" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.AdminUsersTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsCategories" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActiveForCentreWithAll" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.CourseCategoriesTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <%--    <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" ChildrenAsTriggers="true" runat="server"><ContentTemplate>--%>
    <asp:HiddenField ID="hfAdminUserID" ClientIDMode="Static" runat="server" />
    <dx:BootstrapGridView ID="bsgvAdminUsers" runat="server" Settings-GridLines="None" AutoGenerateColumns="False" DataSourceID="dsAdminUsers" KeyFieldName="AdminID">
        <SettingsBootstrap Striped="True" />
        <Settings ShowHeaderFilterButton="True" />
        <SettingsCookies Enabled="True" Version="0.121" />
        <SettingsPager PageSize="15">
        </SettingsPager>
        <Columns>
            <dx:BootstrapGridViewTextColumn Caption=" " Name="Edit" VisibleIndex="0">
                <DataItemTemplate>
                    <asp:LinkButton ToolTip="Edit User / Roles" EnableViewState="false" ID="lbtEditRoles" CommandArgument='<%#Eval("AdminID") %>' OnCommand="lbtEditRoles_Command" CssClass="btn btn-sm btn-primary" runat="server"><i class="fas fa-pencil-alt"></i></asp:LinkButton>
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="Forename" VisibleIndex="1">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="Surname" VisibleIndex="2">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="Email" VisibleIndex="3">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Roles" Name="Roles" VisibleIndex="4">
                <DataItemTemplate>
                    <table style="width: 100%; background: none; height: 28px;">
                        <tr>
                            <td style="width: 20%;">
                                <i aria-hidden="true" class="fas fa-user-tie" runat="server" title="Centre Manager" visible='<%#Eval("IsCentreManager") %>'></i>
                            </td>
                            <td style="width: 20%;">
                                <i aria-hidden="true" class="fas fa-cog" runat="server" title="CMS Admin" visible='<%#Eval("ContentManager") And Eval("ImportOnly") %>'></i>
                                <i aria-hidden="true" class="fas fa-cogs" runat="server" title="CMS Manager" visible='<%#Eval("ContentManager") And Not Eval("ImportOnly") %>'></i>
                            </td>

                            <td style="width: 20%;">
                                <i aria-hidden="true" class="fas fa-pencil-ruler" runat="server" title="Content Creator" visible='<%#Eval("ContentCreator") %>'></i>
                            </td>
                            <td style="width: 20%;">
                                <i aria-hidden="true" class="fas fa-id-card-alt" runat="server" title="Supervisor" visible='<%#Eval("Supervisor") %>'></i>
                            </td>
                            <td style="width: 20%;">
                                <i aria-hidden="true" class="fas fa-chalkboard-teacher" runat="server" title="Trainer" visible='<%#Eval("Trainer") %>'></i>
                            </td>
                        </tr>
                    </table>
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewComboBoxColumn FieldName="CategoryID" Caption="Course Cat" VisibleIndex="5">

                <PropertiesComboBox DataSourceID="dsCategories" NullText="All" TextField="CategoryName" ValueField="CourseCategoryID">
                </PropertiesComboBox>

            </dx:BootstrapGridViewComboBoxColumn>
            <dx:BootstrapGridViewTextColumn Name="Approved" Caption="Approved" VisibleIndex="6" FieldName="Approved">
                <DataItemTemplate>
                    <asp:LinkButton EnableViewState="false" ID="lbtToggle" ToolTip="Click to toggle approval status" CssClass='<%# IIf(Eval("Approved"), "btn btn-success", "btn btn-warning")%>' OnCommand="btnToggle_Click" CommandArgument='<%#  Eval("AdminID")%>' runat="server"><i aria-hidden="true" class='<%# IIf(Eval("Approved"), "far fa-check-square", "far fa-square")%>'></i></asp:LinkButton>
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn HorizontalAlign="Left" Caption="Locked" FieldName="FailedLoginCount" Name="Locked" VisibleIndex="7">
                <DataItemTemplate>
                    <asp:LinkButton ID="lbtUnlock" ToolTip="Click to unlock" OnCommand="Unlock_Click" CommandArgument='<%#  Eval("AdminID")%>' Visible='<%#  Eval("FailedLoginCount") >= 5 %>' EnableViewState="false" CssClass="btn btn-primary" runat="server"><i aria-hidden="true" class="fas fa-unlock-alt"></i></asp:LinkButton>
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Name="Inactivate" VisibleIndex="8">
                <Settings AllowHeaderFilter="False" />
                <DataItemTemplate>
                    <asp:LinkButton EnableViewState="false" ID="lbtInactivateUser" Visible='<%# Eval("Active") %>' OnClientClick="return confirm('Are you sure that you wish to Inactivate / Delete this admin account? If the user has never logged in, their account will be deleted. If they have, it will be inactivated.');" CssClass="btn btn-danger btn-sm" ToolTip="Inactivate / Delete Admin Account" OnCommand="InactivateUser_Click" CommandArgument='<%# Eval("AdminID") %>' runat="server"><i aria-hidden="true" class="fas fa-times"></i></asp:LinkButton>
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>

        </Columns>
        <SettingsSearchPanel Visible="True" AllowTextInputTimer="false" />
    </dx:BootstrapGridView>
    <%--        </ContentTemplate>
        
    </asp:UpdatePanel>--%>
    <!-- Modal -->
    <div class="modal fade" id="editUserModal" tabindex="-1" role="dialog" aria-labelledby="editUserModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editUserModalLabel">Edit Administrator Roles</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group row">
                        <asp:Label ID="lblAdminEmail" AssociatedControlID="tbAdminUser" runat="server" CssClass="col col-sm-4 control-label">AdminUser:</asp:Label>
                        <div class="col col-sm-8">
                            <asp:HiddenField ID="hfAdminID" runat="server" />
                            <asp:TextBox ID="tbAdminUser" Enabled="false" CssClass="form-control" runat="server" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <asp:Label ID="Label6" AssociatedControlID="cbCentreAdmin" runat="server" CssClass="col col-sm-4 control-label">Centre Admin:</asp:Label>
                        <div class="col col-sm-8">
                            <asp:CheckBox ID="cbCentreAdmin" CssClass="checkbox" runat="server" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <asp:Label ID="Label4" AssociatedControlID="cbSupervisor" runat="server" CssClass="col col-sm-4 control-label">Supervisor:</asp:Label>
                        <div class="col col-sm-8">
                            <asp:CheckBox ID="cbSupervisor" CssClass="checkbox" runat="server" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <asp:Label ID="Label5" AssociatedControlID="cbTrainer" runat="server" CssClass="col col-sm-4 control-label">Trainer:</asp:Label>
                        <div class="col col-sm-8">
                            <asp:CheckBox ID="cbTrainer" CssClass="checkbox" runat="server" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <asp:Label ID="Label1" AssociatedControlID="ddCategory" runat="server" CssClass="col col-sm-4 control-label">Learning Category:</asp:Label>
                        <div class="col col-sm-8">
                            <asp:DropDownList ID="ddCategory" DataSourceID="dsCategories" DataTextField="CategoryName" DataValueField="CourseCategoryID" CssClass="form-control" runat="server"></asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group row">
                        <asp:Label ID="Label2" AssociatedControlID="ddCMSRole" runat="server" CssClass="col col-sm-4 control-label">CMS Roles:</asp:Label>
                        <div class="col col-sm-8">
                            <asp:DropDownList ID="ddCMSRole" CssClass="form-control" runat="server">
                                <asp:ListItem Text="None" Value="0">
                                </asp:ListItem>
                                <asp:ListItem Text="Administrator" Value="1">
                                </asp:ListItem>
                                <asp:ListItem Text="Manager" Value="2">
                                </asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group row">
                        <asp:Label ID="Label3" AssociatedControlID="cbCCLicence" runat="server" CssClass="col col-sm-4 control-label">Content Creator Licence:</asp:Label>
                        <div class="col col-sm-8">
                            <asp:CheckBox ID="cbCCLicence" CssClass="checkbox" runat="server" />
                        </div>
                    </div>
                    

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary mr-auto float-left" data-dismiss="modal">Close</button>
                    <asp:LinkButton ID="lbtAdminEditSubmit" CssClass="btn btn-primary float-right" runat="server">Submit</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
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
