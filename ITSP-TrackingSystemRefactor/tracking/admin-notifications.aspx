<%@ Page Title="Admin - Notifications" Language="vb" AutoEventWireup="false" MasterPageFile="~/tracking/Site.Master" CodeBehind="admin-notifications.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.admin_notifications" %>

<%@ Register Assembly="DevExpress.Web.ASPxHtmlEditor.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxHtmlEditor" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<asp:Content ID="Content1" ContentPlaceHolderID="breadtray" runat="server">
    <h1>Notifications</h1>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col col-lg-12">
             <div class="card card-default mb-2">
                <div class="card-header">
                    <h4>System Push Notifications</h4>
                </div>
                 <div class="card-body">
                 <asp:CheckBox ID="cbIncExpired" cssclass="checkbox float-right" Text="Include expired?" AutoPostBack="true" runat="server" />
                     <asp:ObjectDataSource ID="dsRoles" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetAdminRoles" TypeName="ITSP_TrackingSystemRefactor.NotificationsTableAdapters.UserRolesTableAdapter"></asp:ObjectDataSource>
                 <asp:ObjectDataSource ID="dsSANotifications" runat="server" DeleteMethod="Delete" InsertMethod="InsertSANotification" OldValuesParameterFormatString="original_{0}" SelectMethod="GetFiltered" TypeName="ITSP_TrackingSystemRefactor.NotificationsTableAdapters.SANotificationsTableAdapter" UpdateMethod="UpdateQuery">
                     <DeleteParameters>
                         <asp:Parameter Name="Original_SANotificationID" Type="Int32" />
                     </DeleteParameters>
                     <InsertParameters>
                         <asp:Parameter Name="SubjectLine" Type="String" />
                         <asp:Parameter Name="BodyHTML" Type="String" />
                         <asp:Parameter Name="ExpiryDate" Type="DateTime" />
                         <asp:Parameter Name="TargetUserRoleID" Type="Int32" />
                     </InsertParameters>
                     <SelectParameters>
                         <asp:ControlParameter ControlID="cbIncExpired" Name="IncExpired" Type="Boolean" />
                     </SelectParameters>
                     <UpdateParameters>
                         <asp:Parameter Name="SubjectLine" Type="String" />
                         <asp:Parameter Name="BodyHTML" Type="String" />
                         <asp:Parameter Name="ExpiryDate" Type="DateTime" />
                         <asp:Parameter Name="Original_SANotificationID" Type="Int32" />
                     </UpdateParameters>
                 </asp:ObjectDataSource>
                 </div>
            <dx:BootstrapGridView ID="bsgvSANotifications" EnableCallBacks="false" runat="server" AutoGenerateColumns="False" DataSourceID="dsSANotifications" KeyFieldName="SANotificationID" EnableCallbackAnimation="True" SettingsBootstrap-Striped="True" SettingsCookies-Enabled="True" SettingsCommandButton-EditButton-IconCssClass="icon-pencil">

                        <SettingsCommandButton UpdateButton-CssClass="btn btn-primary float-right" UpdateButton-RenderMode="Button" CancelButton-CssClass="btn btn-outline-secondary" UpdateButton-Text="Submit" UpdateButton-IconCssClass="icon-checkmark" CancelButton-IconCssClass="icon-close" CancelButton-RenderMode="Button" NewButton-IconCssClass="icon-plus" NewButton-CssClass="btn btn-primary" NewButton-RenderMode="Button" EditButton-CssClass="btn btn-outline-secondary" EditButton-RenderMode="button" EditButton-Text=" ">
<NewButton IconCssClass="fas fa-plus" CssClass="btn btn-primary" ButtonType="Button" RenderMode="Button"></NewButton>

<UpdateButton IconCssClass="fas fa-check" CssClass="btn btn-primary float-right" ButtonType="Button" RenderMode="Button" Text="Submit"></UpdateButton>

<CancelButton IconCssClass="fas fa-times" CssClass="btn btn-outline-secondary" ButtonType="Button" RenderMode="Button"></CancelButton>

<EditButton IconCssClass="fas fa-pencil-alt" CssClass="btn btn-outline-secondary" ButtonType="Button" RenderMode="Button" Text=" "></EditButton>
                        </SettingsCommandButton>
                        <SettingsCookies Enabled="True" />
                        <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />
                        <SettingsBootstrap Striped="True" />
                        <Settings ShowHeaderFilterButton="True" />
                        <Columns>
                            <dx:BootstrapGridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0"></dx:BootstrapGridViewCommandColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="SubjectLine" VisibleIndex="1" SettingsEditForm-ColumnSpan="12">
                                <Settings AllowHeaderFilter="False" />
                                <SettingsEditForm ColumnSpan="12" />
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="BodyHTML" VisibleIndex="2" SettingsEditForm-ColumnSpan="12">
                                <Settings AllowHeaderFilter="False" />
                                <SettingsEditForm ColumnSpan="12" />
                                <DataItemTemplate>
                                    <asp:Literal ID="Literal1" runat="server" Text='<%# Eval("BodyHTML")%>'></asp:Literal>
                                </DataItemTemplate>
                                <EditItemTemplate>
                                    <dx:ASPxHtmlEditor ID="ASPxHtmlEditor1" runat="server" Html='<%# Bind("BodyHTML")%>' Width="100%"></dx:ASPxHtmlEditor>
                                </EditItemTemplate>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewDateColumn FieldName="DateAdded" ReadOnly="True" VisibleIndex="4">
                                <SettingsEditForm Visible="False" />
                            </dx:BootstrapGridViewDateColumn>
                            <dx:BootstrapGridViewDateColumn FieldName="ExpiryDate" VisibleIndex="5" SettingsEditForm-ColumnSpan="12" Caption="Expiry Date" Name="Expiry Date">
                                <SettingsEditForm ColumnSpan="12" />
                            </dx:BootstrapGridViewDateColumn>
                           
                            <dx:BootstrapGridViewComboBoxColumn Caption="Target Role" FieldName="TargetUserRoleID" VisibleIndex="3">
                                <PropertiesComboBox  DataSourceID="dsRoles" TextField="Role" ValueField="RoleID">
                                </PropertiesComboBox>
                            </dx:BootstrapGridViewComboBoxColumn>
                            
                        </Columns>
                        <SettingsSearchPanel Visible="True" AllowTextInputTimer="false" />
                    </dx:BootstrapGridView>
        </div></div>
 <div class="col col-lg-12">
     <div class="card card-default">
                <div class="card-header">
                    <h4>One-off Digital Learning Solutions Server E-mail</h4>
                </div>
                <div class="card-body">
                    <div class="alert alert-info">
                        <p>Use this panel to send a test e-mail to an e-mail address (to aid investigation of e-mail failures, for example).</p>
                    </div>
                    <div class="form m-3">
                        <div class="form-group row">
                            <asp:Label CssClass="col col-sm-3 control-label" ID="Label1" AssociatedControlID="tbTo" runat="server" Text="To:"></asp:Label>
                            <div class="col col-sm-9">
                                <asp:TextBox ID="tbTo" CssClass="form-control" placeholder="Enter one valid e-mail address" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator Display="dynamic" ID="RequiredFieldValidator4" ValidationGroup="vgSendMail" ControlToValidate="tbTo" runat="server" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator1" Display="Dynamic"
                                                            ValidationGroup="vgSendMail" ControlToValidate="tbTo" ValidationExpression="[a-za-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-za-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-za-zA-Z0-9](?:[a-za-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-za-zA-Z0-9](?:[a-za-zA-Z0-9-]*[a-za-zA-Z0-9])?"
                                                            ErrorMessage="A valid email address must be provided" SetFocusOnError="true" />
                            </div>
                        </div>
                         <div class="form-group row">
                            <asp:Label CssClass="col col-sm-3 control-label" ID="Label2" AssociatedControlID="tbCC" runat="server" Text="CC:"></asp:Label>
                            <div class="col col-sm-9">
                                <asp:TextBox ID="tbCC" CssClass="form-control" placeholder="Optionally enter one valid e-mail address" runat="server"></asp:TextBox>
                                <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator2" Display="Dynamic"
                                                            ValidationGroup="vgSendMail" ControlToValidate="tbCC" ValidationExpression="[a-za-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-za-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-za-zA-Z0-9](?:[a-za-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-za-zA-Z0-9](?:[a-za-zA-Z0-9-]*[a-za-zA-Z0-9])?"
                                                            ErrorMessage="A valid email address must be provided" SetFocusOnError="true" />
                                    </div>
                        </div>
                        <div class="form-group row">
                            <asp:Label CssClass="col col-sm-3 control-label" ID="Label3" AssociatedControlID="tbSubject" runat="server" Text="Subject:"></asp:Label>
                            <div class="col col-sm-9">
                                <asp:TextBox ID="tbSubject" CssClass="form-control" Text="Digital Learning Solutions Server E-mail Test" runat="server"></asp:TextBox>
                                 <asp:RequiredFieldValidator Display="dynamic" ID="RequiredFieldValidator5" ValidationGroup="vgSendMail" ControlToValidate="tbSubject" runat="server" ErrorMessage="Required"></asp:RequiredFieldValidator>
                            
                                    </div>
                        </div>
                        <div class="form-group row">
                            <asp:Label CssClass="col col-sm-3 control-label" ID="Label4" AssociatedControlID="tbBody" runat="server" Text="Body:"></asp:Label>
                            <div class="col col-sm-9">
                                   <asp:TextBox ID="tbBody" TextMode="MultiLine" Height="100px" CssClass="form-control" Text="This is a test e-mail sent from the Digital Learning Solutions e-mail account." runat="server"></asp:TextBox>
                                  <asp:RequiredFieldValidator Display="dynamic" ID="RequiredFieldValidator6" ValidationGroup="vgSendMail" ControlToValidate="tbBody" runat="server" ErrorMessage="Required"></asp:RequiredFieldValidator>
                            
                                    </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer clearfix">
                    <asp:LinkButton ID="lbtSendEmail" CssClass="btn btn-primary float-right" CausesValidation="true" ValidationGroup="vgSendMail" runat="server"><i aria-hidden="true" class="fas fa-envelope"></i> Send</asp:LinkButton>
                </div>
            </div>
                </div>
            </div>
    <!-- Modal message-->
    <div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                   
                    <h5 class="modal-title" id="myModalLabel">
                        <asp:Label ID="lblModalHeading" runat="server" Text=""></asp:Label></h5> <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
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
