<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="GoogleReCaptcha" Namespace="GoogleReCaptcha" TagPrefix="cc1" %>
<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="usermxmodals.ascx.vb" Inherits="ITSP_TrackingSystemRefactor.usermxmodals" %>
<script>
         function binaryImageUploaded(s, e) {
    e.processOnServer = true;
    e.usePostBack = true;
}
   
        function onChangePWValidation(s, e) {
            var confirmpw = e.value;
            var pw = $('#bstbNewPassword1_I').val();
            if (confirmpw !== pw && pw.length > 0) {
                e.isValid = false;
                e.errorText = "Password must match";
            }
        }
 function onChangeAdminPWValidation(s, e) {
            var confirmpw = e.value;
            var pw = $('#bstbNewPassword_I').val();
            if (confirmpw !== pw && pw.length > 0) {
                e.isValid = false;
                e.errorText = "Password must match";
            }
    }
   
    </script>

<asp:Panel CssClass="modal modal-primary" ID="pnlAccount" ClientIDMode="Static" TabIndex="-1" role="dialog" aria-labelledby="lblLoginHeader" runat="server">
    <div class="modal-dialog animated zoomIn animated-3x" role="document">
        <div class="modal-content">
            <div class="modal-header d-block shadow-2dp no-pb">
                <button type="button" class="close d-inline float-right mt-2" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">
                        <i class="fas fa-close"></i>
                    </span>
                </button>

                <div class="modal-title text-center">
                    <span class="ms-logo mr-1">
                        <img runat="server" src="~/Images/DLS-Logo-Colour-sm.png" height="42" width="42" /></span>
                    <h4 class="no-m ms-site-title">
                        <asp:Label ID="lblLoginHeader" ClientIDMode="Static" runat="server" Text="Digital Learning Solutions"></asp:Label>
                    </h4>
                </div>
                <div class="modal-header-tabs">
                    <ul class="nav nav-tabs nav-tabs-full nav-tabs-3 nav-tabs-primary" role="tablist">
                        <li class="nav-item" role="presentation">
                            <a href="#ms-login-tab" aria-controls="ms-login-tab" role="tab" data-toggle="tab" class="nav-link active withoutripple">
                                <i class="fas fa-user"></i>Login</a>
                        </li>
                        <li class="nav-item" role="presentation">
                            <asp:LinkButton ID="lbtRegLink" CssClass="nav-link withoutripple" runat="server"><i class="fas fa-user-plus"></i>Register</asp:LinkButton>
                            
                        </li>
                        <li class="nav-item" role="presentation">
                            <a href="#ms-recovery-tab" id="recoverLink" aria-controls="ms-recovery-tab" role="tab" data-toggle="tab" class="nav-link withoutripple">
                                <i class="fas fa-key"></i>Recover</a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="modal-body">
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="ms-login-tab">
                        <asp:LinkButton ID="lbtSignIn" ToolTip="Got an nhs.net email address? Sign in here." runat="server">
<%--<svg width="323.33" height="59" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" xmlns:se="http://svg-edit.googlecode.com">
 <defs>
  <style>.cls-1{fill:#003087;}.cls-2{fill:#005eb8;}.cls-3{fill:#fff;}.fnt0 {
                    font-size: 20px;
                    font-family: 'Segoe UI Semibold', 'Segoe UI';
                    text-decoration: none;
                }</style>
 </defs>
 <title>SignInWith_Original</title>
 <g class="layer">
  <title>Layer 1</title>
  <g data-name="Layer 1" id="Layer_1-2">
   <rect class="cls-1" height="55" id="svg_1" rx="4" width="323.33" y="4"/>
   <rect class="cls-2" height="55" id="svg_2" rx="4" width="323.33"/>
   <rect class="cls-2" fill="black" height="51" id="svg_3" width="319.22" x="2.1" y="2"/>
   <polygon class="cls-2" id="svg_23" points="18.54 14.54 18.54 40.46 84.42 40.46 84.42 14.54 18.54 14.54 18.54 14.54"/>
   <path class="cls-3" d="m85.05,41l0,-27l-67.05,0l0,27l67.05,0zm-40.05,-24.39l-4.67,21.73l-7.26,0l-4.57,-15l-0.06,0l-3,15l-5.55,0l4.67,-21.73l7.28,0l4.48,15.07l0.06,0l3.07,-15.07l5.55,0zm20.77,0l-4.57,21.73l-5.85,0l1.94,-9.34l-6.92,0l-1.94,9.31l-5.85,0l4.54,-21.73l5.88,0l-1.72,8.31l6.91,0l1.72,-8.31l5.86,0.03zm16.81,0.59l-1.41,4.33a11,11 0 0 0 -4.82,-1c-2.31,0 -4.19,0.34 -4.19,2.09c0,3.08 8.48,1.93 8.48,8.53c0,6 -5.6,7.56 -10.67,7.56a24.58,24.58 0 0 1 -6.76,-1.12l1.38,-4.42a11.37,11.37 0 0 0 5.38,1.25c1.81,0 4.66,-0.35 4.66,-2.59c0,-3.49 -8.48,-2.18 -8.48,-8.31c0,-5.61 4.94,-7.29 9.73,-7.29a17.91,17.91 0 0 1 6.7,1l0,-0.03z" id="svg_24"/>
   <text fill="#ffffff" class="fnt0" id="svg_29" stroke-width="0" text-anchor="middle" x="200.298372" xml:space="preserve" y="34.366667">Sign in with NHSmail</text>
  </g>
 </g>
</svg>--%>
                            <svg xmlns="http://www.w3.org/2000/svg" xml:space="preserve" width="300px" height="50px" viewBox="0 0 3278 522" class="SignInButton">
            <style type="text/css">
                .fil0:hover {
                    fill: #4B4B4B;
                }

                .fnt0 {
                    font-size: 260px;
                    font-family: 'Segoe UI Semibold', 'Segoe UI';
                    text-decoration: none;
                }
</style>
            <rect class="fil0" x="2" y="2" width="3174" height="517" fill="black" />
            <rect x="150" y="129" width="122" height="122" fill="#F35325" />
            <rect x="284" y="129" width="122" height="122" fill="#81BC06" />
            <rect x="150" y="263" width="122" height="122" fill="#05A6F0" />
            <rect x="284" y="263" width="122" height="122" fill="#FFBA08" />
            <text x="470" y="357" fill="white" class="fnt0">Sign in with Microsoft</text>
        </svg>
                        </asp:LinkButton>
                        <fieldset>
                            <div class="form-group label-floating">
                                
                                <div class="input-group">
                                        <span class="input-group-addon">
                                            <i class="fas fa-user"></i>
                                        </span>
<asp:Label ID="lblUserName" CssClass="control-label" AssociatedControlID="bstbUserName" runat="server">Email / User ID</asp:Label>
                                        <dx:BootstrapTextBox ID="bstbUserName" runat="server">
                                            <ValidationSettings ValidationGroup="vgLogin">
                                                <RequiredField IsRequired="true" ErrorText="Required" />
                                            </ValidationSettings>
                                        </dx:BootstrapTextBox>
                                    </div>
                            </div>
                            <div class="form-group label-floating">
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fas fa-lock"></i>
                                    </span>
                                    <asp:Label ID="Label1" runat="server" CssClass="control-label" AssociatedControlID="bstbUserPassword" Text="Password"></asp:Label>
                                   
                                    <dx:BootstrapTextBox ClientIDMode="Static" ID="bstbUserPassword" AutoCompleteType="Disabled" runat="server" Password="True">
                                            <ValidationSettings ValidationGroup="vgLogin">
                                                <RequiredField IsRequired="true" ErrorText="Required" />
                                            </ValidationSettings>
                                        </dx:BootstrapTextBox>
                                </div>
                            </div>
                            <%--<div class="form-group">
                                <div class="ml-5">
                            <asp:Label ID="Label4" CssClass="sr-only" runat="server" AssociatedControlID="ctrlGoogleReCaptcha">Solve Captcha:</asp:Label>
                                <cc1:GoogleReCaptcha ID="ctrlGoogleReCaptcha" runat="server" PublicKey="6LdAWpcUAAAAAELGuBQlrXR4_pyNEOXc1XuqZoiB" PrivateKey="6LdAWpcUAAAAAEyyLxiI3zDF46b1_9OoE_7IOMrQ" />
                                <asp:Label ID="lblCaptchaError" CssClass="bg-danger" Visible="false" runat="server" Text="Label"></asp:Label>
                                   </div>
                            </div>--%>
                           <div class="row mt-2">
                        <div class="col-md-6">
                          <div class="form-group no-mt">
                            <div class="checkbox">
                              <label>
                                  <asp:CheckBox ID="cbRememberMe" runat="server" /> Remember Me </label>
                            </div>
                          </div>
                        </div>
                        <div class="col-md-6">
                            <dx:BootstrapButton ID="bsbtnLogin" runat="server" SettingsBootstrap-RenderOption="Primary" CssClasses-Control="btn btn-raised btn-primary float-right" Text="Sign in" type="submit" >
                           <ClientSideEvents Click="function(s, e) { e.processOnServer = ASPxClientEdit.ValidateGroup('vgLogin'); }" />
                            </dx:BootstrapButton>
  <asp:Panel ID="pnlErrorPW" CssClass="alert alert-danger text-center" Visible="false" runat="server">
                                        <asp:Label ID="lblErrorPW" runat="server" Text=""></asp:Label>
                                    </asp:Panel>
                        </div>
                      </div>
                            
                            
                        </fieldset><div class="alert alert-info small small">
                             
                             By logging in, I consent to my details being stored and processed in line with your <a style="cursor: pointer;text-decoration:underline;"  data-toggle="modal" data-target="#privacyMessage">Privacy Notice</a> and agree to use the system according to the <a style="cursor: pointer;text-decoration:underline;" data-toggle="modal" data-target="#termsMessage">Terms of Use</a>.
                        </div>
                        <div class="text-center">
                            <div class="row">
                                <div class="col-sm-6">
<h6>Not yet registered?</h6>
                            <asp:LinkButton ID="lbtRegLink2" CausesValidation="false" CssClass="wave-effect-light btn btn-raised  btn-default" runat="server"><i class="fas fa-user-plus"></i>Register</asp:LinkButton>
                                </div>
                                <div class="col-sm-6">
<h6>Forgotten password?</h6>
                            <a href="home?action=reset" id="recoverLink2" class="wave-effect-light btn btn-raised  btn-default">
                                <i class="fas fa-key"></i>Recover</a>
                                </div>
                            </div>
                                        
                                    </div>
                    </div>
                    
                    <div role="tabpanel" class="tab-pane" id="ms-recovery-tab">
                        
                        <fieldset>

                            <div class="form-group label-floating">
                                <div class="input-group">
                                    <span class="input-group-addon">
                                        <i class="fas fa-envelope"></i>
                                    </span>
                                    <asp:Label ID="lblResetEmail" CssClass="control-label" AssociatedControlID="bstbResetEmail" runat="server">E-mail</asp:Label>
                                    <dx:BootstrapTextBox ID="bstbResetEmail" runat="server">
                                        <ValidationSettings ValidationGroup="vgRecover">
                                                <RequiredField IsRequired="true" ErrorText="E-mail is required" />
                                                <RegularExpression ErrorText="Invalid e-mail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                            </ValidationSettings>
                                    </dx:BootstrapTextBox>
                                    
                                </div>
                                <dx:BootstrapButton ID="bsbtnResetPW" runat="server" SettingsBootstrap-RenderOption="Primary" CssClasses-Control="btn btn-raised btn-block btn-primary" Text="Reset" type="submit" >
                                <ClientSideEvents Click="function(s, e) { e.processOnServer = ASPxClientEdit.ValidateGroup('vgRecover'); }" />
                            </dx:BootstrapButton>
                            </div>
                        </fieldset>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Panel>
<asp:Panel CssClass="modal modal-primary" ID="pnlAppSelect" ClientIDMode="Static" role="dialog" aria-labelledby="lblAppSelect" runat="server">
    <div class="modal-dialog modal-lg animated zoomIn animated-3x" role="document">
        <div class="modal-content">
            <div class="modal-header d-block shadow-2dp no-pb">
                <button type="button" class="close d-inline float-right mt-2 text-black" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">
                        <i class="fas fa-close"></i>
                    </span>
                </button>

                <div class="modal-title">
                    <span class="ms-logo mr-1">
                        <img runat="server" src="~/Images/DLS-Logo-Colour-sm.png" height="42" width="42" /></span>
                    <h3 id="lblAppSelect" class="no-m ms-site-title">Application Selector
                    </h3>
                </div>
            </div>
            <div class="modal-body">
                
                <div class="row">
                    <div class="col-8">
                        <div class="row">
                            <asp:Panel ID="pnlLP" CssClass="col-md-6" runat="server">
                                <a runat="server" id="lnkLearningPortal" href="#">
                                    <div class="card ms-feature card-dls-squares mb-3">
                                        <div class="img-hover"></div>
                                                  <div class="text-center umx-card card-header">
              <i class="fas fa-book-reader fa-4x mb-3"></i>
              <div class="h6 text-white">Learning Portal</div>
             
            </div>
                                              </div></a>
                            </asp:Panel>

                            <asp:Panel ID="pnlTracking" CssClass="col-md-6" runat="server">
                                <asp:LinkButton ID="lbtTrackingSystem" PostBackUrl="~/tracking/dashboard" runat="server">
                                              <div class="card ms-feature card-itsp-purple mb-3"><div class="img-hover"></div>
                                                  <div class="text-center umx-card card-header">
              <i class="fas fa-chart-line fa-4x mb-3"></i>
              <div class="h6 text-white">Tracking System</div>
             
            </div>
                                              </div>
                                </asp:LinkButton>
                            </asp:Panel>
                            <asp:Panel ID="pnlSupervise" CssClass="col-md-6" runat="server">
                                <asp:LinkButton ID="LinkButton1" PostBackUrl="~/tracking/supervise" runat="server">
                                              <div class="card ms-feature card-itsp-purple mb-3"><div class="img-hover"></div>
                                                  <div class="text-center umx-card card-header">
              <i class="fas fa-id-card-alt fa-4x mb-3"></i>
              <div class="h6 text-white">Supervise</div>
             
            </div>
                                              </div>
                                </asp:LinkButton>
                            </asp:Panel>
                            <asp:Panel ID="pnlCMS" CssClass="col-md-6" runat="server">

                                <asp:LinkButton ID="lbtCMS" PostBackUrl="~/cms/courses" runat="server">
                                    <div class="card ms-feature card-itsp-pink mb-3"><div class="img-hover"></div>
                                                  <div class="text-center umx-card card-header">
              <i class="fas fa-th-list fa-4x mb-3"></i>
              <div class="h6 text-white">CMS</div>
             
            </div>
                                              </div></asp:LinkButton>
                            </asp:Panel>
                            <asp:Panel ID="pnlCC" CssClass="col-md-6" runat="server">
                                <asp:LinkButton ID="lbtCC" PostBackUrl="~/cms/contentcreator" runat="server">
                                    <div class="card ms-feature card-itsp-green mb-3"><div class="img-hover"></div>
                                                  <div class="text-center umx-card card-header">
              <i class="fas fa-pencil-ruler fa-4x mb-3"></i>
              <div class="h6 text-white">Content Creator</div>
             
            </div>
                                              </div></asp:LinkButton>
                            </asp:Panel>
                            <asp:Panel ID="pnlWebSite" CssClass="col-md-6" runat="server">
                                <asp:LinkButton ID="lbtDLSWebSite" PostBackUrl="~/Home" runat="server">
                                              <div class="card ms-feature card-itsp-blue mb-3"><div class="img-hover"></div>
                                                  <div class="text-center umx-card card-header">
              <i class="fas fa-globe fa-4x mb-3"></i>
              <div class="h6 text-white">Web Site</div>
             
            </div>
                                              </div>
                                </asp:LinkButton>
                            </asp:Panel>

                        </div>
                    </div>
                    <div class="col-4">
                        
                        <asp:LinkButton ID="lbtMxAdminAccount" CssClass="btn btn-primary btn-raised btn-block mb-2" runat="server"><i class="fas fa-user-cog"></i> My Admin Details</asp:LinkButton>
                        <asp:LinkButton ID="lbtMxLearningAccount" CssClass="btn btn-primary btn-raised btn-block mb-2" runat="server"><i class="fas fa-user-cog"></i> My Delegate Details</asp:LinkButton>
                        <asp:LinkButton ID="lbtLogout" CssClass="btn btn-danger btn-raised btn-block mb-2" runat="server"><i class="fas fa-sign-out-alt"></i> Sign Out</asp:LinkButton>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <div class="card mb-2">
                            <div class="card-body">

                                <div class="card-text">Centre: <b class="mr-1"><%= Session("UserCentreName") %></b><asp:label ID="lblAdm" runat="server">
                                    User: <b class="mr-1"><%= Session("UserEmail") %></b>
                                </asp:label>
<asp:Label ID="lblDel" runat="server">
                                   Delegate ID: <b class="mr-1"><%= Session("learnCandidateNumber") %></b>
                                </asp:Label>
                                </div>
                                
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Panel>
<dx:BootstrapPopupControl ID="bspAdminDetails" PopupHorizontalAlign="Center" PopupVerticalAlign="Middle"  ShowFooter="true" ShowCloseButton="True" CloseAction="CloseButton" Modal="True" ShowOnPageLoad="false" HeaderText="<h5>Manage Admin User Details</h5>" EncodeHtml="false" PopupElementCssSelector=".delegate-details" runat="server">
    <SettingsAdaptivity Mode="Always" MaxWidth="1024" SwitchAtWindowInnerWidth="1024" VerticalAlign="WindowCenter"
        FixedHeader="true" FixedFooter="true" />
                      
    <ContentCollection>
        <dx:ContentControl>
            <div id="admindetails" class="m-3">
                            
                            <div class="form-group row">
                                <asp:Label ID="Label2" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="bstbFName">First name:</asp:Label>
                                <div class="col col-sm-8">
                                    <dx:BootstrapTextBox ID="bstbFName" MaxLength="250" runat="server">
                            <ValidationSettings ValidationGroup="vgUpdateAdminDetails">
                                <RequiredField IsRequired="true" ErrorText="Required" />
                            </ValidationSettings>
                        </dx:BootstrapTextBox>
                                  
                                </div>
                            </div>
                            <div class="form-group row">
                                <asp:Label ID="Label3" CssClass="control-label col-sm-4" runat="server" AssociatedControlID="bstbLName">Last name:</asp:Label>
                                <div class="col col-sm-8">
                                    <dx:BootstrapTextBox ID="bstbLName" runat="server">
                                          <ValidationSettings ValidationGroup="vgUpdateAdminDetails">
                                <RequiredField IsRequired="true" ErrorText="Required" />
                            </ValidationSettings>
                                    </dx:BootstrapTextBox>
                                </div>
                            </div>
                            <div class="form-group row">
                                <asp:Label ID="Label5" CssClass="control-label col-sm-4" runat="server" AssociatedControlID="bstbEmail">Email address:</asp:Label>
                                <div class="col col-sm-8">
                                    <dx:BootstrapTextBox ID="bstbEmail" runat="server">
                                        <ValidationSettings ValidationGroup="vgUpdateAdminDetails">
                                            <RegularExpression ErrorText="Invalid e-mail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                <RequiredField IsRequired="true" ErrorText="Required" />
                            </ValidationSettings>
                                    </dx:BootstrapTextBox>
                                    
                                </div>
                            </div>

                            <div class="form-group row">
                                <asp:Label ID="Label11" CssClass="control-label col-sm-4" runat="server" AssociatedControlID="bsimgProfileImage">Profile Image (optional):</asp:Label>
                                <div class="col col-sm-8">
                                    <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
                                        <ContentTemplate>--%>
   <dx:BootstrapBinaryImage ID="bsimgProfileImage"  ClientSideEvents-ValueChanged="binaryImageUploaded" EditingSettings-Enabled="true"  runat="server" Height="150" EmptyImage-Url="~/Images/avatar.png"></dx:BootstrapBinaryImage>                                   
                                   
                                               
                                              <%--</ContentTemplate>
                                    </asp:UpdatePanel>--%>
                                  
                                </div>
                            </div>
                            <div class="form-group row">
                                <asp:Label ID="Label10" CssClass="control-label col-sm-4" AssociatedControlID="rptNotifications" runat="server">Notification Preferences</asp:Label>
<div class="col col-sm-6">
    <a class="btn btn-raised btn-info" role="button" data-toggle="collapse" href="#collapseManageNotifications" aria-expanded="false" aria-controls="collapseManageNotifications"><i aria-hidden="true" class="fas fa-cogs"></i> Manage
                                    </a>
</div>
                            </div>
                            <div class="collapse mb-1" id="collapseManageNotifications">
                            <div class="card card-default">
                                <div class="card-header">Manage e-mail notification preferences</div>
                                <asp:ObjectDataSource ID="dsUserNotifications" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByAdminUser" TypeName="ITSP_TrackingSystemRefactor.NotificationsTableAdapters.NotificationsTableAdapter">
            <SelectParameters>
                <asp:SessionParameter Name="AdminUserID" SessionField="UserAdminID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
                                <ul class="list-group">
                                <asp:Repeater ID="rptNotifications" DataSourceID="dsUserNotifications" runat="server">
            <ItemTemplate>
                   <li class="list-group-item clearfix">
                       <asp:Label ID="lblNotificationName" runat="server" Text='<%# Eval("NotificationName") %>'></asp:Label>
                    <span runat="server">

                        <a id='<%# "notTip" & Eval("NotificationID")%>' enableviewstate="false" class="btn" role="button"><i aria-hidden="true" class="fas fa-info-circle"></i></a>
                        <dx:BootstrapPopupControl ID="BootstrapPopupControl1"  PopupElementCssSelector='<%# "#notTip" & Eval("NotificationID")%>' PopupAnimationType="Slide" CloseAnimationType="Slide" runat="server" ShowHeader="true"
    HeaderText='<%# Eval("NotificationName")%>' SettingsBootstrap-Sizing="Normal">
                             <ContentCollection>
        <dx:ContentControl>
            <%# Eval("Description") + "<hr/><p>Applicable to roles:</p><ul>" + Eval("RolesList") + "</ul>" %>
        </dx:ContentControl>
    </ContentCollection>
                        </dx:BootstrapPopupControl>
                    </span>
                      
                       <asp:HiddenField ID="hfNotificationID" Value='<%# Eval("NotificationID")%>' runat="server" />
                       <input type="checkbox" id="cbYesNo" runat="server" class="float-right btn-raised" checked='<%# Eval("UserSubscribed")%>' data-toggle="toggle" data-on="Subscribed" data-off="Unsubscribed" data-width="115px" data-onstyle="success btn-raised float-right" data-size="small" data-offstyle="danger btn-raised float-right">
                       </li> 
            </ItemTemplate>
        </asp:Repeater></ul>
                            </div></div>
                            <div class="form-group row">
                                <asp:Label ID="Label7" CssClass="control-label col-sm-4" runat="server" AssociatedControlID="bstbPassword">Current Password:</asp:Label>
                                <div class="col col-sm-6">
                                    <dx:BootstrapTextBox ID="bstbPassword" Password="true" runat="server">
                                        <ValidationSettings ValidationGroup="vgUpdateAdminDetails">
                                <RequiredField IsRequired="true" ErrorText="You must enter your password to make changes." />
                            </ValidationSettings>
                                    </dx:BootstrapTextBox>
                                </div>
                                <div class="col col-sm-2">
                                    <a class="btn btn-raised btn-primary" role="button" data-toggle="collapse" href="#collapseChangePW" aria-expanded="false" aria-controls="collapseChangePW">Change
                                    </a>
                                </div>
                            </div>

                            <div class="collapse mb-1" id="collapseChangePW">
                                <div class="form-group row">
                                    <asp:Label ID="Label6" CssClass="control-label col-sm-4" runat="server" AssociatedControlID="bstbNewPassword">New Password:</asp:Label>
                                    <div class="col col-sm-8">
                                        <dx:BootstrapTextBox ClientIDMode="Static"  ID="bstbNewPassword" Password="true" runat="server">
                                            <ValidationSettings ValidationGroup="vgUpdateAdminDetails">
                                            <RegularExpression ErrorText="Minimum 8 characters with at least 1 letter, 1 number and 1 symbol" ValidationExpression="(?=.{8,})(?=.*?[^\w\s])(?=.*?[0-9])(?=.*?[A-Za-z]).*" />
                               
                            </ValidationSettings>
                                        </dx:BootstrapTextBox>
                                     
                                </div></div>
                                <div class="form-group row">
                                    <asp:Label ID="Label8" CssClass="control-label col-sm-4" runat="server" AssociatedControlID="bstbConfirmPassword">Confirm New Password:</asp:Label>
                                    <div class="col col-sm-8">
                                        <dx:BootstrapTextBox ID="bstbConfirmPassword" Password="true" runat="server">
                                               <ClientSideEvents Validation="onChangeAdminPWValidation" />
                                            <ValidationSettings ValidationGroup="vgUpdateAdminDetails">
                                            </ValidationSettings>
                                        </dx:BootstrapTextBox>
                                      
                                    </div>
                                </div>
                            </div>
                            <asp:Panel ID="pnlError" runat="server" CssClass="alert alert-danger alert-dismissible" Visible="false">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <asp:Label ID="lblMyDetailsError" runat="server" Text=""></asp:Label>
                            </asp:Panel>
                        </div>
            </dx:ContentControl>
        </ContentCollection>
    <FooterContentTemplate>
           <dx:BootstrapButton ID="bsbtnSaveAdminDetails" OnCommand="bsbtnSaveAdminDetails_Command" runat="server" Text="Save" UseSubmitBehavior="true" SettingsBootstrap-RenderOption="Primary" SettingsBootstrap-Sizing="Large">
               <ClientSideEvents Click="function(s, e) { e.processOnServer = ASPxClientEdit.ValidateGroup('vgUpdateAdminDetails'); }" />
          </dx:BootstrapButton>         
    </FooterContentTemplate>
</dx:BootstrapPopupControl>

<dx:BootstrapPopupControl ID="bspDelegateDetails" PopupHorizontalAlign="Center" PopupVerticalAlign="Middle"  ShowFooter="true" ShowCloseButton="True" CloseAction="CloseButton" Modal="True" ShowOnPageLoad="false" HeaderText="<h5>Manage My Profile</h5>" EncodeHtml="false" PopupElementCssSelector=".delegate-details" runat="server">
    <SettingsAdaptivity Mode="Always" MaxWidth="1024" SwitchAtWindowInnerWidth="1024" VerticalAlign="WindowCenter"
        FixedHeader="true" FixedFooter="true" />
                      
    <ContentCollection>
        <dx:ContentControl>
             <asp:HiddenField ID="hfActive" runat="server" />
                                                <asp:HiddenField ID="hfApproved" runat="server" />
                                                <asp:HiddenField ID="hfAlias" runat="server" />
           <div id="delegateForm" class="m-3">
        <div class="form-group row">
                    <asp:Label ID="Label9" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="bstbDelFName">First name</asp:Label>
                    <div class="col col-sm-8">
                        <dx:BootstrapTextBox ID="bstbDelFName" MaxLength="250" runat="server">
                            <ValidationSettings ValidationGroup="vgUpdateDelDetails">
                                <RequiredField IsRequired="true" ErrorText="Required" />
                            </ValidationSettings>
                        </dx:BootstrapTextBox>
                    </div>
                </div>
                <div class="form-group row">
                    <asp:Label ID="lbltbDelLName" CssClass="control-label col-sm-4" runat="server" AssociatedControlID="bstbDelLName">Last name</asp:Label>
                    <div class="col col-sm-8">
                        <dx:BootstrapTextBox ID="bstbDelLName" runat="server">
                             <ValidationSettings ValidationGroup="vgUpdateDelDetails">
                                <RequiredField IsRequired="true" ErrorText="Required" />
                            </ValidationSettings>
                        </dx:BootstrapTextBox>
                    </div>
                </div>
                <div class="form-group row">
                    <asp:Label ID="Label13" CssClass="control-label col-sm-4" runat="server" AssociatedControlID="bstbDelEmail">Email address</asp:Label>
                    <div class="col col-sm-8">
                        <dx:BootstrapTextBox ID="bstbDelEmail" runat="server">
                             <ValidationSettings ValidationGroup="vgUpdateDelDetails">
                                <RequiredField IsRequired="true" ErrorText="Required" />
                                 <RegularExpression ErrorText="Invalid e-mail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                            </ValidationSettings>
                        </dx:BootstrapTextBox>
                    </div>
                </div>
                <div class="form-group row">
                    <asp:Label ID="Label14" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="cbxJobGroup">Job group</asp:Label>
                    <div class="col col-sm-8">
                        <dx:BootstrapComboBox ID="cbxJobGroup" runat="server" DataSourceID="dsJobGroups"  TextField="JobGroupName" ValueField="JobGroupID" ValueType="System.Int32">
                            <ValidationSettings ValidationGroup="vgUpdateDelDetails">
                                                <RequiredField IsRequired="true" ErrorText="Select a Job Group" />
                                            </ValidationSettings>
                        </dx:BootstrapComboBox>
                    </div>
                </div>
                <div id="trCustField1" runat="server" class="form-group row">
                    <asp:Label ID="lblCustField1" runat="server" CssClass="col col-sm-4 control-label" AssociatedControlID="bstbField1">Field 1</asp:Label>
                    <div class="col col-sm-8">
                        <dx:BootstrapTextBox ID="bstbField1" MaxLength="250" runat="server"></dx:BootstrapTextBox>
                        <dx:BootstrapComboBox ID="cbxField1" runat="server"></dx:BootstrapComboBox>

                    </div>
                </div>
                <div class="form-group row" id="trCustField2" runat="server">
                    <asp:Label ID="lblCustField2" CssClass="col col-sm-4 control-label" runat="server" AssociatedControlID="bstbField2">Field 2</asp:Label>
                    <div class="col col-sm-8">
                        <dx:BootstrapTextBox ID="bstbField2" MaxLength="250" runat="server"></dx:BootstrapTextBox>
                        <dx:BootstrapComboBox ID="cbxField2" runat="server"></dx:BootstrapComboBox>
                    </div>
                </div>
                <div class="form-group row" id="trCustField3" runat="server">
                    <asp:Label ID="lblCustField3" CssClass="col col-sm-4 control-label" runat="server" AssociatedControlID="bstbField3">Field 3</asp:Label>
                    <div class="col col-sm-8">
                        <dx:BootstrapTextBox ID="bstbField3" MaxLength="250" runat="server"></dx:BootstrapTextBox>
                        <dx:BootstrapComboBox ID="cbxField3" runat="server"></dx:BootstrapComboBox>
                    </div>
                </div>
               <div id="trCustField4" runat="server" class="form-group row">
                    <asp:Label ID="lblCustField4" runat="server" CssClass="col col-sm-4 control-label" AssociatedControlID="bstbField4">Field 4</asp:Label>
                    <div class="col col-sm-8">
                        <dx:BootstrapTextBox ID="bstbField4" MaxLength="250" runat="server"></dx:BootstrapTextBox>
                        <dx:BootstrapComboBox ID="cbxField4" runat="server"></dx:BootstrapComboBox>
                    </div>
                </div>
                <div class="form-group row" id="trCustField5" runat="server">
                    <asp:Label ID="lblCustField5" CssClass="col col-sm-4 control-label" runat="server" AssociatedControlID="bstbField5">Field 5</asp:Label>
                    <div class="col col-sm-8">
                        <dx:BootstrapTextBox ID="bstbField5" MaxLength="250" runat="server"></dx:BootstrapTextBox>
                        <dx:BootstrapComboBox ID="cbxField5" runat="server"></dx:BootstrapComboBox>
                    </div>
                </div>
                <div class="form-group row" id="trCustField6" runat="server">
                    <asp:Label ID="lblCustField6" CssClass="col col-sm-4 control-label" runat="server" AssociatedControlID="bstbField6">Field 6</asp:Label>
                    <div class="col col-sm-8">
                        <dx:BootstrapTextBox ID="bstbField6" MaxLength="250" runat="server"></dx:BootstrapTextBox>
                        <dx:BootstrapComboBox ID="cbxField6" runat="server"></dx:BootstrapComboBox>
                    </div>
                </div>
               <div class="form-group row">
                                <asp:Label ID="Label4" CssClass="control-label col-sm-4" runat="server" AssociatedControlID="bsimgDelProfileImage">Profile Image (optional):</asp:Label>
                                <div class="col col-sm-8">
                                    <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
                                        <ContentTemplate>--%>
   <dx:BootstrapBinaryImage ID="bsimgDelProfileImage"  ClientSideEvents-ValueChanged="binaryImageUploaded" EditingSettings-Enabled="true"  runat="server" Height="150" EmptyImage-Url="~/Images/avatar.png"></dx:BootstrapBinaryImage>                                   
                                   
                                               
                                              <%--</ContentTemplate>
                                    </asp:UpdatePanel>--%>
                                  
                                </div>
                            </div>
   <div class="card mt-3 card-default">
                                <div class="card-header">Manage e-mail notification preferences</div>
                                                            
                                <asp:ObjectDataSource ID="dsUserNotifications2" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByCandidate" TypeName="ITSP_TrackingSystemRefactor.LearnerPortalTableAdapters.NotificationsTableAdapter">
            <SelectParameters>
                <asp:SessionParameter Name="CandidateID" SessionField="learnCandidateID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
                                <ul class="list-group">
                                <asp:Repeater ID="rptDelNotifications" DataSourceID="dsUserNotifications2" runat="server">
            <ItemTemplate>
                   <li class="list-group-item clearfix">
                       <asp:Label ID="lblNotificationName" runat="server" Text='<%# Eval("NotificationName") %>'></asp:Label>
                       <%--notification description tooltip:--%>
                    <span runat="server">

                        <a id='<%# "notTip" & Eval("NotificationID")%>' enableviewstate="false" tabindex="0" class="btn" role="button" data-html="true" ><i aria-hidden="true" class="fas fa-info-circle"></i></a>
                    </span>
                      <dx:BootstrapPopupControl ID="bspDelNot"  PopupElementCssSelector='<%# "#notTip" & Eval("NotificationID")%>' PopupAnimationType="Slide" CloseAnimationType="Slide" runat="server" ShowHeader="true"
    HeaderText='<%# Eval("NotificationName")%>' SettingsBootstrap-Sizing="Normal">
                             <ContentCollection>
        <dx:ContentControl>
            <%# Eval("Description") %>
        </dx:ContentControl>
    </ContentCollection>
                        </dx:BootstrapPopupControl>
                       <asp:HiddenField ID="hfNotificationID" Value='<%# Eval("NotificationID")%>' runat="server" />
                       <input type="checkbox" id="cbYesNo" runat="server" class="float-right" checked='<%# Eval("UserSubscribed")%>' data-toggle="toggle" data-on="Subscribed" data-off="Unsubscribed" data-width="115px" data-onstyle="success float-right btn-raised" data-size="small" data-offstyle="danger float-right btn-raised" />
                       </li> 
            </ItemTemplate>
        </asp:Repeater></ul>
                           </div>
                                                    
               <%--need password reset button here--%>
               <div class="clearfix">
               <button class="btn btn-raised btn-secondary btn-sm float-right" type="button" data-toggle="collapse" data-target="#divPWReset" aria-expanded="false" aria-controls="divPWReset">
                   <asp:Label ID="lblChangePWBtn" runat="server" Text="Set password"></asp:Label>
</button></div>
               <div class="collapse" id="divPWReset">
                   <hr />
                    <div class="form-group row" id="divOldPW" visible="false" runat="server">
                        <asp:Label ID="lblCurrentPW" AssociatedControlID="bstbOldPassword" CssClass="col col-sm-4 control-label" runat="server">Old password</asp:Label>
                        <div class="col col-sm-8">
                            <dx:BootstrapTextBox ID="bstbOldPassword" runat="server" Password="True"></dx:BootstrapTextBox>
                            </div>
                        </div>
                   <div class="form-group row">
                        <asp:Label ID="Label15" AssociatedControlID="bstbNewPassword1" CssClass="col col-sm-4 control-label" runat="server">New password</asp:Label>
                        <div class="col col-sm-8">
                            <dx:BootstrapTextBox ID="bstbNewPassword1" ClientIDMode="Static" runat="server" Password="True">
                                <ValidationSettings ValidationGroup="vgUpdateDelDetails">
                                            <RegularExpression ErrorText="Minimum 8 characters with at least 1 letter, 1 number and 1 symbol" ValidationExpression="(?=.{8,})(?=.*?[^\w\s])(?=.*?[0-9])(?=.*?[A-Za-z]).*" />
                               
                            </ValidationSettings></dx:BootstrapTextBox>
                            </div>
                        </div>
                    <div class="form-group row">
                        <asp:Label ID="Label16" AssociatedControlID="bstbNewPassword2" CssClass="col col-sm-4 control-label" runat="server">Retype new password</asp:Label>
                        <div class="col col-sm-8">
                            <dx:BootstrapTextBox ID="bstbNewPassword2" runat="server" Password="True">
                                            <ClientSideEvents Validation="onChangePWValidation" />
                                            <ValidationSettings ValidationGroup="vgUpdateDelDetails">
                                            </ValidationSettings></dx:BootstrapTextBox>
                           </div>
                        </div>
               </div>
                </div>
            </dx:ContentControl>
        </ContentCollection>
    <FooterTemplate>
          <dx:BootstrapButton ID="bsbtnSaveDelDetails" OnCommand="bsbtnSaveDelDetails_Command" runat="server" Text="Save" UseSubmitBehavior="true" SettingsBootstrap-RenderOption="Primary" SettingsBootstrap-Sizing="Large">
               <ClientSideEvents Click="function(s, e) { e.processOnServer = ASPxClientEdit.ValidateGroup('vgUpdateDelDetails'); }" />
          </dx:BootstrapButton>         
                        </FooterTemplate>
</dx:BootstrapPopupControl>

   <asp:ObjectDataSource ID="dsJobGroups" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.LearnerPortalTableAdapters.JobGroupsTableAdapter"></asp:ObjectDataSource>
        
 <%-- Manage details modal popup ends here --%>
        <div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        
                        <h5 class="modal-title" id="confirmModalLabel">
                            <asp:Label ID="lblConfirmTitle" runat="server" Text="Changes Saved"></asp:Label></h5><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    </div>
                    <div class="modal-body">
                        <asp:Label ID="lblConfirmMessage" runat="server" Text="Your changes have been saved successfully."></asp:Label>
                    </div>
                    <div class="modal-footer">
                        <button type="button"  class="btn btn-primary float-right" data-dismiss="modal">OK</button>
                    </div>
                </div>
            </div>
        </div>

<%-- Manage details modal popup ends here --%>
        <div class="modal fade" id="registerMSUserModal" tabindex="-1" role="dialog" aria-labelledby="regMSModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        
                        <h5 class="modal-title" id="regMSModalLabel">
                            <asp:Label ID="Label12" runat="server" Text="Complete DLS Registration?"></asp:Label></h5><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    </div>
                    <div class="modal-body">
                        <asp:Label ID="lblCompleteMSReg" runat="server"></asp:Label>
                    </div>
                    <div class="modal-footer">
                        <button type="button"  class="btn btn-secondary mr-auto" data-dismiss="modal">Cancel</button>
                        <asp:LinkButton ID="lbtRegLink3" CausesValidation="false" CssClass="btn btn-primary ml-auto" runat="server"><i class="fas fa-user-plus"></i>Register</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>