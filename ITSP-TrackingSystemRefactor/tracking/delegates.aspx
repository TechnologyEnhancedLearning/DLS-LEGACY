<%@ Page Title="Delegates" Language="vb" AutoEventWireup="false" MasterPageFile="~/tracking/Site.Master" CodeBehind="delegates.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.delegates" %>
<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Src="~/tracking/TabbedProgressView.ascx" TagPrefix="uc1" TagName="TabbedProgressView" %>
<%@ Register Src="~/controls/DelegatesModals.ascx" TagPrefix="uc1" TagName="DelegatesModals" %>

<asp:Content ID="Content1" ContentPlaceHolderID="breadtray" runat="server">
    <link href="../Content/fileup.css" rel="stylesheet" />
    <script src="../Scripts/adminreg.js"></script>
    <script>
        function BindEvents() {
        };
</script>
   <ol class="breadcrumb breadcrumb-slash">
        <li class="breadcrumb-item active">Delegates</li>
    </ol>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ObjectDataSource ID="dsJobGroups" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.JobGroupsTableAdapter"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsCourseDelegates" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetByCentreID" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.CandidatesTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsCandidateProgress" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.centrecandidatesTableAdapters.CustomisationsTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CandidateID" SessionField="dvCandidateID" Type="Int32" />
            <asp:SessionParameter Name="AdminCategoryID" SessionField="AdminCategoryID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <div class="table-responsive small">

        <dx:ASPxGridViewExporter ID="DelegateGridViewExporter" GridViewID="bsgvCentreDelegates" FileName="Digital Learning Solutions Delegates" runat="server"></dx:ASPxGridViewExporter>
        <dx:BootstrapGridView EnableViewState="False" CssClasses-Table="table table-striped" ID="bsgvCentreDelegates" runat="server" AutoGenerateColumns="False" DataSourceID="dsCourseDelegates" KeyFieldName="CandidateID" SettingsCustomizationDialog-Enabled="True" OnToolbarItemClick="GridViewCustomToolbar_ToolbarItemClick" SettingsBootstrap-Sizing="Small" SettingsDetail-ShowDetailRow="True" SettingsDetail-AllowOnlyOneMasterRowExpanded="True">
            <CssClasses Table="table table-striped" />
            <SettingsBootstrap Sizing="Small" />
            <Settings GridLines="None" ShowHeaderFilterButton="True" />
            <SettingsCookies Enabled="True" Version="0.123" />
            <SettingsPager PageSize="15">
            </SettingsPager>
            <Columns>

                <dx:BootstrapGridViewTextColumn ReadOnly="true" ShowInCustomizationDialog="false" Name="Status" VisibleIndex="0">
                    <Settings AllowHeaderFilter="False" />
                    <SettingsEditForm Visible="False" />
                    <DataItemTemplate>
                        <asp:Label EnableViewState="false" ID="Label2" ToolTip="Registered by Centre" CssClass="text-success" Visible='<%# Eval("SelfReg").ToString = "False"  %>' runat="server"><i aria-hidden="true" class="fas fa-user-circle fa-2x"></i></asp:Label>
                        <asp:Label EnableViewState="false" ID="Label3" ToolTip="Self Registered (External)" CssClass="text-danger" Visible='<%# Eval("ExternalReg").ToString = "True"  %>' runat="server"><i aria-hidden="true" class="fas fa-user-circle fa-2x"></i></asp:Label>
                         <asp:Label EnableViewState="false" ID="Label4" ToolTip="Self Registered" CssClass="text-warning" Visible='<%# Eval("ExternalReg").ToString = "False" And Eval("SelfReg").ToString = "True" %>' runat="server"><i aria-hidden="true" class="fas fa-user-circle fa-2x"></i></asp:Label>
                    </DataItemTemplate>
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewTextColumn Caption="Name" FieldName="Fullname" VisibleIndex="1" Name="Name">
                    <Settings AllowHeaderFilter="False" />
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewTextColumn FieldName="EmailAddress" VisibleIndex="2" Visible="False" Name="Email Address">
                    <Settings AllowHeaderFilter="False" />
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewTextColumn Caption="ID" FieldName="CandidateNumber" VisibleIndex="3" Name="Delegate ID">
                    <Settings AllowHeaderFilter="False" />
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewTextColumn Caption="Alias" FieldName="AliasID" VisibleIndex="4" Name="Alias">
                    <Settings AllowHeaderFilter="False" />
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="13">
                </dx:BootstrapGridViewCheckColumn>
                <dx:BootstrapGridViewTextColumn Caption="Job Group" FieldName="JobGroupName" ReadOnly="True" VisibleIndex="5" Name="Job Group">
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewDateColumn Caption="Registered" FieldName="DateRegistered" VisibleIndex="6" Name="Registered">
                    <SettingsHeaderFilter Mode="DateRangePicker">
                    </SettingsHeaderFilter>
                </dx:BootstrapGridViewDateColumn>
                <dx:BootstrapGridViewTextColumn FieldName="Answer1" VisibleIndex="7">
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewTextColumn FieldName="Answer2" VisibleIndex="8">
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewTextColumn FieldName="Answer3" VisibleIndex="9">
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewTextColumn FieldName="Answer4" VisibleIndex="10">
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewTextColumn FieldName="Answer5" VisibleIndex="11">
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewTextColumn FieldName="Answer6" VisibleIndex="12">
                    <SettingsHeaderFilter Mode="CheckedList">
                    </SettingsHeaderFilter>
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewCheckColumn FieldName="Approved" VisibleIndex="14">
                </dx:BootstrapGridViewCheckColumn>
                <dx:BootstrapGridViewCheckColumn FieldName="IsAdmin" VisibleIndex="15">
                    <DataItemTemplate>
                        <asp:Label ID="Label14" Visible='<%# Eval("IsAdmin") = 1 %>' runat="server" Text="Label"><span class="dxbs-icon dxbs-icon-check"></span></asp:Label>
                          </DataItemTemplate>
                </dx:BootstrapGridViewCheckColumn>
                <dx:BootstrapGridViewTextColumn ReadOnly="true" Caption="Password" FieldName="PasswordSet" VisibleIndex="0">
                    <SettingsEditForm Visible="False" />
                    <DataItemTemplate>
                 
                        <asp:Label ID="Label13" runat="server" ToolTip="Password not set" CssClass="text-danger" Visible='<%# Not Eval("PasswordSet") %>' Text="Label"><i aria-hidden="true" class="far fa-circle fa-2x"></i></asp:Label>
                        <asp:Label ID="Label7" runat="server" ToolTip="Password set" CssClass="text-success" Visible='<%# Eval("PasswordSet") %>' Text="Label"><i aria-hidden="true" class="fas fa-check-circle fa-2x"></i></asp:Label>
                      
                    </DataItemTemplate>

                </dx:BootstrapGridViewTextColumn>
            </Columns>
            <Templates>
                <DetailRow>
                    <dx:BootstrapGridView ID="bsgvCandidateProgress" OnHtmlRowPrepared="bsgvCandidateProgress_HtmlRowPrepared"  OnToolbarItemClick="GridViewCustomToolbar_ToolbarItemClick" SettingsDetail-ShowDetailRow="True" Settings-GridLines="None" OnBeforePerformDataSelect="detailGrid_DataSelect" KeyFieldName="ProgressID" runat="server" AutoGenerateColumns="False" DataSourceID="dsCandidateProgress" SettingsDetail-AllowOnlyOneMasterRowExpanded="True">
                        <SettingsBootstrap Striped="True" />
                        <Columns>
                            <dx:BootstrapGridViewTextColumn FieldName="CustomisationName" Caption="Course" VisibleIndex="0">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewDateColumn FieldName="FirstSubmittedTime" Caption="Enrolled" VisibleIndex="1">
                            </dx:BootstrapGridViewDateColumn>
                            <dx:BootstrapGridViewDateColumn FieldName="CompleteByDate" Caption="Complete By" VisibleIndex="2">
                            </dx:BootstrapGridViewDateColumn>
                            <dx:BootstrapGridViewDateColumn FieldName="Completed" VisibleIndex="3">
                            </dx:BootstrapGridViewDateColumn>
                            <dx:BootstrapGridViewDateColumn FieldName="RemovedDate" Caption="Archived" VisibleIndex="4">
                            </dx:BootstrapGridViewDateColumn>
                        </Columns>
                        <Templates>
                            <DetailRow>
                                <uc1:TabbedProgressView runat="server" ID="TabbedProgressView" />
                            </DetailRow>
                        </Templates>
                        <Toolbars>
                                            <dx:BootstrapGridViewToolbar Position="Bottom">
                                                <Items>
                                                    <dx:BootstrapGridViewToolbarItem Command="Custom" Name="EnrolOnCourse" CssClass="btn btn-primary show-enrol" Text="Enrol on Course" IconCssClass="fas fa-plus" />
                                                </Items>
                                            </dx:BootstrapGridViewToolbar>
                                        </Toolbars>
                        <ClientSideEvents ToolbarItemClick="onToolbarItemClick" />
                    </dx:BootstrapGridView>
                    
                </DetailRow>
            </Templates>
            <ClientSideEvents ToolbarItemClick="onToolbarItemClick" />
            <Toolbars>
                <dx:BootstrapGridViewToolbar Position="Top">
                    <Items>

                        <dx:BootstrapGridViewToolbarItem Command="ClearGrouping" IconCssClass="far fa-caret-square-down" BeginGroup="True" />
                        <dx:BootstrapGridViewToolbarItem Command="ClearSorting" IconCssClass="fas fa-sort" />
                        <dx:BootstrapGridViewToolbarItem Command="ClearFilter" />
                        <dx:BootstrapGridViewToolbarItem Command="ShowCustomizationDialog" Text="Customise Grid"/>
                        <dx:BootstrapGridViewToolbarItem Command="Custom" Name="ExcelExport" CssClass="btn btn-success" Text="Excel Export" IconCssClass="fas fa-file-export" BeginGroup="True" />
                        
                    </Items>
                </dx:BootstrapGridViewToolbar>
            </Toolbars>
            <SettingsDetail AllowOnlyOneMasterRowExpanded="True" ShowDetailRow="True" />
            <SettingsCustomizationDialog Enabled="True" />
            <SettingsSearchPanel Visible="True" AllowTextInputTimer="false" />
        </dx:BootstrapGridView>
        
    </div>
    <asp:ObjectDataSource ID="dsCandidate" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetCandidate" TypeName="ITSP_TrackingSystemRefactor.centrecandidatesTableAdapters.CandidatesTableAdapter">
                                     <SelectParameters>
                        <asp:SessionParameter Name="CandidateID" SessionField="dvCandidateID" Type="Int32" />
                        <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
    <%-- </div>--%>
    
    <dx:BootstrapPopupControl ID="bsppEnrolOnCourse" ClientInstanceName="enrolPopup1" ClientIDMode="Static" PopupHorizontalAlign="Center" PopupVerticalAlign="Middle"  ShowFooter="true" ShowCloseButton="false" CloseAction="CloseButton" Modal="True" ShowOnPageLoad="false" HeaderText="<h4>Enrol Delegate on Course <small>Step 1 - Choose Course</small></h4>" EncodeHtml="false" PopupElementCssSelector=".show-enrol" runat="server">
        <SettingsAdaptivity Mode="Always" MaxWidth="1024" SwitchAtWindowInnerWidth="1024" VerticalAlign="WindowCenter"
        FixedHeader="true" FixedFooter="true" />
                        
    <ContentCollection>
        <dx:ContentControl>
            <asp:ObjectDataSource ID="dsAvailableCourses" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetIncludingHidden" TypeName="ITSP_TrackingSystemRefactor.centrecandidatesTableAdapters.GetActiveAvailableCustomisationsForCentreFiltered_V3TableAdapter">
            <SelectParameters>
                <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                <asp:SessionParameter Name="CandidateID" SessionField="dvCandidateID" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
            <asp:Label ID="Label1" CssClass="control-label" AssociatedControlID="bsgvCusomisationsAdd" runat="server" Text="Choose a course:"></asp:Label>
            <dx:BootstrapGridView ID="bsgvCusomisationsAdd" runat="server" AutoGenerateColumns="False" DataSourceID="dsAvailableCourses" KeyFieldName="CustomisationID">
                                <CssClasses Table="table table-striped" />
                                <SettingsBootstrap Sizing="Small" />
                                <Settings GridLines="None" ShowHeaderFilterButton="True" />
                                <SettingsBehavior AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
                                <SettingsPager PageSize="10">
                                </SettingsPager>
                                <SettingsSearchPanel Visible="True" />
                                <Columns>
                                    <dx:BootstrapGridViewCommandColumn ShowSelectCheckbox="True" VisibleIndex="0">
                                    </dx:BootstrapGridViewCommandColumn>
                                    <dx:BootstrapGridViewTextColumn FieldName="CourseName" ReadOnly="True" VisibleIndex="1">
                                        <Settings AllowHeaderFilter="False" />
                                    </dx:BootstrapGridViewTextColumn>
                                    <dx:BootstrapGridViewCheckColumn FieldName="IsAssessed" VisibleIndex="2">
                                    </dx:BootstrapGridViewCheckColumn>
                                    <dx:BootstrapGridViewCheckColumn FieldName="HasDiagnostic" ReadOnly="True" VisibleIndex="3">
                                    </dx:BootstrapGridViewCheckColumn>
                                    <dx:BootstrapGridViewCheckColumn FieldName="HasLearning" ReadOnly="True" VisibleIndex="4">
                                    </dx:BootstrapGridViewCheckColumn>
                                    <dx:BootstrapGridViewTextColumn FieldName="Category" ReadOnly="True" VisibleIndex="5">
                                    </dx:BootstrapGridViewTextColumn>
                                    <dx:BootstrapGridViewTextColumn FieldName="Topic" ReadOnly="True" VisibleIndex="6">
                                    </dx:BootstrapGridViewTextColumn>
                                </Columns>
                            </dx:BootstrapGridView>
            </dx:ContentControl>
        </ContentCollection>
                        <FooterTemplate>
                            <button type="button" class="btn btn-outline-secondary" onclick="javascript:enrolPopup1.Hide();return false;">Cancel</button>
                            <asp:LinkButton CssClass="btn btn-primary" ID="lbtEnrolNext" OnCommand="lbtEnrolNext_Command" runat="server">Next</asp:LinkButton>
                        </FooterTemplate>
    </dx:BootstrapPopupControl>
    
      <!-- Modal message-->
        <dx:BootstrapPopupControl ID="bsppEnrolOnCourse2" ClientInstanceName="enrolPopup2" ClientIDMode="Static" PopupHorizontalAlign="Center" PopupVerticalAlign="Middle"  ShowFooter="true" ShowCloseButton="false" CloseAction="CloseButton" Modal="True" ShowOnPageLoad="false" HeaderText="<h4>Enrol Delegate on Course <small>Step 2 - Enrolment Options</small></h4>" EncodeHtml="false" PopupElementCssSelector=".show-enrol" runat="server">
        <SettingsAdaptivity Mode="Always" MaxWidth="1024" SwitchAtWindowInnerWidth="1024" VerticalAlign="WindowCenter"
        FixedHeader="true" FixedFooter="true" />
                        
    <ContentCollection>
        <dx:ContentControl>
<asp:HiddenField ID="hfCustomisationID" runat="server" />
             <asp:ObjectDataSource ID="dsSupervisors" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.customiseTableAdapters.SupervisorsTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
            <asp:ControlParameter ControlID="hfCustomisationID" Name="CustomisationID" PropertyName="Value" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
             <div class="form m-3">
                        <div class="form-group row">
                            <asp:Label ID="lbCourseName" runat="server" Text="Course label" AssociatedControlID="tbCourseNameToAdd" CssClass="control-label col-sm-4"></asp:Label>
                            <div class="col col-sm-8">
                                
                                <asp:TextBox ID="tbCourseNameToAdd" Enabled="false" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>
                 <div class="form-group row">
                            <asp:Label ID="lblSupervisor" runat="server" Text="Supervisor:" AssociatedControlID="ddSupervisor" CssClass="control-label col-sm-4"></asp:Label>
                            <div class="col col-sm-8">
                                <asp:DropDownList ID="ddSupervisor" CssClass="form-control" DataSourceID="dsSupervisors" AppendDataBoundItems="True" DataTextField="Name" DataValueField="AdminID" runat="server">
                                    <asp:ListItem Selected="True" Text="None selected" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-group row">
                            <asp:Label ID="Label5" runat="server" Text="Complete within" AssociatedControlID="tbCourseNameToAdd" CssClass="control-label col-sm-4"></asp:Label>
                            <div class="col col-sm-8">
                                <div class="input-group">
                                    <dx:BootstrapSpinEdit ID="spinCompleteWithinMonths" ToolTip="The number of months after enrollment that the learner should complete the course within (0 = not set)" NumberType="Integer" MaxValue="36" runat="server"></dx:BootstrapSpinEdit>
                                    <div class="input-group-append"><span="input-group-text">months</span></div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <asp:Label ID="lblMandatory" ToolTip="Indicates whether completion of the course within the completion window above is mandatory" CssClass="control-label col-sm-4" runat="server" AssociatedControlID="cbMandatory" Text="Mandatory:"></asp:Label>
                            <div class="col col-sm-8">
                                <asp:CheckBox ID="cbMandatory" Enabled="false" ToolTip="Indicates whether completion of the course within the completion window above is mandatory" runat="server" disabled />
                            </div>
                        </div>
                        <div class="form-group row">
                            <asp:Label ID="lblValidityMonths" ToolTip="The number of months after completion that the delegate will remain compliant with the learning expectation (0 = not set)" CssClass="control-label col-sm-4" runat="server" AssociatedControlID="spinValidityMonths" Text="Completion valid for:"></asp:Label>
                            <div class="col col-sm-8">
                                <div class="input-group">
                                    <dx:BootstrapSpinEdit ID="spinValidityMonths" ToolTip="The number of months after completion that the delegate will remain compliant with the learning expectation (0 = not set)" NumberType="Integer" MaxValue="36" runat="server" ReadOnly="true"></dx:BootstrapSpinEdit>
                                    <div class="input-group-append"><span="input-group-text">months</span></div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group row">
                            <asp:Label ID="lblAutoRefresh" ToolTip="Indicates whether the delegate will automatically be enrolled on a new course when validity expires" CssClass="control-label col-sm-4" runat="server" AssociatedControlID="cbAutoRefresh" Text="Auto-refresh:"></asp:Label>
                            <div class="col col-sm-8">
                                <label data-toggle="collapse" data-target="#collapseRefresh">
                                    <asp:CheckBox ID="cbAutoRefresh" Enabled="false" ToolTip="Indicates whether the delegate will automatically be enrolled on a new course when validity expires" runat="server" disabled />
                                </label>
                            </div>
                        </div>
                    </div>
            </dx:ContentControl>
        </ContentCollection>
             <FooterTemplate>
                            <button type="button" class="btn btn-outline-secondary" onclick="javascript:enrolPopup2.Hide();return false;">Cancel</button>
                            <asp:LinkButton CssClass="btn btn-primary" ID="lbtEnrolConfirm" OnCommand="lbtEnrolConfirm_Command" runat="server">Enrol</asp:LinkButton>
                        </FooterTemplate>
        </dx:BootstrapPopupControl>
     <!-- Modal message-->
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
    <asp:ObjectDataSource ID="dsCategories" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActiveForCentreWithAll" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.CourseCategoriesTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <uc1:DelegatesModals runat="server" id="DelegatesModals" />
    <script>
        Sys.Application.add_load(BindEvents);
     </script> 
</asp:Content>
