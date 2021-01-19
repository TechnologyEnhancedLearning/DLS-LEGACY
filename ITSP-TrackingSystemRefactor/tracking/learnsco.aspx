<%@ Page Language="vb" EnableEventValidation="false" Title="Learning Menu" AutoEventWireup="false" EnableViewState="true" CodeBehind="learnsco.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.learnsco" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><%: Page.Title %> - Digital Learning Solutions Tracking System</title>

    <asp:PlaceHolder runat="server">
        <%: Scripts.Render("~/bundles/modernizr") %>
    </asp:PlaceHolder>
   <style>
        .light-grey {
            color: gainsboro;
        }

        .full-screen {
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
        }

        #tutVideo {
            margin: 0 auto;
            height: 75vh;
            text-align: center;
            overflow: hidden;
            max-width: 178vh
        }

        .avatar-100 {
            width: 100px;
            height: 100px;
            border-radius: 100%;
            box-shadow: 0 2px 3px 0 rgba(0,0,0,.14), 0 2px 2px -2px rgba(0,0,0,.2), 0 1px 7px 0 rgba(0,0,0,.12);
            position: absolute;
            top: 0;
            left: 0;
            margin: 10px;
            margin-top: 20px;
            transition: all ease .3s;
            z-index: 2
        }

            .avatar-100:hover {
                box-shadow: 0 6px 10px 0 rgba(0,0,0,.14),0 1px 18px 0 rgba(0,0,0,.12),0 3px 5px -1px rgba(0,0,0,.2);
                transform: translate(-5px,-5px);
                width: 110px;
                height: 110px;
                z-index: 2
            }

        .avatar-60 {
            width: 60px;
            height: 60px;
            border-radius: 100%;
            box-shadow: 0 2px 3px 0 rgba(0,0,0,.14), 0 2px 2px -2px rgba(0,0,0,.2), 0 1px 7px 0 rgba(0,0,0,.12);
            position: absolute;
            top: 0;
            left: 0;
            margin: 10px;
            margin-top: 20px;
            transition: all ease .3s;
            z-index: 2
        }

            .avatar-60:hover {
                box-shadow: 0 6px 10px 0 rgba(0,0,0,.14),0 1px 18px 0 rgba(0,0,0,.12),0 3px 5px -1px rgba(0,0,0,.2);
                transform: translate(-5px,-5px);
                width: 70px;
                height: 70px;
                z-index: 2
            }
            @media all and (-ms-high-contrast: none), (-ms-high-contrast: active) {
            /* IE11 fix for button positioning issue in modal footer */
            .modal-footer {
                display: block !important;
            }
        }
    </style>
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/master.css" rel="stylesheet" />
    <link href="../Content/login.css" rel="stylesheet" />
    <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <link href="../Content/LearnMenu.css" rel="stylesheet" />
    <script src="../Scripts/plugins.min.js"></script>
    <script src="../Scripts/LearnMenu.js"></script>
    <script src="../Scripts/LMS_API.js"></script>
    <script src="../Scripts/bsasper.js"></script>
    <link href="../Content/bootstrap-toggle.min.css" rel="stylesheet" />
    <script src="../Scripts/bootstrap-toggle.min.js"></script>
</head>
<body runat="server" id="LMBody">
    <form id="form1" enableviewstate="true" runat="server">
        <asp:ScriptManager runat="server">
            <Scripts>
                <%--To learn more about bundling scripts in ScriptManager see http://go.microsoft.com/fwlink/?LinkID=301884 --%>
                <%--Framework Scripts--%>
                <asp:ScriptReference Name="MsAjaxBundle" />
                <asp:ScriptReference Name="respond" />
                <asp:ScriptReference Name="WebForms.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebForms.js" />
                <asp:ScriptReference Name="WebUIValidation.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebUIValidation.js" />
                <asp:ScriptReference Name="MenuStandards.js" Assembly="System.Web" Path="~/Scripts/WebForms/MenuStandards.js" />
                <asp:ScriptReference Name="GridView.js" Assembly="System.Web" Path="~/Scripts/WebForms/GridView.js" />
                <asp:ScriptReference Name="DetailsView.js" Assembly="System.Web" Path="~/Scripts/WebForms/DetailsView.js" />
                <asp:ScriptReference Name="TreeView.js" Assembly="System.Web" Path="~/Scripts/WebForms/TreeView.js" />
                <asp:ScriptReference Name="WebParts.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebParts.js" />
                <asp:ScriptReference Name="Focus.js" Assembly="System.Web" Path="~/Scripts/WebForms/Focus.js" />
                <asp:ScriptReference Name="WebFormsBundle" />
                <%--Site Scripts--%>
            </Scripts>
        </asp:ScriptManager>
       <script>
            function BindEvents() {
                $(document).ready(function () {
                    $("input, textarea, select").bsasper({
                        placement: "right", createContent: function (errors) {
                            return '<span class="text-danger">' + errors[0] + '</span>';
                        }
                    });
                    $('.no-collapsable').on('click', function (e) {
                        e.stopPropagation();
                    });
                    $('#videoModal').on('hidden.bs.modal', function () {
                        $('#tutVideo').text('');
                    })
                    LoadProgressText(<%:Session("lmProgressID") %>);
                });
                $('.bs-toggle').bootstrapToggle({
                    on: 'Subscribed',
                    off: 'Unsubscribed',
                    onstyle: 'success',
                    offstyle: 'danger',
                    width: '100px'
                });

                doPopover()

                function doPopover(s, e) {
                    $('[data-toggle="popover"]').popover();
                }
            };
            window.onresize = function () {
                sizeLearnPanel();
            }
            function sizeLearnPanel() {
                var width = $(window).width();
                var height = $(window).height();
                $("#pnlLearnframe").width(width);
                $("#frame1").width(width);
                $("#pnlLearnframe").height(height);
                $("#frame1").height(height);
                if (height < 1000) {
                    document.getElementById("frame1").style.overflow = "auto";
                }
                else {
                    document.getElementById("frame1").style.overflow = "";
                }
            }
        </script>
        <asp:HiddenField ID="hfAssessSrc" ClientIDMode="Static" runat="server" />
        <asp:HiddenField ID="hfProg" ClientIDMode="Static" runat="server" />
        <asp:MultiView ID="mvOuter" runat="server" ActiveViewIndex="0">
            <asp:View ID="vMain" runat="server">
                <div class="container clearfix">
                   
                    <%--Logos--%>
                    <div class="row mt-3 mb-3">
                        <div class="col col-md-6" runat="server" id="mainlogo">
                            
                            <div class="row">
                                <div class="col">
<dx:BootstrapBinaryImage ID="bimgLogo" runat="server"></dx:BootstrapBinaryImage>
                        </div>
                                </div>
                           
                            <div class="row mt-1">
                                <div class="col">
                                    <h3>Learning Menu</h3>
                                </div>
                            </div>
                        </div>
                            <div id="divCtreLogo" runat="server" class="col col-md-6">
                            <asp:Image ID="logoImage" runat="server" ImageUrl="~/centrelogo"
                                Height="100px" Width="300px" class="float-right" />
                            </div>
                           <%-- <img id="logoimg" runat="server" src="~/Images/pathLMLogo.png" />--%>
                        </div>
                    <%--Centre name heading--%>

                    <%--outer learning menu card--%>
                    <asp:Panel ID="pnlMenuPanel" CssClass='<%: Session("sPanelClass") %>' runat="server">
                        <div class="card-header">
                            <div class="row">
                                <div class="col">
 <h5>
                                <asp:Label ID="lblCentreName" runat="server" Text="Label"></asp:Label>
                            </h5>
                            <h6>
                                <asp:Label ID="lblCourseTitle" runat="server" Text="Label"></asp:Label></h6>
                                </div>
                                 <asp:ObjectDataSource ID="dsProgSupervisor" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByProgressID" TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.SupervisorTableAdapter">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="ProgressID" SessionField="lmProgressID" Type="Int32" />
                                    </SelectParameters>
                                </asp:ObjectDataSource>
                                <asp:Repeater ID="rptProgSupervisor" DataSourceID="dsProgSupervisor" runat="server">
                                    <ItemTemplate>
                                        <div class="col-md-4">
                                            <div class="card mt-1 mb-1">
                                                <div class="row no-gutters">
                                                    <div class="col-md-3">
                                                        <dx:BootstrapBinaryImage ID="BootstrapBinaryImage1" CssClasses-Control="avatar-60" Value='<%# Eval("ProfileImage")%>' runat="server" EmptyImage-Url="~/Images/avatar.png"></dx:BootstrapBinaryImage>
                                                    </div>
                                                    <div class="col-md-9">
                                                        <div class="card-body">
                                                            <p class="card-title"><small>Course Supervisor</small><br />
                                                                <b><%# Eval("Forename") & " " & Eval("Surname") %></b></p>
                                                            <p class="card-text"><small class="text-muted"><a href='<%# "mailto:" & Eval("Email") %>'>Email supervisor</a></small></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                                </div>
                        </div>

                        <asp:MultiView ID="mvLearnMenu" ActiveViewIndex="0" runat="server">
                            <asp:View ID="vLogin" runat="server">
                                <div class="card-body">

                                    <asp:Panel ID="pnlLogin" DefaultButton="btnLogin" runat="server">
                                        <div class="row">
                                            <div class="col col-sm-6 col-md-4 col-md-offset-4">
                                                <h1 class="text-center login-title">Sign in to your learning</h1>
                                                <div class="account-wall">
                                                    <div class="text-center"><span aria-hidden="false" class="fas fa-5x fa-user-circle light-grey"></span></div>


                                                    <div class="form-signin">
                                                        <asp:TextBox runat="server" CssClass="form-control" ID="tbUserName" placeholder="User or delegate ID" autofocus />
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="Login" runat="server" ControlToValidate="tbUserName" Display="Dynamic" CssClass="bg-danger" ErrorMessage="This is a required field" />
                                                        <div id="pwdDiv" runat="server">
                                                            <asp:TextBox runat="server" Visible="false" CssClass="form-control" placeholder="Password" ID="tbPassword" TextMode="Password" />
                                                        </div>
                                                        <asp:Button ID="btnLogin" ValidationGroup="Login" runat="server" class="btn btn-lg btn-primary btn-block btn-signin" Text="Sign in" type="submit" />


                                                        <div class="need-help clearfix">
                                                            Forgotten your delegate ID? Type your e-mail address into the ID field above and click
                                    <asp:LinkButton ID="lbtReminder" ValidationGroup="Login" CausesValidation="false" runat="server">Reminder</asp:LinkButton>.
                                                        </div>
                                                    </div>
                                                </div>
                                                <asp:LinkButton ID="lbtRegister" CausesValidation="false" CssClass="text-center new-account btn btn-outline-secondary" runat="server">Register</asp:LinkButton>
                                                <p id="pRegHelp" runat="server">
                                                    <asp:Label ID="lblRegHelp" runat="server" Text=""></asp:Label>
                                                </p>
                                                <asp:Panel ID="pnlError" CssClass="alert alert-danger text-center" Visible="false" runat="server">
                                                    <asp:Label ID="lblError" runat="server" Text=""></asp:Label>
                                                </asp:Panel>

                                            </div>
                                        </div>
                                    </asp:Panel>
                                </div>
                            </asp:View>
                            <asp:View ID="vSecureYourLogin" runat="server">
                                <div class="card-body">
                                    <asp:Panel ID="pnlSecure" DefaultButton="btnSetPassword" runat="server">

                                        <div class="row">
                                            <div class="col col-sm-6 col-md-4 col-md-offset-4">
                                                <h1 class="text-center login-title">
                                                    <asp:Label ID="lblSetPWTitle" runat="server" Text="Secure your Login"></asp:Label></h1>
                                                <div class="account-wall">

                                                    <div class="text-center"><span aria-hidden="false" class="fas fa-5x fa-user-circle light-grey"></span></div>
                                                    <div class="form-signin">
                                                        <p>
                                                            <asp:Label ID="lblSetPWText" runat="server" Text="Secure your login by setting a password."></asp:Label>
                                                        </p>

                                                        <asp:TextBox runat="server" CssClass="form-control user-hard-corners" ID="tbSetPassword1" placeholder="Password" ClientIDMode="Static" TextMode="Password" />
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="vgSecLog" runat="server" ControlToValidate="tbSetPassword1" Display="Dynamic" CssClass="bg-danger" ErrorMessage="This is a required field" />
                                                        <asp:RegularExpressionValidator ID="Regex4" runat="server" ValidationGroup="vgSecLog" ControlToValidate="tbSetPassword1" Display="Dynamic" CssClass="bg-danger"
                                                            ValidationExpression="(?=.{8,})(?=.*?[^\w\s])(?=.*?[0-9])(?=.*?[A-Za-z]).*"
                                                            ErrorMessage="Minimum 8 characters with at least 1 letter, 1 number and 1 symbol" />
                                                        <asp:TextBox runat="server" CssClass="form-control input-pw" placeholder="Confirm password" ID="tbSetPassword2" TextMode="Password" />
                                                        <asp:CompareValidator ID="cfvSetPW2" runat="server" ErrorMessage="Passwords do not match" Display="Dynamic" ControlToValidate="tbSetPassword2" ControlToCompare="tbSetPassword1" ValidationGroup="vgSecLog"></asp:CompareValidator>
                                                        <asp:Button ID="btnSetPassword" ValidationGroup="vgSecLog" runat="server" class="btn btn-lg btn-primary btn-block btn-signin" Text="Submit" type="submit" />



                                                    </div>
                                                </div>
                                                <br />
                                                <div class="alert alert-info"><small>Your password should be at least 8 characters long with at least 1 letter, 1 number and 1 symbol.</small></div>


                                            </div>
                                        </div>
                                    </asp:Panel>
                                </div>
                                <script>
                                    if (!!navigator.userAgent.match(/Trident\/7\./)) {

                                    }
                                    else {
                                        $('#tbSetPassword1').focus()
                                    }
                                </script>
                            </asp:View>
                            <asp:View ID="vUserPassword" runat="server">
                                <div class="card-body">
                                    <asp:Panel ID="pnlUserPassword" DefaultButton="btnSubmitPWord" runat="server">

                                        <div class="row">
                                            <div class="col col-sm-6 col-md-4 col-md-offset-4">
                                                <h1 class="text-center login-title">Sign in to your learning</h1>
                                                <div class="account-wall">
                                                    <div class="text-center"><span aria-hidden="false" class="fas fa-5x fa-user-circle light-grey"></span></div>
                                                    <div class="form-signin">
                                                        <asp:TextBox runat="server" CssClass="form-control" ID="tbUserPassword" placeholder="User password" ClientIDMode="Static" TextMode="Password" />
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="Login" runat="server" ControlToValidate="tbUserPassword" Display="Dynamic" CssClass="bg-danger" ErrorMessage="This is a required field" />

                                                        <asp:Button ID="btnSubmitPWord" ValidationGroup="Login" runat="server" class="btn btn-lg btn-primary btn-block btn-signin" Text="Sign in" type="submit" />


                                                        <div class="float-left need-help">
                                                            Forgotten your password?
                                    <asp:LinkButton ID="lbtResetPW" ValidationGroup="Login" CausesValidation="false" runat="server">Reset</asp:LinkButton>.
                                                        </div>
                                                        <span class="clearfix"></span>
                                                    </div>
                                                </div>

                                                <asp:Panel ID="pnlErrorPW" CssClass="alert alert-danger text-center" Visible="false" runat="server">
                                                    <asp:Label ID="lblErrorPW" runat="server" Text=""></asp:Label></asp:Panel>

                                            </div>
                                        </div>
                                    </asp:Panel>
                                </div>
                                <script>
                                    if (!!navigator.userAgent.match(/Trident\/7\./)) {

                                    }
                                    else {
                                        $('#tbUserPassword').focus()
                                    }
                                </script>
                            </asp:View>
                            <asp:View ID="vLearnerReg" runat="server">
                                <asp:ObjectDataSource ID="dsJobGroups" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.JobGroupsTableAdapter"></asp:ObjectDataSource>
                                <div class="card-body">
                                    <div class="card card-primary">
                                        <div class="card-header">
                                            <h4>Register for Digital Learning Solutions</h4>
                                        </div>
                                        <div class="card-body">

                                            <asp:Panel ID="pnlIPAlert" CssClass="alert alert-danger" Visible="false" runat="server">
                                                <asp:Label ID="lblIPWarning" runat="server" Text="You appear to be accessing this web site from an unapproved Internet location. If you proceed to register, your registration will need to be approved by a centre administrator. To avoid this, try registering from a PC in your place of work."></asp:Label>
                                            </asp:Panel>

                                            <section id="registrationForm" class="m-3">
                                                <div class="form-group row">
                                                    <asp:Label ID="Label1" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="tbFName">First name</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbFName" CssClass="form-control" runat="server" TabIndex="1" MaxLength="250"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfFName" ValidationGroup="Register" runat="server" ControlToValidate="tbFName" Display="Dynamic"
                                                            CssClass="field-validation-error" ErrorMessage="The first name field is required" />
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label2" CssClass="control-label col-sm-4" runat="server" AssociatedControlID="tbLName">Last name</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbLName" CssClass="form-control" runat="server" TabIndex="2" MaxLength="250"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="rfEmail" ValidationGroup="Register" runat="server" ControlToValidate="tbLName" Display="Dynamic"
                                                            CssClass="field-validation-error" ErrorMessage="The last name field is required" />
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label3" CssClass="control-label col-sm-4" runat="server" AssociatedControlID="tbEmail">Email address</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox runat="server" ID="tbEmail" CssClass="form-control" TabIndex="3" TextMode="Email" />
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="Register" runat="server" ControlToValidate="tbEmail" Display="Dynamic"
                                                            CssClass="field-validation-error" ErrorMessage="The email address field is required" />
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label4" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="ddJobGroup">Job group</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:DropDownList ID="ddJobGroup" CssClass="form-control" runat="server"
                                                            AppendDataBoundItems="True" TabIndex="3"
                                                            DataSourceID="dsJobGroups" DataTextField="JobGroupName"
                                                            DataValueField="JobGroupID">
                                                            <asp:ListItem Selected="True" Value="0">--Select--</asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:RequiredFieldValidator ID="rfvJobGroup" runat="server" ErrorMessage="Please select a job group"
                                                            CssClass="field-validation-error" ControlToValidate="ddJobGroup" ValidationGroup="Register" ToolTip="Required" SetFocusOnError="True" Display="Dynamic"
                                                            InitialValue="0"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>
                                                <div id="trCustField1" runat="server" class="form-group row">
                                                    <asp:Label ID="lblCustField1" runat="server" CssClass="col col-sm-4 control-label" AssociatedControlID="tbField1">Field 1</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbField1" CssClass="form-control" runat="server" MaxLength="250" TabIndex="5"></asp:TextBox>
                                                        <asp:DropDownList ID="ddField1" CssClass="form-control" runat="server" TabIndex="5"></asp:DropDownList>
                                                    </div>
                                                </div>
                                                <div class="form-group row" id="trCustField2" runat="server">
                                                    <asp:Label ID="lblCustField2" CssClass="col col-sm-4 control-label" runat="server" AssociatedControlID="tbField2">Field 2</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbField2" CssClass="form-control" runat="server" MaxLength="250" TabIndex="5"></asp:TextBox>
                                                        <asp:DropDownList CssClass="form-control" ID="ddField2" runat="server" TabIndex="5"></asp:DropDownList>
                                                    </div>
                                                </div>
                                                <div class="form-group row" id="trCustField3" runat="server">
                                                    <asp:Label ID="lblCustField3" CssClass="col col-sm-4 control-label" runat="server" AssociatedControlID="tbField3">Field 3</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox CssClass="form-control" ID="tbField3" runat="server" MaxLength="250" TabIndex="5"></asp:TextBox>
                                                        <asp:DropDownList CssClass="form-control" ID="ddField3" runat="server" TabIndex="5"></asp:DropDownList>
                                                    </div>
                                                </div>
                                                <div class="form-group row" id="trCustField4" runat="server">
                                                    <asp:Label ID="lblCustField4" CssClass="col col-sm-4 control-label" runat="server" AssociatedControlID="tbField4">Field 4</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox CssClass="form-control" ID="tbField4" runat="server" MaxLength="250" TabIndex="5"></asp:TextBox>
                                                        <asp:DropDownList CssClass="form-control" ID="ddField4" runat="server" TabIndex="5"></asp:DropDownList>
                                                    </div>
                                                </div>
                                                <div class="form-group row" id="trCustField5" runat="server">
                                                    <asp:Label ID="lblCustField5" CssClass="col col-sm-4 control-label" runat="server" AssociatedControlID="tbField5">Field 5</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox CssClass="form-control" ID="tbField5" runat="server" MaxLength="250" TabIndex="5"></asp:TextBox>
                                                        <asp:DropDownList CssClass="form-control" ID="ddField5" runat="server" TabIndex="5"></asp:DropDownList>
                                                    </div>
                                                </div>
                                                <div class="form-group row" id="trCustField6" runat="server">
                                                    <asp:Label ID="lblCustField6" CssClass="col col-sm-4 control-label" runat="server" AssociatedControlID="tbField6">Field 6</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox CssClass="form-control" ID="tbField6" runat="server" MaxLength="250" TabIndex="5"></asp:TextBox>
                                                        <asp:DropDownList CssClass="form-control" ID="ddField6" runat="server" TabIndex="5"></asp:DropDownList>
                                                    </div>
                                                </div>
                                                <asp:Panel ID="pnlRegistrationError" Visible="false" CssClass="alert alert-danger" runat="server">
                                                    <asp:Label ID="lblRegistrationError" runat="server" Text="Label"></asp:Label>
                                                </asp:Panel>
                                            </section>
                                        </div>
                                        <div class="card-footer clearfix">
                                            <asp:Button ID="btnRegister" CssClass="float-right btn btn-primary" ValidationGroup="Register" CausesValidation="true" runat="server" Text="Register" />

                                        </div>
                                    </div>


                                    <br />

                                    <p>
                                        Already have a Digital Learning Solutions login?
                    <asp:LinkButton ID="btnLoginReturn" runat="server" CommandName="Logout"
                        ToolTip="Login" CausesValidation="False">Log in here</asp:LinkButton>
                                    </p>
                                </div>
                            </asp:View>
                            <asp:View ID="vUpdateDetails" runat="server">
                                <div class="card-body">
                                    <asp:Panel ID="pnlUpdateDetails" runat="server" DefaultButton="btnUpdateDetails">
                                        <div class="card card-primary">
                                            <div class="card-header">
                                                <h4>Update your details</h4>
                                            </div>
                                            <div class="card-body">
                                                <asp:HiddenField ID="hfActive" runat="server" />
                                                <asp:HiddenField ID="hfApproved" runat="server" />
                                                <asp:HiddenField ID="hfAlias" runat="server" />
                                                <div id="updateDetailsForm" class="m-3">
                                                    <div class="form-group row">
                                                        <asp:Label ID="Label5" CssClass="col col-sm-4 control-label" AssociatedControlID="tbFName_u" runat="server" Text="First name:"></asp:Label>
                                                        <div class="col col-sm-8">
                                                            <asp:TextBox ID="tbFName_u" CssClass="form-control" ValidationGroup="vgUpdateDetails" runat="server" TabIndex="1" MaxLength="250"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="rfvFName_u" runat="server" ErrorMessage="Required" ValidationGroup="vgUpdateDetails" Text="Required" ControlToValidate="tbFName_u"
                                                                ToolTip="Required" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <asp:Label ID="Label6" CssClass="col col-sm-4 control-label" AssociatedControlID="tbLName_u" runat="server" Text="Last name:"></asp:Label>
                                                        <div class="col col-sm-8">
                                                            <asp:TextBox ID="tbLName_u" CssClass="form-control" ValidationGroup="vgUpdateDetails" runat="server" MaxLength="250" TabIndex="2"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="rfvLName_u" runat="server" ValidationGroup="vgUpdateDetails" ErrorMessage="Required" Text="Required" ControlToValidate="tbLName_u"
                                                                ToolTip="Required" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <asp:Label ID="Label7" CssClass="col col-sm-4 control-label" AssociatedControlID="tbEmail_u" runat="server" Text="E-mail address:"></asp:Label>
                                                        <div class="col col-sm-8">
                                                            <asp:TextBox ID="tbEmail_u" CssClass="form-control" ValidationGroup="vgUpdateDetails" runat="server" MaxLength="250" TabIndex="2"></asp:TextBox><asp:RequiredFieldValidator
                                                                ID="rfvEmail_u" runat="server" ErrorMessage="Required" Text="Required" ControlToValidate="tbEmail_u"
                                                                ToolTip="Required" ValidationGroup="vgUpdateDetails" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <asp:Label ID="Label8" CssClass="col col-sm-4 control-label" AssociatedControlID="ddJobGroup_u" runat="server" Text="Job group:"></asp:Label>
                                                        <div class="col col-sm-8">
                                                            <asp:DropDownList ID="ddJobGroup_u" CssClass="form-control" ValidationGroup="vgUpdateDetails" runat="server" DataSourceID="dsJobGroups"
                                                                DataTextField="JobGroupName" DataValueField="JobGroupID" AppendDataBoundItems="True">
                                                                <asp:ListItem Value="0">--Select--</asp:ListItem>
                                                            </asp:DropDownList>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="vgUpdateDetails" runat="server" ErrorMessage="Required"
                                                                Text="*" ControlToValidate="ddJobGroup_u" ToolTip="Required" SetFocusOnError="True" Display="Dynamic"
                                                                InitialValue="0"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </div>
                                                    <asp:Panel runat="server" ID="pnlField1_u" CssClass="form-group row">
                                                        <asp:Label ID="lblField1_u" AssociatedControlID="tbField1_u" CssClass="col col-sm-4 control-label" runat="server" Text="Label"></asp:Label>
                                                        <div class="col col-sm-8">
                                                            <asp:TextBox ID="tbField1_u" CssClass="form-control" ValidationGroup="vgUpdateDetails" runat="server" MaxLength="250" TabIndex="2"></asp:TextBox>
                                                            <asp:DropDownList ID="ddField1_u" CssClass="form-control" ValidationGroup="vgUpdateDetails" runat="server">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </asp:Panel>
                                                    <asp:Panel runat="server" ID="pnlField2_u" class="form-group row">
                                                        <asp:Label ID="lblField2_u" AssociatedControlID="tbField2_u" CssClass="col col-sm-4 control-label" runat="server" Text="Label"></asp:Label>
                                                        <div class="col col-sm-8">
                                                            <asp:TextBox ID="tbField2_u" CssClass="form-control" ValidationGroup="vgUpdateDetails" runat="server" Width="240px" MaxLength="250" TabIndex="2"></asp:TextBox>
                                                            <asp:DropDownList ID="ddField2_u" CssClass="form-control" ValidationGroup="vgUpdateDetails" runat="server">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </asp:Panel>
                                                    <asp:Panel ID="pnlField3_u" runat="server" class="form-group row">
                                                        <asp:Label ID="lblField3_u" AssociatedControlID="tbField3_u" CssClass="col col-sm-4 control-label" runat="server" Text="Label"></asp:Label>
                                                        <div class="col col-sm-8">
                                                            <asp:TextBox ID="tbField3_u" CssClass="form-control" ValidationGroup="vgUpdateDetails" runat="server" Width="240px" MaxLength="250" TabIndex="2"></asp:TextBox>
                                                            <asp:DropDownList ID="ddField3_u" CssClass="form-control" ValidationGroup="vgUpdateDetails" runat="server">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </asp:Panel>
                                                    <asp:Panel ID="pnlField4_u" runat="server" class="form-group row">
                                                        <asp:Label ID="lblField4_u" AssociatedControlID="tbField4_u" CssClass="col col-sm-4 control-label" runat="server" Text="Label"></asp:Label>
                                                        <div class="col col-sm-8">
                                                            <asp:TextBox ID="tbField4_u" CssClass="form-control" ValidationGroup="vgUpdateDetails" runat="server" Width="240px" MaxLength="250" TabIndex="2"></asp:TextBox>
                                                            <asp:DropDownList ID="ddField4_u" CssClass="form-control" ValidationGroup="vgUpdateDetails" runat="server">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </asp:Panel>
                                                    <asp:Panel ID="pnlField5_u" runat="server" class="form-group row">
                                                        <asp:Label ID="lblField5_u" AssociatedControlID="tbField5_u" CssClass="col col-sm-4 control-label" runat="server" Text="Label"></asp:Label>
                                                        <div class="col col-sm-8">
                                                            <asp:TextBox ID="tbField5_u" CssClass="form-control" ValidationGroup="vgUpdateDetails" runat="server" Width="240px" MaxLength="250" TabIndex="2"></asp:TextBox>
                                                            <asp:DropDownList ID="ddField5_u" CssClass="form-control" ValidationGroup="vgUpdateDetails" runat="server">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </asp:Panel>
                                                    <asp:Panel ID="pnlField6_u" runat="server" class="form-group row">
                                                        <asp:Label ID="lblField6_u" AssociatedControlID="tbField6_u" CssClass="col col-sm-4 control-label" runat="server" Text="Label"></asp:Label>
                                                        <div class="col col-sm-8">
                                                            <asp:TextBox ID="tbField6_u" CssClass="form-control" ValidationGroup="vgUpdateDetails" runat="server" Width="240px" MaxLength="250" TabIndex="2"></asp:TextBox>
                                                            <asp:DropDownList ID="ddField6_u" CssClass="form-control" ValidationGroup="vgUpdateDetails" runat="server">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </asp:Panel>
                                                </div>
                                            </div>
                                            <div class="card-footer clearfix">
                                                <asp:LinkButton ID="btnUpdateDetails" runat="server" ValidationGroup="vgUpdateDetails" ToolTip="Update details" CssClass="btn btn-primary float-right">Update</asp:LinkButton>
                                            </div>

                                        </div>
                                    </asp:Panel>
                                </div>
                            </asp:View>

                            <asp:View ID="vLearnMenu" runat="server">
                                <div class="row">
                                <div class="col">
                                    How to use:
											<asp:LinkButton ID="lbtDiagVid" CommandName="DiagVid" CssClass="btn btn-sm btn-info" runat="server"
                                                ToolTip="Launch &quot;How To&quot; video"><i aria-hidden="true" class="fas fa-video"></i> Diagnostics</asp:LinkButton>
                                    <asp:LinkButton CssClass="btn btn-sm btn-info" ID="lbtLearnVid" runat="server" CommandName="LearnVid"
                                        ToolTip="Launch &quot;How To&quot; video"><i aria-hidden="true" class="fas fa-video"></i> Learning Materials</asp:LinkButton>
                                    <asp:LinkButton CssClass="btn btn-sm btn-info" ID="lbtPLAssess" CommandName="PLVid" runat="server"
                                        ToolTip="Launch &quot;How To&quot; video"><i aria-hidden="true" class="fas fa-video"></i> Assessments</asp:LinkButton>
                                </div>

                                <div class="col">
                                    <div class="float-right">
                                        <div style="font-size: 1.5em">
                                            <button id="btnGroup" type="button" class="btn btn-success ml-2" runat="server" visible="false" data-toggle="modal" data-target="#cohortModal"><i class="fas fa-users mr-1""></i> My Group</button>
                                            <button id="btnSupervisor" type="button" class="btn btn-success ml-2" runat="server" visible="false" data-toggle="modal" data-target="#cohortModal"><i class="fas fa-chalkboard-teacher mr-1""></i> Supervisor</button>
                                            <asp:LinkButton ID="lbtnlogout" CssClass="btn btn-primary ml-2" runat="server"><i class="fas fa-sign-out-alt mr-1"></i>Logout</asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                                                              
                            </div>
                            <br />
                            <asp:LinkButton ID="btnPost" runat="server" Visible="True" CssClass="hiddencol"></asp:LinkButton>
                            <asp:LinkButton ID="btnSwitchView" runat="server" Visible="True" CssClass="hiddencol"></asp:LinkButton>
                            <asp:ObjectDataSource ID="dsLMSections" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByUSP" TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.LMSectionsTableAdapter">
                                <SelectParameters>
                                    <asp:SessionParameter Name="ProgressID" SessionField="lmProgressID" Type="Int32" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                                                        <asp:Repeater ID="rptLMSections" runat="server" DataSourceID="dsLMSections">

                                <ItemTemplate>
                                    <asp:HiddenField ID="hfSectionID" Value='<%#Eval("SectionID")%>' runat="server"></asp:HiddenField>
                                    <asp:HiddenField ID="hfRowNumber" Value='<%#Container.ItemIndex%>' runat="server"></asp:HiddenField>
                                    <asp:ObjectDataSource ID="dsLMTutorials" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.uspReturnProgressDetailTableAdapter">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="ProgressID" SessionField="lmProgressID" Type="Int32" />
                                            <asp:ControlParameter Name="SectionID" Type="Int32" ControlID="hfSectionID" />

                                        </SelectParameters>
                                    </asp:ObjectDataSource>

                                    <asp:Panel ID="pnlSectionHeader" CssClass='<%# GetSectionClass(Eval("PCComplete")) %>' runat="server">
                                        <div class="card-header clickable clearfix" data-toggle="collapse" data-target='<%# ".Accordion" & Eval("SectionID")%>'>
                                            <i class="fas fa-plus"></i>&nbsp;&nbsp;<asp:Label ID="lblSectionHeader" runat="server" Text='<%#Eval("SectionName")%>'></asp:Label>
                                            <div class="float-right">
                                                <asp:Label ID="lblSecStatus" runat="server" Style="font-size: 10px; color: #666666;"
                                                    Text='<%#Eval("PCComplete", "{0}% complete")%>' />
                                                &nbsp;
																								<asp:Label ID="Label12" Visible='<%#Eval("HasLearning")%>' runat="server" Style="font-size: 10px; color: #666666;" Text='<%#Eval("TimeMins", "{0} mins")%>'
                                                                                                    ToolTip='<%#Eval("TimeMins", "You have spent {0} mins on the tutorials in this section")%>' />&nbsp;
																								<asp:Label ID="Label13" Visible='<%#Eval("HasLearning")%>' runat="server" Style="font-size: 10px; color: #666666;" Text='<%#Eval("AvgSecTime", "(average time {0} mins)")%>'
                                                                                                    ToolTip='<%#Eval("AvgSecTime", "Average completion time for the tutorials in this section is {0} mins")%>' />
                                            </div>
                                        </div>
                                       
                                        <div id="TutsCollapse" class='<%# "section-panel collapse Accordion" & Eval("SectionID")%>' runat="server">
                                            <div class="card-body">
                                                <ul class="list-group">

                                                    <li class="list-group-item list-group-item-assess" runat="server" visible='<%# Eval("DiagAssessPath").ToString.Length > 0 And Eval("DiagStatus")%>'>
                                                        <div class="row">
                                                            <div class="col col-sm-6">
                                                                Diagnostic Assessment<br />
                                                                <asp:Label ID="lblDiagOutcome" CssClass="small text-muted" runat="server" Text='<%# Eval("SecScore").ToString + " / " + Eval("SecOutOf").ToString + " - " + Eval("DiagAttempts").ToString + " attempt(s)" %>'
                                                                    Visible='<%# Eval("DiagAttempts").ToString <> "0" %>'></asp:Label>
                                                                <asp:Label ID="lblDiagNotAttempted" CssClass="small text-muted" runat="server" Text="Not attempted"
                                                                    Visible='<%# Eval("DiagAttempts").ToString = "0" %>'></asp:Label>
                                                            </div>
                                                            <div class="col col-sm-6">
                                                                <button type="button" class="btn btn-success btn-sm" onclick="javascript:LaunchAssessment(<%# Eval("SectionID")%>, <%# Session("lmCustomisationID")%>, <%# Session("UserCentreID")%>, false, <%# Session("lmCustDiagObjSelect").ToString.ToLower()%>, false, '<%# Eval("DiagAssessPath")%>', '<%# getTrackingURL() %>', <%# Session("lmCustomisationID")%>, <%# Session("lmProgressID")%>, <%# Session("lmCustVersion")%>, <%# Session("lmPlaPassThreshold")%>, <%# Session("learnCandidateID")%>)" title="Launch diagnostic assessment"><i aria-hidden="true" class="fas fa-play p-2"></i></button>
                                                                <%--<asp:LinkButton ID="lbtLaunchDiag" runat="server" CausesValidation="false" CommandArgument='<%# Eval("DiagAssessPath") %>'
                                                                    CommandName="LaunchDiag" CssClass="btn btn-success btn-sm" ToolTip="Launch diagnostic assessment"
                                                                    UseSubmitBehavior="False"><i aria-hidden="true" class="fas fa-play p-2"></i></asp:LinkButton>--%>
                                                            </div>
                                                        </div>
                                                    </li>
                                                    <asp:Repeater ID="rptTutorials" runat="server" OnItemCommand="rptTutorials_ItemCommand" DataSourceID="dsLMTutorials">
                                                        <ItemTemplate>
                                                            <li class="list-group-item">
                                                                <div class="row">
                                                                    <div class="col col-sm-6 col-xs-12">
                                                                        <asp:Label ID="lblTutorialTitle" runat="server" Text='<%#Eval("TutorialName")%>' /><br />
                                                                        <asp:Label ID="Label1" runat="server" CssClass="small text-muted" Text='<%#Eval("Status", "{0}")%>' />
                                                                        &nbsp;
																											<asp:Label ID="Label12" runat="server" CssClass="small text-muted" Text='<%#Eval("TutTime", "{0} mins")%>'
                                                                                                                ToolTip='<%#Eval("TutTime", "You have spent {0} mins on this tutorial")%>' />&nbsp;
																											<asp:Label ID="Label14" runat="server" CssClass="small text-muted" Text='<%#Eval("AvgTime", "(average time {0} mins)")%>'
                                                                                                                ToolTip='<%#Eval("AvgTime", "Average completion time for this tutorial is {0} mins")%>' />&nbsp;
																											<asp:Label ID="lblDiagOutcome" CssClass="small text-muted" runat="server" Text='<%#"Diagnostic: " + Eval("TutScore").ToString + "/" + Eval("PossScore").ToString %>'
                                                                                                                Visible='<%# Eval("DiagAttempts") > 0 And Eval("DiagStatus") %>' />&nbsp;
																											<asp:Label ID="lblRecommended" CssClass="small text-danger" runat="server" Text="Recommended"
                                                                                                                ToolTip="Based on your diagnostic assessment outcome, this tutorial is recommended"
                                                                                                                Font-Bold="True" Visible='<%# Eval("DiagAttempts") > 0 And Eval("DiagStatus") And Eval("TutScore") < Eval("PossScore") %>' />
                                                                        <asp:Label ID="lblOptional" CssClass="small text-success" runat="server" Text="Optional" ToolTip="Based on your diagnostic assessment outcome, this tutorial is optional"
                                                                            Font-Bold="True" Visible='<%# Eval("DiagAttempts") > 0 And Eval("DiagStatus") And Eval("TutScore") = Eval("PossScore") %>' />
                                                                    </div>
                                                                    <div class="col col-sm-1 col-xs-2">
                                                                        <button type="button" visible='<%#Eval("Objectives").ToString.Trim.Length > 0%>' class="btn btn-danger btn-sm" runat="server" title="View objectives" data-toggle="modal" data-target='<%#".objective-modal-" & Eval("TutorialID")%>'>
                                                                            <i aria-hidden="true" class="far fa-dot-circle p-2"></i>
                                                                        </button>


                                                                    </div>
                                                                    <div class="col col-sm-1 col-xs-2">
                                                                        <asp:LinkButton ID="lbtPlayVideo" CausesValidation="false" CommandArgument='<%# Eval("TutorialID")%>' Visible='<%# Eval("VideoPath").ToString.Length > 0 %>' ToolTip="Watch introduction video" CommandName="cmdIntro" class="btn btn-info btn-sm" runat="server"><i aria-hidden="true" class="fas fa-video p-2"></i></asp:LinkButton>
                                                                    </div>
                                                                    <div class="col col-sm-1 col-xs-2">
                                                                        <asp:LinkButton ID="lbtLaunchTutorial" CausesValidation="false" ToolTip="Launch tutorial" CommandArgument='<%# Eval("TutorialID")%>' CommandName="cmdLaunch" class="btn btn-success btn-sm" runat="server"><i aria-hidden="true" class="fas fa-play p-2"></i></asp:LinkButton>
                                                                    </div>
                                                                    <div class="col col-sm-1 col-xs-2">
                                                                        <asp:LinkButton ID="lbtSupportMats" CausesValidation="false" ToolTip="View supporting information" CommandArgument='<%# Eval("TutorialID")%>' Visible='<%# Eval("SupportingMatsPath").ToString.Length > 0 %>' CommandName="cmdSupport" class="btn btn-warning btn-sm" runat="server"><i aria-hidden="true" class="fas fa-info-circle p-2"></i></asp:LinkButton>
                                                                    </div>
                                                                </div>
                                                            </li>
                                                            <%--This is the modal dialogue that will display the objectives:--%>
                                                            <div runat="server" class='<%#"modal fade objective-modal-" & Eval("TutorialID")%>' id="messageModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                                                                <div class="modal-dialog" role="document">
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">

                                                                            <h6 class="modal-title" id="myModalLabel">
                                                                                <asp:Label ID="lblModalHeading" runat="server" Text='<%#"Objectives: " & Eval("TutorialName")%>'></asp:Label></h6>
                                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <asp:Literal ID="litObjective" Text='<%#Eval("Objectives")%>' runat="server"></asp:Literal>

                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <button type="button" class="btn btn-primary float-right" data-dismiss="modal">OK</button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                        </ItemTemplate>
                                                    </asp:Repeater>

                                                    <li class="list-group-item list-group-item-assess" runat="server" visible='<%# Eval("PLAssessPath").ToString.Length > 0 And Eval("IsAssessed")%>'>
                                                        <div class="row">
                                                            <div class="col col-sm-6">
                                                                Post Learning Assessment<br />
                                                                <asp:Label ID="lblPLAssessOutcome" CssClass="small text-muted" runat="server" Visible='<%# Eval("AttemptsPL").ToString <> "0" %>'
                                                                    Text='<%# Eval("MaxScorePL").ToString + "%  - " + Eval("AttemptsPL").ToString + " attempt(s)" %>'></asp:Label>
                                                                <asp:Label ID="lblPLAssessStatus" CssClass="small text-muted label-default" runat="server" Text="Not attempted"
                                                                    Visible='<%# Eval("AttemptsPL").ToString = "0" %>'></asp:Label>
                                                                <asp:Label ID="lblRecommended" CssClass="label text-danger" runat="server" Text="FAILED"
                                                                    Font-Bold="True" Visible='<%# Eval("AttemptsPL") > 0 And Eval("IsAssessed") And Eval("PLPassed").ToString = "False" %>' />
                                                                <asp:Label ID="lblOptional" CssClass="label text-success" runat="server" Text="PASSED" Font-Bold="True"
                                                                    Visible='<%# Eval("AttemptsPL") > 0 And Eval("IsAssessed") And Eval("PLPassed") %>' />
                                                            </div>
                                                            <div class="col col-sm-6">
                                                                 <button type="button" <%# IIf(Eval("PLLocked"), "disabled='disabled'", "") %> class='<%# IIF(Eval("PLLocked"), "btn btn-success btn-sm disabled", "btn btn-success btn-sm")%>' title='<%# IIf(Eval("PLLocked"), "LOCKED - You have too many failed assessments for this course.", "Launch Post Learning Assessment")%>' onclick="javascript:LaunchAssessment(<%# Eval("SectionID")%>, <%# Session("lmCustomisationID")%>, <%# Session("UserCentreID")%>, true, false, true, '<%# Eval("PLAssessPath")%>', '<%# getTrackingURL() %>', <%# Session("lmCustomisationID")%>, <%# Session("lmProgressID")%>, <%# Session("lmCustVersion")%>, <%# Session("lmPlaPassThreshold")%>, <%# Session("learnCandidateID")%>)"><i aria-hidden="true" class="fas fa-play p-2"></i></button>
                                                               
                                                                <%--<asp:LinkButton ID="lbtLaunchPLAssess" Enabled='<%# Not Eval("PLLocked") %>' runat="server" CausesValidation="false" CommandArgument='<%# Eval("PLAssessPath") %>'
                                                                    CommandName="LaunchPLAssess" CssClass='<%# IIF(Eval("PLLocked"), "btn btn-success btn-sm disabled", "btn btn-success btn-sm")%>' ToolTip='<%# IIf(Eval("PLLocked"), "LOCKED - You have too many failed assessments for this course.", "Launch Post Learning Assessment")%>'
                                                                    UseSubmitBehavior="False"><i aria-hidden="true" class="fas fa-play p-2"></i></asp:LinkButton>--%>
                                                            </div>
                                                        </div>
                                                    </li>
                                                    <li class="list-group-item list-group-item-consol" runat="server" visible='<%# Eval("ConsolidationPath").ToString.Length > 0 %>'>
                                                        <div class="row">
                                                            <div class="col col-sm-6">Consolidation Exercise</div>
                                                            <div class="col col-sm-1 col-xs-2">
                                                                <asp:HyperLink CssClass="btn btn-warning btn-sm"
                                                                    ID="DownloadLink" Text="Download consolidation exercise" ToolTip="Click to download"
                                                                    Target='_blank' runat="server" NavigateUrl='<%# "~/tracking/dlconsolidation?client=" + Eval("ConsolidationPath") %>'><i aria-hidden="true" class="fas fa-file-export p-2"></i></asp:HyperLink>
                                                            </div>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </asp:Panel>
                                     <script>
                                            $('<%# ".Accordion" & Eval("SectionID")%>').on('shown.bs.collapse', function () {
                                                UpdateProgressText(<%# Eval("SectionID")%>, <%#Session("lmProgressID") %>, true);

                                         })
                                          $('<%# ".Accordion" & Eval("SectionID")%>').on('hidden.bs.collapse', function () {
                                                UpdateProgressText(<%# Eval("SectionID")%>, <%#Session("lmProgressID") %>, false);

  })
                                        </script>
                                </ItemTemplate>
                            </asp:Repeater>
                                    <script>$('.collapse').on('shown.bs.collapse', function () {
    $(this).parent().find(".fas fa-plus").removeClass("fas fa-plus").addClass("fas fa-minus");
}).on('hidden.bs.collapse', function () {
    $(this).parent().find(".fas fa-minus").removeClass("fas fa-minus").addClass("fas fa-plus");
});</script>

                                    <asp:ObjectDataSource ID="dsProgressSummary" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.uspReturnProgressSummaryV2TableAdapter">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="ProgressID" SessionField="lmProgressID" Type="Int32" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                </div>
                                <div class="card-footer">
                                    <asp:FormView ID="fvProgSummary" RenderOuterTable="false" runat="server" DataKeyNames="ProgressID" DataSourceID="dsProgressSummary">
                                        <ItemTemplate>
                                            <div class='<%# "panel card-" & IIf(Eval("Completed").ToString.Length > 0, "hundred", "fifty") %>'>
                                                <div data-toggle="collapse" data-target="#progsummary" class="card-header clickable clearfix">
                                                    <div class="row">
                                                        <div class="col col-xs-12">
                                                            <table style="width: 100%;">
                                                                <tr>
                                                                    <td style="width: 40px;">
                                                                        <i class="fas fa-plus"></i></td>
                                                                    <td>
                                                                        <asp:Label ID="Label9" Visible='<%# Eval("Completed").ToString.Length = 0 %>'
                                                                            runat="server" Text='Course Incomplete' Font-Bold="True" />
                                                                        <asp:Label ID="lblCompReq1" Visible='<%# Eval("IsAssessed") And Eval("Completed").ToString.Trim.Length < 2 %>' runat="server" Text='<%# IIF(Eval("AssessAttempts").ToString = "0", "To complete this course, you must pass all post learning assessments with a score of " & Eval("PLAPassThreshold").ToString() & "% or higher.", "To complete this course, you must pass all post learning assessments with a score of " & Eval("PLAPassThreshold").ToString() & "% or higher. Failing an assessment " & Eval("AssessAttempts").ToString() & " times will lock your progress.") %>' />
                                                                        <asp:Label ID="lblCompReq2" Visible='<%# Convert.ToInt32(Eval("DiagCompletionThreshold")) > 0 And Convert.ToInt32(Eval("TutCompletionThreshold")) > 0 And Not Eval("IsAssessed") And Eval("Completed").ToString.Trim.Length < 2 %>'
                                                                            runat="server" Text='<%#Eval("DiagCompletionThreshold", "To complete this course, you must achieve {0}% in the diagnostic assessment and complete ") & Eval("TutCompletionThreshold", "{0}% of the learning materials") %>' />
                                                                        <asp:Label ID="lblCompReq3" Visible='<%# Convert.ToInt32(Eval("DiagCompletionThreshold")) = 0 And Not Eval("IsAssessed") And Eval("Completed").ToString.Trim.Length < 2 %>'
                                                                            runat="server" Text='<%#Eval("TutCompletionThreshold", "To complete this course, you must complete {0}% of the learning materials") %>' />
                                                                        <asp:Label ID="lblCompReq4" Visible='<%# Convert.ToInt32(Eval("TutCompletionThreshold")) = 0 And Not Eval("IsAssessed") And Eval("Completed").ToString.Trim.Length < 2 %>'
                                                                            runat="server" Text='<%#Eval("DiagCompletionThreshold", "To complete this course, you must achieve {0}% in the diagnostic assessment") %>' />
                                                                        <asp:Label ID="lblCompleted" Visible='<%# Eval("Completed").ToString.Length > 0 %>'
                                                                            runat="server" Text='Course Complete' ToolTip='<%#Eval("Completed", "You completed this course on {0:dd MMMM yyyy}")%>' Font-Bold="True" />
                                                                    </td>

                                                                    <td>
                                                                        <div class="float-right">
                                                                            <asp:LinkButton ID="lbtSummary" CssClass="btn btn-secondary btn-sm no-collapsable" CommandName="summary" ToolTip="Generate PDF progress summary for printing / saving / sending"
                                                                                runat="server"><i aria-hidden="true" class="far fa-file-pdf"></i> Summary</asp:LinkButton>
                                                                            <asp:LinkButton Visible='<%# Eval("IsAssessed") And Eval("Completed").ToString.Length > 0 And Eval("Evaluated").ToString.Length = 0 %>'
                                                                                ID="lbtEvalCert" runat="server" ToolTip="Click to complete evaluation and access certificate"
                                                                                CssClass="btn btn-success btn-sm no-collapsable" CommandName="finalise"><i aria-hidden="true" class="fas fa-trophy"></i>Evaluate and certificate</asp:LinkButton>
                                                                            <asp:LinkButton Visible='<%# Not Eval("IsAssessed") And Eval("Completed").ToString.Length > 0 And Eval("Evaluated").ToString.Length = 0 %>'
                                                                                ID="lbtEval" runat="server" ToolTip="Click to complete post-course evaluation"
                                                                                CssClass="btn btn-secondary btn-sm no-collapsable" CommandName="finalise"><i aria-hidden="true" class="far fa-check-square"></i> Evaluate</asp:LinkButton>
                                                                            <asp:LinkButton Visible='<%# Eval("IsAssessed") And Eval("Completed").ToString.Length > 0 And Eval("Evaluated").ToString.Length > 0 %>'
                                                                                ID="lbtCert" runat="server" ToolTip="Click to access certificate of completion"
                                                                                CssClass="btn btn-success btn-sm no-collapsable" CommandName="finalise"><i aria-hidden="true" class="fas fa-trophy"></i> Certificate</asp:LinkButton>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>

                                                    </div>
                                                </div>
                                                <div class="card-body collapse" id="progsummary">

                                                    <div class="row">
                                                        <div runat="server" class="col col-sm-4" visible='<%# Eval("DiagAttempts") > 0 %>'>
                                                            Diagnostic Score: 
                                                    <asp:Label ID="lblDiagScore" Font-Bold="true" runat="server" Text='<%# Eval("DiagnosticScore", "{0}%") %>'></asp:Label>
                                                        </div>
                                                        <div runat="server" class="col col-sm-4" visible='<%# Eval("LearningDone") > 0 %>'>
                                                            Learning Completed: 
                                                    <asp:Label Font-Bold="true" ID="Label15" runat="server" Text='<%# Eval("LearningDone", "{0}%") %>'></asp:Label>
                                                        </div>
                                                        <div runat="server" class="col col-sm-4" visible='<%# Eval("IsAssessed") %>'>
                                                            Assessments Passed: 
                                                    <asp:Label Font-Bold="true" ID="Label16" runat="server" Text='<%# Eval("PLPasses") & " out of " & Eval("Sections") %>'></asp:Label>
                                                        </div>
                                                    </div>


                                                </div>
                                            </div>
                                            <script>$('.collapse').on('shown.bs.collapse', function () {
    $(this).parent().find(".fas fa-plus").removeClass("fas fa-plus").addClass("fas fa-minus");
}).on('hidden.bs.collapse', function () {
    $(this).parent().find(".fas fa-minus").removeClass("fas fa-minus").addClass("fas fa-plus");
});</script>
                                        </ItemTemplate>
                                    </asp:FormView>
                                </div>
                            </asp:View>


                            <asp:View ID="vNotApproved" runat="server">
                                <div class="card-body">
                                    <div class="well">
                                        <h2>Registration not yet approved</h2>
                                        <hr />
                                        <p>
                                            Your registration has not yet been approved by a centre administrator. You will
            receive an e-mail at the address you registered with when your registration has
            been approved.
                                        </p>
                                    </div>
                                </div>
                            </asp:View>
                            <asp:View ID="vShowDelegateID" runat="server">
                                <div class="card-body">
                                    <asp:Panel ID="card1" CssClass="well" runat="server" DefaultButton="btnLoginPostReg">

                                        <h2>Digital Learning Solutions Registration Complete</h2>
                                        <hr />

                                        <div class="alert alert-info" role="alert">
                                            Your delegate number is: 
                      <asp:Label ID="lblCandidateNumber" runat="server" Text="Label" Font-Size="X-Large"
                          ForeColor="#000066" Font-Bold="True" Style="text-align: center; padding: 20px;"></asp:Label>
                                        </div>

                                        <p>You should make a note of your delegate number and keep it safe. You will use it to log in to the Learning Portal and any Digital Learning Solutions courses.</p>

                                        <div id="divRegNotApproved" runat="server">

                                            <p>Your registration must be approved by a centre administrator before you can login. You will receive an e-mail at the address you registered with when your registration has been approved.</p>
                                        </div>
                                        <div id="divRegApproved" runat="server">
                                            <asp:LinkButton ID="btnLoginPostReg" runat="server" ToolTip="Login" CssClass="btn btn-primary"><span><span>Login</span></span></asp:LinkButton>
                                        </div>
                                    </asp:Panel>
                                </div>
                            </asp:View>
                            <asp:View ID="vDuplicateEmail" runat="server">
                                <div class="card-body">
                                    <asp:Panel ID="card2" CssClass="well" runat="server">

                                        <h2>Existing registration for e-mail address</h2>
                                        <hr />

                                        <div class="alert alert-warning" role="alert">
                                            <p>A delegate is already registered with the e-mail address you supplied.</p>
                                            <p>To receive a reminder of your delegate number at the e-mail address you supplied click
                                                <asp:LinkButton ID="btnSendReminder" CausesValidation="false" runat="server" ToolTip="Login" CssClass="btn btn-primary"><span><span>Send Reminder</span></span></asp:LinkButton></p>
                                            <p>To return to the login page click
                                                <asp:LinkButton ID="btnReturn" CausesValidation="false" runat="server" ToolTip="Login" CssClass="btn btn-primary"><span><span>Login</span></span></asp:LinkButton></p>
                                        </div>
                                        <asp:Panel ID="pnlReminderOutcome" CssClass="hidden" runat="server">
                                            <asp:Label ID="lblReminderOutcome" runat="server" Text="Label"></asp:Label>
                                        </asp:Panel>




                                    </asp:Panel>
                                </div>
                            </asp:View>
                            <asp:View ID="vPickCentre" runat="server">
                                <asp:ObjectDataSource ID="dsCentres" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.Centres2TableAdapter">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="0" Name="RegionID" Type="Int32" />
                                    </SelectParameters>
                                </asp:ObjectDataSource>
                                <asp:Panel ID="pnlPickCentre" CssClass="card card-default" runat="server">
                                    <div class="card-header">
                                        Pick your Digital Learning Solutions Centre
                                    </div>
                                    <div class="card-body">
                                        <div class="m-3">
                                            <div class="form-group row">
                                                <asp:Label ID="Label11" runat="server" CssClass="col col-sm-3 control-label" AssociatedControlID="ddCentre" Text="Centre:"></asp:Label>
                                                <div class="col col-sm-9">
                                                    <asp:DropDownList ID="ddCentre" CssClass="form-control" runat="server" DataSourceID="dsCentres"
                                                        DataTextField="CentreName" DataValueField="CentreID">
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-footer clearfix">
                                        <asp:LinkButton ID="btnPickCentre" CssClass="btn btn-primary float-right" ToolTip="Confirm and continue" runat="server">Confirm</asp:LinkButton>
                                    </div>
                                </asp:Panel>
                            </asp:View>
                            <asp:View ID="vPickCustomisation" runat="server">
                                 <asp:Panel ID="pnlPickCourse" CssClass="card card-default" runat="server">
                                    <div class="card-header">
                                        Choose your course
                                    </div>
                                    <div class="card-body">
                                        <div class="m-3">
                                            <div class="form-group row">
                                                <asp:Label ID="Label17" runat="server" CssClass="col col-sm-3 form-control" AssociatedControlID="ddCusomisation" Text="Course:"></asp:Label>
                                                <div class="col col-sm-9">
                                                    <asp:DropDownList ID="ddCusomisation" CssClass="form-control" runat="server" DataValueField="CustomisationID" DataTextField="CustomisationName">
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-footer clearfix">
                                        <asp:LinkButton ID="btnSelectCustomisation" CssClass="btn btn-primary float-right" ToolTip="Confirm and continue" runat="server">Confirm</asp:LinkButton>
                                    </div>
                                </asp:Panel>
                            </asp:View>
                        </asp:MultiView>
                    </asp:Panel>

                </div>
                <footer class="footer">
                    <div class="container">
                        <div class="text-muted">
                            <div class="float-left" style="padding-left: 8px; padding-top: 5px;">
                                &copy; <%: DateTime.Now.Year %> - Digital Learning Solutions, Health Education England.  <%: Session("BannerText") %>
                            </div>
                            <div class="float-right" style="padding-right: 8px;">
                                <a style="cursor: pointer;" class="btn btn-outline-secondary btn-sm" data-toggle="modal" data-target="#termsMessage"><i aria-hidden="true" class="far fa-check-square hidden-sm"></i>
                                    Terms of use
                                </a>&nbsp;&nbsp;
                    <a style="cursor: pointer;" class="btn btn-outline-secondary btn-sm" data-toggle="modal" data-target="#accessMessage"><i aria-hidden="true" class="fas fa-search hidden-sm"></i>
                        Accessibility
                    </a>&nbsp;&nbsp;<a style="cursor: pointer;" class="btn btn-outline-secondary btn-sm"  href="https://www.hee.nhs.uk/about/privacy-notice" target="_blank"><i aria-hidden="true" class="fas fa-eye hidden-sm"></i>
                        Privacy
                    </a>
                            </div>

                        </div>
                    </div>
                </footer>
            </asp:View>
            <asp:View ID="vLearningContent" runat="server">
                <div id="learnDiv" runat="server" class="full-screen">
                    <div id="learningcontainer" runat="server" class="container container-table">
                        <div class="row vertical-center-row">
                            <asp:Panel runat="server" ID="pnlLearnframe" CssClass="text-center">
                                <iframe runat="server" allowtransparency="true" id="frame1" width="1034" height="776" scrolling="auto" align="middle"
                                    frameborder="0" marginheight="0" marginwidth="0"></iframe>
                            </asp:Panel>
                        </div>
                    </div>
                </div>
            </asp:View>
        </asp:MultiView>
        <%-- Terms Modal --%>
        <div id="termsMessage" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="lbltermsHeading" aria-hidden="true">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        
                        <h4 class="modal-title">
                            <asp:Label ID="lbltermsHeading" runat="server">Terms of Use</asp:Label></h4><button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body" style="max-height: 600px; overflow: auto;">

                        <asp:Literal ID="litTOUDetail" runat="server"></asp:Literal>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary float-right" data-dismiss="modal">OK</button>
                    </div>
                </div>
            </div>
        </div>
        <%-- Privacy Modal --%>
        <div id="privacyMessage" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="label1" aria-hidden="true">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                       
                        <h4 class="modal-title">
                            <asp:Label ID="Label10" runat="server">Privacy Notice</asp:Label></h4> <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body" style="max-height: 600px; overflow: auto;">

                        <asp:Literal ID="litPrivacy" runat="server"></asp:Literal>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary float-right" data-dismiss="modal">OK</button>
                    </div>
                </div>
            </div>
        </div>
        <%-- Privacy Modal --%>
        <div id="accessMessage" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="label2" aria-hidden="true">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                       
                        <h4 class="modal-title">
                            <asp:Label ID="Label9" runat="server">Accessibility Help</asp:Label></h4> <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body" style="max-height: 600px; overflow: auto;">

                        <asp:Literal ID="litAccess" runat="server"></asp:Literal>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary float-right" data-dismiss="modal">OK</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Diagnostic Assess Objectives Modal -->
            <div class="modal fade" id="diagObjectivesModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">

                        <h6 class="modal-title" id="myModalLabel">
                            <label id="AssessTitle">Launch Diagnostic Assessment</label></h6>
                            <%--<asp:Label ID="lblLaunchTitle" runat="server" Text="Launch Diagnostic Assessment"></asp:Label>--%>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        
                    </div>
                    <div class="modal-body">
                        <b>IMPORTANT NOTES:</b>
                        <ul>

                            <li id="DiagOnlyPoint" runat="server">Your score will be reset for any areas that you have attempted previously and
													choose to attempt again. </li>

                            <li>Please allow sufficient time to complete the assessment. If you close part way
												through, your progress will not be stored. </li>
                            <li>Throughout most assessments, green or red indicators will appear to indicate whether you have answered correctly. </li>

                            <li>Most keyboard shortcuts will be disabled in the assessment because we are unable
												to capture them in the testing software. If in doubt, use the mouse. </li>
                        </ul>
                        <br />
                        <span runat="server" id="DiagOnly2">Please choose the areas to be tested. </span>
                        Click <b>Start</b> to begin.<br />
                        <br />

                    </div>
                    <div id="DiagSelectForm" runat="server">
                         <ul class='list-group' id='objectives-list-box'>
                                                    <!--odschoices-->
                                                </ul>
                        <%--<asp:UpdatePanel ID="upnlDiagObjs" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvDiagObjs" runat="server" DataKeyNames="ObjectiveNum" AutoGenerateColumns="False"
                                    class="table table-striped" GridLines="None">
                                    <Columns>
                                        <asp:TemplateField ItemStyle-Width="30px">
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" ID="cbDiagObj" AutoPostBack="True" Checked="True"></asp:CheckBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Label ID="lblDiagObj" runat="server" Text='<%#Eval("TutorialName") %>'></asp:Label>
                                                <asp:HiddenField ID="hfTutorialID" Value='<%#Eval("TutorialID") %>' runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>--%>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary float-left mr-auto" data-dismiss="modal">Cancel</button>
                        <button id="btnStartAssess" type="button" class="btn btn-primary float-right" data-dismiss="modal">Start</button>
                        <%--<asp:LinkButton ID="btnStartAssess" OnClick="javascript:StartAssessment()" runat="server" class="btn btn-primary float-right"><span><span>Start</span></span></asp:LinkButton>--%>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="videoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        

                        <asp:Label ID="lblVideoCount" runat="server" Text="Views: " Font-Size="Small" Font-Names="Calibri"
                            ToolTip="Total views" Font-Bold="True"></asp:Label><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    </div>
                    <div class="modal-body">
                        <asp:Literal ID="LitIntroVideo" runat="server"></asp:Literal>
                    </div>
                    <div class="modal-footer">
                        <div class="float-left">
                            <asp:Label ID="lblVideoRate" runat="server" Text="Views: " Font-Size="Small" Font-Names="Calibri"
                                ToolTip="Average rating"></asp:Label><cc1:Rating ID="ajxVideoRating" StarCssClass="ratingStar" WaitingStarCssClass="savedRatingStar"
                                    FilledStarCssClass="filledRatingStar" EmptyStarCssClass="emptyRatingStar" runat="server"
                                    ReadOnly="True" Wrap="False">
                                </cc1:Rating>
                        </div>
                        <div class="float-right">
                            <asp:LinkButton ID="btnRateThis" runat="server" ToolTip="Rate this video" CssClass="btn btn-outline-secondary btn-sm"><span><span>Rate this</span></span></asp:LinkButton>
                            <cc1:Rating ID="ajxRateThis" StarCssClass="ratingStar2" WaitingStarCssClass="savedRatingStar"
                                FilledStarCssClass="filledRatingStar" EmptyStarCssClass="emptyRatingStar" runat="server"
                                ReadOnly="False" Wrap="False" AutoPostBack="True" Visible="False" CurrentRating="0"
                                ToolTip="Rate this video">
                            </cc1:Rating>
                            <asp:Label ID="lblThanks" runat="server" Text="Thank you" Visible="False" ForeColor="Gray"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--standard modal--%>
        <div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="lblModalTitle">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        
                        <h5 class="modal-title">
                            <asp:Label ID="lblModalTitle" runat="server" Text="Label"></asp:Label></h5><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    </div>
                    <div class="modal-body">
                        <p>
                            <asp:Label ID="lblModalBody" runat="server" Text="Label"></asp:Label>
                        </p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary float-right" data-dismiss="modal">OK</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
                <!-- Cohort Modal -->
        <asp:ObjectDataSource ID="dsSupervisor" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByGroupCustomisationID" TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.SupervisorTableAdapter">
            <SelectParameters>
                <asp:SessionParameter Name="GCID" SessionField="lmCohortGroupCustomisationID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="dsCohort" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.CohortTableAdapter">
            <SelectParameters>
                <asp:SessionParameter Name="GroupCustomisationID" SessionField="lmCohortGroupCustomisationID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        
<div class="modal fade" id="cohortModal" tabindex="-1" role="dialog" aria-labelledby="cohortModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="cohortModalLabel">My Group</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <asp:Repeater ID="rptSupervisor" DataSourceID="dsSupervisor" runat="server">
            <ItemTemplate>
                <div class="card mb-3">
  <div class="row no-gutters">
    <div class="col-md-3">
        <dx:BootstrapBinaryImage ID="BootstrapBinaryImage1" CssClasses-Control="avatar-100" Value='<%# Eval("ProfileImage")%>' runat="server" EmptyImage-Url="~/Images/avatar.png"></dx:BootstrapBinaryImage>
    </div>
    <div class="col-md-9">
      <div class="card-body">
        <h5 class="card-title"><small>Group Supervisor</small><br /> <%# Eval("Forename") & " " & Eval("Surname") %></h5>
        <p class="card-text"></p>
        <p class="card-text"><small class="text-muted"><a href='<%# "mailto:" & Eval("Email") %>'>Email supervisor</a></small></p>
      </div>
    </div>
  </div>
</div>
            </ItemTemplate>
        </asp:Repeater>
          <h6>Group Members</h6>
          <ul class="list-group">
        <asp:Repeater ID="rptCohort" DataSourceID="dsCohort" runat="server">
            <ItemTemplate>
                <li class="list-group-item"><%# Eval("FirstName") & " " & Eval("LastName") %> <div class="float-right text-muted"><small><%# IIF(Eval("LastAccess").ToString.Length > 2, GetNiceDate(Eval("LastAccess")), "Never") %></small></div></li>
            </ItemTemplate>
        </asp:Repeater>
              </ul>
      </div>
      <div class="modal-footer">
        <button type="button" data-dismiss="modal" class="btn btn-primary float-right">Close</button>
      </div>
    </div>
  </div>
</div>
        <script>

            Sys.Application.add_load(BindEvents);

        </script>
    </form>
</body>

</html>
