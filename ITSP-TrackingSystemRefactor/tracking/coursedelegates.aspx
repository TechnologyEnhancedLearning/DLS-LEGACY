<%@ Page Title="Course Delegates" Language="vb" AutoEventWireup="false" MasterPageFile="~/tracking/Site.Master" CodeBehind="coursedelegates.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.coursedelegates" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Src="~/tracking/TabbedProgressView.ascx" TagPrefix="uc1" TagName="TabbedProgressView" %>
<%@ Register Src="~/controls/DelegatesModals.ascx" TagPrefix="uc1" TagName="DelegatesModals" %>

<asp:Content ID="Content1" ContentPlaceHolderID="breadtray" runat="server">
    <ol class="breadcrumb breadcrumb-slash">
        <li class="breadcrumb-item"><a href="delegates">Delegates </a></li>
        <li class="breadcrumb-item active">Course Delegates</li>
    </ol>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="m-3">
        <div class="form-group row">

            <asp:Label ID="lblCourseSelect" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label" AssociatedControlID="ddCustomisationSelector" runat="server" Text="Course Name:"></asp:Label>
            <div class="col col-sm-8 col-md-9 col-lg-8">
                <asp:DropDownList ID="ddCustomisationSelector" CssClass="form-control" AppendDataBoundItems="true" runat="server" DataSourceID="CustomisationsDataSourceCourse"
                    DataTextField="CustomisationName" DataValueField="CustomisationID" AutoPostBack="True">
                    <asp:ListItem Value="0" Text="All"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col col-sm-2">
                <asp:CheckBox ID="cbActiveOnly" Checked="true" CssClass="checkbox-inline" Text="Active only" ToolTip="Show active courses only" AutoPostBack="true" runat="server" />
            </div>
        </div>

    </div>
    <asp:ObjectDataSource ID="CustomisationsDataSourceCourse" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetByCentre2" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.CustomisationsTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
            <asp:ControlParameter ControlID="cbActiveOnly" Name="Active" PropertyName="Checked" Type="Boolean" />
            <asp:SessionParameter Name="AdminCategoryID" SessionField="AdminCategoryID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsDelegatesForCustomisation" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataBySP" TypeName="ITSP_TrackingSystemRefactor.progressTableAdapters.DelegatesForCustomisationTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddCustomisationSelector" Name="CustomisationID" PropertyName="SelectedValue" Type="Int32" />
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
            <asp:SessionParameter Name="AdminCategoryID" SessionField="AdminCategoryID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <dx:ASPxGridViewExporter ID="DelegateGridViewExporter" GridViewID="bsgvDelegatesForCustomisation" FileName="Digital Learning Solutions Course Delegates" runat="server"></dx:ASPxGridViewExporter>
    <dx:BootstrapGridView ID="bsgvDelegatesForCustomisation" SettingsDetail-ShowDetailRow="True" SettingsDetail-AllowOnlyOneMasterRowExpanded="True" runat="server" AutoGenerateColumns="False" DataSourceID="dsDelegatesForCustomisation" KeyFieldName="ProgressID" SettingsCustomizationDialog-Enabled="True" OnToolbarItemClick="GridViewCustomToolbar_ToolbarItemClick" SettingsBootstrap-Sizing="Small">
        <CssClasses Table="table table-striped table-condensed small" />

        <SettingsBootstrap Sizing="Small"></SettingsBootstrap>

        <Settings ShowHeaderFilterButton="True" />
        <SettingsCookies Enabled="True" Version="0.130" />
        <SettingsPager PageSize="15">
        </SettingsPager>
        <Columns>
            <dx:BootstrapGridViewTextColumn FieldName="CourseName" GroupIndex="0" SortIndex="0" SortOrder="Ascending" VisibleIndex="0">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="DelegateName" Settings-AllowHeaderFilter="False" VisibleIndex="1" Caption="Delegate" ReadOnly="True">
                <Settings AllowHeaderFilter="False"></Settings>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="Email" VisibleIndex="2" Settings-AllowHeaderFilter="False">
                <Settings AllowHeaderFilter="False"></Settings>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewDateColumn FieldName="DateRegistered" VisibleIndex="13" Caption="Enrolled" Name="Enrolled">
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewTextColumn FieldName="CandidateNumber" VisibleIndex="3" Caption="Del ID" Name="Delegate ID" Settings-AllowHeaderFilter="False">
                <Settings AllowHeaderFilter="False"></Settings>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewDateColumn FieldName="LastUpdated" VisibleIndex="12" Caption="Last updated" Name="Last updated">
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="15">
            </dx:BootstrapGridViewCheckColumn>
            <dx:BootstrapGridViewTextColumn FieldName="AliasID" VisibleIndex="4" Caption="Alias" Name="Alias" Visible="False" Settings-AllowHeaderFilter="False">
                <Settings AllowHeaderFilter="False"></Settings>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="JobGroupName" VisibleIndex="5" Caption="Job Group" Name="Job Group" Visible="False">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewDateColumn FieldName="Completed" VisibleIndex="16">
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewTextColumn FieldName="Logins" ReadOnly="True" VisibleIndex="17" Settings-AllowHeaderFilter="False">
                <Settings AllowHeaderFilter="False"></Settings>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="Duration" ReadOnly="True" VisibleIndex="18" Caption="Time (mins)" Name="Time (mins)" Settings-AllowHeaderFilter="False">
                <Settings AllowHeaderFilter="False"></Settings>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="Passes" ReadOnly="True" VisibleIndex="20" Caption="Assess Passed" Settings-AllowHeaderFilter="False">
                <Settings AllowHeaderFilter="False"></Settings>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="Attempts" ReadOnly="True" VisibleIndex="21" Visible="False" Settings-AllowHeaderFilter="False">
                <Settings AllowHeaderFilter="False"></Settings>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewDateColumn FieldName="RemovedDate" ReadOnly="True" Caption="Archived" VisibleIndex="21" Settings-AllowHeaderFilter="False">
                <Settings AllowHeaderFilter="False"></Settings>
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewCheckColumn FieldName="PLLocked" VisibleIndex="23" Caption="Locked" Name="Locked">
                <DataItemTemplate>
                    <asp:LinkButton ID="lbtUnlock" ToolTip="Click to unlock" OnCommand="lbtUnlock_Command" CommandArgument='<%#  Eval("ProgressID")%>' Visible='<%#  Eval("PLLocked")  %>' EnableViewState="false" CssClass="btn btn-outline-primary" runat="server"><i aria-hidden="true" class="fas fa-unlock-alt"></i></asp:LinkButton>
                </DataItemTemplate>
            </dx:BootstrapGridViewCheckColumn>
            <dx:BootstrapGridViewTextColumn FieldName="PassRatio" ReadOnly="True" PropertiesTextEdit-DisplayFormatString="{0:F0}%" VisibleIndex="19" Settings-AllowHeaderFilter="False">
                <PropertiesTextEdit DisplayFormatString="{0:F0}%"></PropertiesTextEdit>

                <Settings AllowHeaderFilter="False"></Settings>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="DiagnosticScore" VisibleIndex="19" Caption="Diag. Score" Settings-AllowHeaderFilter="False">
                <Settings AllowHeaderFilter="False"></Settings>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Reg Answer 1" FieldName="Answer1" VisibleIndex="6" Visible="False">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Reg Answer 2" FieldName="Answer2" VisibleIndex="7" Visible="False">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Reg Answer 3" FieldName="Answer3" VisibleIndex="8" Visible="False">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Reg Answer 4" FieldName="Answer4" VisibleIndex="9" Visible="False">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Reg Answer 5" FieldName="Answer5" VisibleIndex="10" Visible="False">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Reg Answer 6" FieldName="Answer6" VisibleIndex="11" Visible="False">
            </dx:BootstrapGridViewTextColumn>

            <dx:BootstrapGridViewTextColumn FieldName="CustomisationID" Visible="False" ShowInCustomizationDialog="False" VisibleIndex="24">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewDateColumn Caption="Complete By" FieldName="CompleteByDate" VisibleIndex="14">
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewTextColumn FieldName="CourseAnswer1" ShowInCustomizationDialog="false" VisibleIndex="23">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="CourseAnswer2" ShowInCustomizationDialog="false" VisibleIndex="24">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="CourseAnswer3" ShowInCustomizationDialog="false" VisibleIndex="25">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn ReadOnly="True" ShowInCustomizationDialog="false" Name="Edit" VisibleIndex="26">
                <Settings AllowHeaderFilter="False" />
                <SettingsEditForm Visible="False" />

                <DataItemTemplate>
                    <asp:LinkButton ID="EditCustFields" EnableViewState="false" ToolTip="Edit custom admin field values" CommandArgument='<%# Eval("ProgressID") %>' CssClass="btn btn-outline-secondary btn-sm" runat="server" OnCommand="EditCustFields_Command"><i aria-hidden="true" class="fas fa-pencil-alt"></i></asp:LinkButton>
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
        </Columns>
        <Templates>
            <DetailRow>
                <uc1:TabbedProgressView runat="server" ID="TabbedProgressView" />
            </DetailRow>
        </Templates>

        <Toolbars>
            <dx:BootstrapGridViewToolbar Position="Top">
                <Items>
                    <%--<dx:BootstrapGridViewToolbarItem Command="ClearGrouping" IconCssClass="far fa-caret-square-o-down" />--%>
                    <dx:BootstrapGridViewToolbarItem Command="ClearSorting" IconCssClass="fas fa-sort" />
                    <dx:BootstrapGridViewToolbarItem Command="ClearFilter" />
                    <dx:BootstrapGridViewToolbarItem Command="ShowCustomizationDialog" Text="Customise Grid" />
                    <dx:BootstrapGridViewToolbarItem Command="Custom" Name="ExcelExport" Text="Excel Export" IconCssClass="fas fa-file-export" />
                </Items>
            </dx:BootstrapGridViewToolbar>
        </Toolbars>
        <ClientSideEvents ToolbarItemClick="onToolbarItemClick" />
        <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="True"></SettingsDetail>

        <SettingsCustomizationDialog Enabled="True"></SettingsCustomizationDialog>

        <SettingsSearchPanel Visible="True" AllowTextInputTimer="false" />
    </dx:BootstrapGridView>
    <div class="modal fade" id="customFieldModal" tabindex="-1" role="dialog" aria-labelledby="customFieldcustomFieldModal-label">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    
                    <h4 class="modal-title" id="customFieldcustomFieldModal-label">
                        <asp:Label ID="lblCFMHeading" runat="server" Text="Label"></asp:Label></h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hfCFProgressID" runat="server" />
                    <asp:Panel ID="pnlField1" CssClass="form-group row" runat="server">
                        <asp:Label ID="lblCustField1" CssClass="control-label col-sm-4" AssociatedControlID="tbField1" runat="server" Text="First name"></asp:Label>
                        <div class="col col-sm-8">
                            <asp:TextBox ID="tbField1" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                            <asp:DropDownList ID="ddField1" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:DropDownList>
                        </div>
                    </asp:Panel>
                    <asp:Panel ID="pnlField2" CssClass="form-group row" runat="server">
                        <asp:Label ID="lblCustField2" CssClass="control-label col-sm-4" AssociatedControlID="tbField2" runat="server" Text="First name"></asp:Label>
                        <div class="col col-sm-8">
                            <asp:TextBox ID="tbField2" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                            <asp:DropDownList ID="ddField2" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:DropDownList>
                        </div>
                    </asp:Panel>
                    <asp:Panel ID="pnlField3" CssClass="form-group row" runat="server">
                        <asp:Label ID="lblCustField3" CssClass="control-label col-sm-4" AssociatedControlID="tbField3" runat="server" Text="First name"></asp:Label>
                        <div class="col col-sm-8">
                            <asp:TextBox ID="tbField3" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                            <asp:DropDownList ID="ddField3" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:DropDownList>
                        </div>
                    </asp:Panel>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:LinkButton ID="lbtSaveCustFields" CssClass="btn btn-primary" runat="server">Submit</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <uc1:DelegatesModals runat="server" ID="DelegatesModals" />
</asp:Content>
