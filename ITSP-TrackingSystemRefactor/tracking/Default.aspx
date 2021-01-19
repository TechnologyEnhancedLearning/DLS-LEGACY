<%@ Page Title="Login" Language="VB" MasterPageFile="~/tracking/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.vb" Inherits="ITSP_TrackingSystemRefactor._Default" %>

<asp:Content ID="Breadcrumb" ContentPlaceHolderID="breadtray" runat="server">
   <ol class="breadcrumb breadcrumb-slash">

        <li class="breadcrumb-item active">Sign in</li>
    </ol>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="./Content/login.css" rel="stylesheet" />
 
    <asp:MultiView ID="mvDefault" runat="server" ActiveViewIndex="0">
        <asp:View ID="vLogin" runat="server">
            <asp:Panel ID="pnlLoginmessage" runat="server" CssClass="alert alert-info" role="alert">
                <asp:Literal ID="txtLoginMessage" runat="server"></asp:Literal></asp:Panel>
            <asp:Panel ID="pnlLogin" DefaultButton="btnLogin" runat="server">
                <div class="row">
                    <div class="col col-sm-8 col-md-6 col-md-offset-3 col-sm-offset-2">
                        <%--<h1 class="text-center login-title">Sign in to the Tracking System</h1>--%>
                        <div class="account-wall">

                            <%--<img id="profile-img" class="profile-img" src="//ssl.gstatic.com/accounts/ui/avatar_2x.png" />--%>
                            <%--<img class="" src="https://lh5.googleusercontent.com/-b0-k99FZlyE/AAAAAAAAAAI/AAAAAAAAAAA/eu7opA4byxI/photo.jpg?sz=120"
                    alt="">--%>
                            <div class="form-signin">
                                <asp:TextBox runat="server" CssClass="form-control  user-hard-corners" ID="tbUserName" placeholder="User name" autofocus />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="Login" runat="server" ControlToValidate="tbUserName" Display="Dynamic" CssClass="bg-danger" ErrorMessage="This is a required field" />

                                <asp:TextBox runat="server" CssClass="form-control" placeholder="Password" ID="tbPassword" TextMode="Password" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="Login" runat="server" ControlToValidate="tbPassword" Display="Dynamic" CssClass="bg-danger" ErrorMessage="This is a required field" />
                                <asp:Panel ID="pnlLoginError" runat="server" Visible="false" Class="alert alert-danger">
                                    <asp:Label ID="lblLoginError" runat="server"></asp:Label>
                                </asp:Panel>
                                <asp:Button ID="btnLogin" ValidationGroup="Login" runat="server" class="btn btn-lg btn-primary btn-block btn-signin" Text="Sign in" type="submit" />


                                <div class="float-left need-help">
                                    Forgotten your password? Type your e-mail address or username into the user name field above and click
                                    <asp:LinkButton ID="lbtReminder" ToolTip="Send reset link" CausesValidation="false" runat="server">Reset</asp:LinkButton>.
                                </div>
                                <span class="clearfix"></span>
                            </div>
                        </div>
                        <a href="Default?action=registration" class="text-center new-account">New User Registration</a>

                        <p id="pRegHelp" runat="server">
                            <asp:Label ID="lblRegHelp" runat="server" Text=""></asp:Label>
                        </p>
                    </div>
                </div>
            </asp:Panel>
        </asp:View>
        <asp:View ID="vRegister" runat="server">
            <asp:ObjectDataSource ID="CentresDataSource" runat="server"
                OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetDataSortedByName"
                TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.CentresTableAdapter"></asp:ObjectDataSource>
            <div class="row">
                <div class="col col-md-8 col-md-offset-2">
                    <div class="card card-primary">
                        <div class="card-header clearfix">
                            Register as a Centre Administrator for the Digital Learning Solutions Tracking System <a href="Default?action=login" class="btn-primary float-right"><i aria-hidden="true" class="fas fa-times"></i></a>
                        </div>
                        <div class="card-body">
                            <div class="alert alert-warning">
                                <asp:Label ID="lblIPWarning" runat="server"><b>NOTE:</b> This form should <b>NOT</b> be used to register learners.</asp:Label>
                            </div>
                            <section id="registrationForm" class="m-3">
                                <div class="form-group row">
                                    <asp:Label ID="Label6" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="tbFName">Centre:</asp:Label>
                                    <div class="col col-sm-8">
                                        <asp:DropDownList ID="CentreIDDropDown" CssClass="form-control" runat="server" AppendDataBoundItems="true" DataSourceID="CentresDataSource"
                                            DataTextField="CentreName" DataValueField="CentreID">
                                            <asp:ListItem Selected="True" Text="Please choose..." Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="You must select a centre"
                                            CssClass="field-validation-error" ControlToValidate="CentreIDDropDown" ValidationGroup="Register" ToolTip="Required" SetFocusOnError="True" Display="Dynamic"
                                            InitialValue="0"></asp:RequiredFieldValidator>

                                    </div>
                                </div>

                                <div class="form-group row">
                                    <asp:Label ID="Label1" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="tbFName">First name:</asp:Label>
                                    <div class="col col-sm-8">
                                        <asp:TextBox ID="tbFName" CssClass="form-control" runat="server" TabIndex="1" MaxLength="250"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfFName" ValidationGroup="Register" runat="server" ControlToValidate="tbFName" Display="Dynamic"
                                            CssClass="field-validation-error" ErrorMessage="The first name field is required" />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label2" CssClass="control-label col-sm-4" runat="server" AssociatedControlID="tbLName">Last name:</asp:Label>
                                    <div class="col col-sm-8">
                                        <asp:TextBox ID="tbLName" CssClass="form-control" runat="server" TabIndex="2" MaxLength="250"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfEmail" ValidationGroup="Register" runat="server" ControlToValidate="tbLName" Display="Dynamic"
                                            CssClass="field-validation-error" ErrorMessage="The last name field is required" />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label3" CssClass="control-label col-sm-4" runat="server" AssociatedControlID="tbEmail">Email address:</asp:Label>
                                    <div class="col col-sm-8">
                                        <asp:TextBox runat="server" ID="tbEmail" CssClass="form-control" TabIndex="3" TextMode="Email" />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="Register" runat="server" ControlToValidate="tbEmail" Display="Dynamic"
                                            CssClass="field-validation-error" ErrorMessage="The email address field is required" />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblUsername" runat="server" CssClass="col col-sm-4 control-label" AssociatedControlID="tbRegUsername">User name:</asp:Label>
                                    <div class="col col-sm-8">
                                        <asp:TextBox ID="tbRegUsername" CssClass="form-control" runat="server" MaxLength="250" TabIndex="5"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="Register" runat="server" ControlToValidate="tbRegUsername" Display="Dynamic"
                                            CssClass="field-validation-error" ErrorMessage="You must specify a user name" />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblRegPassword" CssClass="col col-sm-4 control-label" runat="server" AssociatedControlID="tbRegPassword">Password:</asp:Label>
                                    <div class="col col-sm-8">
                                        <asp:TextBox ID="tbRegPassword" CssClass="form-control" runat="server" MaxLength="250" TabIndex="5" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="Register" runat="server" ControlToValidate="tbRegPassword" Display="Dynamic"
                                            CssClass="field-validation-error" ErrorMessage="You must specify a password" />
                                        <asp:RegularExpressionValidator ID="Regex4" runat="server" ValidationGroup="Register" ControlToValidate="tbRegPassword" Display="Dynamic"
    ValidationExpression="(?=.{8,})(?=.*?[^\w\s])(?=.*?[0-9])(?=.*?[A-Za-z]).*"
ErrorMessage="Minimum 8 characters with at least 1 letter, 1 number and 1 symbol" />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label4" CssClass="col col-sm-4 control-label" runat="server" AssociatedControlID="tbRegPassword2">Confirm Password:</asp:Label>
                                    <div class="col col-sm-8">
                                        <asp:TextBox ID="tbRegPassword2" CssClass="form-control" runat="server" MaxLength="250" TabIndex="5" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ValidationGroup="Register" runat="server" ControlToValidate="tbRegPassword2" Display="Dynamic"
                                            CssClass="field-validation-error" ErrorMessage="You must reenter your password" />
                                        <asp:CompareValidator ID="CompareValidator1" ValidationGroup="Register" runat="server" Display="Dynamic" ControlToValidate="tbRegPassword2"
                                            CssClass="field-validation-error" ErrorMessage="Does not match password" ControlToCompare="tbRegPassword"></asp:CompareValidator>
                                    </div>
                                </div>
                                <div class="form-group row">

                                    <div class="col col-sm-8 col-sm-offset-4">

                                        <asp:CheckBox ID="cbTerms" runat="server" /><asp:Label ID="lblTerms" runat="server" AssociatedControlID="cbTerms"> I have read, understood and agree to abide by the Digital Learning Solutions Tracking System <a data-toggle="modal" data-target="#termsMessage">Terms and Conditions</a>.</asp:Label>


                                    </div>

                                </div>
                                <asp:Panel ID="pnlRegisterError" runat="server" Visible="false" Class="alert alert-danger">
                                    <asp:Label ID="lblRegisterMessage" runat="server"></asp:Label>
                                </asp:Panel>

                            </section>
                        </div>
                        <div class="card-footer clearfix">
                            <asp:Button ID="btnRegister" CssClass="float-right btn btn-primary" ValidationGroup="Register" CausesValidation="true" runat="server" Text="Register" />

                        </div>
                    </div>
                </div>

            </div>
            <div class="row">
                <div class="col col-md-8 col-md-offset-2">
                    Already have a Digital Learning Solutions Tracking System login?
                     <a href="Default?action=login">Log in here</a>

                </div>
            </div>


        </asp:View>
        <asp:View ID="vNotApproved" runat="server">
        </asp:View>
        <asp:View ID="vPassswordReminder" runat="server">
            <div class="card card-primary">
                <div class="card-header">
                    <h4><asp:Label ID="lblSetPWTitle" runat="server" Text="Password Reset"></asp:Label></h4>
                </div>
                <div class="card-body">
                    <p><asp:Label ID="lblSetPWText" runat="server" Text="Secure your login by setting a password."></asp:Label></p>
                    <br />
                    <div class="m-3">
                        <div class="form-group row">
                            <asp:Label ID="lblNewPassword1" runat="server" AssociatedControlID="tbNewPassword1" CssClass="control-label col-xs-4">New password:</asp:Label>
                            <div class="col col-xs-8">
                                <asp:TextBox ID="tbNewPassword1" CssClass="form-control" TextMode="Password" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPass1" runat="server" ValidationGroup="vgResetPW" ErrorMessage="Required" Display="Dynamic" ControlToValidate="tbNewPassword1"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationGroup="vgResetPW" ControlToValidate="tbNewPassword1" Display="Dynamic"
    ValidationExpression="(?=.{8,})(?=.*?[^\w\s])(?=.*?[0-9])(?=.*?[A-Za-z]).*"
ErrorMessage="Minimum 8 characters with at least 1 letter, 1 number and 1 symbol" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <asp:Label ID="lblNewPassword2" AssociatedControlID="tbNewPassword2" runat="server" CssClass="control-label col-xs-4">New password:</asp:Label>
                            <div class="col col-xs-8">
                                <asp:TextBox ID="tbNewPassword2" CssClass="form-control" TextMode="Password" runat="server"></asp:TextBox>
                                <asp:CompareValidator ID="cvPass2" runat="server" Display="Dynamic" ValidationGroup="vgResetPW" ErrorMessage="Doesn't match" ControlToValidate="tbNewPassword2" ControlToCompare="tbNewPassword1"></asp:CompareValidator>
                            </div>
                        </div>
                    </div>
                    <br />
                        <div class="alert alert-info"><small>Your password should be at least 8 characters with at least 1 letter, 1 number and 1 symbol.</small></div>
                    <%--<p><asp:Label ID="lblPassword" runat="server"></asp:Label></p>--%>
                </div>
                <div class="card-footer clearfix">
                    <asp:LinkButton ID="btnPasswordOK" runat="server"  ValidationGroup="vgResetPW" Text="Submit" CssClass="float-right btn btn-primary" />
                </div>
            </div>
        </asp:View>
    </asp:MultiView>
      <!-- Modal -->
    <div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    
                    <h5 class="modal-title" id="myModalLabel">
                        <asp:Label ID="lblModalHeading" runat="server" Text=""></asp:Label></h5><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
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
