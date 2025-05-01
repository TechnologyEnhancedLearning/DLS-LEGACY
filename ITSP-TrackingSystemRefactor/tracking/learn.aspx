<%@ Page Language="vb" EnableEventValidation="false" Title="Learning Menu" AutoEventWireup="false" EnableViewState="true" CodeBehind="learn.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.learn" %>
<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/controls/usermx.ascx" TagPrefix="uc1" TagName="usermx" %>
<%@ Register Src="~/controls/usermxmodals.ascx" TagPrefix="uc1" TagName="usermxmodals" %>
<%@ Register assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register Src="~/controls/filemx.ascx" TagPrefix="uc1" TagName="filemx" %>
<%@ Register Src="~/controls/filemxsess.ascx" TagPrefix="uc1" TagName="filemxsess" %>




<!DOCTYPE html>

<html lang="en-gb">
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

        .embed-responsive {
            width: 100%;
            height: 100%;
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
            .avatar-40 {
            width: 40px;
            height: 40px;
            border-radius: 100%;
            box-shadow: 0 2px 3px 0 rgba(0,0,0,.14), 0 2px 2px -2px rgba(0,0,0,.2), 0 1px 7px 0 rgba(0,0,0,.12);
            transition: all ease .3s;
            z-index: 2
        }

            .avatar-40:hover {
                box-shadow: 0 6px 10px 0 rgba(0,0,0,.14),0 1px 18px 0 rgba(0,0,0,.12),0 3px 5px -1px rgba(0,0,0,.2);
                transform: translate(-5px,-5px);
                width: 45px;
                height: 45px;
                z-index: 2
            }

        .account-wall {
            margin-top: 20px;
            padding: 40px 0px 20px 0px;
            background-color: #f7f7f7;
            -moz-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
            -webkit-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
            box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
        }

        .nav-pills .nav-link {
            border: 1px solid #ccc;
            margin-right: 2px;
            margin-bottom: 2px
        }

        .not-greyed input:read-only {
            background-color: #fff !important;
        }

        .popover {
            font-size: 1.2rem !important;
        }

        @media all and (-ms-high-contrast: none), (-ms-high-contrast: active) {
            /* IE11 fix for button positioning issue in modal footer */
            .modal-footer {
                display: block !important;
            }
        }
    </style>
    <link href="../Content/resources.css" rel="stylesheet" />
   <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/master.css" rel="stylesheet" />
    <link href="../Content/login.css" rel="stylesheet" />
    <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.4/css/all.min.css">
    <link href="../Content/LearnMenu.css" rel="stylesheet" />
    <link href="../Content/bootstrap-toggle.min.css" rel="stylesheet" />
    <script src="../Scripts/plugins.min.js"></script>
    <script src="../Scripts/LearnMenu.js"></script>
    <script src="../Scripts/bsasper.js"></script>
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

                $.fn.selectpicker.Constructor.BootstrapVersion = '4';
                $(document).ready(function () {
                    $('.popover-method').popover({ title: 'Method', placement: 'top', trigger: 'focus', content: 'Choose the most appropriate starter verb for the method for the activity' });
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
                    LoadProgressText(<%: Session("lmProgressID") %>)
                });
                $('.bs-toggle').bootstrapToggle({
                    on: 'Subscribed',
                    off: 'Unsubscribed',
                    onstyle: 'success',
                    offstyle: 'danger',
                    width: '100px'
                });
                $('.list-group.checked-list-box .list-group-item, .nav.nav-pills.checked-nav .nav-link').each(function () {
                    // Settings
                    var $widget = $(this),
                        $checkbox = $('<input style="display:none" type="' + $widget.data('type') + '" name="choices" />'),

                        color = ($widget.data('color') ? $widget.data('color') : "success"),
                        style = ($widget.data('style') === "button" ? "btn-" : "list-group-item-");


                    $widget.css('cursor', 'pointer');
                    $widget.prepend($checkbox);

                    // Event Handlers
                    $widget.on('click', function (e) {
                        e.preventDefault();
                        $checkbox.prop('checked', !$checkbox.is(':checked'));
                        $checkbox.triggerHandler('change');
                        updateDisplay();
                    });
                    $checkbox.on('click', function () {
                        $checkbox.prop('checked', !$checkbox.is(':checked'));
                        $checkbox.triggerHandler('change');
                        updateDisplay();
                    });
                    $checkbox.on('change', function () {
                        updateDisplay();
                    });


                    // Actions
                    function updateDisplay() {
                        var isChecked = $checkbox.is(':checked');

                        // Set the button's state
                        $widget.data('state', (isChecked) ? "on" : "off");

                        //// Set the button's icon
                        //$widget.find('.state-icon')
                        //    .removeClass()
                        //    .addClass('state-icon ' + settings[$widget.data('state')].icon);
                        if ($widget.data('type') === 'radio') {
                            $(".active").removeClass(style + color + ' active');
                        }

                        // Update the button's color
                        if (isChecked) {

                            if ($widget.data('toggle') === 'tab') {
                                $widget.tab('show');
                            }
                            $widget.addClass(style + color + ' active');
                            $('#hfSASelected').val($widget.data('value'));
                        } else {
                            $widget.removeClass(style + color + ' active');
                        }
                    }

                    // Initialization
                    function init() {

                        if ($widget.data('checked') === true) {
                            $checkbox.prop('checked', !$checkbox.is(':checked'));
                            $widget.addClass('active');
                            if ($widget.data('toggle') === 'tab') {
                                $widget.tab('show');
                            }
                        }

                        //updateDisplay();

                        // Inject the icon if applicable
                        //if ($widget.find('.state-icon').length == 0) {
                        //    $widget.prepend('<span class="state-icon ' + settings[$widget.data('state')].icon + '"></span>');
                        //}
                    }
                    init();
                });
                doPopover()

                function doPopover(s, e) {
                    $('[data-toggle="popover"]').popover();
                }

            };

        </script>
        <asp:HiddenField ID="hfAssessSrc" ClientIDMode="Static" runat="server" />
        <asp:HiddenField ID="hfProg" ClientIDMode="Static" runat="server" />
        <asp:HiddenField ID="hfCompAssessTutID" Value="0" runat="server" />
        <asp:HiddenField ID="hfMethodID"  Value="0" runat="server" />
        <asp:MultiView ID="mvOuter" runat="server" ActiveViewIndex="0">
            <asp:View ID="vMain" runat="server">
                <div class="container clearfix">
                    <%--Logos--%>
                    <div class="row mt-3 mb-3">
                        <div class="col-md-8" runat="server" id="mainlogo">
                            <div class="row">
                                <div class="col">
<dx:BootstrapBinaryImage ID="bimgLogo" AlternateText="Brand Logo" runat="server"></dx:BootstrapBinaryImage>
                        </div>
                                </div>
                           
                            <div class="row mt-1">
                                <div class="col">
                                    <h4>
                                        <asp:Label ID="lblPageTitle" runat="server" Text="Learning Menu"></asp:Label></h4>
                                </div>
                            </div>
                        </div>
                            <div id="divCtreLogo" runat="server" class="col-md-4">
                            <asp:Image ID="logoImage" AlternateText="Organisation Logo" runat="server" ImageUrl="~/centrelogo"
                                Height="100px" Width="300px" class="float-right" />
                            </div>
                        </div>
                    <asp:Panel ID="pnlMenuPanel" CssClass='<%: Session("sPanelClass") %>' runat="server">
                        <div class="card-header">
                            <div class="row">
                                <div class="col-md-8">
 <h5>
                                <asp:Label ID="lblCentreName" runat="server" Text="Label"></asp:Label>
                            </h5>
                            <h6><small><asp:Label ID="lblCourseTitle" runat="server" Text="Label"></asp:Label></small>
                                </h6>
                                </div>
                                 <asp:ObjectDataSource ID="dsProgSupervisor" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByProgressID" TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.SupervisorTableAdapter">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="ProgressID" SessionField="lmProgressID" Type="Int32" />
                                    </SelectParameters>
                                </asp:ObjectDataSource>
                                <asp:Repeater ID="rptProgSupervisor" Visible='<%# IsAvailableToContributor(0) %>' DataSourceID="dsProgSupervisor" runat="server">
                                    <ItemTemplate>
                                        <div class="col-md-4">
                                            <div class="card mt-1 mb-1">
                                                <div class="row no-gutters">
                                                    <div class="col-md-3">
                                                        <dx:BootstrapBinaryImage ID="BootstrapBinaryImage1" CssClasses-Control="avatar-60" Value='<%# Eval("ProfileImage")%>' runat="server" EmptyImage-Url="~/Images/avatar.png"></dx:BootstrapBinaryImage>
                                                    </div>
                                                    <div class="col-md-9">
                                                        <div class="card-body">
                                                            <p class="card-title"><small><%# GetCS("LearnMenu.Supervisor") %></small><br />
                                                                <b><%# Eval("Forename") & " " & Eval("Surname") %></b> <asp:LinkButton ID="lbtChangeSupervisor" OnCommand="lbtChangeSupervisor_Command" aria-label='<%# "Change " & GetCS("LearnMenu.Supervisor") %>' ToolTip='<%# "Change " & GetCS("LearnMenu.Supervisor") %>' runat="server"><i class="fas fa-edit"></i></asp:LinkButton></p>
                                                            <p class="card-text"><small class="text-muted"><a href='<%# "mailto:" & Eval("Email") %>'><%# "Email " & GetCS("LearnMenu.Supervisor") %></a></small>
 <asp:LinkButton ID="lbtRequestVerification" CssClass="btn btn-info btn-sm" ToolTip='<%# "Request " & GetCS("LearnMenu.Supervisor") & " " & GetCS("LearnMenu.Verification").ToString.ToLower() %>' OnCommand="lbtRequestVerification_Command" runat="server">Request <%# GetCS("LearnMenu.Verification") %></asp:LinkButton>
                                                            </p>
                                                           
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <asp:Panel ID="pnlChooseSV" Visible="false" runat="server" CssClass="col-md-4">
                                    <asp:ObjectDataSource ID="dsSupervisors" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.customiseTableAdapters.SupervisorsTableAdapter">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                                            <asp:SessionParameter SessionField="lmCustomisationID" Name="CustomisationID" Type="Int32" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                    <div class="card mt-1 mb-1">
                                        <div class="form-group m-1">
                                            <asp:DropDownList ID="ddSupervisor" OnDataBinding="ddSupervisor_DataBinding" DataSourceID="dsSupervisors" CssClass="form-control" DataTextField="Name" AppendDataBoundItems="true" DataValueField="AdminID" runat="server">
                                            </asp:DropDownList>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <asp:LinkButton ID="lbtCancelSetSV" OnCommand="lbtCancelSetSV_Command" CssClass="btn btn-outline-secondary btn-block float-left" runat="server">Cancel</asp:LinkButton>
                                            </div>
                                            <div class="col-sm-6">
                                                <asp:LinkButton ID="lbtSetSV" OnCommand="lbtSetSV_Command" CssClass="btn btn-outline-primary btn-block float-right" runat="server">Set</asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </asp:Panel>
                            </div>

                        </div>
                        <div class="card-body">
                            <asp:MultiView ID="mvLM" runat="server" ActiveViewIndex="0">
                                <asp:View ID="vLM" runat="server">
                                    <div class="row">
                                        <asp:Panel ID="pnlHowToVids" CssClass="col" Visible="false" runat="server">
                                            How to use:
											<asp:LinkButton ID="lbtDiagVid" CommandName="DiagVid" CssClass="btn btn-sm btn-info" runat="server"
                                                ToolTip="Launch &quot;How To&quot; video"><i aria-hidden="true" class="fas fa-video"></i> Diagnostics</asp:LinkButton>
                                            <asp:LinkButton CssClass="btn btn-sm btn-info" ID="lbtLearnVid" runat="server" CommandName="LearnVid"
                                                ToolTip="Launch &quot;How To&quot; video"><i aria-hidden="true" class="fas fa-video"></i> Learning Materials</asp:LinkButton>
                                            <asp:LinkButton CssClass="btn btn-sm btn-info" ID="lbtPLAssess" CommandName="PLVid" runat="server"
                                                ToolTip="Launch &quot;How To&quot; video"><i aria-hidden="true" class="fas fa-video"></i> Assessments</asp:LinkButton>
                                        </asp:Panel>
                                <div class="col">
                                    <div class="float-right">
                                        <div style="font-size: 1.5em">
                                           
                                            <uc1:usermx runat="server" ID="usermx" />
                                            <uc1:usermxmodals runat="server" ID="usermxmodals" /> 
                                            <button id="btnGroup" type="button" class="btn btn-success ml-2" runat="server" visible="false" data-toggle="modal" data-target="#cohortModal"><i class="fas fa-users mr-1""></i> My Group</button>
                                            <button id="btnContributors" type="button" class="btn btn-success ml-2" runat="server" visible="false" data-toggle="modal" data-target="#contributorsModal"><i class="fas fa-users-cog mr-1""></i> Manage Contributors</button>
                                            <button id="btnSupervisor" type="button" class="btn btn-success ml-2" runat="server" visible="false" data-toggle="modal" data-target="#cohortModal"><i class="fas fa-chalkboard-teacher mr-1""></i> <%: GetCS("LearnMenu.Supervisor")%></button>
                                            <asp:LinkButton ID="lbtnlogout" CssClass="btn btn-primary ml-2" runat="server"><i class="fas fa-sign-out-alt mr-1"></i>Logout</asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                                                              
                            </div>
                            <asp:Panel ID="pnlSWDownload" CssClass="row mt-2" Visible="false" runat="server">
                                <div class="col">
                                <div class="alert alert-warning">
                                    <p>
									Internet Explorer 11 and the latest version of Shockwave Player are required to run this IT Skills Pathway course. 
									If you haven't got Shockwave Player installed, it can be downloaded <a href="https://www.dls.nhs.uk/downloadfiles/sw_lic_full_installer.msi">here</a>.
									</p>
                                   
                                </div>
                                    </div>
                            </asp:Panel>
                            
                            <br />
                            <asp:LinkButton ID="btnPost" runat="server" Visible="True" CssClass="d-none">Post progress data (do not use)</asp:LinkButton>
                            <asp:LinkButton ID="btnSwitchView" runat="server" Visible="True" CssClass="d-none">Switch view (do not use)</asp:LinkButton>
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
                                                <div class="card-header clickable clearfix collapse-card collapsed" data-toggle="collapse" data-target='<%# ".Accordion" & Eval("SectionID")%>'>
                                                    <asp:Label CssClass="card-title" ID="lblSectionHeader" runat="server" Text='<%#Eval("SectionName")%>'></asp:Label>
                                                    <div class="float-right">
                                                        <asp:Label ID="lblSecStatus" Visible='<%# GetCS("LearnMenu.ShowPercentage") %>' runat="server" Style="font-size: 10px; color: #666666;"
                                                            Text='<%#Eval("PCComplete", "{0}% complete")%>' /><asp:Panel ID="Panel1" Visible='<%# Session("lmContentTypeID") < 4 %>' runat="server">
                                                        &nbsp;
																								<asp:Label ID="Label12" Visible='<%#Eval("HasLearning") And GetCS("LearnMenu.ShowTime")%>' runat="server" Style="font-size: 10px; color: #666666;" Text='<%#Eval("TimeMins", "{0} mins")%>'
                                                                                                    ToolTip='<%#Eval("TimeMins", "You have spent {0} mins on the tutorials in this section")%>' />&nbsp;
																								<asp:Label ID="Label13" Visible='<%#Eval("HasLearning") And GetCS("LearnMenu.ShowTime")%>' runat="server" Style="font-size: 10px; color: #666666;" Text='<%#Eval("AvgSecTime", "(average time {0} mins)")%>'
                                                                                                    ToolTip='<%#Eval("AvgSecTime", "Average completion time for the tutorials in this section is {0} mins")%>' /></asp:Panel>
                                                    </div>
                                                </div>

                                                <div id="TutsCollapse" class='<%# "section-panel collapse Accordion" & Eval("SectionID")%>' runat="server">
                                                    <div class="card-body">
                                                        <ul class="list-group">

                                                            <li class="list-group-item list-group-item-assess" runat="server" visible='<%# Eval("DiagAssessPath").ToString.Length > 0 And Eval("DiagStatus")%>'>
                                                                <div class="row">
                                                                    <div class="col-sm-6">
                                                                        Diagnostic Assessment<br />
                                                                        <asp:Label ID="lblDiagOutcome" CssClass="small text-muted" runat="server" Text='<%# Eval("SecScore").ToString + " / " + Eval("SecOutOf").ToString + " - " + Eval("DiagAttempts").ToString + " attempt(s)" %>'
                                                                            Visible='<%# Eval("DiagAttempts").ToString <> "0" %>'></asp:Label>
                                                                        <asp:Label ID="lblDiagNotAttempted" CssClass="small text-muted" runat="server" Text="Not attempted"
                                                                            Visible='<%# Eval("DiagAttempts").ToString = "0" %>'></asp:Label>
                                                                    </div>
                                                                    <div class="col-sm-6">
                                                                        <button type="button" class="btn btn-success btn-sm" <%# IIf(Not IsAvailableToContributor(4), "disabled='disabled'", "") %> onclick="javascript:LaunchAssessment(<%# Eval("SectionID")%>, <%# Session("lmCustomisationID")%>, <%# Session("UserCentreID")%>, false, <%# Session("lmCustDiagObjSelect").ToString.ToLower()%>, false, '<%# Eval("DiagAssessPath")%>', '<%# getTrackingURL() %>', <%# Session("lmCustomisationID")%>, <%# Session("lmProgressID")%>, <%# Session("lmCustVersion")%>, <%# Session("lmPlaPassThreshold")%>, <%# Session("learnCandidateID")%>)" title="Launch diagnostic assessment"><i aria-hidden="true" class="fas fa-play p-2"></i></button>
                                                                    </div>
                                                                </div>
                                                            </li>
                                                            <asp:Repeater ID="rptTutorials" runat="server" OnItemCommand="rptTutorials_ItemCommand" DataSourceID="dsLMTutorials">
                                                                <ItemTemplate>
                                                                    <li class="list-group-item">
                                                                        <div class="row">
                                                                            <div class="col-sm-6 col-xs-12">
                                                                                <asp:Label ID="lblTutorialTitle" runat="server" Text='<%#Eval("TutorialName")%>' /><br />
                                                                                <asp:Panel ID="pnlLearnStatus" Visible='<%# Eval("ContentTypeID") < 4 And (GetCS("LearnMenu.ShowLearnStatus") Or GetCS("LearnMenu.ShowTime") Or (Eval("DiagAttempts") > 0 And Eval("DiagStatus")))  %>' runat="server">
                                                                                    <asp:Label ID="Label1" Visible='<%# GetCS("LearnMenu.ShowLearnStatus") %>' runat="server" CssClass="small text-muted" Text='<%#Eval("Status", "{0}")%>' />
                                                                                    &nbsp;
																											
                                                                        <asp:Label ID="Label12" runat="server" Visible='<%# GetCS("LearnMenu.ShowTime") %>' CssClass="small text-muted" Text='<%#Eval("TutTime", "{0} mins")%>'
                                                                            ToolTip='<%#Eval("TutTime", "You have spent {0} mins on this tutorial")%>' />&nbsp;
																											<asp:Label ID="Label14" runat="server" Visible='<%# GetCS("LearnMenu.ShowTime") %>' CssClass="small text-muted" Text='<%#Eval("AvgTime", "(average time {0} mins)")%>'
                                                                                                                ToolTip='<%#Eval("AvgTime", "Average completion time for this tutorial is {0} mins")%>' />&nbsp;
																											<asp:Label ID="lblDiagOutcome" CssClass="small text-muted" runat="server" Text='<%#"Diagnostic: " + Eval("TutScore").ToString + "/" + Eval("PossScore").ToString %>'
                                                                                                                Visible='<%# Eval("DiagAttempts") > 0 And Eval("DiagStatus") %>' />&nbsp;
																											<asp:Label ID="lblRecommended" CssClass="small text-danger" runat="server" Text="Recommended"
                                                                                                                ToolTip="Based on your diagnostic assessment outcome, this tutorial is recommended"
                                                                                                                Font-Bold="True" Visible='<%# Eval("DiagAttempts") > 0 And Eval("DiagStatus") And Eval("TutScore") < Eval("PossScore") %>' />

                                                                                    <asp:Label ID="lblOptional" CssClass="small text-success" runat="server" Text="Optional" ToolTip="Based on your diagnostic assessment outcome, this tutorial is optional"
                                                                                        Font-Bold="True" Visible='<%# Eval("DiagAttempts") > 0 And Eval("DiagStatus") And Eval("TutScore") = Eval("PossScore") %>' />
                                                                                </asp:Panel>
                                                                                <asp:Panel ID="pnlCompetency" Visible='<%# Session("learnShowLearningLog") And GetCS("DevelopmentLogForm.ShowSkillMapping") %>' runat="server">
                                                                                    <asp:Label ID="Label2" runat="server" CssClass='<%# IIf(Eval("SelfAssessStatus") = "Not assessed", "small text-muted", "text-primary") %>' ToolTip="Self assessment rating" Text='<%#Eval("SelfAssessStatus", "{0}")%>' />
                                                                                    
                                                                                        &nbsp;
                                                                                        <asp:Label ID="Label3" Visible='<%# Not Eval("SelfAssessStatus") = "Not assessed" And Eval("SupervisorVerify") %>' runat="server" CssClass='<%# IIf(Eval("SupervisorOutcome") = -1, "small text-muted", IIf(Eval("SupervisorOutcome") = 0, "small text-danger", "small text-success")) %>' ToolTip="Self assessment rating" Text='<%#Eval("SupervisorOutcomeText")%>' />
                                                                                    <asp:Label ID="Label30" ToolTip='<%: GetCS("LearnMenu.Verification") & " Requested"%>' CssClass="text-warning small" Visible='<%#Eval("SupervisorOutcomeText").ToString.ToLower = "not verified" And Eval("SupervisorVerificationRequested").ToString.Length > 0%>' runat="server"><i class="fas fa-flag"></i></asp:Label>
                                                                                        &nbsp;
                                                                                        <asp:Label ID="Label4" Visible='<%# Not Eval("SelfAssessStatus") = "Not assessed" And Session("learnShowLearningLog") And GetCS("DevelopmentLogForm.ShowSkillMapping") And GetCS("DevelopmentLog.ShowPlanned") %>' runat="server" CssClass="small text-muted" Text='<%#Eval("LogActions") & " " & GetCS("DevelopmentLog.Planned") %>'></asp:Label>
                                                                                        &nbsp;
                                                                                        <asp:Label ID="Label5" Visible='<%# Not Eval("SelfAssessStatus") = "Not assessed" And Session("learnShowLearningLog") And GetCS("DevelopmentLogForm.ShowSkillMapping") And GetCS("DevelopmentLog.ShowCompleted") %>' runat="server" CssClass="small text-muted" Text='<%#Eval("LogCompleted") & " " & GetCS("DevelopmentLog.Completed") %>'></asp:Label>
                                                                                    
                                                                                </asp:Panel>
                                                                            </div>
                                                                            <div class='<%# IIf(Eval("ContentTypeID") = 4, "col-sm-2 col-xs-4", "col-sm-1 col-xs-2") %>'>
                                                                                <button type="button" visible='<%#Eval("Objectives").ToString.Trim.Length > 0 And Eval("ContentTypeID") < 4 %>' aria-label='<%#Eval("TutorialName", "View {0} objectives")%>' title="View objectives" class="btn btn-danger btn-sm" runat="server" data-toggle="modal" data-target='<%#".objective-modal-" & Eval("TutorialID")%>'>
                                                                                    <i aria-hidden="true" class="far fa-dot-circle p-2"></i>
                                                                                </button>
                                                                                <asp:LinkButton ID="lbtReviewSkill" ToolTip='<%# GetCS("LearnMenu.Review")%>' CommandArgument='<%# Eval("aspProgressID")%>' aria-label='<%# GetCS("LearnMenu.Review") & " " & Eval("TutorialName")%>' title='<%# GetCS("LearnMenu.Review")%>' CommandName="cmdReviewSkill" Visible='<%# Eval("ContentTypeID") = 4 %>' CssClass="btn btn-primary btn-sm" runat="server"><i aria-hidden="true" class="fas fa-search p-2"></i> <%# GetCS("LearnMenu.Review")%></asp:LinkButton>

                                                                            </div>
                                                                            <div class="col-sm-1 col-xs-2">
                                                                                <asp:LinkButton ID="lbtPlayVideo" CausesValidation="false" Enabled='<%# IsAvailableToContributor(4) %>' CommandArgument='<%# Eval("TutorialID")%>' Visible='<%# Eval("VideoPath").ToString.Length > 0 %>'  aria-label='<%#Eval("TutorialName", "Watch {0} video")%>' title="View objectives" ToolTip="Watch video" CommandName="cmdIntro" class="btn btn-info btn-sm" runat="server"><i aria-hidden="true" class="fas fa-video p-2"></i></asp:LinkButton>
                                                                            </div>
                                                                            <div class="col-sm-1 col-xs-2">
                                                                                <asp:LinkButton ID="lbtLaunchTutorial" CausesValidation="false" Enabled='<%# IsAvailableToContributor(4) %>' Visible='<%#Eval("TutorialPath").ToString.Trim.Length > 0 %>' ToolTip="Launch tutorial" CommandArgument='<%# Eval("TutorialID")%>' aria-label='<%#Eval("TutorialName", "Launch {0} tutorial")%>' title="View objectives" CommandName="cmdLaunch" class="btn btn-success btn-sm" runat="server"><i aria-hidden="true" class="fas fa-play p-2"></i></asp:LinkButton>
                                                                            </div>
                                                                            <div class="col-sm-1 col-xs-2">
                                                                                <asp:LinkButton ID="lbtSupportMats" CausesValidation="false" Enabled='<%# IsAvailableToContributor(4) %>' ToolTip='<%# GetCS("LearnMenu.SupportingInformation")%>' CommandArgument='<%# Eval("TutorialID")%>' Visible='<%# Eval("SupportingMatsPath").ToString.Length > 0 %>' CommandName="cmdSupport" aria-label='<%# GetCS("LearnMenu.SupportingInformation")%>' title='<%# GetCS("LearnMenu.SupportingInformation")%>' class="btn btn-warning btn-sm" runat="server"><i aria-hidden="true" class="fas fa-info-circle p-2"></i></asp:LinkButton>
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
                                                                    <div class="col-sm-6">
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
                                                                    <div class="col-sm-6">
                                                                        <button type="button" <%# IIf(Eval("PLLocked") Or Not IsAvailableToContributor(4), "disabled='disabled'", "") %> class='<%# IIF(Eval("PLLocked"), "btn btn-success btn-sm disabled", "btn btn-success btn-sm")%>' title='<%# IIf(Eval("PLLocked"), "LOCKED - You have too many failed assessments for this course.", IIf(Not IsAvailableToContributor(4), "Post Learning Assessment Unavailable to Contributor", "Launch Post Learning Assessment"))%>' onclick="javascript:LaunchAssessment(<%# Eval("SectionID")%>, <%# Session("lmCustomisationID")%>, <%# Session("UserCentreID")%>, true, false, true, '<%# Eval("PLAssessPath")%>', '<%# getTrackingURL() %>', <%# Session("lmCustomisationID")%>, <%# Session("lmProgressID")%>, <%# Session("lmCustVersion")%>, <%# Session("lmPlaPassThreshold")%>, <%# Session("learnCandidateID")%>)"><i aria-hidden="true" class="fas fa-play p-2"></i></button>
                                                                    </div>
                                                                </div>
                                                            </li>
                                                            <li class="list-group-item list-group-item-consol" runat="server" visible='<%# Eval("ConsolidationPath").ToString.Length > 0 %>'>
                                                                <div class="row">
                                                                    <div class="col-sm-6"><%# GetCS("LearnMenu.ConsolidationExercise")%></div>
                                                                    <div class="col-sm-6 col-xs-4">
                                                                        <asp:HyperLink CssClass="btn btn-warning btn-sm"  Enabled='<%# IsAvailableToContributor(4) %>'
                                                                            ID="DownloadLink" Text='<%# "<i aria-hidden=""true"" class=""fas fa-file-export p-2""></i> Download " & GetCS("LearnMenu.ConsolidationExercise")%>' ToolTip="Click to download"
                                                                            Target='_blank' runat="server" NavigateUrl='<%# "~/tracking/dlconsolidation?client=" + Eval("ConsolidationPath") %>'><i aria-hidden="true" class="fas fa-file-export p-2"></i> Download</asp:HyperLink>
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


                                    <asp:Panel ID="pnlDevLog" runat="server">
                                        <div class="card card-itsp-blue">
                                            <div class="card-header card-title"><%: GetCS("DevelopmentLog.DevelopmentLog")%> <asp:LinkButton ID="lbtRefresh" CssClass="btn btn-primary float-right"  runat="server"><i class="fas fa-sync"></i> Refresh</asp:LinkButton></div>
                                            <div class="card-body">
                                                
                                                <div <%= IIf(GetCS("DevelopmentLog.ShowPlanned"), "class='card card-fifty mb-2'", "class='d-none'") %> >
                                                    <div class="card-header clickable clearfix collapse-card collapsed" data-toggle="collapse" data-target="#divplanned">
                                                        <asp:Label ID="lblPlanned" CssClass="card-title" runat="server"><%: GetCS("DevelopmentLog.Planned") %></asp:Label>
                                                    </div>
                                                    <div id="divplanned" class="collapse section-panel Accordion0">
                                                        <div class="card-body">
                                                        <asp:ObjectDataSource ID="dsPlanned" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetPlannedByProgID" TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.LearningLogItemsTableAdapter">
                                                            <SelectParameters>
                                                                <asp:SessionParameter Name="ProgressID" SessionField="lmProgressID" Type="Int32" />
                                                            </SelectParameters>
                                                        </asp:ObjectDataSource>
                                                        
                                                            <dx:BootstrapGridView ID="bsgvPlanned" OnDataBound="bsgvSkillActions_DataBound" runat="server" AutoGenerateColumns="False" OnInit="bsgvPlanned_Init" DataSourceID="dsPlanned" KeyFieldName="LearningLogItemID" SettingsDetail-ShowDetailRow="True" SettingsDetail-AllowOnlyOneMasterRowExpanded="True" SettingsAdaptivity-AdaptivityMode="Off" SettingsBehavior-AllowFocusedRow="False">
                                                                <SettingsBootstrap Striped="True" />
                                                                <Settings GridLines="None" />
                                                                <Columns>
                                                                    <dx:BootstrapGridViewTextColumn Caption=" " VisibleIndex="0">
                                                                        <DataItemTemplate>
                                                                            <div style="display:flex">
                                                                            <asp:LinkButton EnableViewState="false" Visible='<%# Eval("LoggedByID") = Session("learnCandidateID") And Eval("LoggedByAdminID") = 0 And IsAvailableToContributor(3)  %>' ID="lbtEditLogItem" OnCommand="lbtEditLogItem_Command" ToolTip="Edit Item" CommandName="EditPlanned" aria-label="Edit Item" CommandArgument='<%# Eval("LearningLogItemID") %>' CssClass="btn btn-outline-primary" runat="server"><i class="fas fa-pen"></i></asp:LinkButton>
                                                                            <asp:LinkButton EnableViewState="false" ID="lbtDownloadICS" Visible='<%# Not Eval("AppointmentTypeID") = 3 And Not Eval("AppointmentTypeID") = 4 %>' CssClass="btn btn-outline-success" OnCommand="lbtDownloadICS_Command" ToolTip="Download Calendar Invite" aria-label="Download Calendar Invite" CommandArgument='<%# Eval("LearningLogItemID") %>' runat="server"><i class="fas fa-calendar-plus fa-lg"></i></asp:LinkButton>
                                                                                <asp:LinkButton EnableViewState="false" ID="LinkButton1" Visible='<%# (Eval("AppointmentTypeID") = 3 Or Eval("AppointmentTypeID") = 4) And Eval("CallUri").ToString.Length > 0 And IsAvailableToContributor(3) %>' CssClass="btn btn-outline-success" OnCommand="lbtDlSFBICS_Command" ToolTip="Email Calendar Invite" aria-label="Email Calendar Invite" CommandArgument='<%# Eval("LearningLogItemID") %>' runat="server"><i class="fas fa-calendar-plus fa-lg"></i></asp:LinkButton>
                                                                            <asp:LinkButton OnCommand="lbtEditLogItem_Command"  Visible='<%#Eval("AppointmentTypeID") = 5 And IsAvailableToContributor(3) %>' CommandName="LaunchDLS" CommandArgument='<%# Eval("LinkedCustomisationID") %>'  ID="lbtEvent" CssClass='<%# "btn btn-" & Eval("BtnColourClass") %>' runat="server"><i class='<%#Eval("IconClass") %>'></i></asp:LinkButton>
                                                                            <asp:Panel ID="pnlSFB" CssClass="dropdown" Visible='<%# Eval("AppointmentTypeID") = 3 And Eval("CallUri").ToString.Length > 0 And IsAvailableToContributor(3) %>' runat="server">
                                                                                <button class='<%# "btn btn-" & Eval("BtnColourClass") & " dropdown-toggle" %>' title="Join Skype Call" type="button" id='<%# "dropdownMenuButton-" & Eval("LearningLogItemID").ToString %>' data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    <i class='<%#Eval("IconClass") %>'></i>
  </button>
                                                                                <div aria-labelledby='<%# "dropdownMenuButton-" & Eval("LearningLogItemID").ToString %>' class="dropdown-menu">
                                                                                    <a class="dropdown-item" target="_blank" href='<%# getSFBLink(Eval("CallUri").ToString()) %>'>Join in web browser</a>
                                                                                    <a class="dropdown-item" href='<%# getSFBMeetLink(Eval("CallUri").ToString()) %>'>Join in Skype for Business app</a>
                                                                                </div>
                                                                            </asp:Panel>


                                                                            <asp:HyperLink ID="hlSFB" runat="server" ToolTip="Join Supervision Session" Visible='<%# (Eval("AppointmentTypeID") = 4 Or Eval("AppointmentTypeID") = 8) And Eval("CallUri").ToString.Length > 0 And IsAvailableToContributor(3) %>' Target="_blank" CssClass='<%# "btn btn-" & Eval("BtnColourClass") %>' NavigateUrl='<%# Eval("CallUri").ToString() %>'><i class='<%# Eval("IconClass") %>'></i></asp:HyperLink>
                                                                        </div></DataItemTemplate>
                                                                    </dx:BootstrapGridViewTextColumn>
                                                                    
                                                                    <dx:BootstrapGridViewDateColumn FieldName="DueDate" Caption="Due" VisibleIndex="1">
                                                                        <DataItemTemplate>
                                                                            <asp:Label EnableViewState="false" ID="Label31" runat="server" Text='<%# Eval("DueDate", getDateFormatString(Eval("DueDate").ToString)) & IIf(Eval("DurationMins") > 0, " <small>(" & GetNiceMins(Eval("DurationMins")) & ")</small>", "") %>'></asp:Label>
                                                                        </DataItemTemplate>
                                                                    </dx:BootstrapGridViewDateColumn>
                                                                    <dx:BootstrapGridViewTextColumn Caption="Activity" FieldName="Topic" VisibleIndex="2">
                                                                        <DataItemTemplate>
                                                                            <asp:Label ID="lblActivity" EnableViewState="false" runat="server" Text='<%# IIf(Eval("MethodOther").ToString.Length > 0, Eval("MethodOther"), Eval("MethodFuture")) & " " & Eval("Topic") %>'></asp:Label>
                                                                        </DataItemTemplate>
                                                                    </dx:BootstrapGridViewTextColumn>
                                                                    <dx:BootstrapGridViewTextColumn Caption="Files" HorizontalAlign="Center" FieldName="FileCount" VisibleIndex="3">
                                                                        
                                                                </dx:BootstrapGridViewTextColumn>
                                                                    <dx:BootstrapGridViewTextColumn Caption=" " VisibleIndex="6">
                                                                        <DataItemTemplate>
                                                                            <asp:LinkButton EnableViewState="false" ID="lbtMarkCompleteLogItem"   Visible='<%# Eval("LoggedByID") = Session("learnCandidateID") And Eval("LoggedByAdminID") = 0 And IsAvailableToContributor(3)  %>' OnCommand="lbtEditLogItem_Command" ToolTip="Mark Complete" aria-label="Mark Item Complete" CommandName="MarkComplete" CommandArgument='<%# Eval("LearningLogItemID") %>' CssClass="btn btn-outline-success" runat="server"><i class="fas fa-calendar-check"></i></asp:LinkButton>
                                                                        <asp:LinkButton EnableViewState="false" ID="lbtUTA"   Visible='<%# Eval("LoggedByAdminID") > 0 And IsAvailableToContributor(3)  %>' OnCommand="lbtEditLogItem_Command" ToolTip="Mark unable to attend" aria-label="Mark unable to attend"  OnClientClick="return confirm('Are you sure you want mark yourself as unable to attend this activity?');" CommandName="MarkUta" CommandArgument='<%# Eval("LearningLogItemID") %>' CssClass="btn btn-outline-danger" runat="server"><i class="fas fa-calendar-times"></i></asp:LinkButton>
                                                                            <asp:LinkButton EnableViewState="false" ID="lbtArchive" Visible='<%# Eval("LoggedByID") = Session("learnCandidateID") And Eval("LoggedByAdminID") = 0 And IsAvailableToContributor(3)  %>' OnCommand="lbtEditLogItem_Command" ToolTip="Archive Item" aria-label="Archive Item"  OnClientClick="return confirm('Are you sure you want archive this log item and delete any associated files?');" CommandName="Archive" CommandArgument='<%# Eval("LearningLogItemID") %>' CssClass="btn btn-outline-danger" runat="server"><i class="fas fa-trash"></i></asp:LinkButton>
                                                                        </DataItemTemplate>
                                                                    </dx:BootstrapGridViewTextColumn>
                                                                    
                                                                </Columns>
                                                                <FormatConditions>
                                                                    <dx:GridViewFormatConditionHighlight  FieldName="DueDate" Expression="[DueDate] < LocalDateTimeToday()"  Format="RedText" />
                                                                </FormatConditions>
                                                                <SettingsSearchPanel Visible="True" />
                                                                <Templates>
                                                                    <DetailRow>
                                                                        <div class="form-group row mt-1">
                                                                            <asp:Label ID="lblLogged" AssociatedControlID="tbLogged" CssClass="col-sm-3 col-md-2" runat="server" Text="Logged:"></asp:Label><div class="col-md-3 col-sm-9">
                                                                                <asp:TextBox ID="tbLogged" CssClass="form-control mb-1" Enabled="false" Text='<%# Eval("LoggedDate", "{0:d}") %>' runat="server"></asp:TextBox>
                                                                            </div>
                                                                            <asp:Label ID="lblLoggedBy" AssociatedControlID="tbLoggedBy" CssClass="col-sm-3 col-md-2" runat="server" Text="By:"></asp:Label><div class="col-md-3 col-sm-9">
                                                                                <asp:TextBox ID="tbLoggedBy" CssClass="form-control mb-1" Enabled="false" Text='<%# Eval("LoggedBy") %>' runat="server"></asp:TextBox>
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group row">
                                                                            <asp:Label ID="Label28" AssociatedControlID="tbOutcomes" CssClass="col-sm-3 col-md-2" runat="server" Text="Agenda/Outcomes:"></asp:Label>
                                                                            <div class="col-md-10 col-sm-9">
                                                                                <asp:TextBox ID="tbOutcomes" CssClass="form-control mb-1" Enabled="false" TextMode="MultiLine" Text='<%# Eval("Outcomes") %>' runat="server"></asp:TextBox>
                                                                            </div>
                                                                        </div>
                                                                        <div class='<%# IIf(GetCS("DevelopmentLogForm.ShowSkillMapping"), "form-group row", "d-none")  %>'>
                                                                            <asp:Label ID="Label29" AssociatedControlID="tbRelatesTo" CssClass="col-sm-3 col-md-2" runat="server" Text="Linked to:"></asp:Label>
                                                                            <div class="col-sm-9 col-md-10">
                                                                                <asp:TextBox ID="tbRelatesTo" CssClass="form-control mb-1" Enabled="false" Text='<%# Eval("LinkedTo") %>' runat="server"></asp:TextBox></div>
                                                                        </div>
                                                                        <uc1:filemx EnableViewState="false" OnInit="filemx_Init" Visible='<%# Session("lmDelegateByteLimit") > 0 %>' runat="server" ID="filemx" />

                                                                    </DetailRow>
                                                                </Templates>
                                                            </dx:BootstrapGridView>

                                                        </div>
                                                        <div class="card-footer clearfix">
                                                            <asp:LinkButton ID="lbtLogAddPlanned" OnCommand="lbtAddSkillAction_Command" CssClass="btn btn-warning float-right mt-1 mb-1" runat="server"><i class="fas fa-plus"></i> <%: GetCS("DevelopmentLog.AddPlanned") %></asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div <%= IIf(GetCS("DevelopmentLog.ShowCompleted"), "class='card card-hundred'", "class='d-none'") %> >
                                                
                                                    <div class="card-header clickable clearfix collapse-card collapsed" data-toggle="collapse" data-target="#divcomplete">
                                                        <asp:Label ID="lblComplete" CssClass="card-title" runat="server"><%: GetCS("DevelopmentLog.Completed") %></asp:Label>
                                                    </div>
                                                    <div id="divcomplete" class="collapse section-panel Accordion1">
                                                        <div class="card-body">
                                                            <asp:ObjectDataSource ID="dsComplete" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetCompletedByProgID" TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.LearningLogItemsTableAdapter">
                                                                <SelectParameters>
                                                                    <asp:SessionParameter Name="ProgressID" SessionField="lmProgressID" Type="Int32" />
                                                                </SelectParameters>
                                                            </asp:ObjectDataSource>
                                                            <dx:BootstrapGridView ID="bsgvComplete" runat="server" AutoGenerateColumns="False" OnDataBound="bsgvSkillActions_DataBound" OnInit="bsgvPlanned_Init" DataSourceID="dsComplete" KeyFieldName="LearningLogItemID" SettingsDetail-ShowDetailRow="True" SettingsDetail-AllowOnlyOneMasterRowExpanded="True">
                                                                <SettingsBootstrap Striped="True" />
                                                                <Settings GridLines="None" />
                                                                <Columns>
                                                                    <dx:BootstrapGridViewTextColumn Caption=" " VisibleIndex="0">
                                                                        <DataItemTemplate>
                                                                            <asp:LinkButton ID="lbtEditLogItem" Visible='<%# Eval("LoggedByID") = Session("learnCandidateID") And Eval("LoggedByAdminID") = 0 And IsAvailableToContributor(2)  %>' EnableViewState="false" OnCommand="lbtEditLogItem_Command" ToolTip="Edit Item" CommandName="EditComplete" CommandArgument='<%# Eval("LearningLogItemID") %>' CssClass="btn btn-outline-primary" runat="server"><i class="fas fa-pen"></i></asp:LinkButton>
                                                                            <asp:LinkButton ID="lbtAddRA" Visible='<%# Eval("ReflectiveAccount") = 0 And GetCS("DevelopmentLog.IncludeReflectiveAccount")  %>' EnableViewState="false" OnCommand="lbtEditLogItem_Command" ToolTip="Add Reflective Account" CommandName="AddRA" CommandArgument='<%# Eval("LearningLogItemID") %>' CssClass="btn btn-outline-success" runat="server"><i aria-hidden="true" role="presentation" class="fas fa-file-alt"></i><span class="sr-only">Add Reflective Account</span></asp:LinkButton>
                                                                    <asp:LinkButton ID="lbtEditRA" Visible='<%# Eval("ReflectiveAccount") > 0 And GetCS("DevelopmentLog.IncludeReflectiveAccount")  %>' EnableViewState="false" OnCommand="lbtEditLogItem_Command" ToolTip="View/Edit Reflective Account" CommandName="EditRA" CommandArgument='<%# Eval("LearningLogItemID") %>' CssClass="btn btn-success" runat="server"><i aria-hidden="true" role="presentation" class="fas fa-file-alt"></i><span class="sr-only">View/Edit Reflective Account</span></asp:LinkButton>
                                                                        </DataItemTemplate>
                                                                    </dx:BootstrapGridViewTextColumn>
                                                                    <dx:BootstrapGridViewDateColumn FieldName="CompletedDate" Caption="Completed" VisibleIndex="1">
                                                                    </dx:BootstrapGridViewDateColumn>
                                                                    <dx:BootstrapGridViewTextColumn Caption="Activity" FieldName="Topic" VisibleIndex="2">
                                                                        <DataItemTemplate>
                                                                            <asp:Label ID="lblActivity" EnableViewState="false" runat="server" Text='<%# IIf(Eval("MethodOther").ToString.Length > 0, Eval("MethodOther"), Eval("MethodPast")) & " " & Eval("Topic") %>'></asp:Label>
                                                                        </DataItemTemplate>
                                                                    </dx:BootstrapGridViewTextColumn>
                                                                    <dx:BootstrapGridViewTextColumn Caption="Files" HorizontalAlign="Center" FieldName="FileCount" VisibleIndex="3">
                                                                    </dx:BootstrapGridViewTextColumn>
                                                                    <dx:BootstrapGridViewTextColumn FieldName="DurationMins" HorizontalAlign="Left" Caption="Duration" VisibleIndex="4">
                                                                        <DataItemTemplate>
                                                                            <asp:Label ID="Label19" EnableViewState="false" runat="server" Text='<%# GetNiceMins(Eval("DurationMins")) %>'></asp:Label>
                                                                        </DataItemTemplate>
                                                                    </dx:BootstrapGridViewTextColumn>
                                                                    <%--<dx:BootstrapGridViewTextColumn FieldName="VerifiedBy" ReadOnly="True" VisibleIndex="5">
                                                                </dx:BootstrapGridViewTextColumn>--%>
                                                                    <dx:BootstrapGridViewTextColumn Caption=" " VisibleIndex="7">
                                                                        <DataItemTemplate>
                                                                            <asp:LinkButton ID="lbtArchive" Visible='<%# Eval("LoggedByID") = Session("learnCandidateID") And Eval("LoggedByAdminID") = 0 And IsAvailableToContributor(2)  %>' EnableViewState="false" OnCommand="lbtEditLogItem_Command" ToolTip="Archive Item" OnClientClick="return confirm('Are you sure you want archive this log item and delete any associated files?');" CommandName="Archive" CommandArgument='<%# Eval("LearningLogItemID") %>' CssClass="btn btn-outline-danger" runat="server"><i class="fas fa-trash"></i></asp:LinkButton>
                                                                        </DataItemTemplate>
                                                                    </dx:BootstrapGridViewTextColumn>
                                                                </Columns>
                                                                <SettingsDetail ShowDetailRow="True" />
                                                                <SettingsSearchPanel Visible="True" />
                                                                <Templates>
                                                                    <DetailRow>
                                                                        <div class="form-group row mt-1">
                                                                            <asp:Label ID="Label28" AssociatedControlID="tbOutcomes" CssClass="col-sm-3 col-md-2" runat="server" Text="Outcomes:"></asp:Label>
                                                                            <div class="col-md-10 col-sm-9">
                                                                                <asp:TextBox ID="tbOutcomes" CssClass="form-control mb-1" Enabled="false" TextMode="MultiLine" Text='<%# Eval("Outcomes") %>' runat="server"></asp:TextBox>
                                                                            </div>
                                                                        </div>
                                                                        <div class='<%# IIf(GetCS("DevelopmentLogForm.ShowSkillMapping"), "form-group row", "d-none")  %>'>
                                                                            <asp:Label ID="Label29" AssociatedControlID="tbRelatesTo" CssClass="col-sm-3 col-md-2" runat="server" Text="Linked to:"></asp:Label>
                                                                            <div class="col-sm-9 col-md-10">
                                                                                <asp:TextBox ID="tbRelatesTo" CssClass="form-control mb-1" Enabled="false" Text='<%# Eval("LinkedTo") %>' runat="server"></asp:TextBox></div>
                                                                        </div>
                                                                        <uc1:filemx OnInit="filemx_Init" Visible='<%# Session("lmDelegateByteLimit") > 0 %>' runat="server" ID="filemx" />
                                                                    </DetailRow>
                                                                </Templates>
                                                            </dx:BootstrapGridView>
                                                        </div>
                                                        <div class="card-footer clearfix">
                                                            <asp:LinkButton ID="lbtLogAddComplete" OnCommand="lbtAddSkillEvidence_Command" CssClass="btn btn-success float-right" runat="server"><i class="fas fa-plus"></i> <%: GetCS("DevelopmentLog.AddCompleted")%></asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <script>
                                                $('.Accordion0').on('shown.bs.collapse', function () {
                                                    UpdateProgressText(0, <%:Session("lmProgressID") %>, true);

                                                })
                                                $('.Accordion0').on('hidden.bs.collapse', function () {
                                                    UpdateProgressText(0, <%:Session("lmProgressID") %>, false);

                                            })
                                            $('.Accordion1').on('shown.bs.collapse', function () {
                                                    UpdateProgressText(1, <%:Session("lmProgressID") %>, true);

                                                })
                                                $('.Accordion1').on('hidden.bs.collapse', function () {
                                                    UpdateProgressText(1, <%:Session("lmProgressID") %>, false);

                                            })
                                            </script>
                                    </asp:Panel>
                                    <asp:ObjectDataSource ID="dsProgressSummary" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.uspReturnProgressSummaryV2TableAdapter">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="ProgressID" SessionField="lmProgressID" Type="Int32" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                </asp:View>
                                <asp:View ID="vReviewSkill" runat="server">
                                    <asp:HiddenField ID="hfAPID" runat="server" />
                                    <div class="card card-itsp-blue">
                                        <div class="card-header">
                                            <h4>Review <%: GetCS("DevelopmentLogForm.Skill") %>: <small>
                                                <asp:Label ID="lblSASkill" runat="server" Text="lblSASkill"></asp:Label></small></h4>
                                        </div>
                                        <div class="card-body">


                                            <asp:Panel ID="pnlSADefinition" runat="server">
                                                <h6>Definition</h6>
                                                <p>
                                                    <asp:Label ID="lblSADescription" runat="server" Text="Label"></asp:Label>
                                                </p>
                                            </asp:Panel>
                                            <asp:Panel ID="pnlSARequirements" runat="server">
                                                <h6>Requirements to be met:</h6>
                                                <p>
                                                    <asp:Label ID="lblSAObjectives" runat="server" Text="Label"></asp:Label>
                                                </p>
                                            </asp:Panel>
                                            <div class="card card-default mb-2">
                                                <asp:Panel ID="pnlSelfAssessHeader" CssClass="card-header clickable collapse-card collapsed" data-toggle="collapse" data-target="#pnlSelfAssessBody" aria-controls="pnlSelfAssessBody" aria-expanded="false" role="button" runat="server">

                                                    <div class="card-title d-flex justify-content-between">
                                                        <h6 class="mt-0 mb-0">Self Assessment</h6>
                                                        <div>
                                                            Current Status: <b>
                                                                <asp:UpdatePanel ID="UpdatePanel2" UpdateMode="Conditional" ChildrenAsTriggers="True" runat="server">
                                                                    <ContentTemplate>
                                                                        <asp:Label ID="lblSAStatus" runat="server" Text="lblSAStatus"></asp:Label>
                                                                    </ContentTemplate>
                                                                    <Triggers>
                                                                        <asp:AsyncPostBackTrigger ControlID="lbtSASubmit" />
                                                                    </Triggers>
                                                                </asp:UpdatePanel>
                                                            </b>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                                <asp:Panel ID="pnlSelfAssessBody" ClientIDMode="static" CssClass="card-body collapse" runat="server">
                                                    <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" ChildrenAsTriggers="True" runat="server">
                                                        <ContentTemplate>

                                                            <asp:MultiView ID="mvSelfAssess" ActiveViewIndex="0" runat="server">
                                                                <asp:View ID="vSubmitSA" runat="server">
                                                                    <asp:ObjectDataSource ID="dsAssessDescriptors" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetByAssessmentTypeID" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.AssessmentTypeDescriptorsTableAdapter">

                                                                        <SelectParameters>
                                                                            <asp:Parameter DefaultValue="0" Name="AssessmentTypeID" Type="Int32" />
                                                                        </SelectParameters>

                                                                    </asp:ObjectDataSource>
                                                                    <p>
                                                                        <asp:Label ID="lblSARateYourself" runat="server" Text="Rate yourself against these requirements:"></asp:Label>
                                                                    </p>
                                                                    <asp:HiddenField ID="hfSASelected" ClientIDMode="static" runat="server" />
                                                                    <asp:Panel ID="pnlVerticalPrompts" runat="server">
                                                                        <div class="list-group checked-list-box">
                                                                            <asp:Repeater ID="rptAssessDescs" DataSourceID="dsAssessDescriptors" runat="server">
                                                                                <ItemTemplate>
                                                                                    <asp:Panel ID="pnlChoice" CssClass="list-group-item q-choice" data-type="radio" data-value='<%#Eval("AssessmentTypeDescriptorID") %>' data-style="alert" data-color="success" runat="server">


                                                                                        <asp:HiddenField ID="hfAssessDescID" Value='<%#Eval("AssessmentTypeDescriptorID") %>' runat="server" />
                                                                                        <p class="mb-1">
                                                                                            <b><%# Eval("DescriptorText") %></b>

                                                                                        </p>
                                                                                        <p class="mb-1"><%# Eval("DescriptorDetail") %></p>

                                                                                    </asp:Panel>
                                                                                </ItemTemplate>
                                                                            </asp:Repeater>
                                                                        </div>
                                                                    </asp:Panel>
                                                                    <asp:Panel ID="pnlHorizontalPrompts" runat="server">
                                                                        <ul class="nav nav-pills checked-nav nav-fill" id="hzTabList" role="tablist">
                                                                            <asp:Repeater ID="rptHZAssessTabs" DataSourceID="dsAssessDescriptors" runat="server">
                                                                                <ItemTemplate>
                                                                                    <li class="nav-item">
                                                                                        <asp:HiddenField ID="hfAssessDescID" Value='<%#Eval("AssessmentTypeDescriptorID") %>' runat="server" />
                                                                                        <asp:HyperLink ID="hlAssessDesc" data-toggle="tab" href='<%# "#ad-tab-" & Eval("AssessmentTypeDescriptorID").ToString %>' data-type="radio" data-value='<%#Eval("AssessmentTypeDescriptorID") %>' data-style="alert" data-color="success" role="tab" aria-controls='<%# "ad-tab-" & Eval("AssessmentTypeDescriptorID").ToString %>' aria-selected="false" CssClass="nav-link" runat="server"><%# Eval("DescriptorText") %></asp:HyperLink>
                                                                                    </li>
                                                                                </ItemTemplate>
                                                                            </asp:Repeater>
                                                                        </ul>
                                                                        <div class="tab-content" id="myTabContent">
                                                                            <asp:Repeater ID="rptHZAssessDescs" DataSourceID="dsAssessDescriptors" runat="server">
                                                                                <ItemTemplate>
                                                                                    <asp:HiddenField ID="hfAssessDescID" Value='<%#Eval("AssessmentTypeDescriptorID") %>' runat="server" />
                                                                                    <div class="tab-pane fade" id='<%# "ad-tab-" & Eval("AssessmentTypeDescriptorID").ToString %>' role="tabpanel">
                                                                                        <div class="alert alert-primary"><%# Eval("DescriptorDetail") %></div>
                                                                                    </div>
                                                                                </ItemTemplate>
                                                                            </asp:Repeater>
                                                                        </div>
                                                                    </asp:Panel>
                                                                    <asp:TextBox ID="tbSAComments" CssClass="form-control mt-2" TextMode="MultiLine" placeholder="Comments supporting self assessment rating" runat="server"></asp:TextBox>
                                                                    <asp:Panel ID="pnlRFVHolder" runat="server"></asp:Panel>
                                                                    <asp:LinkButton CssClass="btn btn-primary float-right btn-lg mt-2" ID="lbtSASubmit" CausesValidation="true" ValidationGroup="vgSelfAssess" runat="server">Submit</asp:LinkButton>
                                                                </asp:View>
                                                                <asp:View ID="vViewSA" runat="server">
                                                                    <h6><small>Self Assessment Rating:</small>
                                                                        <asp:Label ID="lblSARating" runat="server" Text="Label"></asp:Label></h6>
                                                                    <asp:Panel ID="pnlViewComments" runat="server">
                                                                        <h6>Supporting comments</h6>
                                                                        <asp:TextBox ID="tbSASupportingComments" CssClass="form-control mt-2 mb-2" Enabled="false" TextMode="MultiLine" placeholder="No comments provided" runat="server"></asp:TextBox>
                                                                    </asp:Panel>
                                                                    <asp:LinkButton CssClass="btn btn-primary float-right" ID="lbtUpdateSA" ToolTip="Submit new self assessment" runat="server">Update Self Assessment</asp:LinkButton>
                                                                </asp:View>
                                                            </asp:MultiView>
                                                        </ContentTemplate>
                                                        <Triggers>
                                                            <asp:AsyncPostBackTrigger ControlID="lbtSASubmit" />
                                                            <asp:AsyncPostBackTrigger ControlID="lbtUpdateSA" />
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </asp:Panel>
                                                <asp:Panel ID="pnlSV" CssClass="card card-default m-1" runat="server">
                                                    <div id="superviseHeader" runat="server" class="card-header clickable clearfix collapse-card collapsed" data-toggle="collapse" data-target="#supervisorstatus" aria-controls="supervisorstatus" aria-expanded="false">
                                                        <div class="card-title d-flex justify-content-between">
                                                            <h6 class="mt-0 mb-0"><%: GetCS("LearnMenu.Supervisor") %> verification status:
                                                                <asp:Label ID="lblSAVerificationStatus" runat="server" Text="Label"></asp:Label></h6>
                                                            <asp:Label ID="lblRequested" runat="server" CssClass="alert alert-warning float-right"></asp:Label></div>
                                                    </div>
                                                    <div id="supervisorstatus" class="card-body collapse">
                                                        <h6><%: GetCS("LearnMenu.Supervisor") %></h6>
                                                        <p>
                                                            <asp:Label ID="lblSASupervisor" runat="server" Text="Label"></asp:Label>
                                                        </p>
                                                        <h6><%: GetCS("LearnMenu.Verification") %> Outcome</h6>
                                                        <p>Status:<b><asp:Label ID="lblSASupervisorStatus" runat="server" Text="Label"></asp:Label></b>&nbsp;&nbsp;Date:<b><asp:Label ID="lblSAVerifiedDate" runat="server" Text="N/A"></asp:Label></b></p>
                                                        <h6><%: GetCS("LearnMenu.Supervisor") %> Comments</h6>
                                                        <p>
                                                            <asp:Label ID="lblSASupervisorComments" runat="server" Text="label"></asp:Label>
                                                        </p>
                                                    </div>

                                                </asp:Panel>
                                            </div>
                                            <asp:Panel ID="pnlSAEvidence" runat="server">
                                                <div <%= IIf(GetCS("DevelopmentLog.ShowCompleted"), "class='card card-hundred mb-2'", "class='d-none'") %> >
                                                
                                                    <div class="card-header clickable clearfix collapse-card collapsed" data-toggle="collapse" data-target="#evidence" aria-controls="evidence" aria-expanded="false" role="button" style="cursor: pointer;">
                                                        <div class="d-flex justify-content-between">
                                                            <h6 class="mt-0 mb-0"><%: GetCS("DevelopmentLog.Completed") %></h6>
                                                            <div class="mt-0">
                                                                <%: GetCS("DevelopmentLog.Completed") %> items: <b>
                                                                    <asp:Label ID="lblEvidenceCount" runat="server" Text="0"></asp:Label></b>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="collapse" id="evidence">
                                                        <div class="card-body">
                                                            <div class="alert alert-info">Use this section to record completed actions supporting your self assessment.</div>
                                                            <div class="card card-default">
                                                                <div class="card-body">
                                                                    <asp:Label ID="lblSAEvidenceText" runat="server" Text="Label"></asp:Label>
                                                                    <asp:ObjectDataSource ID="dsSkillEvidence" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetCompletedByProgTutID" TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.LearningLogItemsTableAdapter">
                                                                        <SelectParameters>
                                                                            <asp:SessionParameter Name="ProgressID" SessionField="lmProgressID" Type="Int32" />
                                                                            <asp:Parameter DefaultValue="0" Name="TutorialID" Type="Int32" />
                                                                        </SelectParameters>
                                                                    </asp:ObjectDataSource>
                                                                    <dx:BootstrapGridView ID="bsgvSkillEvidence" OnDataBound="bsgvSkillActions_DataBound" runat="server" OnInit="bsgvPlanned_Init" AutoGenerateColumns="False" DataSourceID="dsSkillEvidence" KeyFieldName="LearningLogItemID">
                                                                        <SettingsBootstrap Striped="True" />
                                                                        <Settings GridLines="None" />
                                                                        <SettingsDetail ShowDetailRow="True" ShowDetailButtons="true" AllowOnlyOneMasterRowExpanded="True"></SettingsDetail>
                                                                        <Columns>
                                                                            <dx:BootstrapGridViewTextColumn Caption=" " VisibleIndex="0">
                                                                                <DataItemTemplate>
                                                                                    <asp:LinkButton ID="lbtEditLogItem" Visible='<%# Eval("LoggedByID") = Session("learnCandidateID") And Eval("LoggedByAdminID") = 0 And IsAvailableToContributor(2)  %>' OnCommand="lbtEditLogItem_Command" ToolTip="Edit Item" CommandName="EditComplete" CommandArgument='<%# Eval("LearningLogItemID") %>' CssClass="btn btn-outline-primary" runat="server"><i class="fas fa-pen"></i></asp:LinkButton>
                                                                                </DataItemTemplate>
                                                                            </dx:BootstrapGridViewTextColumn>
                                                                            <dx:BootstrapGridViewDateColumn FieldName="CompletedDate" Caption="Completed" VisibleIndex="1">
                                                                            </dx:BootstrapGridViewDateColumn>
                                                                            <dx:BootstrapGridViewTextColumn Caption="Activity" FieldName="Topic" VisibleIndex="2">
                                                                                <DataItemTemplate>
                                                                                    <asp:Label ID="lblActivity" EnableViewState="false" runat="server" Text='<%# IIf(Eval("MethodOther").ToString.Length > 0, Eval("MethodOther"), Eval("MethodPast")) & " " & Eval("Topic") %>'></asp:Label>
                                                                                </DataItemTemplate>
                                                                            </dx:BootstrapGridViewTextColumn>
                                                                            <dx:BootstrapGridViewTextColumn Caption="Files" HorizontalAlign="Center" FieldName="FileCount" VisibleIndex="3">
                                                                            </dx:BootstrapGridViewTextColumn>
                                                                            <dx:BootstrapGridViewTextColumn FieldName="DurationMins" Caption="Duration" VisibleIndex="4">
                                                                                <DataItemTemplate>
                                                                                    <asp:Label ID="Label19" runat="server" Text='<%# GetNiceMins(Eval("DurationMins")) %>'></asp:Label>
                                                                                </DataItemTemplate>
                                                                            </dx:BootstrapGridViewTextColumn>
                                                                            <dx:BootstrapGridViewTextColumn Caption=" " VisibleIndex="6">
                                                                                <DataItemTemplate>
                                                                                    <asp:LinkButton ID="lbtArchive" Visible='<%# Eval("LoggedByID") = Session("learnCandidateID") And Eval("LoggedByAdminID") = 0 And IsAvailableToContributor(2)  %>' EnableViewState="false" OnCommand="lbtEditLogItem_Command" ToolTip="Archive Item" OnClientClick="return confirm('Are you sure you want archive this log item and delete any associated files?');" CommandName="Archive" CommandArgument='<%# Eval("LearningLogItemID") %>' CssClass="btn btn-outline-danger" runat="server"><i class="fas fa-trash"></i></asp:LinkButton>
                                                                                </DataItemTemplate>
                                                                            </dx:BootstrapGridViewTextColumn>
                                                                        </Columns>
                                                                        <Templates>
                                                                            <DetailRow>
                                                                                <div class="form-group row mt-1">
                                                                                    <asp:Label ID="Label28" AssociatedControlID="tbOutcomes" CssClass="col-sm-3 col-md-2" runat="server" Text="Outcomes:"></asp:Label>
                                                                                    <div class="col-md-10 col-sm-9">
                                                                                        <asp:TextBox ID="tbOutcomes" CssClass="form-control mb-1" Enabled="false" TextMode="MultiLine" Text='<%# Eval("Outcomes") %>' runat="server"></asp:TextBox>
                                                                                    </div>
                                                                                </div>
                                                                                <div class='<%# IIf(GetCS("DevelopmentLogForm.ShowSkillMapping"), "form-group row", "d-none")  %>'>
                                                                                    <asp:Label ID="Label29" AssociatedControlID="tbRelatesTo" CssClass="col-sm-3 col-md-2" runat="server" Text="Linked to:"></asp:Label>
                                                                                    <div class="col-sm-9 col-md-10">
                                                                                        <asp:TextBox ID="tbRelatesTo" CssClass="form-control mb-1" Enabled="false" Text='<%# Eval("LinkedTo") %>' runat="server"></asp:TextBox>
                                                                                    </div>
                                                                                </div>
                                                                                <uc1:filemx OnInit="filemx_Init" Visible='<%# Session("lmDelegateByteLimit") > 0 %>' runat="server" ID="filemx" />
                                                                            </DetailRow>
                                                                        </Templates>
                                                                        <SettingsDetail ShowDetailRow="True" />
                                                                        <SettingsSearchPanel Visible="True" />
                                                                    </dx:BootstrapGridView>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="card-footer clearfix">
                                                            <asp:LinkButton ID="lbtAddSkillEvidence" OnCommand="lbtAddSkillEvidence_Command" CssClass="btn btn-success float-right" runat="server"><i class="fas fa-plus"></i> Add Evidence</asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div <%= IIf(GetCS("DevelopmentLog.ShowPlanned"), "class='card card-fifty mb-2'", "class='d-none'") %> >
                                               
                                                    <div class="card-header clickable clearfix collapse-card collapsed" data-toggle="collapse" data-target="#actionplan" aria-controls="actionplan" aria-expanded="false" role="button" style="cursor: pointer;">
                                                        <div class="d-flex justify-content-between">
                                                            <h6 class="mt-0 mb-0"><%: GetCS("DevelopmentLog.Planned") %></h6>
                                                            <div class="mt-0">Open actions: <b>
                                                                <asp:Label ID="lblActionsCount" runat="server" Text="0"></asp:Label></b></div>
                                                        </div>
                                                    </div>
                                                    <div class="collapse" id="actionplan">
                                                        <div class="card-body">
                                                            <div class="alert alert-info">Use this section to record actions to improve performance against this requirement.</div>

                                                            <asp:ObjectDataSource ID="dsSkillAction" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetPlannedByProgressTutorialID" TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.LearningLogItemsTableAdapter">
                                                                <SelectParameters>
                                                                    <asp:SessionParameter Name="ProgressID" SessionField="lmProgressID" Type="Int32" />
                                                                    <asp:Parameter DefaultValue="0" Name="TutorialID" Type="Int32" />
                                                                </SelectParameters>
                                                            </asp:ObjectDataSource>
                                                            <dx:BootstrapGridView ID="bsgvSkillActions" runat="server" OnInit="bsgvPlanned_Init" OnDataBound="bsgvSkillActions_DataBound" AutoGenerateColumns="False" DataSourceID="dsSkillAction" KeyFieldName="LearningLogItemID">
                                                                <SettingsBootstrap Striped="True" />
                                                                <Settings GridLines="None" />
                                                                <Columns>
                                                                    <dx:BootstrapGridViewTextColumn Caption=" " VisibleIndex="0">
                                                                        <DataItemTemplate>
                                                                            <div style="display: flex">
                                                                                <asp:LinkButton EnableViewState="false" Visible='<%# Eval("LoggedByID") = Session("learnCandidateID") And Eval("LoggedByAdminID") = 0 And IsAvailableToContributor(3)  %>' ID="lbtEditLogItem" OnCommand="lbtEditLogItem_Command" ToolTip="Edit" CommandName="EditPlanned" aria-label="Edit" CommandArgument='<%# Eval("LearningLogItemID") %>' CssClass="btn btn-outline-primary" runat="server"><i class="fas fa-pen"></i></asp:LinkButton>
                                                                                <asp:LinkButton EnableViewState="false" ID="lbtDownloadICS" Visible='<%# Not Eval("AppointmentTypeID") = 8 And Not Eval("AppointmentTypeID") = 4 %>' CssClass="btn btn-outline-success" OnCommand="lbtDownloadICS_Command" ToolTip="Download Calendar Invite" aria-label="Download Calendar Invite" CommandArgument='<%# Eval("LearningLogItemID") %>' runat="server"><i class="fas fa-calendar-plus fa-lg"></i></asp:LinkButton>
                                                                                <asp:LinkButton EnableViewState="false" ID="LinkButton1" Visible='<%# (Eval("AppointmentTypeID") = 8 Or Eval("AppointmentTypeID") = 4) And Eval("CallUri").ToString.Length > 0 And IsAvailableToContributor(3) %>' CssClass="btn btn-outline-success" OnCommand="lbtDlSFBICS_Command" ToolTip="Email Calendar Invite" aria-label="Email Calendar Invite" CommandArgument='<%# Eval("LearningLogItemID") %>' runat="server"><i class="fas fa-calendar-plus fa-lg"></i></asp:LinkButton>
                                                                                <asp:LinkButton OnCommand="lbtEditLogItem_Command" Visible='<%#Eval("AppointmentTypeID") = 5 And IsAvailableToContributor(3) %>' CommandName="LaunchDLS" CommandArgument='<%# Eval("LinkedCustomisationID") %>' ID="lbtEvent" CssClass='<%# "btn btn-" & Eval("BtnColourClass") %>' runat="server"><i class='<%#Eval("IconClass") %>'></i></asp:LinkButton>
                                                                                <%--<asp:Panel ID="pnlSFB" CssClass="dropdown" Visible='<%# Eval("AppointmentTypeID") = 3 And Eval("CallUri").ToString.Length > 0 And IsAvailableToContributor(3) %>' runat="server">
                                                                                    <button class='<%# "btn btn-" & Eval("BtnColourClass") & " dropdown-toggle" %>' title="Join Skype Call" type="button" id='<%# "dropdownMenuButton-" & Eval("LearningLogItemID").ToString %>' data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                                        <i class='<%#Eval("IconClass") %>'></i>
                                                                                    </button>
                                                                                    <div aria-labelledby='<%# "dropdownMenuButton-" & Eval("LearningLogItemID").ToString %>' class="dropdown-menu">
                                                                                        <a class="dropdown-item" target="_blank" href='<%# getSFBLink(Eval("CallUri").ToString()) %>'>Join in web browser</a>
                                                                                        <a class="dropdown-item" href='<%# getSFBMeetLink(Eval("CallUri").ToString()) %>'>Join in Skype for Business app</a>
                                                                                    </div>
                                                                                </asp:Panel>--%>


                                                                                <asp:HyperLink ID="hlSFB" runat="server" ToolTip="Join Supervision Session" Visible='<%# (Eval("AppointmentTypeID") = 4 Or Eval("AppointmentTypeID") = 8) And Eval("CallUri").ToString.Length > 0 And IsAvailableToContributor(3) %>' Target="_blank" CssClass='<%# "btn btn-" & Eval("BtnColourClass") %>' NavigateUrl='<%# Eval("CallUri").ToString() %>'><i class='<%# Eval("IconClass") %>'></i></asp:HyperLink>
                                                                            </div>
                                                                        </DataItemTemplate>
                                                                    </dx:BootstrapGridViewTextColumn>

                                                                    <dx:BootstrapGridViewDateColumn FieldName="DueDate" Caption="Due" VisibleIndex="1">
                                                                        <DataItemTemplate>
                                                                            <asp:Label EnableViewState="false" ID="Label31" runat="server" Text='<%# Eval("DueDate", getDateFormatString(Eval("DueDate").ToString)) & IIf(Eval("DurationMins") > 0, " <small>(" & GetNiceMins(Eval("DurationMins")) & ")</small>", "") %>'></asp:Label>
                                                                        </DataItemTemplate>
                                                                    </dx:BootstrapGridViewDateColumn>
                                                                    <dx:BootstrapGridViewTextColumn Caption="Activity" FieldName="Topic" VisibleIndex="2">
                                                                        <DataItemTemplate>
                                                                            <asp:Label ID="lblActivity" EnableViewState="false" runat="server" Text='<%# IIf(Eval("MethodOther").ToString.Length > 0, Eval("MethodOther"), Eval("MethodFuture")) & " " & Eval("Topic") %>'></asp:Label>
                                                                        </DataItemTemplate>
                                                                    </dx:BootstrapGridViewTextColumn>
                                                                    <dx:BootstrapGridViewTextColumn Caption="Files" HorizontalAlign="Center" FieldName="FileCount" VisibleIndex="3">
                                                                    </dx:BootstrapGridViewTextColumn>
                                                                    <dx:BootstrapGridViewTextColumn Caption=" " VisibleIndex="6">
                                                                        <DataItemTemplate>
                                                                            <asp:LinkButton EnableViewState="false" ID="lbtMarkCompleteLogItem" Visible='<%# Eval("LoggedByID") = Session("learnCandidateID") And Eval("LoggedByAdminID") = 0 And IsAvailableToContributor(3)  %>' OnCommand="lbtEditLogItem_Command" ToolTip="Mark Complete" aria-label="Mark Complete" CommandName="MarkComplete" CommandArgument='<%# Eval("LearningLogItemID") %>' CssClass="btn btn-outline-success" runat="server"><i class="fas fa-calendar-check"></i></asp:LinkButton>
                                                                            <asp:LinkButton EnableViewState="false" ID="lbtUTA" Visible='<%# Eval("LoggedByAdminID") > 0 And IsAvailableToContributor(3)  %>' OnCommand="lbtEditLogItem_Command" ToolTip="Mark unable to attend" aria-label="Mark unable to attend" OnClientClick="return confirm('Are you sure you want mark yourself as unable to attend this activity?');" CommandName="MarkUta" CommandArgument='<%# Eval("LearningLogItemID") %>' CssClass="btn btn-outline-danger" runat="server"><i class="fas fa-calendar-times"></i></asp:LinkButton>
                                                                            <asp:LinkButton EnableViewState="false" ID="lbtArchive" Visible='<%# Eval("LoggedByAdminID") = 0 And IsAvailableToContributor(3)  %>' OnCommand="lbtEditLogItem_Command" ToolTip="Archive Item" aria-label="Archive Item" OnClientClick="return confirm('Are you sure you want archive this log item and delete any associated files?');" CommandName="Archive" CommandArgument='<%# Eval("LearningLogItemID") %>' CssClass="btn btn-outline-danger" runat="server"><i class="fas fa-trash"></i></asp:LinkButton>
                                                                        </DataItemTemplate>
                                                                    </dx:BootstrapGridViewTextColumn>

                                                                </Columns>
                                                                <FormatConditions>
                                                                    <dx:GridViewFormatConditionHighlight FieldName="DueDate" Expression="[DueDate] < LocalDateTimeToday()" Format="RedText" />
                                                                </FormatConditions>
                                                                <SettingsSearchPanel Visible="True" />
                                                                <Templates>
                                                                    <DetailRow>
                                                                        <div class="form-group row mt-1">
                                                                            <asp:Label ID="lblLogged" AssociatedControlID="tbLogged" CssClass="col-sm-3 col-md-2" runat="server" Text="Logged:"></asp:Label><div class="col-md-3 col-sm-9">
                                                                                <asp:TextBox ID="tbLogged" CssClass="form-control mb-1" Enabled="false" Text='<%# Eval("LoggedBy") %>' runat="server"></asp:TextBox>
                                                                            </div>
                                                                            <asp:Label ID="lblLoggedBy" AssociatedControlID="tbLoggedBy" CssClass="col-sm-3 col-md-2" runat="server" Text="By:"></asp:Label><div class="col-md-3 col-sm-9">
                                                                                <asp:TextBox ID="tbLoggedBy" CssClass="form-control mb-1" Enabled="false" Text='<%# Eval("LoggedBy") %>' runat="server"></asp:TextBox>
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group row">
                                                                            <asp:Label ID="Label28" AssociatedControlID="tbOutcomes" CssClass="col-sm-3 col-md-2" runat="server" Text="Outcomes:"></asp:Label>
                                                                            <div class="col-md-10 col-sm-9">
                                                                                <asp:TextBox ID="tbOutcomes" CssClass="form-control mb-1" Enabled="false" TextMode="MultiLine" Text='<%# Eval("Outcomes") %>' runat="server"></asp:TextBox>
                                                                            </div>
                                                                        </div>
                                                                        <div class='<%# IIf(GetCS("DevelopmentLogForm.ShowSkillMapping"), "form-group row", "d-none")  %>'>
                                                                            <asp:Label ID="Label29" AssociatedControlID="tbRelatesTo" CssClass="col-sm-3 col-md-2" runat="server" Text="Linked to:"></asp:Label>
                                                                            <div class="col-sm-9 col-md-10">
                                                                                <asp:TextBox ID="tbRelatesTo" CssClass="form-control mb-1" Enabled="false" Text='<%# Eval("LinkedTo") %>' runat="server"></asp:TextBox></div>
                                                                        </div>
                                                                        <uc1:filemx EnableViewState="false" OnInit="filemx_Init" Visible='<%# Session("lmDelegateByteLimit") > 0 %>' runat="server" ID="filemx" />

                                                                    </DetailRow>
                                                                </Templates>
                                                                <SettingsSearchPanel Visible="True" />
                                                            </dx:BootstrapGridView>
                                                        </div>
                                                        <div class="card-footer clearfix">
                                                            <asp:LinkButton ID="lbtAddSkillAction" OnCommand="lbtAddSkillAction_Command" CssClass="btn btn-warning float-right" runat="server"><i class="fas fa-plus"></i> Add Action</asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </div>
                                            </asp:Panel>
                                        </div>
                                        <div class="card-footer">
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <asp:LinkButton ID="lbtPrevious" CssClass="btn btn-primary" runat="server"><i class="fas fa-arrow-circle-left"></i> Previous</asp:LinkButton>
                                                    <asp:LinkButton ID="lbtCloseCompetency" CssClass="btn btn-secondary" runat="server"><i class="fas fa-times-circle"></i> Close</asp:LinkButton>
                                                </div>
                                                <asp:Label ID="lblProgress" runat="server" Text="1 / 10"></asp:Label>
                                                <asp:LinkButton ID="lbtNext" CssClass="btn btn-primary" runat="server">Next <i class="fas fa-arrow-circle-right"></i></asp:LinkButton>
                                                <asp:LinkButton ID="lbtFinish" CssClass="btn btn-primary" runat="server"><i class="fas fa-check-circle"></i> Finish</asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </asp:View>
     
    <asp:View ID="vLogItemComplete" runat="server">
      
          <div class="card card-hundred">
                        <div class="card-header">
                            <h4>
                                <asp:Label ID="lblLogItemHeading" runat="server"><%: GetCS("DevelopmentLogForm.RecordCompletedDevelopmentActivityEvidence")%></asp:Label></h4>
                        </div>
                        <div class="card-body">
                              <asp:ObjectDataSource ID="dsMethods" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.MethodsTableAdapter"></asp:ObjectDataSource>
                            <asp:ObjectDataSource ID="dsCustomisationsCompleted" OnSelected="dsCustomisationsCompleted_Selected" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetCompletedByCandidate" TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.CustomisationsListTableAdapter">
                                <SelectParameters>
                                    <asp:SessionParameter Name="CandidateID" SessionField="learnCandidateID" Type="Int32" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                            <asp:UpdatePanel ID="UpdatePanel3" UpdateMode="Conditional" ChildrenAsTriggers="false" runat="server">
                                <ContentTemplate>
                                    <div <%= IIf(GetCS("DevelopmentLogForm.ShowDLSCourses"), "", "class='d-none'") %>>
                                    <asp:Panel ID="pnlCustComp" CssClass="form-group row" runat="server">
                                <asp:Label ID="Label27" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="ddCustomisationCompleted">Was the activity a DLS Course:</asp:Label>
                                <div class="col-sm-8">
                                    <asp:DropDownList CssClass="form-control" AutoPostBack="True" ID="ddCustomisationCompleted" OnSelectedIndexChanged="ddCustomisationCompleted_SelectedIndexChanged" AppendDataBoundItems="True" runat="server" DataSourceID="dsCustomisationsCompleted" DataTextField="CourseName" DataValueField="CustomisationID">
                                        <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </div></asp:Panel></div>
                           <div  <%= IIf(GetCS("DevelopmentLogForm.ShowMethod"), "class='form-group row'", "class='d-none'") %>>
                                <asp:Label ID="Label11" runat="server" CssClass="control-label col-sm-4"  AssociatedControlID="bscbxMethod"><%: GetCS("DevelopmentLogForm.Method")%>:</asp:Label>
                               
                               <div class="col-sm-8">
                                      <dx:BootstrapComboBox ValidationSettings-SetFocusOnError='<%# GetCS("DevelopmentLogForm.ShowMethod") %>' ValidationSettings-ValidationGroup='<%# IIf(GetCS("DevelopmentLogForm.ShowMethod"), "vgLogComplete", "vgNone") %>' ValidationSettings-RequiredField-IsRequired='<%# GetCS("DevelopmentLogForm.ShowMethod") %>' ClientInstanceName="cbxmethod" ID="bscbxMethod" CssClasses-Control="popover-method" ValueType="System.Int32" DataSourceID="dsMethods" NullText="Select a method (what did you do?)" TextField="MethodPast" ValueField="MethodID" ClientIDMode="static" runat="server">
                                         <Buttons>
                                            <dx:BootstrapEditButton Position="Left" IconCssClass="fas fa-info"  />
                                        </Buttons>
                                    </dx:BootstrapComboBox>
                                     </div>
                                    <div class="collapse">
<dx:BootstrapTextBox ID="bstbMethodOther" runat="server"></dx:BootstrapTextBox>
                                    </div>
                                    
                            </div>

                           <div class="form-group row">
                                <asp:Label ID="lblActivity" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="bstbTopic"><%: GetCS("DevelopmentLogForm.Activity")%>:</asp:Label>
                                <div class="col-sm-8">
                                    <dx:BootstrapTextBox ID="bstbTopic" MaxLength="250" runat="server">
                            <ValidationSettings ValidationGroup="vgLogComplete" SetFocusOnError="true">
                                <RequiredField IsRequired="true" ErrorText="Activity is required" />
                            </ValidationSettings>
                        </dx:BootstrapTextBox>
                                  
                                </div>

                           </div> 
                            <div class="form-group row">
                                <asp:Label ID="Label7" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="bstbTopic"><%: GetCS("DevelopmentLogForm.DueDateTime")%> (optional):</asp:Label>
                                <div class="col-sm-8">
                                    <dx:BootstrapDateEdit ID="bsdeDueDate" OnInit="bsdeDueDatePlanned_Init" runat="server" TimeSectionProperties-Visible="True" EditFormat="DateTime"></dx:BootstrapDateEdit>
                                </div>
                            </div>
                            <div class="form-group row">
                                <asp:Label ID="Label8" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="bsdeDueDate"><%: GetCS("DevelopmentLogForm.CompletedDate")%>:</asp:Label>
                                <div class="col-sm-8">
                                    <dx:BootstrapDateEdit ID="bsdeCompletedDate" OnInit="bsdeCompletedDate_Init" runat="server">
                                        <ValidationSettings ValidationGroup="vgLogComplete" SetFocusOnError="True">
            <RequiredField IsRequired="true" ErrorText="Completed date is required" />
        </ValidationSettings>
                                    </dx:BootstrapDateEdit>
                                </div>
                            </div>
                            <div class="form-group row">
                                <asp:Label ID="Label17" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="bspinHours"><%: GetCS("DevelopmentLogForm.Duration")%>:</asp:Label>
                                <div class="col-sm-4">
                                    <div class="input-group">
                                    <dx:BootstrapSpinEdit ID="bspinHours" runat="server" NumberType="Integer" NullText="Hours"></dx:BootstrapSpinEdit>
                                         <div class="input-group-append">
                                            <span class="input-group-text">hours</span>
                                            </div>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="input-group">
                                    <dx:BootstrapSpinEdit ID="bspinMins" runat="server" NumberType="Integer" NullText="Mins"></dx:BootstrapSpinEdit>
                                         <div class="input-group-append">
                                            <span class="input-group-text">mins</span>
                                            </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group row">
                                <asp:Label ID="Label18" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="bsmemOutcomes"><%: GetCS("DevelopmentLog.ExpectedOutcomes")%>:</asp:Label>
                                <div class="col-sm-8">
                                    <dx:BootstrapMemo ID="bsmemOutcomes" runat="server"></dx:BootstrapMemo>
                                </div>
                            </div>
                                    <asp:ObjectDataSource ID="dsObjectives" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetByProgressID" TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.TutorialsListTableAdapter">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="ProgressID" SessionField="lmProgressID" Type="Int32" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                            <div <%= IIf(GetCS("DevelopmentLogForm.ShowSkillMapping"), "class='form-group row'", "class='d-none'") %>>
                                <asp:Label ID="Label20" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="bsddeTutorialsLogItem">Related <%: GetCS("DevelopmentLogForm.Skill")%>(s):</asp:Label>
                                <div class="col-sm-8">
                                    <dx:BootstrapDropDownEdit ID="bsddeTutorialsLogItem" ClientInstanceName="msTutorialsLogItem" runat="server" ReadOnly="True" ClientSideEvents-GotFocus="ddTutLogItemGotFocus">
                                        <CssClasses Control="not-greyed" />
                                        <DropDownWindowTemplate>
                                            <dx:BootstrapListBox ID="bslbTutorialsLogItem" ClientInstanceName="listTutorialsForCompleteLogItem" SelectionMode="CheckColumn" OnDataBound="bslbTutorialsLogItem_DataBound" DataSourceID="dsObjectives" TextField="ObjectiveSkill" ValueField="TutorialID" runat="server">
                                                
                                                <ClientSideEvents SelectedIndexChanged="updateTutLogItemText" Init="updateTutLogItemText" />
                                            </dx:BootstrapListBox>
                                        </DropDownWindowTemplate>
                                        
                                    </dx:BootstrapDropDownEdit>
                                    <%--<asp:ListBox ID="listTutorialsLogItemComplete" SelectionMode="Multiple" CssClass="selectpicker" runat="server" DataSourceID="dsObjectives" DataTextField="ObjectiveSkill" DataValueField="TutorialID"></asp:ListBox>--%>
                                </div>
                            </div>
                                    </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ddCustomisationCompleted" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                            <div  <%= IIf(GetCS("DevelopmentLogForm.ShowFileUpload"), "", "class='d-none'") %>>
                            <asp:Panel ID="pnlAddEvidence" CssClass="form-group row" runat="server">

                            
                           
<asp:Label ID="lblCBAddEv" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="bscbHasEvidenceFiles" Text="I have evidence files to upload against this log item:"></asp:Label>
                                 <div class="col-sm-8">
                                     <dx:BootstrapCheckBox ID="bscbHasEvidenceFiles" runat="server"></dx:BootstrapCheckBox>
                                     </div>
                                 </asp:Panel></div>
                            <dx:BootstrapButton ID="bsbtCancelAddCompleted" CssClasses-Control="float-left" OnCommand="lbtCancelAddCompleted_Command" runat="server" Text="Cancel">
                                <ClientSideEvents Click="function(s, e) { ASPxClientEdit.ClearGroup('vgLogComplete'); }" />
                            </dx:BootstrapButton>
                            <dx:BootstrapButton ID="bsbtSubmitCompletedLogItem" CssClasses-Control="float-right" OnCommand="lbtSubmitCompletedLogItem_Command" SettingsBootstrap-RenderOption="Primary" CommandName="Insert" runat="server" Text="Submit">
                                <ClientSideEvents Click="function(s, e) { e.processOnServer = ASPxClientEdit.ValidateGroup('vgLogComplete'); }" />
    <CssClasses Icon="fa fa-check" />
                            </dx:BootstrapButton>
                            </div>
              </div>
    </asp:View>
    <asp:View ID="vLogItemPlanned" runat="server">
        <asp:ObjectDataSource ID="dsCustomisationsForCentre" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActiveForCentreID" TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.CustomisationsListTableAdapter">
                                <SelectParameters>
                                    <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
         <div class="card card-fifty">
                        <div class="card-header">
                            <h4>
                                <asp:Label ID="lblPlannedHeading" runat="server"><%: GetCS("DevelopmentLogForm.RecordPlannedDevelopmentActivity")%></asp:Label></h4>
                        </div>
                        <div class="card-body">
                            <asp:UpdatePanel ID="UpdatePanel4" UpdateMode="Conditional" ChildrenAsTriggers="False" runat="server">
                                <ContentTemplate>

                                
                            <div <%= IIf(GetCS("DevelopmentLogForm.ShowDLSCourses"), "", "class='d-none'") %>>
                                <asp:Panel ID="pnlCustPlanned" CssClass="form-group row" runat="server">
                                <asp:Label ID="Label24" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="ddCustomisationPlanned">Is the Activity a DLS Course:</asp:Label>
                                <div class="col-sm-8">
                                    <asp:DropDownList CssClass="form-control" ID="ddCustomisationPlanned" AutoPostBack="true" OnSelectedIndexChanged="ddCustomisationPlanned_SelectedIndexChanged" AppendDataBoundItems="True" runat="server" DataSourceID="dsCustomisationsForCentre" DataTextField="CourseName" DataValueField="CustomisationID">
                                        <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </div></asp:Panel>
                                </div>
                           <div <%= IIf(GetCS("DevelopmentLogForm.ShowMethod"), "class='form-group row'", "class='d-none'") %>>
                                <asp:Label ID="Label21" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="bscbxMethodPlanned"><%: GetCS("DevelopmentLogForm.Method")%>:</asp:Label>
                                <div class="col-sm-8">
                                    <dx:BootstrapComboBox ID="bscbxMethodPlanned" ValueType="System.Int32" DataSourceID="dsMethods" CssClasses-Control="popover-method" NullText="Select a method (what do you plan to do?)" TextField="MethodFuture" ValueField="MethodID" ClientIDMode="static" runat="server">
                                        <ValidationSettings ValidationGroup="vgPlanAction" SetFocusOnError="True">
            <RequiredField IsRequired="true" ErrorText="Method is required" />
        </ValidationSettings>
                                        <Buttons>
                                            <dx:BootstrapEditButton Position="Left" IconCssClass="fas fa-info"  />
                                        </Buttons>
                                    </dx:BootstrapComboBox>
                                    <div class="collapse">
<dx:BootstrapTextBox ID="bstbMethodOtherPlanned" runat="server"></dx:BootstrapTextBox>
                                    </div>
                                </div>
                            </div>
                           <div class="form-group row">
                                <asp:Label ID="Label22" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="bstbTopicPlanned"><%: GetCS("DevelopmentLogForm.Activity")%>:</asp:Label>
                                <div class="col-sm-8">
                                    <dx:BootstrapTextBox ID="bstbTopicPlanned" MaxLength="250" runat="server">
                            <ValidationSettings ValidationGroup="vgPlanAction" SetFocusOnError="True">
                                <RequiredField IsRequired="true" ErrorText="Activity is required" />
                            </ValidationSettings>
                        </dx:BootstrapTextBox>
                                  
                                </div>

                           </div> 
                            <div class="form-group row">
                                <asp:Label ID="Label23" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="bsdeDueDatePlanned"><%: GetCS("DevelopmentLogForm.DueDateTime")%>:</asp:Label>
                                <div class="col-sm-8">
                                    <dx:BootstrapDateEdit ID="bsdeDueDatePlanned" OnInit="bsdeDueDatePlanned_Init" runat="server" TimeSectionProperties-Visible="True" EditFormat="DateTime" ValidationSettings-ValidationGroup="vgPlanAction" ValidationSettings-SetFocusOnError="True">
                                        <ValidationSettings ValidationGroup="vgPlanAction" SetFocusOnError="True">
            <RequiredField IsRequired="true" ErrorText="Due date is required" />
        </ValidationSettings>
                                    </dx:BootstrapDateEdit>
                                </div>
                            </div>
                            <div class="form-group row">
                                <asp:Label ID="Label25" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="bspinHoursExpected">Expected <%: GetCS("DevelopmentLogForm.Duration")%>:</asp:Label>
                                <div class="col-sm-4">
                                    <div class="input-group">
                                    <dx:BootstrapSpinEdit ID="bspinHoursExpected" runat="server" NumberType="Integer" NullText="hours"></dx:BootstrapSpinEdit>
                                        <div class="input-group-append">
                                            <span class="input-group-text">hours</span>
                                            </div>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="input-group">
                                    <dx:BootstrapSpinEdit ID="bspinMinsExpected" runat="server" NumberType="Integer" NullText="mins"></dx:BootstrapSpinEdit>
                                         <div class="input-group-append">
                                            <span class="input-group-text">mins</span>
                                            </div>
                                        </div>
                                </div>
                            </div>
                            <div  class="form-group row">
                                <asp:Label ID="Label26" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="bsmemOutcomesPlanned">Expected <%: GetCS("DevelopmentLog.ExpectedOutcomes")%>:</asp:Label>
                                <div class="col-sm-8">
                                    <dx:BootstrapMemo ID="bsmemOutcomesPlanned" runat="server"></dx:BootstrapMemo>
                                </div>
                            </div>
                                    </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ddCustomisationPlanned" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                            <div <%= IIf(GetCS("DevelopmentLogForm.ShowSkillMapping"), "class='form-group row'", "class='d-none'") %>>
                                <asp:Label ID="Label6" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="bsddeTutorialsLogItemPlanned">Related <%: GetCS("DevelopmentLogForm.Skill")%>(s):</asp:Label>
                                <div class="col-sm-8">
                                    <dx:BootstrapDropDownEdit ID="bsddeTutorialsLogItemPlanned" ClientInstanceName="msTutorialsLogItemPlanned" runat="server" ReadOnly="True" ClientSideEvents-GotFocus="ddTutLogItemPlannedGotFocus">
                                        <CssClasses Control="not-greyed" />
                                        <DropDownWindowTemplate>
                                            <dx:BootstrapListBox ID="bslbTutorialsLogItemPlanned" ClientInstanceName="listTutorialsForCompleteLogItemPlanned" SelectionMode="CheckColumn" OnDataBound="bslbTutorialsLogItemPlanned_DataBound" DataSourceID="dsObjectives" TextField="ObjectiveSkill" ValueField="TutorialID" runat="server">
                                                
                                                <ClientSideEvents SelectedIndexChanged="updateTutLogItemTextPlanned" Init="updateTutLogItemTextPlanned" />
                                            </dx:BootstrapListBox>
                                        </DropDownWindowTemplate>
                                        
                                    </dx:BootstrapDropDownEdit>
                                    <%--<asp:ListBox ID="listTutorialsLogItemComplete" SelectionMode="Multiple" CssClass="selectpicker" runat="server" DataSourceID="dsObjectives" DataTextField="ObjectiveSkill" DataValueField="TutorialID"></asp:ListBox>--%>
                                </div>
                            </div>
                            <div  <%= IIf(GetCS("DevelopmentLogForm.ShowFileUpload"), "", "class='d-none'") %>>
                             <asp:Panel ID="pnlAddEvidencePlanned" CssClass="form-group row" runat="server">
<asp:Label ID="lblAddEvPlanned" runat="server" CssClass="control-label col-sm-4" Text="I have evidence files to upload against this log item:" AssociatedControlID="bscbHasEvidenceFilesPlanned"></asp:Label>
                                 <div class="col-sm-8">
                                     <dx:BootstrapCheckBox ID="bscbHasEvidenceFilesPlanned" runat="server"></dx:BootstrapCheckBox>
                                     </div>
                                 </asp:Panel></div>
                            
                            <dx:BootstrapButton ID="bsbtCancelAddPlanned" OnCommand="lbtCancelAddCompleted_Command" CssClasses-Control="float-left" runat="server" Text="Cancel">
                                <ClientSideEvents Click="function(s, e) { ASPxClientEdit.ClearGroup('vgPlanAction'); }" />
                            </dx:BootstrapButton>
                            <dx:BootstrapButton ID="bsbtSubmitPlannedActivity" CommandName="Insert" OnCommand="bsbtSubmitPlannedActivity_Command" CssClasses-Control="float-right" runat="server" Text="Submit" SettingsBootstrap-RenderOption="Primary">
                                <ClientSideEvents Click="function(s, e) { e.processOnServer = ASPxClientEdit.ValidateGroup('vgPlanAction'); }" />
    <CssClasses Icon="fa fa-check" />
                            </dx:BootstrapButton>
                            

                            </div>
              </div>
    </asp:View>
                                <asp:View ID="vEvidenceFiles" runat="server">
                                    <div class="card card-itsp-blue">
                                        <div class="card-header">
                                            <h5>
                                                <asp:Label ID="lblLogItemName" runat="server" Text="Label"></asp:Label>
                                                <small>Evidence Files</small> </h5>
                                        </div>
                                        <uc1:filemxsess runat="server" ID="fmxsess" />
                                        <div class="card-footer">
                                            <asp:LinkButton ID="lbtClose" CssClass="btn btn-secondary float-right" runat="server">Done</asp:LinkButton>
                                        </div>
                                    </div>
                                </asp:View>
                                <asp:View ID="vReflectiveAccount" runat="server">
                                    <div class="card card-hundred">
                                        <div class="card-header">
                                            <h4>
                                                <asp:Label ID="lblReflectiveAccountHeader" runat="server" Text="Reflective Account"></asp:Label>
                                            </h4>
                                        </div>
                                        <div class="card-body">
                                            <div class="form-group">
                                                <asp:Label ID="lblRAActivity" AssociatedControlID="tbRAActivity" runat="server" Text="Reflections on Activity"></asp:Label>
                                                <asp:TextBox ID="tbRAActivity" TextMode="MultiLine" Enabled="false" CssClass="form-control" runat="server"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <asp:Label ID="lblRALearn" AssociatedControlID="tbRALearn" runat="server" Text="What did you learn?"></asp:Label>
                                                <asp:TextBox ID="tbRALearn" TextMode="MultiLine" CssClass="form-control" runat="server" Height="100px"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <asp:Label ID="lblRAPractice" AssociatedControlID="tbRAPractice" runat="server" Text="How did it change/improve your practice?"></asp:Label>
                                                <asp:TextBox ID="tbRAPractice" TextMode="MultiLine" CssClass="form-control" runat="server" Height="100px"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <asp:Label ID="lblRelevanceToCode" AssociatedControlID="pnlRelevanceToCode" runat="server" Text="How is this relevant to the Code?"></asp:Label>
                                                <asp:Panel ID="pnlRelevanceToCode" CssClass="card" runat="server">
                                                    <dx:ASPxCheckBox ID="bscbPrioritisePeople" CssClass="m-2" Text="Prioritise people" runat="server" Layout="Flow"></dx:ASPxCheckBox>
                                                    <dx:ASPxCheckBox ID="bscbPractiseEffectively" CssClass="m-2" Text="Practise effectively" runat="server" Layout="Flow"></dx:ASPxCheckBox>
                                                    <dx:ASPxCheckBox ID="bscbPreserveSafety" CssClass="m-2" Text="Preserve safety" runat="server" Layout="Flow"></dx:ASPxCheckBox>
                                                    <dx:ASPxCheckBox ID="bscbPromoteProfessionalism" CssClass="m-2" Text="Promote professionalism and trust" runat="server" Layout="Flow"></dx:ASPxCheckBox>
                                                </asp:Panel>
                                            </div>
                                            <dx:BootstrapButton ID="bsbtnCancelRA" CssClasses-Control="float-left" OnCommand="bsbtnCancelRA_Command" runat="server" Text="Cancel"></dx:BootstrapButton>
                                            <dx:BootstrapButton ID="bsbtnSubmitRA" CssClasses-Control="float-right" OnCommand="bsbtnSubmitRA_Command" SettingsBootstrap-RenderOption="Primary" CommandName="Insert" runat="server" Text="Submit"></dx:BootstrapButton>
                                        </div>
                                    </div>
                                </asp:View>
                            </asp:MultiView>
                              </div>
                        <asp:Panel ID="pnlCompletion" CssClass="card-footer" runat="server">
                            <asp:FormView ID="fvProgSummary" RenderOuterTable="false" runat="server" DataKeyNames="ProgressID" DataSourceID="dsProgressSummary">
                                <ItemTemplate>
                                    <div class='<%# "card card-" & IIf(Eval("Completed").ToString.Length > 0, "hundred", "fifty") %>'>
                                        <div data-toggle="collapse" data-target="#progsummary" class="card-header card-title clickable clearfix collapse-card collapsed">

                                            <asp:Label CssClass="card-title" ID="Label9" Visible='<%# Eval("Completed").ToString.Length = 0 %>'
                                                runat="server" Text='Course Incomplete' Font-Bold="True" />
                                            <asp:Label ID="lblCompReq1" Visible='<%# Eval("IsAssessed") And Eval("Completed").ToString.Trim.Length < 2 %>' runat="server" Text='<%# IIF(Eval("AssessAttempts").ToString = "0", "To complete this course, you must pass all post learning assessments with a score of " & Eval("PLAPassThreshold").ToString() & "% or higher.", "To complete this course, you must pass all post learning assessments with a score of " & Eval("PLAPassThreshold").ToString() & "% or higher. Failing an assessment " & Eval("AssessAttempts").ToString() & " times will lock your progress.") %>' />
                                            <asp:Label ID="lblCompReq2" Visible='<%# Convert.ToInt32(Eval("DiagCompletionThreshold")) > 0 And Convert.ToInt32(Eval("TutCompletionThreshold")) > 0 And Not Eval("IsAssessed") And Eval("Completed").ToString.Trim.Length < 2 %>'
                                                runat="server" Text='<%#Eval("DiagCompletionThreshold", "To complete this course, you must achieve {0}% in the diagnostic assessment and complete ") & Eval("TutCompletionThreshold", "{0}% of the learning materials") %>' />
                                            <asp:Label ID="lblCompReq3" Visible='<%# Convert.ToInt32(Eval("DiagCompletionThreshold")) = 0 And Not Eval("IsAssessed") And Eval("Completed").ToString.Trim.Length < 2 %>'
                                                runat="server" Text='<%#Eval("TutCompletionThreshold", "To complete this course, you must complete {0}% of the learning materials") %>' />
                                            <asp:Label ID="lblCompReq4" Visible='<%# Convert.ToInt32(Eval("TutCompletionThreshold")) = 0 And Not Eval("IsAssessed") And Eval("Completed").ToString.Trim.Length < 2 %>'
                                                runat="server" Text='<%#Eval("DiagCompletionThreshold", "To complete this course, you must achieve {0}% in the diagnostic assessment") %>' />
                                            <asp:Label CssClass="card-title" ID="lblCompleted" Visible='<%# Eval("Completed").ToString.Length > 0 %>'
                                                runat="server" Text='Course Complete' ToolTip='<%#Eval("Completed", "You completed this course on {0:dd MMMM yyyy}")%>' Font-Bold="True" />

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
                                        </div>
                                        <div class="card-body collapse" id="progsummary">

                                            <div class="row">
                                                <div runat="server" class="col-sm-4" visible='<%# Eval("DiagAttempts") > 0 %>'>
                                                    Diagnostic Score: 
                                                    <asp:Label ID="lblDiagScore" Font-Bold="true" runat="server" Text='<%# Eval("DiagnosticScore", "{0}%") %>'></asp:Label>
                                                </div>
                                                <div runat="server" class="col-sm-4" visible='<%# Eval("LearningDone") > 0 %>'>
                                                    Learning Completed: 
                                                    <asp:Label Font-Bold="true" ID="Label15" runat="server" Text='<%# Eval("LearningDone", "{0}%") %>'></asp:Label>
                                                </div>
                                                <div runat="server" class="col-sm-4" visible='<%# Eval("IsAssessed") %>'>
                                                    Assessments Passed: 
                                                    <asp:Label Font-Bold="true" ID="Label16" runat="server" Text='<%# Eval("PLPasses") & " out of " & Eval("Sections") %>'></asp:Label>
                                                </div>
                                            </div>


                                        </div>
                                    </div>

                                </ItemTemplate>
                            </asp:FormView>
                        </asp:Panel>
                        <%-- THE NEW LEARNING CONTENT VIEW--%>
                    </asp:Panel>

                </div>
                <footer class="footer">
                    <div class="container">
                        <div class="text-muted">
                            <div class="float-left" style="padding-left: 8px; padding-top: 5px;">
                                &copy; <%: DateTime.Now.Year %> - Digital Learning Solutions, NHS England.  <%: Session("BannerText") %>
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
            <asp:View ID="vPassword" runat="server">
                <asp:Panel ID="pnlLogin" DefaultButton="btnLogin" runat="server">
                                        <div class="container h-100">
    <div class="row align-items-center h-100">
        <div class="col-6 mx-auto">
                                            
                                                <h1 class="text-center login-title">Enter the course password</h1>
                                                <div class="account-wall">
                                                    <div class="text-center"><span aria-hidden="false" class="fas fa-5x fa-user-circle light-grey"></span></div>


                                                    <div class="form-signin">
                                                         <asp:TextBox runat="server" CssClass="form-control" placeholder="Password" ID="tbPassword" TextMode="Password" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="Login" runat="server" ControlToValidate="tbPassword" Display="Dynamic" CssClass="bg-danger" ErrorMessage="Course password is required" />
            <asp:CompareValidator ID="cvPassword" ControlToValidate="tbPassword" ValidationGroup="Login" runat="server" ErrorMessage="CompareValidator"></asp:CompareValidator>                  
                                                        <asp:Button ID="btnLogin" ValidationGroup="Login" CausesValidation="true" runat="server" CssClass="btn btn-primary btn-block" Text="Sign in" type="submit" />


                                                        
                                                       
                                                    </div>

                                            </div>
                                        </div>
    </div>
</div>
                                    </asp:Panel>
                  
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

                        <h5 class="modal-title">
                            <asp:Label ID="lbltermsHeading" runat="server">Terms of Use</asp:Label></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;on>
                     
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

                        <h5 class="modal-title">
                            <asp:Label ID="Label10" runat="server">Privacy Notice</asp:Label></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
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

                        <h5 class="modal-title">
                            <asp:Label ID="Label9" runat="server">Accessibility Help</asp:Label></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
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

                            <li id="DiagOnlyPoint" class="diag-only" runat="server">Your score will be reset for any areas that you have attempted previously and
													choose to attempt again. </li>

                            <li>Please allow sufficient time to complete the assessment. If you close part way
												through, your progress will not be stored. </li>
                            <li>Throughout most assessments, green or red indicators will appear to indicate whether you have answered correctly. </li>

                            <li>Most keyboard shortcuts will be disabled in the assessment because we are unable
												to capture them in the testing software. If in doubt, use the mouse. </li>
                        </ul>
                        <br />
                        <span runat="server" class="diag-only" id="DiagOnly2">Please choose the areas to be tested. </span>
                        Click <b>Start</b> to begin.<br />
                        <br />

                    </div>
                    <div id="DiagSelectForm" runat="server">
                         <ul class='list-group' id='objectives-list-box'>
                                                    <!--odschoices-->
                                                </ul>

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
                            ToolTip="Total views" Font-Bold="True"></asp:Label>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
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

                        <h6 class="modal-title">
                            <asp:Label ID="lblModalTitle" runat="server" Text="Label"></asp:Label></h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
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
        <h5 class="card-title"><small>Group <%# GetCS("LearnMenu.Supervisor") %></small><br /> <%# Eval("Forename") & " " & Eval("Surname") %></h5>
        <p class="card-text"></p>
        <p class="card-text"><small class="text-muted"><a href='<%# "mailto:" & Eval("Email") %>'>Email <%# GetCS("LearnMenu.Supervisor") %></a></small></p>
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
                <li class="list-group-item">
                    <div class="row no-gutters">
    <div class="col-md-2">
        <dx:BootstrapBinaryImage ID="BootstrapBinaryImage1" CssClasses-Control="avatar-40" Value='<%# Eval("ProfileImage")%>' runat="server" EmptyImage-Url="~/Images/avatar.png"></dx:BootstrapBinaryImage>
    </div><div class="col-md-10">
        <div class="mt-1">
                    <%# Eval("FirstName") & " " & Eval("LastName") %> <div class="float-right text-muted"></div><small><%# IIF(Eval("LastAccess").ToString.Length > 2, GetNiceDate(Eval("LastAccess")), "Never") %></small></div>
        </div>
        </li>
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
        <asp:ObjectDataSource ID="dsSkillsToVerify" OnSelected="dsSkillsToVerify_Selected" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.SkillsToVerifyTableAdapter">
            <SelectParameters>
                <asp:Parameter Name="ProgressID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <%--standard modal--%>
        <div class="modal fade" id="verificationRequestModal" tabindex="-1" role="dialog" aria-labelledby="lblVRModalTitle">
            <div class="modal-dialog modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">

                        <h6 class="modal-title">
                            <asp:Label ID="lblVRModalTitle" runat="server"><%: "Request " & GetCS("LearnMenu.Supervisor") & " " & GetCS("LearnMenu.Verification") %></asp:Label></h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    </div>
                    <div class="modal-body"><div class="list-group">
                                                    <dx:BootstrapListBox ID="bslbRequestVerification" OnDataBound="bslbRequestVerification_DataBound" ClientInstanceName="listRequestVerification" SelectionMode="CheckColumn" DataSourceID="dsSkillsToVerify" TextField="SkillToVerify" ValueField="aspProgressID" runat="server" Caption='<%# "Which " & GetCS("DevelopmentLogForm.Skills") & " would you like to submit for " & GetCS("LearnMenu.Supervisor") & " " & GetCS("LearnMenu.Verification") & " (please tick)?" %>' ValueType="System.Int32">
                                                        <CssClasses Item="list-group-item" />
                                                        <CaptionSettings ShowColon="False" />
                                                    </dx:BootstrapListBox></div>
                        <asp:Panel ID="pnlNothingToValidate" Visible="false" runat="server">
                            <p>There are no <%: GetCS("DevelopmentLogForm.Skills")%>s that currently require <%: GetCS("LearnMenu.Verification")%>.</p>
                        </asp:Panel>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary mr-auto" data-dismiss="modal">Cancel</button>
                        <asp:LinkButton ID="lbtSubmitVerificationRequest" OnCommand="lbtSubmitVerificationRequest_Command" class="btn btn-outline-primary float-right" runat="server">Submit</asp:LinkButton>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
         <dx:BootstrapPopupControl ID="bsppManageContributors" ClientInstanceName="contributorPopup1" ClientIDMode="Static" PopupHorizontalAlign="Center" PopupVerticalAlign="Middle"  ShowFooter="true" ShowCloseButton="True" CloseAction="CloseButton" Modal="True" ShowOnPageLoad="false" HeaderText="<h4>Manage Contributors</h4>" EncodeHtml="false" PopupElementCssSelector="#btnContributors" runat="server">
        <SettingsAdaptivity Mode="Always" MaxWidth="1024" SwitchAtWindowInnerWidth="1024" VerticalAlign="WindowCenter"
        FixedHeader="true" FixedFooter="true" />
                        
    <ContentCollection>
        <dx:ContentControl>
            <asp:ObjectDataSource ID="dsContributors" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.ProgressContributorsTableAdapter" DeleteMethod="Delete" InsertMethod="InsertProgressContributor" UpdateMethod="UpdateQuery">
                <DeleteParameters>
                    <asp:Parameter Name="Original_ProgressContributorID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="CandidateID" Type="Int32" />
                    <asp:Parameter Name="Active" Type="Boolean" DefaultValue="True" />
                    <asp:Parameter Name="ContributorRoleID" Type="Int32" />
                    <asp:Parameter Name="LastAccess" Type="DateTime" />
                    <asp:SessionParameter Name="ProgressID" SessionField="lmProgressID" Type="Int32" />
                    <asp:SessionParameter Name="TrackingUrl" SessionField="lmTrackingURL" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:SessionParameter Name="ProgressID" SessionField="lmProgressID" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="CandidateID" Type="Int32" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="ContributorRoleID" Type="Int32" />
                    <asp:SessionParameter Name="ProgressID" SessionField="lmProgressID" Type="Int32" />
                    <asp:Parameter Name="original_ProgressContributorID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <dx:BootstrapGridView ID="bsgvContributors" OnBeforeGetCallbackResult="bsgv_BeforeGetCallbackResult" OnRowInserting="bsgvContributors_RowInserting" SettingsText-EmptyDataRow="No contributors assigned" runat="server" AutoGenerateColumns="False" DataSourceID="dsContributors" KeyFieldName="ProgressContributorID">
                                <CssClasses Table="table table-striped" />
                                <SettingsBootstrap Sizing="Small" Striped="True" />
                                <Settings GridLines="None" ShowHeaderFilterButton="True" />
                                <SettingsPager PageSize="10">
                                </SettingsPager>
                 <SettingsCommandButton>
                                            <NewButton ButtonType="Button" IconCssClass="fas fa-plus" RenderMode="Button" />
                                <UpdateButton ButtonType="Button" IconCssClass="fas fa-check" RenderMode="Button" Text="Submit" />
                                <CancelButton ButtonType="Button" IconCssClass="fas fa-close" CssClass="float-left" RenderMode="Button" />
                                <EditButton ButtonType="Button" IconCssClass="fas fa-pencil-alt" RenderMode="Button" Text=" " />
                                <DeleteButton ButtonType="Button" IconCssClass="fas fa-trash" RenderMode="Button" Text=" " />
                                        </SettingsCommandButton>
                                <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />
                                <Columns>
                                    
                                    <dx:BootstrapGridViewCommandColumn VisibleIndex="0" ShowEditButton="True" Caption=" ">
                                    </dx:BootstrapGridViewCommandColumn>
                                    
                                    <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="4">
                                    </dx:BootstrapGridViewCheckColumn>
                                    <dx:BootstrapGridViewDateColumn FieldName="LastAccess" VisibleIndex="3">
                                        <SettingsEditForm Visible="False" />
                                    </dx:BootstrapGridViewDateColumn>
                                    <dx:BootstrapGridViewComboBoxColumn Caption="Role" SettingsEditForm-ColumnSpan="6" FieldName="ContributorRoleID" VisibleIndex="2">
                                        <PropertiesComboBox DataSourceID="dsContributorRoles" TextField="ContributorRole" ValueField="ContributorRoleID">
                                        </PropertiesComboBox>
                                    </dx:BootstrapGridViewComboBoxColumn>
                                    
                                    <dx:BootstrapGridViewComboBoxColumn Caption="User" SettingsEditForm-ColumnSpan="6" FieldName="CandidateID" VisibleIndex="1">
                                        <PropertiesComboBox DataSourceID="dsCandidateSearch" TextField="EmailAddress" ValueField="CandidateID">
                                        </PropertiesComboBox>
                                    </dx:BootstrapGridViewComboBoxColumn>
                                </Columns>
                <Toolbars>
                    <dx:BootstrapGridViewToolbar Position="Bottom">
                        <Items>
                            <dx:BootstrapGridViewToolbarItem Command="New" IconCssClass="fas fa-user-plus" CssClass="mt-2 mr-0" Text="Add Contributor" SettingsBootstrap-RenderOption="Primary"></dx:BootstrapGridViewToolbarItem>
                        </Items>
                    </dx:BootstrapGridViewToolbar>
                </Toolbars>
                            </dx:BootstrapGridView>
            <asp:ObjectDataSource ID="dsContributorRoles" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.ContributorRolesTableAdapter"></asp:ObjectDataSource>
            <asp:ObjectDataSource ID="dsCandidateSearch" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.CandidatesSearchTableAdapter">
                <SelectParameters>
                    <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource> <div class="card-body">
                            
                        </div>
        </dx:ContentControl>
        </ContentCollection>
                        <FooterTemplate>
                            <button type="button" class="btn btn-outline-secondary" onclick="javascript:contributorPopup1.Hide();return false;">Close</button>
                        </FooterTemplate>
    </dx:BootstrapPopupControl>
        <script>

            Sys.Application.add_load(BindEvents);

        </script>
    </form>
</body>

</html>
