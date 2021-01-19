<%@ Page Async="true" Title="Schedule Supervision" Language="vb" AutoEventWireup="false" MasterPageFile="~/tracking/Site.Master" CodeBehind="sv-schedule.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.sv_schedule" %>

<%@ Register Assembly="DevExpress.Web.ASPxHtmlEditor.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxHtmlEditor" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.ASPxScheduler.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxScheduler" TagPrefix="dxwschs" %>
<%@ Register Assembly="DevExpress.XtraScheduler.v19.2.Core, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraScheduler" TagPrefix="cc1" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Src="~/controls/filemxsess.ascx" TagPrefix="uc1" TagName="filemxsess" %>

<asp:Content ID="Content1" ContentPlaceHolderID="breadtray" runat="server">
    <script src="https://swx.cdn.skype.com/shared/v/1.2.35/SkypeBootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/js-cookie@rc/dist/js.cookie.min.js"></script>
  <script src="https://polyfill.io/v3/polyfill.min.js"></script>

    
    <script src="../Scripts/scheduler.js"></script>
    <ol class="breadcrumb breadcrumb-slash">
        <li class="breadcrumb-item"><a href="supervise">Supervise</a></li>
        <li class="breadcrumb-item active">Schedule</li><li><button type="button" class="btn btn-lg ml-2 btn-danger" data-toggle="popover" title="Beta Functionality" data-content="This feature is currently in Beta. Please feel free to try it but bear in mind only organisations that are part of the formal Beta testing will receive support in its use.">Beta</button></li>
    </ol>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <dx:BootstrapPageControl EnableViewState="false" ID="bspcScheduleTabs" TabIndex="0" runat="server" SettingsLoadingcard-Enabled="true" TabAlign="Justify" EnableCallBacks="true" EnableCallbackAnimation="true" ActiveTabIndex="0">
        <CssClasses Content="bstc-content" />
        <TabPages>
            <dx:BootstrapTabPage Text="Planned Activities">
                <ContentCollection>
                    <dx:ContentControl>
                        <asp:HiddenField ID="hfURIModified" Value="False" runat="server" ClientIDMode="Static" />
                        <asp:HiddenField ID="hfRootURL" ClientIDMode="Static" runat="server" />
                        <asp:HiddenField ID="hfInsertedApptType" ClientIDMode="Static" runat="server" />
                        <asp:HiddenField ID="hfAttendeeProgressIDsCSV" ClientIDMode="Static" runat="server" />
                        <asp:HiddenField ID="hfLogItemID" ClientIDMode="Static" runat="server" />
                        <asp:HiddenField ID="hfCallURI" ClientIDMode="Static" runat="server" />
                        <asp:ObjectDataSource ID="dsGroups" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.SuperviseDataTableAdapters.GroupsForAdminTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="0" Name="SAdminID" SessionField="UserAdminID" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <div class="card border-primary">
                            <h5 class="card-header m-0">Supervisor Scheduled Activities</h5>
                            <div class="card-body">
                                <div class="form-group row">
                                    <asp:Label ID="Label1" AssociatedControlID="bscbxGroup" CssClass="col-md-4 text-right" runat="server" Text="Schedule Supervision for Cohort Delegates:"></asp:Label>
                                    <div class="col-md-8">
                                        <dx:BootstrapComboBox ID="bscbxGroup" runat="server" DataSourceID="dsGroups" AutoPostBack="true" ValueField="GroupID" TextField="GroupName" ValueType="System.Int32" SelectedIndex="0"></dx:BootstrapComboBox>
                                    </div>
                                </div>

                                <asp:ObjectDataSource ID="dsSchedule" runat="server" OldValuesParameterFormatString="original_{0}" InsertMethod="InsertLearningLogItemFromSchedule" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.SuperviseDataTableAdapters.SchedulerTableAdapter" DeleteMethod="ArchiveSP" UpdateMethod="UpdateSP">
                                    <DeleteParameters>
                                        <asp:Parameter Name="UniqueID" Type="Int32" />
                                        <asp:SessionParameter DefaultValue="0" Name="CandidateID" SessionField="learnCandidateID" Type="Int32" />
                                        <asp:Parameter Name="original_UniqueID" Type="Int32" />
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="StartDate" Type="DateTime" />
                                        <asp:Parameter Name="EndDate" Type="DateTime" />
                                        <asp:Parameter Name="Subject" Type="String" />
                                        <asp:Parameter Name="Description" Type="String" />
                                        <asp:Parameter Name="ResourceID" Type="String" />
                                        <asp:SessionParameter DefaultValue="0" Name="LoggedByAdminID" SessionField="UserAdminID" Type="Int32" />
                                        <asp:Parameter Name="Label" Type="Int32" />
                                        <asp:Parameter Name="RecurrenceInfo" Type="String" />
                                        <asp:Parameter Name="ReminderInfo" Type="String" />
                                        <asp:Parameter Name="Location" Type="String" />
                                        <asp:Parameter Name="Type" Type="Int32" />
                                        <asp:Parameter Name="Status" Type="Int32" />
                                        <asp:Parameter Name="AllDay" Type="Boolean" />
                                        <asp:Parameter Name="CallUri" Type="String" />
                                        <asp:SessionParameter DefaultValue="0" Name="LoggedByID" SessionField="learnCandidateID" Type="Int32" />
                                    </InsertParameters>
                                    <SelectParameters>
                                        <asp:SessionParameter DefaultValue="0" Name="AdminID" SessionField="UserAdminID" Type="Int32" />
                                        <asp:ControlParameter ControlID="bscbxGroup" DefaultValue="-1" Name="GroupID" PropertyName="Value" Type="String" />
                                    </SelectParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="UniqueID" Type="Int32" />
                                        <asp:Parameter Name="StartDate" Type="DateTime" />
                                        <asp:Parameter Name="EndDate" Type="DateTime" />
                                        <asp:Parameter Name="Subject" Type="String" />
                                        <asp:Parameter Name="Description" Type="String" />
                                        <asp:Parameter Name="ResourceID" Type="String" />
                                        <asp:SessionParameter DefaultValue="0" Name="LoggedByAdminID" SessionField="UserAdminID" Type="Int32" />
                                        <asp:Parameter Name="Label" Type="Int32" />
                                        <asp:Parameter Name="RecurrenceInfo" Type="String" />
                                        <asp:Parameter Name="ReminderInfo" Type="String" />
                                        <asp:Parameter Name="Location" Type="String" />
                                        <asp:Parameter Name="Type" Type="Int32" />
                                        <asp:Parameter Name="Status" Type="Int32" />
                                        <asp:Parameter Name="AllDay" Type="Boolean" />
                                        <asp:SessionParameter DefaultValue="0" Name="LoggedByID" SessionField="learnCandidateID" Type="Int32" />
                                        <asp:Parameter Name="CallUri" Type="String" />
                                        <asp:Parameter Name="original_UniqueID" Type="Int32" />
                                    </UpdateParameters>
                                </asp:ObjectDataSource>
                                <asp:ObjectDataSource ID="dsResources" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.SuperviseDataTableAdapters.ResourcesTableAdapter">
                                    <SelectParameters>
                                        <asp:SessionParameter DefaultValue="0" Name="SAdminID" SessionField="UserAdminID" Type="Int32" />
                                        <asp:ControlParameter ControlID="bscbxGroup" DefaultValue="-1" Name="GroupID" PropertyName="Value" Type="String" />
                                    </SelectParameters>
                                </asp:ObjectDataSource>
                                
                                <dxwschs:ASPxScheduler ID="schSuperviseSessions" ClientInstanceName="scheduler" OptionsCustomization-AllowInplaceEditor="None"  ResourceDataSourceID="dsResources" runat="server" AppointmentDataSourceID="dsSchedule" ActiveViewType="Day" Theme="iOS" OnPopupMenuShowing="schSuperviseSessions_PopupMenuShowing" >
                                   <ClientSideEvents 
                 AppointmentDoubleClick="OnAppointmentDoubleClick"
                CellDoubleClick="OnCellDoubleClick" EndCallback="onSchedulerEndCallBack" 
               /> 
                                    <Storage Appointments-ResourceSharing="True" EnableReminders="False">
                                        <Appointments>
                                            <Mappings AppointmentId="UniqueID" Start="StartDate" End="EndDate" Subject="Subject" AllDay="AllDay"
                                                Description="Description" Label="Label" Location="Location" RecurrenceInfo="RecurrenceInfo"
                                                ReminderInfo="ReminderInfo" Status="Status" Type="Type" ResourceId="ResourceID" />
                                            <CustomFieldMappings>
                                                <dxwschs:ASPxAppointmentCustomFieldMapping Member="CallUri" Name="CallUri" ValueType="String" />
                                            </CustomFieldMappings>
                                            
                                        </Appointments>
                                        <Resources>
                                            <Mappings Caption="ResourceName" ResourceId="ResourceID" />
                                        </Resources>
                                    </Storage>
                                    <Views>
                                        <DayView ViewSelectorItemAdaptivePriority="2" ShowWorkTimeOnly="True">
                                            <TimeRulers>
                                                <cc1:TimeRuler />
                                            </TimeRulers>
                                            <AppointmentDisplayOptions ColumnPadding-Left="2" ColumnPadding-Right="4" />
                                        </DayView>
                                        <WorkWeekView ViewSelectorItemAdaptivePriority="6" ShowWorkTimeOnly="True">
                                            <TimeRulers>
                                                <cc1:TimeRuler />
                                            </TimeRulers>
                                            <AppointmentDisplayOptions ColumnPadding-Left="2" ColumnPadding-Right="4" />
                                        </WorkWeekView>
                                        <WeekView Enabled="false"></WeekView>
                                        <MonthView ViewSelectorItemAdaptivePriority="5">
                                        </MonthView>
                                        <TimelineView ViewSelectorItemAdaptivePriority="3">
                                        </TimelineView>
                                        <FullWeekView Enabled="true" ShowWorkTimeOnly="True">
                                            <TimeRulers>
                                                <cc1:TimeRuler />
                                            </TimeRulers>
                                            <AppointmentDisplayOptions ColumnPadding-Left="2" ColumnPadding-Right="4" />
                                        </FullWeekView>
                                        <AgendaView DayHeaderOrientation="Auto" ViewSelectorItemAdaptivePriority="1" DayCount="30">
                                        </AgendaView>
                                    </Views>



                                    <ClientSideEvents EndCallback="onSchedulerEndCallBack"></ClientSideEvents>



<OptionsCustomization AllowInplaceEditor="None"></OptionsCustomization>



                                    <OptionsBehavior ShowRemindersForm="False" />



                                    <OptionsForms AppointmentFormTemplateUrl="~/DevExpress/ASPxSchedulerForms/AppointmentForm.ascx" AppointmentInplaceEditorFormTemplateUrl="~/DevExpress/ASPxSchedulerForms/InplaceEditor.ascx" GotoDateFormTemplateUrl="~/DevExpress/ASPxSchedulerForms/GotoDateForm.ascx" RecurrentAppointmentDeleteFormTemplateUrl="~/DevExpress/ASPxSchedulerForms/RecurrentAppointmentDeleteForm.ascx" RecurrentAppointmentEditFormTemplateUrl="~/DevExpress/ASPxSchedulerForms/RecurrentAppointmentEditForm.ascx" RemindersFormTemplateUrl="~/DevExpress/ASPxSchedulerForms/ReminderForm.ascx" />
                                    <ClientSideEvents />


                                    <OptionsToolTips AppointmentToolTipCornerType="None" AppointmentDragToolTipUrl="~/DevExpress/ASPxSchedulerForms/AppointmentDragToolTip.ascx" AppointmentToolTipUrl="~/DevExpress/ASPxSchedulerForms/AppointmentToolTip.ascx" SelectionToolTipUrl="~/DevExpress/ASPxSchedulerForms/SelectionToolTip.ascx" />

                                </dxwschs:ASPxScheduler>
                            </div>
                        </div>

                    </dx:ContentControl>
                </ContentCollection>
            </dx:BootstrapTabPage>
            <dx:BootstrapTabPage Text="Completed Activities">
                <ContentCollection>
                    <dx:ContentControl>
                        <asp:MultiView ID="mvCompleted" ActiveViewIndex="0" runat="server">
                            <asp:View ID="vCompletedGrid" runat="server">
<asp:ObjectDataSource ID="dsCompletedSessions" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetForOutcomes" TypeName="ITSP_TrackingSystemRefactor.SuperviseDataTableAdapters.LearningLogItemsTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="-1" Name="AdminID" SessionField="UserAdminID" Type="Int32" />
                                <asp:ControlParameter ControlID="bscbxGroup" DefaultValue="-1" Name="GroupID" PropertyName="Value" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                                <asp:ObjectDataSource ID="dsPreviousSessions" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetPreviousSessions" TypeName="ITSP_TrackingSystemRefactor.SuperviseDataTableAdapters.LearningLogItemsTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="-1" Name="AdminID" SessionField="UserAdminID" Type="Int32" />
                                <asp:ControlParameter ControlID="bscbxGroup" DefaultValue="-1" Name="GroupID" PropertyName="Value" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:Panel ID="pnlOutcomeSessions" CssClass="card border-primary mb-2" runat="server">
                            <h5 class="card-header m-0">Scheduled Activity Outcomes
                            </h5>
                            <div class="card-body">
                                <h5 class="card-title">Please update the outcome of these supervisor scheduled activities</h5>
                                <dx:BootstrapGridView ID="bsgvOutcomeSessions" Settings-GridLines="None" ClientInstanceName="bsgv" EnableCallBacks="false" SettingsBootstrap-Striped="true" runat="server" AutoGenerateColumns="False" DataSourceID="dsCompletedSessions" KeyFieldName="LearningLogItemID">
                                    <SettingsBootstrap Striped="True"></SettingsBootstrap>

                                    <Settings GridLines="None"></Settings>

                                    <SettingsPager PageSize="5"></SettingsPager>

<SettingsPopup>
<HeaderFilter MinHeight="140px"></HeaderFilter>
</SettingsPopup>
                                    <Columns>
                                         <%--<dx:BootstrapGridViewCommandColumn VisibleIndex="0">
                <CustomButtons>
                    <dx:BootstrapGridViewCommandColumnCustomButton ID="btnOutcome" Text="" CssClass="btn btn-primary" IconCssClass="fas fa-tasks text-white" />
                </CustomButtons>
            </dx:BootstrapGridViewCommandColumn>--%>
                                        <dx:BootstrapGridViewTextColumn Caption="Outcome" VisibleIndex="0">
                                            <DataItemTemplate>
                                                <asp:LinkButton EnableViewState="false" ID="lbtOutcome" CommandArgument='<%# Eval("LearningLogItemID") %>' OnCommand="lbtOutcome_Command" CssClass="btn btn-primary" ToolTip="Record attendance and outcomes" runat="server"><i class="fas fa-tasks"></i></asp:LinkButton>
                                            </DataItemTemplate>
                                        </dx:BootstrapGridViewTextColumn>
                                        <dx:BootstrapGridViewDateColumn FieldName="DueDate" Caption="Date" VisibleIndex="1">
                                        </dx:BootstrapGridViewDateColumn>
                                        <dx:BootstrapGridViewTextColumn FieldName="Topic" VisibleIndex="3">
                                        </dx:BootstrapGridViewTextColumn>
                                        <dx:BootstrapGridViewTextColumn FieldName="FileCount" Caption="Files" HorizontalAlign="Left" ReadOnly="True" VisibleIndex="6">
                                        </dx:BootstrapGridViewTextColumn>
                                        <dx:BootstrapGridViewTextColumn FieldName="Attendees" ReadOnly="True" HorizontalAlign="Left" VisibleIndex="7">
                                        </dx:BootstrapGridViewTextColumn>
                                        <dx:BootstrapGridViewTextColumn Caption="Archive" VisibleIndex="8">
                                            <DataItemTemplate>
                                                <asp:LinkButton EnableViewState="false" ID="lbtArchive" CommandArgument='<%# Eval("LearningLogItemID") %>' OnCommand="lbtArchive_Command" CssClass="btn btn-danger" ToolTip="Cancel session" runat="server"><i class="fas fa-trash"></i></asp:LinkButton>
                                            </DataItemTemplate>
                                        </dx:BootstrapGridViewTextColumn>
                                    </Columns>
                                </dx:BootstrapGridView>

                            
                            <h5 class="card-title">Previous Supervision Sessions</h5>
                            <dx:BootstrapGridView ID="bsgvPreviousSessions" Settings-GridLines="None" ClientInstanceName="bsgv" EnableCallBacks="false" SettingsBootstrap-Striped="true" runat="server" AutoGenerateColumns="False" DataSourceID="dsPreviousSessions" KeyFieldName="LearningLogItemID">
                                    <SettingsBootstrap Striped="True"></SettingsBootstrap>

                                    <Settings GridLines="None"></Settings>

                                    <SettingsPager PageSize="10"></SettingsPager>

<SettingsPopup>
<HeaderFilter MinHeight="140px"></HeaderFilter>
</SettingsPopup>
                                    <Columns>
                             <dx:BootstrapGridViewTextColumn Caption="View" VisibleIndex="0">
                                            <DataItemTemplate>
                                                <asp:LinkButton EnableViewState="false" ID="lbtViewDetail" CommandArgument='<%# Eval("LearningLogItemID") %>' OnCommand="lbtViewPrevious_Command" CssClass="btn btn-secondary" ToolTip="View detail" runat="server"><i class="fas fa-tasks"></i></asp:LinkButton>
                                            </DataItemTemplate>
                                        </dx:BootstrapGridViewTextColumn>
                                        <dx:BootstrapGridViewDateColumn FieldName="DueDate" Caption="Date" VisibleIndex="1">
                                        </dx:BootstrapGridViewDateColumn>
                                        <dx:BootstrapGridViewTextColumn FieldName="Topic" VisibleIndex="3">
                                        </dx:BootstrapGridViewTextColumn>
                                        <dx:BootstrapGridViewTextColumn FieldName="FileCount" Caption="Files" HorizontalAlign="Left" ReadOnly="True" VisibleIndex="6">
                                        </dx:BootstrapGridViewTextColumn>
                                        <dx:BootstrapGridViewTextColumn FieldName="Attendees" ReadOnly="True" HorizontalAlign="Left" VisibleIndex="7">
                                        </dx:BootstrapGridViewTextColumn>
                                    </Columns>
                                </dx:BootstrapGridView>
</div>
                        </asp:Panel>
                            </asp:View>
                            <asp:View ID="vOutcomeForm" runat="server">
                                <div class="card card-primary">
                                    <div class="card-header">
                                        <span class="card-title h4">Record Session Outcome</span>
                                    </div>
                                    <div class="card-body">
<asp:ObjectDataSource ID="dsInvited" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.SuperviseDataTableAdapters.InvitedDelegatesTableAdapter">
                                            <SelectParameters>
                                                <asp:SessionParameter DefaultValue="0" Name="LogItemID" SessionField="learnCurrentLogItemID" Type="Int32" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                                        <div class="form-group row">
                                            <asp:Label ID="lblActivity" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="bstbTopic">Activity:</asp:Label>
                                            <div class="col-sm-8">
                                                <dx:BootstrapTextBox ID="bstbTopic" MaxLength="250" runat="server">
                                                    <ValidationSettings ValidationGroup="vgLogComplete" SetFocusOnError="true">
                                                        <RequiredField IsRequired="true" ErrorText="Activity is required" />
                                                    </ValidationSettings>
                                                </dx:BootstrapTextBox>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <asp:Label ID="Label7" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="bstbTopic">Due Date and Time (optional):</asp:Label>
                                            <div class="col-sm-8">
                                                <dx:BootstrapDateEdit ID="bsdeDueDate" Enabled="false" runat="server" TimeSectionProperties-Visible="True" EditFormat="DateTime">
<TimeSectionProperties Visible="True"></TimeSectionProperties>
                                                </dx:BootstrapDateEdit>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <asp:Label ID="Label8" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="bsdeDueDate">Completed Date:</asp:Label>
                                            <div class="col-sm-8">
                                                <dx:BootstrapDateEdit ID="bsdeCompletedDate" OnInit="bsdeCompletedDate_Init" runat="server">
                                                    <ValidationSettings ValidationGroup="vgLogComplete" SetFocusOnError="True">
                                                        <RequiredField IsRequired="true" ErrorText="Completed date is required" />
                                                    </ValidationSettings>
                                                </dx:BootstrapDateEdit>
                                            </div>
                                        </div> 
                                        <div class="form-group row">
                                            <asp:Label ID="Label17" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="bspinHours">Duration:</asp:Label>
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
                                            <asp:Label ID="lblAttendees" AssociatedControlID="bslbAttendees" CssClass="control-label col-sm-4" runat="server" Text="Attendees:"></asp:Label>
                                            <div class="col-sm-8">
                                                <dx:BootstrapListBox ID="bslbAttendees" runat="server" SelectionMode="CheckColumn" DataSourceID="dsInvited" Rows="5"></dx:BootstrapListBox>
<%--                                                <asp:ListBox ID="lbAttendees" DataSourceID="dsInvited" SelectionMode="Multiple" DataTextField="Delegate" DataValueField="LearningLogID" CssClass="form-control" runat="server"></asp:ListBox>--%>
                                            </div>
                                        </div>
                                       
                                        <div class="form-group row">
                                            <asp:Label ID="Label18" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="bsmemOutcomes">Outcomes:</asp:Label>
                                            <div class="col-sm-8">
                                                <dx:BootstrapMemo ID="bsmemOutcomes" runat="server"></dx:BootstrapMemo>
                                            </div>
                                        </div>
<div class="form-group row">
                                            <asp:Label ID="lblFiles" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="filemxsess">Associated files:</asp:Label>
                                            <div class="col-sm-8">
                                                <uc1:filemxsess runat="server" ID="filemxsess" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-footer">
 <dx:BootstrapButton ID="bsbtCancelAddCompleted" CssClasses-Control="float-left" OnCommand="lbtCancelAddCompleted_Command" runat="server" Text="Cancel">
<CssClasses Control="float-left"></CssClasses>

                                <ClientSideEvents Click="function(s, e) { ASPxClientEdit.ClearGroup('vgLogComplete'); }" />
                            </dx:BootstrapButton>
                            <dx:BootstrapButton ID="bsbtSubmitCompletedLogItem" CssClasses-Control="float-right" OnCommand="lbtSubmitCompletedLogItem_Command" CommandName="Update" SettingsBootstrap-RenderOption="Primary" runat="server" Text="Submit">

<SettingsBootstrap RenderOption="Primary"></SettingsBootstrap>

                                <ClientSideEvents Click="function(s, e) { e.processOnServer = ASPxClientEdit.ValidateGroup('vgLogComplete'); }" />
    <CssClasses Icon="fa fa-check" />
                            </dx:BootstrapButton>
                                    </div>
                                </div>

                                       
                            </asp:View>
 <asp:View ID="vPreviousSession" runat="server">
                                <div class="card card-primary">
                                    <div class="card-header">
                                        <span class="card-title h4">Completed Session Outcome</span>
                                    </div>
                                    <div class="card-body">
                                                                                <div class="form-group row">
                                            <asp:Label ID="Label2" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="lblActivityVw">Activity:</asp:Label>
                                            <div class="col-sm-8">
                                                <asp:Label ID="lblActivityVw" CssClass="form-control" Enabled="false" runat="server" Text="Label"></asp:Label>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <asp:Label ID="Label3" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="lblDateVw">Completed Date:</asp:Label>
                                            <div class="col-sm-8">
                                                 <asp:Label ID="lblDateVw" CssClass="form-control" Enabled="false" runat="server" Text="Label"></asp:Label>
                                            </div>
                                        </div>
                                        
                                        <div class="form-group row">
                                            <asp:Label ID="Label5" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="lblHoursVw">Duration:</asp:Label>
                                            <div class="col-sm-4">
                                                <div class="input-group">
                                                     <asp:Label ID="lblHoursVw" CssClass="form-control" Enabled="false" runat="server" Text="Label"></asp:Label>
                                                    <div class="input-group-append">
                                                        <span class="input-group-text">hours</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="input-group">
                                                     <asp:Label ID="lblMinsVw" CssClass="form-control" Enabled="false" runat="server" Text="Label"></asp:Label>
                                                    <div class="input-group-append">
                                                        <span class="input-group-text">mins</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <asp:Label ID="Label6" AssociatedControlID="bslbAttendees" CssClass="control-label col-sm-4" runat="server" Text="Attendees:"></asp:Label>
                                            <div class="col-sm-8">
                                                <ul>
                                                    <asp:Repeater ID="rptAttendees" DataSourceID="dsInvited" runat="server">
                                                        <ItemTemplate>
<li><%#Eval("Text") %></li>
                                                        </ItemTemplate>

                                                    </asp:Repeater>
                                                    
                                                </ul>
                                               </div>
                                        </div>
                                       
                                        <div class="form-group row">
                                            <asp:Label ID="Label9" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="bsmemOutcomes">Outcomes:</asp:Label>
                                            <div class="col-sm-8">
                                              <asp:Label ID="lblOutcomesVw" CssClass="form-control" Enabled="false" runat="server" Text="Label"></asp:Label>
                                            </div>
                                        </div>
<div class="form-group row">
                                            <asp:Label ID="Label10" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="filemxsess">Associated files:</asp:Label>
                                            <div class="col-sm-8">
                                                <uc1:filemxsess runat="server" ID="filemxsess1" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-footer">
 <dx:BootstrapButton ID="BootstrapButton1" CssClasses-Control="float-left" OnCommand="lbtCancelAddCompleted_Command" runat="server" Text="OK"></dx:BootstrapButton>

                                    </div>

                                    </div>
     </asp:View>
                        </asp:MultiView>
                        
                    </dx:ContentControl>
                </ContentCollection>
            </dx:BootstrapTabPage>
           
        </TabPages>
    </dx:BootstrapPageControl>

    <div class="modal" id="sfbModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <asp:Label ID="lblModalTitle" ClientIDMode="Static" runat="server" Text="Label"></asp:Label></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <ul class="list-group list-group-horizontal-sm">
                        <li class="list-group-item">Skype for Business status:</li>
                        <li id="sfbStateAlert" class="list-group-item">
                            <label id="sfbState">Unknown</label></li>
                    </ul>
                    <p>You have indicated that this supervision activity will be delivered using Skype for Business.</p>
                    <p>
                        <asp:Label ID="lblModalBody" ClientIDMode="Static" runat="server" Text="Label"></asp:Label></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary mr-auto" data-dismiss="modal">Close</button>
                    <button type="button" id="btnCreateSFB" class="btn btn-primary">Create Meeting</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal" id="sfbSignin" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <i class="fab fa-skype text-info fa-4x"></i>
                    <div class="h5 modal-title pt-2">
                        Skype for Business Sign-in
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group mt-2">
                        <label for="tbSFBUsername">NHSmail address:</label>
                        <asp:TextBox ID="tbSFBUsername" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <label for="sfbPassword">NHSmail password:</label>
                        <input type="password" class="form-control" id="sfbPassword" />
                    </div>
                    <div class="form-group mb-2">
                        <label for="cbRememberMe">Remember me?</label>
                        <input type="checkbox" id="cbRememberMe" />
                    </div>
                    <button type="button" id="btnSFBSignin" class="mt-1 mb-1 btn btn-lg btn-block btn-primary">Sign In</button>
                </div>

            </div>
        </div>
    </div>
    <div class="modal" id="sendInvitesModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><label id='lblSendInvitesTitle'>Send Invites?</label></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">

                    <p>
                        <label id='lblSendInvites'>The Teams Supervision Session has been created/updated. We recommend sending/resending calendar invites, now.</label></p>
                    <p>Use the test launch button below to test the session.</p>
                    <a id="linkTestSFB" href="#" target="_blank" class="btn btn-info">Test Launch</a>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary mr-auto" data-dismiss="modal">Close</button>
                    <asp:LinkButton ID="lbtSendInvites" CssClass="btn btn-primary btn-lg" OnCommand="lbtSendInvites_Command" runat="server"><i aria-hidden="true" class="fas fa-envelope"></i> Send</asp:LinkButton>
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
                        <asp:Label ID="lblModalHeading" runat="server" Text="Login with Microsoft to Create Teams Meeting"></asp:Label></h5><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <asp:Label ID="lblModalMessage" runat="server" Text="Teams meeting cannot be created for this session unless you login with your Office 365 account. Please logout, log back in choosing Sign in with Microsoft and update this supervision session to generate a Teams meeting."></asp:Label>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary float-right" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
