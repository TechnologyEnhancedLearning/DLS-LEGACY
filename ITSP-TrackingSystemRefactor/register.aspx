<%@ Page Title="Register" Language="vb" AutoEventWireup="false" MasterPageFile="~/Landing.Master" CodeBehind="register.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.register" %>

<%@ Register Assembly="GoogleReCaptcha" Namespace="GoogleReCaptcha" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/register-validation.js"></script>
    <div class="ms-hero-page-override ms-hero-img-study ms-bg-fixed ms-hero-bg-dark-light">
        <div class="container">
            <div class="text-center">
                <h1 class="no-m ms-site-title color-white center-block ms-site-title-lg mt-2 animated zoomInDown animation-delay-5">Register</h1>
                <p class="lead lead-lg color-light text-center center-block mt-2 mw-800 text-info fw-300 animated fadeInUp animation-delay-7">
                    <asp:Label ID="lblRegText" runat="server" Text="Register to access all Digital Learning Solutions services."></asp:Label>
                </p>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="card card-primary card-hero animated fadeInUp animation-delay-7">
            <div class="card-body">
                <asp:MultiView ID="mvRegister" ActiveViewIndex="0" runat="server">
                    <asp:View ID="vRegister" runat="server">
                        <div class="row">
                            <div class="col">
                                <button type="button" title="Cancel" onclick="javascript:history.back();" class="close d-inline float-right mt-2" aria-label="Close"><i class="fas fa-times"></i></button>
                            </div>
                        </div>
                        
                        <fieldset>
                            <div class="row">
                                <div class="col-md-6 form-group label-floating">
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                            <i class="fas fa-user"></i>
                                        </span>
                                        <asp:Label ID="Label17" CssClass="control-label" AssociatedControlID="tbFNameReg" runat="server" Text="First name"></asp:Label>
                                        <asp:TextBox ID="tbFNameReg" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                                        <div id="fnamevalidate" class="text-danger small d-none">Required</div>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="tbFNameReg" ErrorMessage="Required" CssClass="text-danger small" Display="Dynamic" ValidationGroup="vgRegister" runat="server"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-6 form-group label-floating">
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                            <i class="fas fa-user"></i>
                                        </span>
                                        <asp:Label ID="Label18" CssClass="control-label" AssociatedControlID="tbLNameReg" runat="server" Text="Last name"></asp:Label>
                                        <asp:TextBox ID="tbLNameReg" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                                        <div id="lnamevalidate" class="text-danger small d-none">Required</div>
                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="tbLNameReg" ErrorMessage="Required" CssClass="alert alert-danger small" Display="Dynamic" ValidationGroup="vgRegister" runat="server"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                </div>
                            <div class="row">
                                <div class="col-md-6 form-group label-floating">
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                            <i class="fas fa-envelope"></i>
                                        </span>
                                        <asp:Label ID="Label4" CssClass="control-label" AssociatedControlID="tbEmailReg" runat="server" Text="Email"></asp:Label>
                                        <asp:TextBox ID="tbEmailReg" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                                        <div id="emailvalidate" class="text-danger small d-none">Valid email required</div>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="tbEmailReg" ErrorMessage="Required" CssClass="alert alert-danger small" Display="Dynamic" ValidationGroup="vgRegister" runat="server"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="tbEmailReg" ErrorMessage="E-mail invalid" CssClass="alert alert-danger small" Display="Dynamic" ValidationGroup="vgRegister" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                                <div class="col-md-6 form-group label-floating">
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                            <i class="fas fa-building"></i>
                                        </span>
                                        <asp:Label ID="Label1" CssClass="control-label" AssociatedControlID="ddCentre" runat="server" Text="Centre"></asp:Label>
                                        <asp:DropDownList ID="ddCentre" ClientIDMode="Static" CssClass="form-control" DataSourceID="CentresDataSource" DataTextField="CentreName" DataValueField="CentreID" runat="server" AppendDataBoundItems="true">
                                            <asp:ListItem Text="Select your centre / organisation" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                        <div id="centrevalidate" class="text-danger small d-none">Required</div>
                                        <asp:CompareValidator ID="CompareValidator1"  runat="server" ErrorMessage="Required" CssClass="alert alert-danger small" Display="Dynamic" ValidationGroup="vgRegister" ControlToValidate="ddCentre" ValueToCompare="0" Operator="GreaterThan"></asp:CompareValidator>
                                    </div>
                                </div></div>
                                <asp:Panel ID="pnlPassword" class="row" runat="server">
                                <div class="col-6 form-group label-floating">
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                            <i class="fas fa-lock"></i>
                                        </span>
                                        <asp:Label ID="Label12" runat="server" CssClass="control-label" AssociatedControlID="tbPasswordReg" autocomplete="off" Text="Password"></asp:Label>
                                        <asp:TextBox ID="tbPasswordReg" ClientIDMode="Static" CssClass="form-control" TextMode="Password" runat="server"></asp:TextBox>
                                        <div id="pwvalidate" class="text-danger small d-none">Minimum 8 characters with at least 1 letter, 1 number and 1 symbol</div>
                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="tbPasswordReg" ErrorMessage="Required" CssClass="alert alert-danger small" Display="Dynamic" ValidationGroup="vgRegister" runat="server"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="tbPasswordReg" ErrorMessage="Minimum 8 characters with at least 1 letter, 1 number and 1 symbol" CssClass="alert alert-danger small" Display="Dynamic" ValidationGroup="vgRegister" ValidationExpression="(?=.{8,})(?=.*?[^\w\s])(?=.*?[0-9])(?=.*?[A-Za-z]).*"></asp:RegularExpressionValidator>
                                    </div>
                                </div>

                                <div class="col-6 form-group label-floating">
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                            <i class="fas fa-lock"></i>
                                        </span>
                                        <asp:Label ID="Label19" runat="server" CssClass="control-label" AssociatedControlID="tbPasswordConfirm" Text="Re-type Password"></asp:Label>
                                        <asp:TextBox ID="tbPasswordConfirm" ClientIDMode="Static" CssClass="form-control" TextMode="Password" runat="server"></asp:TextBox>
                                        <div id="pw2validate" class="text-danger small d-none">Reenter matching password</div>
                                          <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="tbPasswordConfirm" ErrorMessage="Required" CssClass="alert alert-danger small" Display="Dynamic" ValidationGroup="vgRegister" runat="server"></asp:RequiredFieldValidator>
                                        <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="tbPasswordConfirm" ErrorMessage="Passwords must match" CssClass="alert alert-danger small" Display="Dynamic" ValidationGroup="vgRegister" ControlToCompare="tbPasswordReg"></asp:CompareValidator>
                                    </div>
                                </div>
                                </asp:Panel>
                            <div class="row">
                                <div class="col-md-6 form-group label-floating">
                                    <div class="input-group">
                                        <asp:Label ID="Label3" CssClass="control-label" AssociatedControlID="ddJobGroup" runat="server" Text="Job Group"></asp:Label>
                                        <asp:DropDownList ID="ddJobGroup" ClientIDMode="Static" runat="server" CssClass="form-control" AppendDataBoundItems="true" DataSourceID="dsJobGroups" DataTextField="JobGroupName" DataValueField="JobGroupID" >
                                            <asp:ListItem Text="Select your job group" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                        <div id="jgvalidate" class="text-danger small d-none">Required</div>
                                           <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ControlToValidate="ddJobGroup" ErrorMessage="Required" CssClass="alert alert-danger small" Display="Dynamic" ValidationGroup="vgRegister" runat="server" InitialValue="0"></asp:RequiredFieldValidator>
                                   <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ControlToValidate="ddJobGroup" ErrorMessage="Required" CssClass="alert alert-danger small" Display="Dynamic" ValidationGroup="vgRegister2" runat="server" InitialValue="0"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                </div>
                            <div class="row">
                                <div class="col-md-6 form-group text-center">
                                    <asp:CheckBox ID="cbTerms" ClientIDMode="Static" CssClass="form-check-input" runat="server" />
                                    <asp:Label ID="Label6" runat="server" AssociatedControlID="cbTerms" Text="&nbsp;&nbsp; I have read, understood and agree to abide by the<br/> Digital Learning Solutions <a data-toggle='modal' class='text-primary' href='#' data-target='#termsMessage'>Terms and Conditions</a>."></asp:Label>
                                    <div id="termsvalidate" class="text-danger small d-none">You must agree to the DLS terms</div>
                                    <asp:Panel ID="pnlTermsAlert" CssClass="alert alert-danger small" Visible="false" runat="server">You must agree to the DLS terms</asp:Panel>
                                </div>
                                <div class="col-md-6 form-group label-floating">
                                    <asp:Label ID="Label5" CssClass="sr-only" runat="server" AssociatedControlID="ctrlRegisterReCaptcha">Solve Captcha:</asp:Label>
                                    <cc1:GoogleReCaptcha ID="ctrlRegisterReCaptcha" runat="server" PublicKey="6LdAWpcUAAAAAELGuBQlrXR4_pyNEOXc1XuqZoiB" PrivateKey="6LdAWpcUAAAAAEyyLxiI3zDF46b1_9OoE_7IOMrQ" />
                                    <asp:Label ID="lblCaptchaError" CssClass="bg-danger" Visible="false" runat="server" Text="Label"></asp:Label>
                                </div>
                            </div>
                            <asp:Button ID="btnRegister" runat="server" ValidationGroup="vgRegister" OnClientClick="return validateRegFields();" Text="Register" CssClass="btn btn-primary btn-raised btn-block" />
                        </fieldset>
                    </asp:View>

                    <asp:View ID="vCustomQuestions" runat="server">
                         <div class="row">
                            <div class="col">
<button type="button" title="Cancel" onclick="javascript:window.history.go(-2);" class="close d-inline float-right mt-2" aria-label="Close"><i class="fas fa-times"></i></button>
                            </div>
                        </div>
                        <div class="alert alert-info">
                            Please provide the following delegate registration information required by your centre.
                        </div>
                        <asp:HiddenField ID="hfTemp" runat="server" />
                        <asp:Panel ID="pnlIPAlert" CssClass="alert alert-danger small" Visible="false" runat="server">
                            <asp:Label ID="lblIPWarning" runat="server" Text="You appear to be accessing this web site from an unapproved Internet location. If you proceed to register, your registration will need to be approved by a centre administrator. To avoid this, try registering from a PC in your place of work."></asp:Label>
                        </asp:Panel>
                        <fieldset>
                            <div class="row">
                                <asp:Panel CssClass="col-md-6 form-group label-floating" ID="pnlField1" runat="server">

                                    <div class="input-group">
                                        <asp:HiddenField ID="hfField1Mand" Value="0" ClientIDMode="Static" runat="server" />
                                        <asp:Label ID="lblCustField1" CssClass="control-label" AssociatedControlID="tbField1" runat="server" Text="First name"></asp:Label>
                                        <asp:TextBox ID="tbField1" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                                        <asp:DropDownList ID="ddField1" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:DropDownList>
                                        <div id="f1validate" class="text-danger small d-none">Required</div>
                                    </div>
                                </asp:Panel>
                                <asp:Panel ID="pnlField2" CssClass="col-md-6 form-group label-floating" runat="server">

                                    <div class="input-group">
                                        <asp:HiddenField ID="hfField2Mand" Value="0" ClientIDMode="Static" runat="server" />
                                        <asp:Label ID="lblCustField2" CssClass="control-label" AssociatedControlID="tbField2" runat="server" Text="First name"></asp:Label>
                                         <asp:TextBox ID="tbField2" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                                        <asp:DropDownList ID="ddField2" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:DropDownList>
                                        <div id="f2validate" class="text-danger small d-none">Required</div>
                                    </div>
                                </asp:Panel>
                                <asp:Panel ID="pnlField3" CssClass="col-md-6 form-group label-floating" runat="server">
                                    <div class="input-group">
                                        <asp:HiddenField ID="hfField3Mand" Value="0" ClientIDMode="Static" runat="server" />
                                        <asp:Label ID="lblCustField3" CssClass="control-label" AssociatedControlID="tbField3" runat="server" Text="First name"></asp:Label>
                                          <asp:TextBox ID="tbField3" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                                        <asp:DropDownList ID="ddField3" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:DropDownList>
                                        <div id="f3validate" class="text-danger small d-none">Required</div>
                                    </div>
                                </asp:Panel>
                                <asp:Panel ID="pnlField4" CssClass="col-md-6 form-group label-floating" runat="server">
                                    <div class="input-group">
                                        <asp:HiddenField ID="hfField4Mand" Value="0" ClientIDMode="Static" runat="server" />
                                        <asp:Label ID="lblCustField4" CssClass="control-label" AssociatedControlID="tbField4" runat="server" Text="First name"></asp:Label>
                                          <asp:TextBox ID="tbField4" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                                        <asp:DropDownList ID="ddField4" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:DropDownList>
                                        <div id="f4validate" class="text-danger small d-none">Required</div>
                                    </div>
                                </asp:Panel>
                                <asp:Panel ID="pnlField5" CssClass="col-md-6 form-group label-floating" runat="server">
                                    <div class="input-group">
                                        <asp:HiddenField ID="hfField5Mand" Value="0" ClientIDMode="Static" runat="server" />
                                        <asp:Label ID="lblCustField5" CssClass="control-label" AssociatedControlID="tbField5" runat="server" Text="First name"></asp:Label>
                                          <asp:TextBox ID="tbField5" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                                        <asp:DropDownList ID="ddField5" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:DropDownList>
                                        <div id="f5validate" class="text-danger small d-none">Required</div>
                                    </div>
                                </asp:Panel>
                                <asp:Panel ID="pnlField6" CssClass="col-md-6 form-group label-floating" runat="server">
                                    <div class="input-group">
                                        <asp:HiddenField ID="hfField6Mand" Value="0" ClientIDMode="Static" runat="server" />
                                        <asp:Label ID="lblCustField6" CssClass="control-label" AssociatedControlID="tbField6" runat="server" Text="First name"></asp:Label>
                                          <asp:TextBox ID="tbField6" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                                        <asp:DropDownList ID="ddField6" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:DropDownList>
                                        <div id="f6validate" class="text-danger small d-none">Required</div>
                                    </div>
                                </asp:Panel>
                            </div>
                            <asp:LinkButton ID="lbtRegisterCustom" OnClientClick="return validateCustomFields();" CausesValidation="true" CssClass="btn btn-primary btn-raised btn-block" runat="server">Register Now</asp:LinkButton>

                        </fieldset>
                    </asp:View>
                </asp:MultiView>


            </div>
        </div>
    </div>
    <asp:ObjectDataSource ID="CentresDataSource" runat="server"
        OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetLiveCentres"
        TypeName="ITSP_TrackingSystemRefactor.AuthenticateTableAdapters.CentresTableAdapter"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsJobGroups" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.JobGroupsTableAdapter"></asp:ObjectDataSource>

    <div class="modal fade" id="termsModal" tabindex="-1" role="dialog" aria-labelledby="termsModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">

                    <h5 class="modal-title" id="termsModalLabel">Agree to Terms and Conditions</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    You must agree to the terms and conditions before registering to use Digital Learning Solutions services.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary float-right" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">

                    <h5 class="modal-title" id="confirmModalLabel">
                        <asp:Label ID="lblConfirmTitle" runat="server" Text="Changes Saved"></asp:Label></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <asp:Label ID="lblConfirmMessage" runat="server" Text="Your changes have been saved successfully."></asp:Label>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary float-right" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="delegateRegisteredModal" tabindex="-1" role="dialog" aria-labelledby="delRegModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">

                    <h5 class="modal-title" id="delRegModalLabel">Delegate Registration Complete</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <div class="alert alert-info" role="alert">
                        Your delegate number is: 
                        <label id="delNumber" class="fa-2x text-center color-dark p-2"></label>

                    </div>

                    <p>You should make a note of your delegate number and keep it safe. You can use it to log in to the Learning Portal and any Digital Learning Solutions courses.</p>

                    <div id="divRegNotApproved" class="alert alert-warning" runat="server">

                        <p>Your registration must be approved by a centre administrator before you can login. You will receive an e-mail at the address you registered with when your registration has been approved.</p>
                    </div>

                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="btnContinue" runat="server" ToolTip="Continue" CssClass="btn btn-primary btn-raised btn-block">
                        <asp:Label ID="lblContinue" runat="server" Text="Continue"></asp:Label>
                    </asp:LinkButton>

                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="adminRegModal" tabindex="-1" role="dialog" aria-labelledby="adminModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">

                    <h5 class="modal-title" id="adminModalLabel">
                        <asp:Label ID="lblAdminRegTitle" runat="server" Text="Changes Saved"></asp:Label></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <asp:Label ID="lblAdminRegText" runat="server" Text="Your changes have been saved successfully."></asp:Label>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton ID="lbtAdminRegOK" CssClass="btn btn-primary float-right" runat="server" Text="OK"></asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="duplicateEmailModal" tabindex="-1" role="dialog" aria-labelledby="dupModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">

                    <h5 class="modal-title" id="dupModalLabel">Existing registration for e-mail address</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <div class="alert alert-warning" role="alert">
                        <p>A delegate is already registered with the e-mail address you supplied.</p>

                        <p>
                            To return to the login page click
                                                <asp:LinkButton ID="btnReturn" CausesValidation="false" runat="server" ToolTip="Login" CssClass="btn btn-raised btn-primary"><span><span>Login</span></span></asp:LinkButton>
                        </p>
                        <p>
                            To reset your password click
                                                <asp:LinkButton ID="btnReset" CausesValidation="false"  runat="server" ToolTip="Login" CssClass="btn btn-raised btn-primary"><span><span>Reset</span></span></asp:LinkButton>
                        </p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary float-right" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
