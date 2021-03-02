<%@ Page Title="Course Setup" Language="vb" AutoEventWireup="false" MasterPageFile="~/tracking/Site.Master" CodeBehind="coursesetup.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.coursesetup" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="breadtray" runat="server">

     <ol class="breadcrumb breadcrumb-slash">
        <li class="breadcrumb-item active">Centre Course Setup</li>
    </ol>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:MultiView ID="mvCourseSetup" ActiveViewIndex="0" runat="server">
     <asp:View ID="vCourseList" runat="server">

            <asp:ObjectDataSource ID="dsCentreCourses" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.CustomisationsSummaryTableAdapter">
                <SelectParameters>
                    <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                    <asp:SessionParameter Name="AdminCategoryID" SessionField="AdminCategoryID" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <dx:BootstrapGridView ID="bsgvCustomisations" Settings-GridLines="None" runat="server" AutoGenerateColumns="False" DataSourceID="dsCentreCourses">
                <SettingsBootstrap Striped="True" />
                <Settings ShowHeaderFilterButton="True" />
                <SettingsCookies Enabled="True" Version="0.1" />
                <SettingsPager PageSize="15">
                </SettingsPager>
                <Columns>
                    <dx:BootstrapGridViewTextColumn Caption="Edit" Name="Edit" ReadOnly="True" VisibleIndex="0">
                        <SettingsEditForm Visible="False" />
                        <DataItemTemplate>
                            <asp:LinkButton ID="lbtEdit" CommandArgument='<%#  Eval("CustomisationID")%>' EnableViewState="false" OnCommand="Edit_Click" ToolTip="Customise course" CssClass="btn btn-circle btn-info btn-sm" runat="server"><i aria-hidden="false" class="fas fa-pencil-alt"></i></asp:LinkButton>
                        </DataItemTemplate>
                    </dx:BootstrapGridViewTextColumn>
                    <dx:BootstrapGridViewTextColumn Caption="Course" FieldName="CustomisationName" Name="Course" ReadOnly="True" VisibleIndex="1">
                        <Settings AllowHeaderFilter="False" />
                        <DataItemTemplate>
                            <asp:LinkButton ID="LinkButton1" CommandArgument='<%#  Eval("CustomisationID")%>' EnableViewState="false" OnCommand="Edit_Click" ToolTip="Customise course" Text='<%#  Eval("CustomisationName")%>' runat="server"></asp:LinkButton>
                        </DataItemTemplate>
                    </dx:BootstrapGridViewTextColumn>
                    <dx:BootstrapGridViewTextColumn Caption="Launch" Name="Launch" VisibleIndex="2">
                        <DataItemTemplate>
                            <asp:HyperLink ID="hlLaunch" EnableViewState="false" ToolTip="Launch course" CssClass="btn btn-circle btn-success btn-sm" NavigateUrl='<%# Session("V2URL") & "LearningMenu/" & Eval("CustomisationID") %>' Target="_blank" runat="server"><i aria-hidden="false" class="fas fa-play"></i></asp:HyperLink>
                            <%--<asp:LinkButton ID="lbtLaunch" EnableViewState="false" ToolTip="Launch course" CssClass="btn btn-circle btn-success btn-sm" PostBackUrl='<%# "~/learn?centreid=" & Session("UserCentreID").ToString & "&customisationid=" & Eval("CustomisationID") %>' runat="server"><i aria-hidden="false" class="fa fa-play"></i></asp:LinkButton>--%>
                        </DataItemTemplate>
                    </dx:BootstrapGridViewTextColumn>
                    <dx:BootstrapGridViewTextColumn FieldName="Category" VisibleIndex="3">
                    </dx:BootstrapGridViewTextColumn>
                    <dx:BootstrapGridViewTextColumn FieldName="Topic" VisibleIndex="4">
                    </dx:BootstrapGridViewTextColumn>
                    <dx:BootstrapGridViewTextColumn FieldName="LearnMins" ReadOnly="True" VisibleIndex="5">
                        <Settings AllowHeaderFilter="False" />
                    </dx:BootstrapGridViewTextColumn>
                    <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="6">
                    </dx:BootstrapGridViewCheckColumn>
                    <dx:BootstrapGridViewCheckColumn Caption="LP" FieldName="LearningPortal" Name="LP" ReadOnly="True" ToolTip="Available in Learning Portal" VisibleIndex="7">
                    </dx:BootstrapGridViewCheckColumn>
                    <dx:BootstrapGridViewTextColumn Caption="Total Dels" HorizontalAlign="Center" FieldName="CandidateCountAll" Name="Total Dels" VisibleIndex="8">
                        <Settings AllowHeaderFilter="False" />
                    </dx:BootstrapGridViewTextColumn>
                    <dx:BootstrapGridViewTextColumn Caption="In Prog" HorizontalAlign="Center" FieldName="CandidateCountInProgress" Name="In Prog" VisibleIndex="9">
                        <Settings AllowHeaderFilter="False" />

                    </dx:BootstrapGridViewTextColumn>

                    <dx:BootstrapGridViewTextColumn Caption="Copy" Name="Copy" VisibleIndex="10">
                        <DataItemTemplate>
                            <span style="display: none;" id='<%# "lblURL" & Eval("CustomisationID")%>'><%# Session("V2URL") & "LearningMenu/" & Eval("CustomisationID") %></span>
                            <%--  <button id="copyButton" onclick='<%# "javascript:copyToClipboardMsg(document.getElementById('lblURL" & Eval("CustomisationID") & "');"%>'>Copy</button>
                   <asp:Label ID='<%# "lblURL2" & Eval("CustomisationID")%>' CssClass="hidden" runat="server" Text='<%# "~/learn?centreid=" & Session("UserCentreID").ToString & "&customisationid=" & Eval("CustomisationID") %>'></asp:Label>--%>
                            <asp:LinkButton EnableViewState="false" CausesValidation="false" OnClientClick='<%# "copyToClipboardMsg(""lblURL" & Eval("CustomisationID") & """); return false;" %>' CssClass="btn btn-circle btn-outline-secondary btn-sm" ID="lbtCopy" runat="server"><i aria-hidden="false" class="far fa-copy"></i></asp:LinkButton>
                        </DataItemTemplate>
                    </dx:BootstrapGridViewTextColumn>
                    <dx:BootstrapGridViewTextColumn Caption="Email" Name="Email" VisibleIndex="11">
                        <DataItemTemplate>
                            <asp:HyperLink EnableViewState="false" CssClass="btn btn-circle btn-outline-secondary btn-sm" ID="hlEmail" NavigateUrl='<%# GetEmail(Eval("CustomisationID"), Eval("CustomisationName"), Eval("Password")) %>' runat="server"><i aria-hidden="false" class="fas fa-envelope"></i></asp:HyperLink>
                        </DataItemTemplate>
                    </dx:BootstrapGridViewTextColumn>

                </Columns>
                <SettingsSearchPanel Visible="True" AllowTextInputTimer="false" />
            </dx:BootstrapGridView>
            <asp:UpdatePanel ID="UpdatePanel1" ChildrenAsTriggers="true" UpdateMode="Always" runat="server">
                <ContentTemplate>
                    <div class="card card-info">
                        <div class="card-header">
                            <h4>Create new Centre Course<div class="form-inline float-right">
                                <asp:DropDownList ID="ddTopicnNewFilter" CssClass="form-control" runat="server" DataSourceID="dsTopics" DataTextField="CourseTopic" DataValueField="CourseTopicID" AppendDataBoundItems="True"
                                    AutoPostBack="True">
                                    <asp:ListItem Value="0" Selected="True" Text="All">Any topic</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                                <h4></h4>
                            </h4>
                        </div>
                        <asp:ObjectDataSource ID="dsTopics" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActiveForCentre" TypeName="ITSP_TrackingSystemRefactor.customiseTableAdapters.CourseTopicsTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="dsApplications" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.customiseTableAdapters.ApplicationsTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="" Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                                <asp:ControlParameter ControlID="ddTopicnNewFilter" Name="CourseTopicID" PropertyName="SelectedValue" Type="Int32" />
                                <asp:SessionParameter Name="AdminCategoryID" SessionField="AdminCategoryID" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>

                        <div class="card-body">
                            <div class="row" style="padding-left: 15px; padding-right: 15px;">
                                <div class="col col-lg-12">
                                    <div class="m-3">
                                        <div class="form-group row">
                                            <div class="input-group">
                                                <%--   <div class="input-group-btn">
                                    
      </div>--%>
                                                <asp:DropDownList ID="ddApplication" CssClass="form-control" runat="server" DataSourceID="dsApplications" DataTextField="ApplicationName" DataValueField="ApplicationID"></asp:DropDownList>
                                                <div class="input-group-append">
                                                    <asp:LinkButton ID="lbtAddCourse" CausesValidation="false" CssClass="btn btn-primary" runat="server"><i aria-hidden="true" class="fas fa-plus"></i> Add</asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="lbtAddCourse" />
                </Triggers>
            </asp:UpdatePanel>

        </asp:View>
           <asp:View ID="vEditCourse" runat="server">
            <div class="card card-primary">
                <div class="card-header">
                    <h5><i aria-hidden="true" class="fas fa-pencil-alt"></i>&nbsp;&nbsp;<asp:Label ID="lblFormTitle" runat="server" Text="Edit Course"></asp:Label></h5>
                </div>
                <div class="card-body">
                     <asp:ObjectDataSource ID="dsCoursePrompts" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActive" TypeName="ITSP_TrackingSystemRefactor.customiseTableAdapters.CoursePromptsTableAdapter"></asp:ObjectDataSource>
                    <div class="row">
                        <div class="col col-lg-6">
                                                       
                                                                 <div class="card card-info mb-1">
                                        <div class="card-header">
                                            <h6 class="mt-1 mb-1">Course details</h6>
                                            <asp:Panel ID="pnlCurrentUsage" runat="server">
                                                <h6 class="mt-1 mb-1"><small><span class="d-inline-block">Created:
										
                                                <asp:Label ID="lblCreated" ClientIDMode="static" runat="server"></asp:Label></span>&nbsp;&nbsp;&nbsp;
                                        <span class="d-inline-block">Last Accessed:
                                                <asp:Label ID="lblLastAccess" ClientIDMode="static" runat="server"></asp:Label></span>&nbsp;&nbsp;&nbsp;
                                      
                                            <span class="d-inline-block">Active learners:
										<asp:HiddenField ID="hfLearners" ClientIDMode="static" runat="server" />
                                                <asp:Label ID="lblLearners" ClientIDMode="static" runat="server"></asp:Label></span>&nbsp;&nbsp;&nbsp;
                                        <span class="d-inline-block">Completions:
                                        <asp:HiddenField ID="hfCompletions" ClientIDMode="static" runat="server" />
                                                <asp:Label ID="lblCompletions" ClientIDMode="static" runat="server"></asp:Label></span>&nbsp;&nbsp;&nbsp;
                                        <span class="d-inline-block">Current version:
                                        <asp:Label ID="lblVersion" runat="server"></asp:Label></span>
                                            </small>

                                            </h6>
                                            </asp:Panel>
                                        </div>
                                        <asp:HiddenField ID="hfAssessAvail" runat="server" />
                                        <asp:HiddenField ID="hfHasAssess" runat="server" />
                                        <div class="card-body">
                                            <div class="m-3">
                                                <div class="form-group row">

                                                    <div class="col col-sm-12">
                                                        <div class="input-group">
                                                            <div class="input-group-prepend"><span class="input-group-text">
                                                                <asp:Label ID="lblAppNameAdd" runat="server" Text="Label"></asp:Label></span></div>
                                                            <asp:TextBox ID="tbCustName" runat="server" CssClass="form-control" ValidationGroup="ASPCust"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="rfvCustName" ControlToValidate="tbCustName" runat="server" Display="Dynamic" InitialValue="New" ErrorMessage="Customisation name is required and must not be left as 'New'" ValidationGroup="ASPCustNew"></asp:RequiredFieldValidator>
                                                            <asp:CompareValidator ID="cfvCustName" ControlToValidate="tbCustName" ValueToCompare="New" Display="Dynamic" Operator="NotEqual" runat="server" ErrorMessage="Customisation name must not be left as 'New'" ValidationGroup="ASPCustNew"></asp:CompareValidator>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label3" CssClass="control-label col-sm-4" runat="server" AssociatedControlID="tbCoursePassword" Text="Password:"></asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbCoursePassword" CssClass="form-control" placeholder="Optional (blank = no password)" runat="server"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label1" CssClass="control-label col-sm-4" runat="server" AssociatedControlID="tbCCEmail" Text="CC Completion Notification:"></asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbCCEmail" CssClass="form-control" placeholder="Optional email address" runat="server"></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="tbCCEmail" ErrorMessage="E-mail invalid" Display="Dynamic" ValidationGroup="ASPCustNew" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label4" CssClass="control-label col-sm-4" runat="server" AssociatedControlID="cbAllowSelfRegistration" Text="Course Options:"></asp:Label>
                                                    <div class="col col-sm-offset-1 col-sm-7">
                                                        <div class="checkbox">
                                                            <asp:CheckBox ID="ActiveCheckBox" runat="server" Text="Active" />
                                                        </div>

                                                        <asp:HiddenField ClientIDMode="static" ID="hfPostLearn" runat="server" />

                                                        <div class="checkbox">
                                                            <asp:CheckBox ID="cbAllowSelfRegistration" runat="server" Text="Allow self-registration" />
                                                        </div>
                                                        <div class="checkbox">
                                                            <asp:CheckBox ID="cbHideInLearningPortal" runat="server" Text="Hide in Learning Portal" />
                                                        </div>
                                                        <div class="checkbox">
                                                            <asp:CheckBox ID="cbInviteContributors" runat="server" Text="Allow invited contributors" />
                                                        </div>
                                                        <div class="checkbox">
                                                            <asp:CheckBox ID="cbDiagObjSelection" runat="server" Text="Allow diagnostic objective selection" />
                                                        </div>
                                                        <asp:Panel ID="pnlPL" runat="server">
                                                            
                                                                <div class="checkbox">
                                                                    <asp:CheckBox ID="cbPostLearning" ClientIDMode="Static" runat="server" Text="Include post learning assessment" />
                                                                </div>
                                                        </asp:Panel>
                                                    </div>
                                                </div>
                                                <asp:Panel ClientIDMode="Static" ID="pnlThresh" CssClass="form-group collapse" runat="server">

                                                
                                                
                                                    <div class="form-group row">
                                                        <asp:Label ID="Label6" CssClass="control-label col-sm-5" runat="server" AssociatedControlID="spinLearnThresh" Text="Required learning:"></asp:Label>
                                                        <div class="col col-sm-7">
                                                            <div class="input-group">
                                                                <dx:BootstrapSpinEdit ID="spinLearnThresh" CssClasses-IconDecrement="fas fa-angle-down" CssClasses-IconIncrement="fas fa-angle-up" runat="server" ToolTip="% of learning materials required to complete course" NumberType="Integer" MaxValue="100"></dx:BootstrapSpinEdit>
                                                                <div class="input-group-append"><span class="input-group-text">%</span></div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <asp:Panel ID="pnlDiagnosticAdd" runat="server">
                                                        <div class="form-group row">
                                                            <asp:Label ID="Label7" CssClass="control-label col-sm-5" runat="server" AssociatedControlID="spinDiagnosticThresh" Text="Required diagnostic:"></asp:Label>
                                                            <div class="col col-sm-7">
                                                                <div class="input-group">
                                                                    <dx:BootstrapSpinEdit ID="spinDiagnosticThresh" CssClasses-IconDecrement="fas fa-angle-down" CssClasses-IconIncrement="fas fa-angle-up" runat="server" ToolTip="% diagnostic score required to complete course" NumberType="Integer" MaxValue="100"></dx:BootstrapSpinEdit>
                                                                    <div class="input-group-append"><span class="input-group-text">%</span></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </asp:Panel>
                                                </asp:Panel>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card card-info mb-1">
                                        <div class="card-header pt-1 pb-1 collapse-card collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="divPathwayDefaults" data-target="#divPathwayDefaults">
                                            <h6 class="d-inline">Learning Pathway Defaults</h6>
                                        </div>
                                        <div id="divPathwayDefaults" class="card-body collapse">
                                            <div class="m-3">
                                                <div class="form-group row">
                                                    <asp:Label ID="lblCompleteWithin" ToolTip="The number of months after enrolment that the learner should complete the course within (0 = not set)" CssClass="control-label col-sm-5" runat="server" AssociatedControlID="spinCompleteWithinMonths" Text="Complete within:"></asp:Label>
                                                    <div class="col col-sm-7">
                                                        <div class="input-group">
                                                            <dx:BootstrapSpinEdit ID="spinCompleteWithinMonths" CssClasses-IconDecrement="fas fa-angle-down" CssClasses-IconIncrement="fas fa-angle-up" ToolTip="The number of months after enrolment that the learner should complete the course within (0 = not set)" NumberType="Integer" MaxValue="48" runat="server"></dx:BootstrapSpinEdit>
                                                            <div class="input-group-append"><span class="input-group-text">months</span></div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="lblMandatory" ToolTip="Indicates whether completion of the course within the completion window above is mandatory" CssClass="control-label col-sm-5" runat="server" AssociatedControlID="cbMandatory" Text="Mandatory:"></asp:Label>
                                                    <div class="col col-sm-7">
                                                        <asp:CheckBox ID="cbMandatory" ToolTip="Indicates whether completion of the course within the completion window above is mandatory" runat="server"/>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="lblValidityMonths" ToolTip="The number of months after completion that the delegate will remain compliant with the learning expectation (0 = not set)" CssClass="control-label col-sm-5" runat="server" AssociatedControlID="spinValidityMonths" Text="Completion valid for:"></asp:Label>
                                                    <div class="col col-sm-7">
                                                        <div class="input-group">
                                                            <dx:BootstrapSpinEdit ID="spinValidityMonths" CssClasses-IconDecrement="fas fa-angle-down" CssClasses-IconIncrement="fas fa-angle-up" ToolTip="The number of months after completion that the delegate will remain compliant with the learning expectation (0 = not set)" NumberType="Integer" MaxValue="48" runat="server"></dx:BootstrapSpinEdit>
                                                            <div class="input-group-append"><span class="input-group-text">months</span></div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="lblAutoRefresh" ToolTip="Indicates whether the delegate will automatically be enrolled on a new course when validity expires" CssClass="control-label col-sm-5" runat="server" AssociatedControlID="cbAutoRefresh" Text="Auto-refresh:"></asp:Label>
                                                    <div class="col col-sm-7">
                                                        <label data-toggle="collapse" data-target="#collapseRefresh" aria-expanded="false" aria-controls="collapseRefresh">
                                                            <asp:CheckBox ID="cbAutoRefresh" ToolTip="Indicates whether the delegate will automatically be enrolled on a new course when validity expires" runat="server" />
                                                        </label>
                                                    </div>
                                                </div>
                                                <div id="collapseRefresh" runat="server" class="form-group collapse"></div>
                                                    <div class="form-group row">
                                                        <asp:Label ID="lblRefreshTo" ToolTip="The course to refresh to when completion validity expires" CssClass="control-label col-sm-5" runat="server" AssociatedControlID="ddResfreshTo" Text="Course to refresh to:"></asp:Label>
                                                        <div class="col col-sm-7">
                                                            <asp:DropDownList DataSourceID="dsCentreCourses" AppendDataBoundItems="True" DataTextField="CustomisationName" DataValueField="CustomisationID" CssClass="form-control" ID="ddResfreshTo" runat="server">
                                                                <asp:ListItem Text="Same course" Value="0"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <asp:Label ID="lblRefreshMonths" ToolTip="The number of months prior to expiry that the delegate will be enrolled on the refresh to course" CssClass="control-label col-sm-5" runat="server" AssociatedControlID="spinEnrolMonths" Text="Enrol on refresher:"></asp:Label>
                                                        <div class="col col-sm-7">
                                                            <div class="input-group">
                                                                <dx:BootstrapSpinEdit ID="spinEnrolMonths" CssClasses-IconDecrement="fas fa-angle-down" CssClasses-IconIncrement="fas fa-angle-up" ToolTip="The number of months prior to expiry that the delegate will be enrolled on the refresh to course" NumberType="Integer" MaxValue="12" runat="server"></dx:BootstrapSpinEdit>
                                                                <div class="input-group-append"><span class="input-group-text">months < expiry</span></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                
                                                <div class="form-group row">
                                                    <asp:Label ID="lblApplyToEnrol" ToolTip="If checked, the above defaults will be applied to self-enrolments" CssClass="control-label col-sm-5" runat="server" AssociatedControlID="cbApplyToSelfEnrol" Text="Apply to Self-enrolments:"></asp:Label>
                                                    <div class="col col-sm-7">
                                                        <asp:CheckBox ID="cbApplyToSelfEnrol" ToolTip="Indicates whether completion of the course within the completion window above is mandatory" runat="server"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                             <%-- <div class="card card-info mb-1">
                                        <div class="card-header pt-1 pb-1 collapse-card collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="divSupervision" data-target="#divSupervision">
                                            <h6 class="d-inline">Supervision Settings</h6>
                                        </div>
                                        <div id="divSupervision" class="card-body collapse">
                                            <div class="m-3">
                                                                                            
                                                <div class="form-group row">
                                                        <asp:Label ID="Label1" ToolTip="The default supervisor for delegates enrolled or enrolling on this course" CssClass="control-label col-sm-5" runat="server" AssociatedControlID="ddDefaultSupervisor" Text="Default supervisor:"></asp:Label>
                                                        <div class="col col-sm-7">
                                                            <asp:DropDownList DataSourceID="dsSupervisors" AppendDataBoundItems="True" CssClass="form-control" ID="ddDefaultSupervisor" runat="server">
                                                                <asp:ListItem Text="None" Value="0"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                <div class="form-group row">
                                                        <asp:Label ID="Label2" ToolTip="The default supervision tool for supervisor scheduled activities for this course" CssClass="control-label col-sm-5" runat="server" AssociatedControlID="ddDefaultSVTool" Text="Default supervision tool:"></asp:Label>
                                                        <div class="col col-sm-7">
                                                            <asp:DropDownList DataSourceID="dsAppointmentTypes" AppendDataBoundItems="True" CssClass="form-control" ID="ddDefaultSVTool" runat="server">
                                                                <asp:ListItem Text="None" Value="0"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                  </div>
                            <div class="card card-info mb-1">
                                        <div class="card-header pt-1 pb-1 collapse-card collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="divDevLogTagging" data-target="#divDevLogTagging">
                                            <h6 class="d-inline">Additional Development Log Fields</h6>
                                        </div>
                                        <div id="divDevLogTagging" class="card-body collapse">
                                            <div class="m-3">
                                                 <div class="alert alert-info">Optional additional fields to tag / categorise planned and completed development log items. Users will be prompted for this information when adding development log items. To request additions to the list of available fields, please raise a ticket.</div>
                                                
                                                </div>
                                            </div>
                                  </div>--%>
                                    <div class="card card-info">
                                        <div class="card-header pt-1 pb-1 collapse-card collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="colCourseFields" data-target="#colCourseFields">
                                            <h6 class="d-inline">Course Admin Fields</h6>
                                        </div>
                                        <div id="colCourseFields" class="card-body collapse">
                                            <div class="m-3">
                                                <div class="alert alert-info">Optional additional fields to store useful data against delegate course progress. This data can be managed by administrators in the <b>Course Delegates</b> view. To request additions to the list of available fields, please raise a ticket.</div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label11" AssociatedControlID="ddCoursePrompt1" runat="server" CssClass="col col-sm-4 control-label">Field 1:</asp:Label>
                                                    <div class="col col-sm-8">


                                                        <asp:DropDownList CssClass="form-control input-sm" AppendDataBoundItems="True" ID="ddCoursePrompt1" DataSourceID="dsCoursePrompts" DataValueField="CoursePromptID" DataTextField="CoursePrompt" runat="server">
                                                            <asp:ListItem Value="0" Text="Unused"></asp:ListItem>
                                                        </asp:DropDownList>


                                                        <asp:TextBox ID="Q1OptionsText" runat="server" CssClass="form-control input-sm" Rows="3" TextMode="MultiLine" placeholder="Optional. Enter field value options on separate lines." />

                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label12" AssociatedControlID="ddCoursePrompt2" runat="server" CssClass="col col-sm-4 control-label">Field 2:</asp:Label>
                                                    <div class="col col-sm-8">

                                                        <asp:DropDownList AppendDataBoundItems="True" CssClass="form-control input-sm" ID="ddCoursePrompt2" DataSourceID="dsCoursePrompts" DataValueField="CoursePromptID" DataTextField="CoursePrompt" runat="server">
                                                            <asp:ListItem Value="0" Text="Unused"></asp:ListItem>
                                                        </asp:DropDownList>


                                                        <asp:TextBox ID="Q2OptionsText" runat="server" CssClass="form-control input-sm" placeholder="Optional. Enter field value options on separate lines." Rows="3" TextMode="MultiLine" />

                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label13" AssociatedControlID="ddCoursePrompt3" runat="server" CssClass="col col-sm-4 control-label">Prompt 3:</asp:Label>
                                                    <div class="col col-sm-8">

                                                        <asp:DropDownList CssClass="form-control input-sm" AppendDataBoundItems="true" ID="ddCoursePrompt3" DataSourceID="dsCoursePrompts" DataValueField="CoursePromptID" DataTextField="CoursePrompt" runat="server">
                                                            <asp:ListItem Value="0" Text="Unused"></asp:ListItem>
                                                        </asp:DropDownList>

                                                        <asp:TextBox ID="Q3OptionsText" runat="server" Rows="3" TextMode="MultiLine" CssClass="form-control input-sm" placeholder="Optional. Enter field value options on separate lines." />


                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                            </div>
                        <div class="col col-lg-6">


                            <div class="card card-info">
                                <div class="card-header">
                                    <h6>Course Content</h6>
                                </div>
                                <div class="card-body">
                                    <div class="container">
                                        <div class="row small" style="padding-right: 15px; padding-left: 15px;">
                                            <div class="offset-8 col-2">
                                                <div class="center-block text-center">
                                                    <asp:Label ID="lblDiagCol" Font-Bold="True" runat="server"><span class="vertical-text" style="font-size:xx-small">Diagnostic</span></asp:Label><br />
                                                    <asp:CheckBox ID="cbDiagnostic" Checked="true" CssClass="small" ClientIDMode="Static" runat="server" ToolTip="Toggle all on / off" />
                                                </div>
                                            </div>
                                            <div class="col-2 center-block text-center"><div style="font-size: xx-small;" class="center-text"><b>Learning</b></div><asp:CheckBox ID="cbLearning" Checked="true" ClientIDMode="Static" runat="server" CssClass="center-text small" ToolTip="Toggle all on / off" /></div>
                                        </div>

                                        <asp:Repeater ID="rptSections" OnItemDataBound="rptSections_ItemDataBound" runat="server">
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hfSectionID" Value='<%# Eval("SectionID") %>' runat="server" />
                                                
                                                <div class="row">
                                                    <div class="col-12">
                                                        <div class="card card-default">
                                                            <div class="card-header clearfix" role="button" data-toggle="collapse" data-target='<%# "#collapse" & Eval("SectionID") %>' aria-expanded="true" aria-controls='<%# "collapse" & Eval("SectionID") %>'>

                                                                <div class="row">
                                                                    <div class="col-8"><i aria-hidden="true" class="fas fa-plus"></i>&nbsp;&nbsp;<asp:Label ID="Label11" CssClass="small" Text='<%# Eval("SectionName") %>' runat="server"></asp:Label></div>
                                                                    <div class="col-2 center-block text-center">
                                                                        <small>
                                                                            <asp:CheckBox ID="cbDiag" Checked="true" Visible='<%# Eval("HasDiag") %>' runat="server" CssClass="check-only sec-diag diag-check" /></small>
                                                                    </div>
                                                                    <div class="col-2 center-block text-center">
                                                                        <small>
                                                                            <asp:CheckBox ID="cbLearn" Checked="true" runat="server" CssClass="check-only sec-learn learn-check" /></small>
                                                                    </div>
                                                                </div>

                                                            </div>

                                                            <div id='<%# "collapse" & Eval("SectionID") %>' class="collapse">
                                                                <ul class="list-group">
                                                                    <asp:Repeater ID="rptTutorials" OnItemDataBound="rptTutorials_ItemDataBound" runat="server">
                                                                        <ItemTemplate>
                                                                            <asp:HiddenField ID="hfTutorialID" Value='<%# Eval("TutorialID") %>' runat="server" />
                                                                            <li class="list-group-item">
                                                                                <div class="row">
                                                                                    <div class="col-8">
                                                                                        <asp:Label ID="Label12" runat="server" Text='<%# Eval("TutName") %>'></asp:Label>
                                                                                    </div>
                                                                                    <div class="col-2 center-block text-center">
                                                                                        <small>
                                                                                            <asp:CheckBox EnableViewState="false" ID="cbDiag" CssClass="diag-check" Visible='<%# Eval("HasDiag") %>' runat="server" Checked='<%# Eval("DiagStatus") %>' /></small>
                                                                                    </div>
                                                                                    <div class=" col-2 center-block text-center">
                                                                                        <small>
                                                                                            <asp:CheckBox ID="cbLearn" EnableViewState="false" Checked='<%# Eval("Status") %>' CssClass="learn-check" runat="server" /></small>
                                                                                    </div>
                                                                                </div>
                                                                            </li>
                                                                        </ItemTemplate>
                                                                    </asp:Repeater>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ItemTemplate>

                                        </asp:Repeater>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    </div>
                <div class="card-footer clearfix">
                    <asp:LinkButton ID="lbtCancelUpdate" CausesValidation="false" CssClass="btn btn-danger mr-auto" runat="server"><i aria-hidden="true" class="fas fa-times"></i> Cancel</asp:LinkButton>
                    <asp:LinkButton ID="lbtUpdateCourse" OnClientClick="javascript:return checkBeforeSubmit();" CssClass="btn btn-success float-right" runat="server"><i aria-hidden="true" class="fas fa-check"></i> Submit</asp:LinkButton>

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
    <script src="../Scripts/coursesetup.js"></script>
    <script src="../Scripts/clipcopy.js"></script>
</asp:Content>

