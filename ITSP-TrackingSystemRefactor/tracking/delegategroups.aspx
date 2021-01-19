<%@ Page Title="Delegate Groups" Language="vb" AutoEventWireup="false" MasterPageFile="~/tracking/Site.Master" CodeBehind="delegategroups.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.delegategroups" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="breadtray" runat="server">

   <ol class="breadcrumb breadcrumb-slash">
        <li class="breadcrumb-item"><a href="delegates">Delegates </a></li>
        <li class="breadcrumb-item active">Groups</li>
    </ol>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        text-muted {
            color: #bbb !important;
        }
    </style>
    <asp:ObjectDataSource ID="dsGroups" runat="server" InsertMethod="InsertQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActiveForCentre" TypeName="ITSP_TrackingSystemRefactor.centrecandidatesTableAdapters.GroupsTableAdapter" UpdateMethod="UpdateQuery">
        <InsertParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
            <asp:Parameter Name="GroupLabel" Type="String" />
            <asp:Parameter Name="GroupDescription" Type="String" />
            <asp:Parameter Name="LinkedToField" Type="Int32" />
            <asp:Parameter Name="SyncFieldChanges" Type="Boolean" />
            <asp:Parameter Name="AddNewRegistrants" Type="Boolean" />
            <asp:Parameter Name="PopulateExisting" Type="Boolean" />
            <asp:SessionParameter Name="CreatedByAdminUserID" SessionField="UserAdminID" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="GroupLabel" Type="String" />
            <asp:Parameter Name="GroupDescription" Type="String" />
            <asp:Parameter Name="LinkedToField" Type="Int32" />
            <asp:Parameter Name="SyncFieldChanges" Type="Boolean" />
            <asp:Parameter Name="AddNewRegistrants" Type="Boolean" />
            <asp:Parameter Name="PopulateExisting" Type="Boolean" />
            <asp:Parameter Name="Original_GroupID" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsAdminUsers" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.AdminUsersListTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsLinkFields" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.centrecandidatesTableAdapters.LinkFieldsTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsGroupDelegates" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetByGroupID" TypeName="ITSP_TrackingSystemRefactor.centrecandidatesTableAdapters.GroupDelegatesTableAdapter" DeleteMethod="DeleteGroupDelegate">
        <DeleteParameters>
            <asp:Parameter Name="Original_GroupDelegateID" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter Name="GroupID" SessionField="dvGroupID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsGroupCustomisations" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.customiseTableAdapters.GroupCustomisationsTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="GroupID" SessionField="dvGroupID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <dx:ASPxGridViewExporter ID="GroupsGridViewExporter" GridViewID="bsgvGroups" FileName="Digital Learning Solutions Group Delegates" runat="server"></dx:ASPxGridViewExporter>
    <dx:BootstrapGridView ID="bsgvGroups" SettingsPopup-EditForm-Modal="true" runat="server" DataSourceID="dsGroups" OnToolbarItemClick="GridViewCustomToolbar_ToolbarItemClick" AutoGenerateColumns="False" KeyFieldName="GroupID">
        <CssClasses Table="table table-striped" />
        <Settings GridLines="None" ShowHeaderFilterButton="True" />
        <SettingsCookies Enabled="True" Version="0.1" />
        <SettingsPager PageSize="15">
        </SettingsPager>
        <SettingsEditing Mode="PopupEditForm">
            <FormLayoutProperties>
                <Items>
                    <dx:BootstrapGridViewColumnLayoutItem ColSpanMd="12" ColumnName="GroupLabel" ShowCaption="False">
                    </dx:BootstrapGridViewColumnLayoutItem>
                    <dx:BootstrapGridViewColumnLayoutItem ColSpanMd="12" ColumnName="GroupDescription" ShowCaption="False">
                    </dx:BootstrapGridViewColumnLayoutItem>
                    <dx:BootstrapEditModeCommandLayoutItem ColSpanMd="12" HorizontalAlign="Right">
                    </dx:BootstrapEditModeCommandLayoutItem>
                </Items>
            </FormLayoutProperties>
        </SettingsEditing>
        <SettingsCommandButton>
            <CancelButton CssClass="float-left mr-auto text-white" RenderMode="Button" IconCssClass="fas fa-times" />
            <UpdateButton CssClass="float-right" RenderMode="Button" IconCssClass="fas fa-check" />
            
            <NewButton CssClass="float-right" RenderMode="Button" IconCssClass="fas fa-plus" Text="Add Group" />
            <EditButton RenderMode="Button" IconCssClass="fas fa-pencil-alt" Text=" " />
        </SettingsCommandButton>
        <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="True"></SettingsDetail>
        <SettingsPopup>
            <EditForm Modal="True"></EditForm>
        </SettingsPopup>

        <SettingsDataSecurity AllowEdit="True" AllowInsert="True" />
        <Columns>
            <dx:BootstrapGridViewCommandColumn ShowEditButton="True" Caption=" " VisibleIndex="0">
            </dx:BootstrapGridViewCommandColumn>
            <dx:BootstrapGridViewTextColumn FieldName="GroupLabel" VisibleIndex="1" Caption="Group">
                <Settings AllowHeaderFilter="False" />
                <PropertiesTextEdit MaxLength="100" NullText="Group name" NullTextDisplayMode="UnfocusedAndFocused">
                </PropertiesTextEdit>

                <SettingsEditForm ShowCaption="False" />
                <DataItemTemplate>
                    <div class="row">
                        <div class="col col-sm-8">
                            <b>
                                <asp:Label EnableViewState="false" ID="Label1" runat="server" Text='<%# Eval("GroupLabel") %>'></asp:Label></b>
                        </div>
                        <div class="col col-sm-2">
                            <asp:Label EnableViewState="false" ID="lblDelCount" ToolTip='<%#Eval("Delegates").ToString & " delegates associated with group" %>' runat="server"><i aria-hidden='true' class='fa fa-users'></i>&nbsp;<%#Eval("Delegates")%></asp:Label>

                        </div>
                        <div class="col col-sm-2">
                            <asp:Label EnableViewState="false" ID="Label15" ToolTip='<%# Eval("Courses").ToString & " courses associated with group"%>' runat="server"><i aria-hidden='true' class='fa fa-book'></i>&nbsp;<%#Eval("Courses")%></asp:Label>

                        </div>
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="LinkFieldName" Caption="Linked Field" VisibleIndex="4">
                <SettingsEditForm Visible="False" />
                <DataItemTemplate>
                    <div class="row">
                        <div class="col col-sm-8">
                            <asp:Label EnableViewState="false" ID="Label2" runat="server" Text='<%# Eval("LinkFieldName") %>'></asp:Label>
                        </div>
                        <div class="col col-sm-2">
                            <asp:Label ID="Label3" Visible='<%# Eval("LinkedToField") > 0 %>' CSSClass='<%# IIf(Eval("AddNewRegistrants"), "", "text-muted") %>' ToolTip='<%# IIf(Eval("AddNewRegistrants"), "New registrants added to group", "New registrants NOT added to group") %>' runat="server">
                         <i class="fas fa-user-plus"></i></asp:Label>
                        </div>
                        <div class="col col-sm-2">
                            <asp:Label ID="Label4" Visible='<%# Eval("LinkedToField") > 0 %>' ToolTip='<%# IIf(Eval("SyncFieldChanges"), "Changes to field synchronised with group", "Changes to field NOT synchronised with group") %>' CssClass='<%# IIf(Eval("SyncFieldChanges"), "", "text-muted") %>' runat="server">
                         <i class="fas fa-sync-alt"></i></asp:Label>
                        </div>
                    </div>

                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewComboBoxColumn Caption="Added By" FieldName="CreatedByAdminUserID" VisibleIndex="2">
                <PropertiesComboBox DataSourceID="dsAdminUsers" TextField="Name" ValueField="AdminID">
                </PropertiesComboBox>
                <SettingsEditForm Visible="False" />
            </dx:BootstrapGridViewComboBoxColumn>
            <dx:BootstrapGridViewMemoColumn FieldName="GroupDescription" Visible="False" VisibleIndex="3">
                <PropertiesMemoEdit NullText="Group description (optional)" NullTextDisplayMode="UnfocusedAndFocused" Rows="5">
                </PropertiesMemoEdit>
                <SettingsEditForm ShowCaption="False" Visible="True" />
            </dx:BootstrapGridViewMemoColumn>
            <dx:BootstrapGridViewTextColumn Name="Delete" VisibleIndex="4">
                <DataItemTemplate>
                    <asp:LinkButton EnableViewState="false" ID="lbtDeleteGroup" CssClass="btn btn-danger" ToolTip="Delete group and content" CausesValidation="false" CommandArgument='<%# Eval("GroupID") %>' OnCommand="lbtDeleteGroup_Command" runat="server"><i class="fas fa-trash" aria-hidden="true"></i></asp:LinkButton>
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
        </Columns>
        <Toolbars>
            <dx:BootstrapGridViewToolbar>
                <Items>
                    
                            <dx:BootstrapGridViewToolbarItem Name="AddGroup" Command="New" IconCssClass="fas fa-plus" Text="Add Group" SettingsBootstrap-RenderOption="Primary"></dx:BootstrapGridViewToolbarItem>
                            <dx:BootstrapGridViewToolbarItem Name="GenerateGroups" BeginGroup="True" IconCssClass="fas fa-cog" Text="Generate Groups" ToolTip="Generate Groups from Registration Field" SettingsBootstrap-RenderOption="Primary" />
                        

                    <dx:BootstrapGridViewToolbarItem Command="ClearGrouping" BeginGroup="True" IconCssClass="far fa-caret-square-down" />
                    <dx:BootstrapGridViewToolbarItem Command="ClearSorting" IconCssClass="fas fa-sort" />
                    <dx:BootstrapGridViewToolbarItem Command="ClearFilter" />
                    <dx:BootstrapGridViewToolbarItem Command="ShowCustomizationDialog" Text="Customise Grid" />
                    <dx:BootstrapGridViewToolbarItem Command="Custom" Name="ExcelExport" BeginGroup="True" CssClass="btn btn-success" Text="Excel Export" IconCssClass="fas fa-file-export" />
                </Items>
            </dx:BootstrapGridViewToolbar>
        </Toolbars>
        <Templates>
            <DetailRow>
                <dx:BootstrapPageControl EnableViewState="false" TabAlign="Justify" ID="bspcDetailRow" runat="server" EnableCallBacks="true" EnableCallbackAnimation="true">
                    <TabPages>
                        <dx:BootstrapTabPage TabIconCssClass="fas fa-users" Text="Delegates">
                            <ContentCollection>
                                <dx:ContentControl runat="server" SupportsDisabledAttribute="True">
                                    <dx:BootstrapGridView ID="bsgvGroupDelegates" Settings-GridLines="Horizontal" SettingsBehavior-ConfirmDelete="true" SettingsText-ConfirmDelete="Are you sure you wish to remove this delegate from the group?" runat="server" AutoGenerateColumns="False" OnInit="bsgvGroupDelegates_Init" OnBeforePerformDataSelect="detailGrid_DataSelect" OnToolbarItemClick="GridViewCustomToolbar_ToolbarItemClick" DataSourceID="dsGroupDelegates" KeyFieldName="GroupDelegateID">
                                        <SettingsText EmptyDataRow="No delegates are associated with this group. Click Add to add some." />
                                        <SettingsCommandButton>
                                            <DeleteButton CssClass="btn-outline-danger" Text=" " RenderMode="Button" IconCssClass="fas fa-trash" />
                                        </SettingsCommandButton>
                                        <%--<Settings ShowColumnHeaders="False" />--%>
                                        <SettingsDataSecurity AllowDelete="True" />
                                        <Columns>
                                            <dx:BootstrapGridViewCommandColumn Caption=" " ShowDeleteButton="True" VisibleIndex="15">
                                            </dx:BootstrapGridViewCommandColumn>
                                            <dx:BootstrapGridViewTextColumn Caption="Delegate" FieldName="LastName" VisibleIndex="4">
                                                <DataItemTemplate>
                                                    <asp:Label EnableViewState="false" ID="Label10" runat="server" Text='<%# Eval("FirstName") & " " & Eval("LastName") & ", <b>" & Eval("CandidateNumber") & "</b>" %>'></asp:Label><asp:Label ID="Label11" Visible='<%#Eval("EmailAddress").ToString.Length > 0 %>' runat="server" Text='<%# ", (" & Eval("EmailAddress") & ")" %>'></asp:Label>
                                                </DataItemTemplate>
                                            </dx:BootstrapGridViewTextColumn>
                                        </Columns>
                                        <Toolbars>
                                            <dx:BootstrapGridViewToolbar Position="Bottom">
                                                <Items>
                                                    <dx:BootstrapGridViewToolbarItem Command="Custom" Name="AddDelegates" CssClass="btn btn-primary" Text="Add Delegates" IconCssClass="fas fa-user-plus" />
                                                </Items>
                                            </dx:BootstrapGridViewToolbar>
                                        </Toolbars>
                                        <ClientSideEvents ToolbarItemClick="onToolbarItemClick" />
                                    </dx:BootstrapGridView>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:BootstrapTabPage>
                        <dx:BootstrapTabPage TabIconCssClass="fas fa-book" Text="Courses">
                            <ContentCollection>
                                <dx:ContentControl runat="server" SupportsDisabledAttribute="True">
                                    <dx:BootstrapGridView ID="bsgvGroupCustomisations" OnHtmlRowPrepared="bsgvGroupCustomisations_HtmlRowPrepared" Settings-GridLines="Horizontal" runat="server" AutoGenerateColumns="False" DataSourceID="dsGroupCustomisations" OnToolbarItemClick="GridViewCustomToolbar_ToolbarItemClick" KeyFieldName="GroupCustomisationID">
                                        <SettingsText EmptyDataRow="No courses are associated with this group. Click Add to add some." />
                                        <%--<Settings ShowColumnHeaders="False" />--%>
                                        <Columns>
                                            <dx:BootstrapGridViewDateColumn Caption="Added to Group" FieldName="AddedDate" VisibleIndex="1">
                                            </dx:BootstrapGridViewDateColumn>
                                            <dx:BootstrapGridViewTextColumn FieldName="Course" ReadOnly="True" VisibleIndex="0">
                                            </dx:BootstrapGridViewTextColumn>
                                            <dx:BootstrapGridViewCheckColumn Caption="Cohort" HorizontalAlign="Center" FieldName="CohortLearners" VisibleIndex="2">
                                            </dx:BootstrapGridViewCheckColumn>
                                            <dx:BootstrapGridViewComboBoxColumn Caption="Supervisor" FieldName="SupervisorAdminID" VisibleIndex="3">
                <PropertiesComboBox DataSourceID="dsAdminUsers" TextField="Name" ValueField="AdminID">
                </PropertiesComboBox>
            </dx:BootstrapGridViewComboBoxColumn>
                                            <dx:BootstrapGridViewTextColumn Caption="Complete Within" HorizontalAlign="Center" FieldName="CompleteWithinMonths" VisibleIndex="4">
                                                <DataItemTemplate>
                                                    <asp:Label id="lblValidity" runat="server" EnableViewState="false" Text='<%# IIf(Eval("CompleteWithinMonths") = 0, "-", Eval("CompleteWithinMonths").ToString() & " months") %>'></asp:Label>
                                                </DataItemTemplate>
                                            </dx:BootstrapGridViewTextColumn>
                                            <dx:BootstrapGridViewCheckColumn FieldName="Mandatory" HorizontalAlign="Center" VisibleIndex="6">
                                            </dx:BootstrapGridViewCheckColumn>
                                            <dx:BootstrapGridViewTextColumn FieldName="ValidityMonths" HorizontalAlign="Center" Caption="Valid For" VisibleIndex="5">
                                                <DataItemTemplate>
                                                    <asp:Label id="lblValidity" runat="server" EnableViewState="false" Text='<%# IIf(Eval("ValidityMonths") = 0, "-", Eval("ValidityMonths").ToString() & " months") %>'></asp:Label>
                                                </DataItemTemplate>
                                            </dx:BootstrapGridViewTextColumn>
                                            <dx:BootstrapGridViewCheckColumn Caption="Assessed" HorizontalAlign="Center" FieldName="IsAssessed" VisibleIndex="7">
                                            </dx:BootstrapGridViewCheckColumn>
                                            
                                            <dx:BootstrapGridViewTextColumn HorizontalAlign="Center" Caption=" " VisibleIndex="8">
                                                <DataItemTemplate>
                                                    <asp:LinkButton ID="lbtInactivateGroupCustomisation" ToolTip="Inactivate group course" Visible='<%# IIf(Eval("InactivatedDate").ToString.Length = 0 And Eval("CourseCategoryID") = Session("AdminCategoryID") Or Eval("InactivatedDate").ToString.Length = 0 And Session("AdminCategoryID") = 0, True, False) %>' EnableViewState="false" OnClientClick="return confirm('Are you sure you wish to inactivate this group course? Delegates added to the group will no longer be enrolled on it.');" CommandArgument='<%# Eval("GroupCustomisationID") %>' OnCommand="lbtInactivateGroupCustomisation_Command" runat="server" CssClass="btn btn-outline-danger"><i class="fas fa-trash" aria-hidden="true"></i></asp:LinkButton>
                                                    <asp:Label ID="Label14" CssClass="small" runat="server" Visible='<%# Eval("InactivatedDate").ToString.Length > 0 %>' Text='<%# "Inactivated: " & Eval("InactivatedDate", "{0:d}") %>' ></asp:Label>
                                                </DataItemTemplate>
                                            </dx:BootstrapGridViewTextColumn>
                                        </Columns>
                                        <Toolbars>
                                            <dx:BootstrapGridViewToolbar Position="Bottom">
                                                <Items>
                                                    <dx:BootstrapGridViewToolbarItem Command="Custom" Name="AddCourse" CssClass="btn btn-primary" Text="Add Course" IconCssClass="fas fa-plus" />
                                                </Items>
                                            </dx:BootstrapGridViewToolbar>
                                        </Toolbars>
                                        <ClientSideEvents ToolbarItemClick="onToolbarItemClick" />
                                    </dx:BootstrapGridView>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:BootstrapTabPage>
                    </TabPages>
                </dx:BootstrapPageControl>
            </DetailRow>
        </Templates>
        <ClientSideEvents ToolbarItemClick="onToolbarItemClick" />
        <SettingsCustomizationDialog Enabled="True" />
    </dx:BootstrapGridView>
    <asp:ObjectDataSource ID="dsLinkFieldsForGen" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetWithoutNone" TypeName="ITSP_TrackingSystemRefactor.centrecandidatesTableAdapters.LinkFieldsTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <!-- Modal message-->
    <div class="modal fade" id="GenerateGroupsModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    
                    <h5 class="modal-title" id="myModalLabel">Generate Groups From Registration Field Options</h5><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <div class="form m-3">
                        <div class="form-group row">
                            <asp:Label ID="lblGenFromField" AssociatedControlID="ddRegField" CssClass="control-label col-sm-6" runat="server" Text="Registration field to generate groups from:"></asp:Label>
                            <div class="col col-sm-6">
                                <asp:DropDownList ID="ddRegField" CssClass="form-control" runat="server" DataSourceID="dsLinkFieldsForGen" DataTextField="Fieldname" DataValueField="ID"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-group row">
                            <asp:Label ID="Label8" AssociatedControlID="cbIncludePrefix" runat="server" CssClass="control-label col-sm-6" Text="Prefix group name with field name?"></asp:Label>
                            <div class="col col-sm-6">
                                <asp:CheckBox ID="cbIncludePrefix" Checked="false" runat="server" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <asp:Label ID="Label5" AssociatedControlID="cbAddExisting" runat="server" CssClass="control-label col-sm-6" Text="Add existing delegates?"></asp:Label>
                            <div class="col col-sm-6">
                                <asp:CheckBox ID="cbAddExisting" Checked="true" runat="server" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <asp:Label ID="Label6" AssociatedControlID="cbAddNew" runat="server" CssClass="control-label col-sm-6" Text="Add new registrants?"></asp:Label>
                            <div class="col col-sm-6">
                                <asp:CheckBox ID="cbAddNew" Checked="true" runat="server" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <asp:Label ID="Label7" AssociatedControlID="cbSyncChanges" runat="server" CssClass="control-label col-sm-6" Text="Synchronise changes to reg info with group membership?"></asp:Label>
                            <div class="col col-sm-6">
                                <asp:CheckBox ID="cbSyncChanges" Checked="true" runat="server" />
                            </div>
                        </div>
                        <div class="form-group row">
                            <asp:Label ID="Label9" AssociatedControlID="cbSkipDuplicates" runat="server" CssClass="control-label col-sm-6" Text="Skip groups with duplicate group name?"></asp:Label>
                            <div class="col col-sm-6">
                                <asp:CheckBox ID="cbSkipDuplicates" Checked="true" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary mr-auto float-left" data-dismiss="modal">Cancel</button>
                    <asp:LinkButton ID="lbtGenerateGroups" CssClass="btn btn-primary float-right" runat="server">Generate Groups</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal delete group confirm-->
    <div class="modal fade" id="confirmDeleteGroupModal" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    
                    <h5 class="modal-title" id="confirmDeleteLabel">Delete Group?</h5><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hfDeleteGroupID" runat="server" />
                    <div class="alert alert-danger">
                        <p>Are you sure that you wish to permanently delete this group?</p>
                        <p>All delegates will be removed from the group.</p>
                        <p>All courses will be removed from the group.</p>
                        <p>This process is permanent and irreversible.</p>
                    </div>
                    <div class="alert alert-warning">
                        <p>Optionally all enrolments on courses for delegates that are incomplete and are associated with their membership of this group can also be removed. This facility should not be used if delegates may have been enrolled on the same course(s) because of membership of another group.</p>
                        <div class="form m-3">

                            <div class="form-group row">
                                <asp:Label ID="Label13" AssociatedControlID="cbIncludePrefix" runat="server" CssClass="control-label col-sm-10" Text="Remove related enrolments where course is not yet complete?"></asp:Label>
                                <div class="col col-sm-2">
                                    <asp:CheckBox ID="cbRemoveEnrollments" Checked="False" runat="server" />
                                </div>
                            </div>

                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary mr-auto float-left" data-dismiss="modal">Cancel</button>
                    <asp:LinkButton ID="lbtConfirmDeleteGroup" CssClass="btn btn-danger float-right" runat="server">Confirm</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <asp:ObjectDataSource ID="dsDelegatesNotInGroup" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.centrecandidatesTableAdapters.AddDelegatesTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
            <asp:SessionParameter Name="GroupID" SessionField="dvGroupID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <!-- Modal add delegates-->
    <div class="modal fade" id="AddDelegatesModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    
                    <h5 class="modal-title" id="addDelegatesLabel">Add Delegates to Group</h5><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <dx:BootstrapGridView ID="bsgvAddDelegates" runat="server" AutoGenerateColumns="False" DataSourceID="dsDelegatesNotInGroup" KeyFieldName="CandidateID">
                        <CssClasses Table="table table-striped" />
                        <SettingsBootstrap Sizing="Small" />
                        <Settings GridLines="None" ShowHeaderFilterButton="True" />
                        <SettingsPager PageSize="15">
                        </SettingsPager>
                        <SettingsSearchPanel Visible="True" />
                        <Columns>
                            <dx:BootstrapGridViewCommandColumn SelectAllCheckboxMode="AllPages" ShowSelectCheckbox="True" VisibleIndex="0">
                            </dx:BootstrapGridViewCommandColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Delegate" VisibleIndex="1">
                                <DataItemTemplate>
                                    <asp:Literal ID="litDel" runat="server" EnableViewState="false" Text='<%# Eval("Delegate") %>'></asp:Literal>
                                </DataItemTemplate>
                                <%--<DataItemTemplate>
                                    <asp:Label EnableViewState="false" ID="Label10" runat="server" Text='<%# Eval("FirstName") & " " & Eval("LastName") & ", <b>" & Eval("CandidateNumber") & "</b>" %>'></asp:Label><asp:Label ID="Label11" Visible='<%#Eval("EmailAddress").ToString.Length > 0 %>' runat="server" Text='<%# ", (" & Eval("EmailAddress") & ")" %>'></asp:Label>
                                </DataItemTemplate>--%>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn Caption="Job Group" FieldName="JobGroupName" ReadOnly="True" VisibleIndex="2">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Answer1" VisibleIndex="3">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Answer2" VisibleIndex="4">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Answer3" VisibleIndex="5">
                            </dx:BootstrapGridViewTextColumn>
                             <dx:BootstrapGridViewTextColumn FieldName="Answer4" VisibleIndex="6">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Answer5" VisibleIndex="7">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Answer6" VisibleIndex="8">
                            </dx:BootstrapGridViewTextColumn>
                        </Columns>
                    </dx:BootstrapGridView>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary mr-auto float-left" data-dismiss="modal">Cancel</button>
                    <asp:LinkButton ID="lbtConfirmAddDelegates" CssClass="btn btn-success float-right" runat="server">Add Delegates</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <asp:ObjectDataSource ID="dsCustomisationsnotInGroup" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.customiseTableAdapters.CustomisationsNotInGroupTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
            <asp:SessionParameter SessionField="dvGroupID" Name="GroupID" Type="Int32" />
            <asp:SessionParameter SessionField="AdminCategoryID" Name="AdminCategoryID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <!-- Modal add courses-->
    <div class="modal fade" id="AddCustomisationModal" tabindex="-1" role="dialog" aria-labelledby="addCustomisationLabel">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    
                    <h5 class="modal-title" id="addCustomisationLabel">Add Course to Group <small>Step 1 - Choose Course</small></h5><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <div class="alert alert-info">
                        <p>Delegates in (or subsequently added to) the group will be enrolled on any courses added here automatically. When adding a course, you will be able to specify a target to complete within a number of months from enrolment.</p>
                    </div>
                    <div class="form">
                        <div class="form-group row">
                            <asp:Label ID="lblSelectCourse" runat="server" AssociatedControlID="bsgvCusomisationsAdd" CssClass="control-label" Text="Choose a course:"></asp:Label>

                            <dx:BootstrapGridView ID="bsgvCusomisationsAdd" runat="server" AutoGenerateColumns="False" DataSourceID="dsCustomisationsnotInGroup" KeyFieldName="CustomisationID">
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

                        </div>

                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary mr-auto float-left" data-dismiss="modal">Cancel</button>
                    <asp:LinkButton ID="lbtNextAddCourse" CssClass="btn btn-primary float-right" runat="server">Next</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <asp:ObjectDataSource ID="dsSupervisors" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.customiseTableAdapters.SupervisorsTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
            <asp:ControlParameter ControlID="hfCustomisationID" Name="CustomisationID" PropertyName="Value" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <!-- Modal message-->
    <div class="modal fade" id="AddCustomisation2Modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    
                    <h5 class="modal-title" id="addCustomisation2Label">Add Course to Group <small>Step 2 - Set Enrolment Options</small></h5><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <div class="form m-3">
                        <div class="form-group row">
                            <asp:Label ID="lbCourseName" runat="server" Text="Course name:" AssociatedControlID="tbCourseNameToAdd" CssClass="control-label col-sm-4"></asp:Label>
                            <div class="col col-sm-8">
                                <asp:HiddenField ID="hfCustomisationID" runat="server" />
                                <asp:TextBox ID="tbCourseNameToAdd" Enabled="false" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row">
                            <asp:Label ID="lblIsCohort" runat="server" ToolTip="Cohorting learners allows them to be supervised as a group." Text="Cohort Learners:" AssociatedControlID="cbCohortLearners" CssClass="control-label col-sm-4"></asp:Label>
                            <div class="col col-sm-8">
                                <asp:CheckBox ID="cbCohortLearners" ToolTip="Indicates whether completion of the course within the completion window above is mandatory" runat="server" />
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
                            <asp:Label ID="Label12" runat="server" Text="Complete within" AssociatedControlID="tbCourseNameToAdd" CssClass="control-label col-sm-4"></asp:Label>
                            <div class="col col-sm-8">
                                <div class="input-group">
                                    <dx:BootstrapSpinEdit ID="spinCompleteWithinMonths" ToolTip="The number of months after enrolment that the learner should complete the course within (0 = not set)" NumberType="Integer" MaxValue="36" runat="server" CssClasses-IconDecrement="fas fa-angle-down" CssClasses-IconIncrement="fas fa-angle-up"></dx:BootstrapSpinEdit>
                                    <div class="input-group-append"><span class="input-group-text">months</span></div>
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
                                    <dx:BootstrapSpinEdit ID="spinValidityMonths" ToolTip="The number of months after completion that the delegate will remain compliant with the learning expectation (0 = not set)" NumberType="Integer" MaxValue="36" runat="server" ReadOnly="true" CaptionSettings-RequiredMarkDisplayMode="Auto" CssClasses-IconDecrement="fas fa-angle-down" CssClasses-IconIncrement="fas fa-angle-up"></dx:BootstrapSpinEdit>
                                    <div class="input-group-append"><span class="input-group-text">months</span></div>
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
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary mr-auto float-left" data-dismiss="modal">Cancel</button>

                    <asp:LinkButton ID="lbtAddCourseConfirm" CssClass="btn btn-success float-right" runat="server">Add Course</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
     <!-- Modal message-->
    <div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="myModalMessageLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    
                    <h5 class="modal-title" id="myModalMessageLabel">
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

