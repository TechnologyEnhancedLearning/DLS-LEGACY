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
            $(document).on('change', '.btn-file :file', function () {
                var input = $(this),
                    numFiles = input.get(0).files ? input.get(0).files.length : 1,
                    label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                input.trigger('fileselect', [numFiles, label]);
            });
            $('#Answer1DropDown').on('change', function () {
                $('#txtAnswer1').val(this.value);
            });
            $('#Answer2DropDown').on('change', function () {
                $('#txtAnswer2').val(this.value);
            });
            $('#Answer3DropDown').on('change', function () {
                $('#txtAnswer3').val(this.value);
            });
            $('#Answer4DropDown').on('change', function () {
                $('#txtAnswer4').val(this.value);
            });
            $('#Answer5DropDown').on('change', function () {
                $('#txtAnswer5').val(this.value);
            });
            $('#Answer6DropDown').on('change', function () {
                $('#txtAnswer6').val(this.value);
            });
            $('#Answer1DropDown_U').on('change', function () {
                $('#txtAnswer1_U').val(this.value);
            });
            $('#Answer2DropDown_U').on('change', function () {
                $('#txtAnswer2_U').val(this.value);
            });
            $('#Answer3DropDown_U').on('change', function () {
                $('#txtAnswer3_U').val(this.value);
            });
            $('#Answer4DropDown_U').on('change', function () {
                $('#txtAnswer4_U').val(this.value);
            });
            $('#Answer5DropDown_U').on('change', function () {
                $('#txtAnswer5_U').val(this.value);
            });
            $('#Answer6DropDown_U').on('change', function () {
                $('#txtAnswer6_U').val(this.value);
            });
            $('#EmailCheckBox').on('change', function () {
                if ($(this).prop("checked") == true) {
                    $('#divSetPW').addClass('d-none');
 $('#divDeliverAfter').removeClass('d-none');
                }
                else {
                    $('#divSetPW').removeClass('d-none');
$('#divDeliverAfter').addClass('d-none');
                }
            });
            $('#tbSetPassword').on('input', function () {
                if ($(this).val() !== '' && $('#EmailCheckBox').prop("checked") !== true) {

                    var pwPat = /(?=.{8,})(?=.*?[^\w\s])(?=.*?[0-9])(?=.*?[A-Za-z]).*/;
                    matchArray = $('#tbSetPassword').val().match(pwPat);
                    if (matchArray === null) {
                        $('#pwvalidate').removeClass('d-none');
                    }
                    else {
                        $('#pwvalidate').addClass('d-none');
                    }
                }
            });
            $(document).ready(function () {
                //$('.bs-pagination td table').each(function (index, obj) {
                //    convertToPagination(obj)
                //});
                //$('input, textarea').placeholder({ customClass: 'my-placeholder' });
                $('.btn-file :file').on('fileselect', function (event, numFiles, label) {

                    var input = $(this).parents('.input-group').find(':text'),
                        log = numFiles > 1 ? numFiles + ' files selected' : label;

                    if (input.length) {
                        input.val(log);
                    } else {
                        if (log) alert(log);
                    }

                });
            });
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

    <%--<div class="row">
                <div class="col col-xs-12">
                    <div class="btn-group float-right" role="group" aria-label="...">
                          <asp:LinkButton ID="lbtClearFilters" runat="server" CssClass="btn btn-outline-secondary"><i aria-hidden="true" class="fas fa-times"></i> Clear filters</asp:LinkButton>
                        <uc1:GridviewControlPanel runat="server" id="ucGridviewControlPanel" HeaderText="Show / Hide Columns" LinkText="Choose Columns" GridID="bsgvCentreDelegates" />
                             <asp:LinkButton ID="lbtExcelExport" CssClass="btn btn-success" runat="server"><i aria-hidden="true" class="fa fa-file-excel-o"></i> Download to Excel</asp:LinkButton>  
             
                    </div>
                </div>
            </div>
            <div class="row">--%>

    <div class="table-responsive small">

        <dx:ASPxGridViewExporter ID="DelegateGridViewExporter" GridViewID="bsgvCentreDelegates" FileName="Digital Learning Solutions Delegates" runat="server"></dx:ASPxGridViewExporter>
        <dx:BootstrapGridView EnableViewState="False" CssClasses-Table="table table-striped" ID="bsgvCentreDelegates" runat="server" AutoGenerateColumns="False" DataSourceID="dsCourseDelegates" KeyFieldName="CandidateID" SettingsCustomizationDialog-Enabled="True" OnToolbarItemClick="GridViewCustomToolbar_ToolbarItemClick" SettingsBootstrap-Sizing="Small" SettingsDetail-ShowDetailRow="True" SettingsDetail-AllowOnlyOneMasterRowExpanded="True">
            <CssClasses Table="table table-striped" />
            <SettingsBootstrap Sizing="Small" />
            <Settings GridLines="None" ShowHeaderFilterButton="True" />
            <SettingsCookies Enabled="True" Version="0.123" />
            <SettingsPager PageSize="15">
            </SettingsPager>
            <SettingsDataSecurity AllowEdit="True" />
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
                        <asp:LinkButton Visible='<%# Eval("IsAdmin") = 0 And Session("UserCentreManager") And Eval("EmailAddress").ToString.Length > 4 And Eval("PasswordSet") %>' ToolTip="Promote to Admin / Supervisor" aria-label="Promote to Admin / Supervisor" EnableViewState="false" ID="lbtPromoteToAdmin" CommandArgument='<%#Eval("CandidateID") %>' OnCommand="lbtPromoteToAdmin_Command" CssClass="btn btn-sm btn-outline-success" runat="server"><i class="fas fa-level-up-alt"></i></asp:LinkButton>
                    </DataItemTemplate>
                </dx:BootstrapGridViewCheckColumn>
                <dx:BootstrapGridViewTextColumn ReadOnly="true" Caption="Password" FieldName="PasswordSet" VisibleIndex="0">
                    <SettingsEditForm Visible="False" />
                    <DataItemTemplate>
                 
                        <asp:Label ID="Label13" runat="server" ToolTip="Password not set" CssClass="text-danger" Visible='<%# Not Eval("PasswordSet") %>' Text="Label"><i aria-hidden="true" class="far fa-circle fa-2x"></i></asp:Label>
                        <asp:Label ID="Label7" runat="server" ToolTip="Password set" CssClass="text-success" Visible='<%# Eval("PasswordSet") %>' Text="Label"><i aria-hidden="true" class="fas fa-check-circle fa-2x"></i></asp:Label>
                        <asp:LinkButton EnableViewState="false" Tooltip="Manage user password" OnCommand="lbtManagePW_Command" CommandArgument='<%# Eval("CandidateID") %>' CssClass="btn btn-light" ID="lbtManagePW" runat="server"><i aria-hidden="true" class="fas fa-user-lock"></i></asp:LinkButton>
                        


                    </DataItemTemplate>

                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewTextColumn ReadOnly="True" ShowInCustomizationDialog="false" Name="Edit" VisibleIndex="15">
                    <Settings AllowHeaderFilter="False" />
                    <SettingsEditForm Visible="False" />

                    <DataItemTemplate>
                        <asp:LinkButton ID="EditDelegate" EnableViewState="false" OnCommand="EditDelegate_ClickCommand" CommandArgument='<%# Eval("CandidateID") %>' CssClass="btn btn-outline-secondary btn-sm" runat="server"><i aria-hidden="true" class="fas fa-pencil-alt"></i></asp:LinkButton>
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
                <dx:BootstrapGridViewToolbar Position="top">
                    <Items>
                        <dx:BootstrapGridViewToolbarItem Name="Register" Text="Register" ToolTip="Register Delegate" SettingsBootstrap-RenderOption="Primary" IconCssClass="fas fa-user-plus" />
                        <dx:BootstrapGridViewToolbarItem Name="SendWelcomeMsgs" Text="Send Welcome Emails" BeginGroup="True" IconCssClass="fas fa-envelope" SettingsBootstrap-RenderOption="Info" />
                        <dx:BootstrapGridViewToolbarItem Name="DownloadDelegates" Text="Download Delegates" ToolTip="Download Centre Delegates for Bulk Upload" BeginGroup="True" IconCssClass="fas fa-download" />
                        <dx:BootstrapGridViewToolbarItem Name="JobGroupsList" Text="Download Job Groups and IDs" IconCssClass="fas fa-download" />
                        <dx:BootstrapGridViewToolbarItem Name="BulkUpload" Text="Bulk Upload Delegates" ToolTip="Upload changes for bulk modification" IconCssClass="fas fa-upload" BeginGroup="True" SettingsBootstrap-RenderOption="Primary" />
                        </Items>
                </dx:BootstrapGridViewToolbar>
            </Toolbars>
            <SettingsDetail AllowOnlyOneMasterRowExpanded="True" ShowDetailRow="True" />
            <SettingsCustomizationDialog Enabled="True" />
            <SettingsSearchPanel Visible="True" AllowTextInputTimer="false" />
        </dx:BootstrapGridView>
        <!-- Modal -->
<div class="modal fade" id="manageModal" tabindex="-1" role="dialog" aria-labelledby="pwModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="pwModalLabel"> Manage <asp:Label ID="lblCandNum" runat="server" Text="Label"></asp:Label> Password</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <asp:HiddenField ID="hfManagePWCandidateID" runat="server" />
           <div class="form m-3 sm">

                                
               <div class="form-group row">
                   <asp:Label ID="Label15" AssociatedControlID="lbtResendWelcome" CssClass="control-label col-sm-5" runat="server" Text="Send DLS welcome email:"></asp:Label>
                                    <div class="col col-sm-7">
 <asp:LinkButton ID="lbtResendWelcome" CssClass="btn btn-primary" OnClick="lbtResendWelcome_Click" ToolTip="Including invite to set password" runat="server"><i class="fas fa-envelope"></i> Send DLS Welcome Email</asp:LinkButton>
                                        </div>
                                    </div>
             <div class="form-group row">
                                                    <asp:Label ID="LabelSetPW" AssociatedControlID="tbSetPassword1" CssClass="control-label col-sm-5" runat="server" Text="Set password:"></asp:Label>
                                                   
                                                     <div class="col col-sm-7">
                                                         <div class="input-group">
<asp:TextBox ID="tbSetPassword1" ClientIDMode="Static" CssClass="form-control" runat="server" />
                                                             <div class="input-group-append">
<asp:Button ID="btnSetPW" OnClick="btnSetPW_Click" runat="server" OnClientClick="return validateSetPW();" Text="Set" CssClass="btn btn-primary" />
                                                             </div>
                                                         </div>
                                                    
                                                         <div id="pwvalidate1" class="text-danger small d-none">Minimum 8 characters with at least 1 letter, 1 number and 1 symbol</div>
                                                         </div>
                
                                                </div>
               </div>
         
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
      </div>
    </div>
  </div>
</div>
    </div><asp:ObjectDataSource ID="dsCandidate" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetCandidate" TypeName="ITSP_TrackingSystemRefactor.centrecandidatesTableAdapters.CandidatesTableAdapter" UpdateMethod="UpdateAfterEdit">
                                     <SelectParameters>
                        <asp:SessionParameter Name="CandidateID" SessionField="dvCandidateID" Type="Int32" />
                        <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Original_CandidateID" Type="Int32" />
                        <asp:Parameter Name="FirstName" Type="String" />
                        <asp:Parameter Name="LastName" Type="String" />
                        <asp:Parameter Name="JobGroupID" Type="Int32" />
                        <asp:Parameter Name="Answer1" Type="String" />
                        <asp:Parameter Name="Answer2" Type="String" />
                        <asp:Parameter Name="Answer3" Type="String" />
                        <asp:Parameter Name="Answer4" Type="String" />
                        <asp:Parameter Name="Answer5" Type="String" />
                        <asp:Parameter Name="Answer6" Type="String" />
                        <asp:Parameter Name="EmailAddress" Type="String" />
                        <asp:Parameter Name="AliasID" Type="String" />
                        <asp:Parameter Name="Approved" Type="Boolean" />
                        <asp:Parameter Name="Active" Type="Boolean" />
                    </UpdateParameters>
                </asp:ObjectDataSource>
    <%-- </div>--%>
    <!-- Modal Edit -->
    <div class="modal fade" id="DelegateDetailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <asp:FormView ID="fvDelegateDetails" DefaultMode="Edit" RenderOuterTable="False" runat="server" DataKeyNames="CandidateID" DataSourceID="dsCandidate">
                    <EditItemTemplate>
                        <div class="modal-header">
                    <h4>Edit Delegate Registration Information</h4>
                </div>
                        <div class="modal-body">
                            <div class="form m-3 sm">

                                <div class="form-group row">
                                    <asp:Label ID="Label8" AssociatedControlID="FirstNameTextBox_U" CssClass="control-label col-sm-4" runat="server" Text="First name:"></asp:Label>
                                    <div class="col col-sm-8">
                                        <asp:TextBox ID="FirstNameTextBox_U" runat="server" ClientIDMode="Static" CssClass="form-control small" Text='<%# Bind("FirstName") %>' />
                                        <div id="fnamevalidate_U" class="text-danger small d-none">Required</div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label9" AssociatedControlID="LastNameTextBox_U" CssClass="control-label col-sm-4" runat="server" Text="Last name:"></asp:Label>
                                    <div class="col col-sm-8">
                                        <asp:TextBox ID="LastNameTextBox_U" CssClass="form-control" ClientIDMode="Static" runat="server" Text='<%# Bind("LastName") %>' />
                                        <div id="lnamevalidate_U" class="text-danger small d-none">Required</div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label10" AssociatedControlID="EmailAddressTextBox_U" CssClass="control-label col-sm-4" runat="server" Text="Email:"></asp:Label>
                                    <div class="col col-sm-8">
                                        <asp:TextBox ID="EmailAddressTextBox_U" CssClass="form-control" ClientIDMode="Static" runat="server" Text='<%# Bind("EmailAddress") %>' />
                                        <div id="emailvalidate_U" class="text-danger small d-none">Required</div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label11" AssociatedControlID="AliasIDTextBox_U" CssClass="control-label col-sm-4" runat="server" Text="Alias ID:"></asp:Label>
                                    <div class="col col-sm-8">
                                        <asp:TextBox ID="AliasIDTextBox_U" CssClass="form-control" runat="server" Text='<%# Bind("AliasID") %>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label12" AssociatedControlID="ddJobGroupEdit" CssClass="control-label col-sm-4" runat="server" Text="Job group:"></asp:Label>
                                    <div class="col col-sm-8">
                                        <asp:DropDownList ID="ddJobGroupEdit" CssClass="form-control" runat="server" DataSourceID="dsJobGroups"
                                            DataTextField="JobGroupName" DataValueField="JobGroupID" SelectedValue='<%# Bind("JobGroupID") %>'>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblAnswer1TextEdit_U" AssociatedControlID="txtAnswer1_U" CssClass="control-label col-sm-4" runat="server" Text="Label"></asp:Label>
                                    <div class="col col-sm-8">
                                        <asp:HiddenField ID="hfField1Mand_U" Value="0" ClientIDMode="Static" runat="server" />
                                                        <asp:TextBox ID="txtAnswer1_U" ClientIDMode="Static" CssClass="form-control" runat="server" Text='<%# Bind("Answer1") %>' />
                                                        <asp:DropDownList CssClass="form-control" ClientIDMode="Static" ID="Answer1DropDown_U" Visible="True" runat="server" />
                                                        <div id="f1validate_U" class="text-danger small d-none">Required</div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblAnswer2TextEdit_U" AssociatedControlID="txtAnswer2_U" CssClass="control-label col-sm-4" runat="server" Text="Label"></asp:Label>
                                    <div class="col col-sm-8">
                                        <asp:HiddenField ID="hfField2Mand_U" Value="0" ClientIDMode="Static" runat="server" />
                                        <asp:TextBox ClientIDMode="static" ID="txtAnswer2_U" CssClass="form-control" runat="server" Text='<%# Bind("Answer2") %>' />
                                        <asp:DropDownList ClientIDMode="static" CssClass="form-control" ID="Answer2DropDown_U" Visible="True" runat="server" />
                                        <div id="f2validate_U" class="text-danger small d-none">Required</div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblAnswer3TextEdit_U" AssociatedControlID="txtAnswer3_U" CssClass="control-label col-sm-4" runat="server" Text="Label"></asp:Label>
                                    <div class="col col-sm-8">
                                        <asp:HiddenField ID="hfField3Mand_U" Value="0" ClientIDMode="Static" runat="server" />
                                                        <asp:TextBox ID="txtAnswer3_U" ClientIDMode="Static" CssClass="form-control" runat="server" Text='<%# Bind("Answer3") %>' />
                                                        <asp:DropDownList CssClass="form-control" ClientIDMode="Static" ID="Answer3DropDown_U" Visible="True" runat="server" />
                                                        <div id="f3validate_U" class="text-danger small d-none">Required</div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <asp:Label ID="lblAnswer4TextEdit_U" AssociatedControlID="txtAnswer4_U" CssClass="control-label col-sm-4" runat="server" Text="Label"></asp:Label>
                                    <div class="col col-sm-8">
                                        <asp:HiddenField ID="hfField4Mand_U" Value="0" ClientIDMode="Static" runat="server" />
                                                        <asp:TextBox ID="txtAnswer4_U" ClientIDMode="Static" CssClass="form-control" runat="server"  Text='<%# Bind("Answer4") %>' />
                                                        <asp:DropDownList ClientIDMode="Static" CssClass="form-control" ID="Answer4DropDown_U"  Visible="True" runat="server" />
                                                        <div id="f4validate_U" class="text-danger small d-none">Required</div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblAnswer5TextEdit_U" AssociatedControlID="txtAnswer5_U" CssClass="control-label col-sm-4" runat="server" Text="Label"></asp:Label>
                                    <div class="col col-sm-8">
                                        <asp:HiddenField ID="hfField5Mand_U" Value="0" ClientIDMode="Static" runat="server" />
                                                        <asp:TextBox ID="txtAnswer5_U" ClientIDMode="Static" CssClass="form-control" runat="server"  Text='<%# Bind("Answer5") %>' />
                                                        <asp:DropDownList CssClass="form-control" ID="Answer5DropDown_U" Visible="True"  runat="server" />
                                                        <div id="f5validate_U" class="text-danger small d-none">Required</div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblAnswer6TextEdit_U" AssociatedControlID="txtAnswer6_U" CssClass="control-label col-sm-4" runat="server" Text="Label"></asp:Label>
                                    <div class="col col-sm-8">
                                        <asp:HiddenField ID="hfField6Mand_U" Value="0" ClientIDMode="Static" runat="server" />
                                                        <asp:TextBox ID="txtAnswer6_U" ClientIDMode="Static" CssClass="form-control" runat="server"  Text='<%# Bind("Answer6") %>' />
                                                        <asp:DropDownList CssClass="form-control" ClientIDMode="Static" ID="Answer6DropDown_U"  Visible="True" runat="server" />
                                                        <div id="f6validate_U" class="text-danger small d-none">Required</div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <asp:Label ID="Label16" AssociatedControlID="ActiveCheckBox" CssClass="control-label col-sm-4" runat="server" Text="Active"></asp:Label>
                                    <div class="col col-sm-8">
                                        <asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Bind("Active") %>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label17" AssociatedControlID="ApprovedCheckBox" CssClass="control-label col-sm-4" runat="server" Text="Approved"></asp:Label>
                                    <div class="col col-sm-8">
                                        <asp:CheckBox ID="ApprovedCheckBox" runat="server" Checked='<%# Bind("Approved") %>' />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer clearfix">
                            <button type="button" class="btn btn-outline-secondary mr-auto" data-dismiss="modal">Cancel</button>
                            <%--<asp:LinkButton ID="UpdateButton" OnClientClick="return validateCustomFields();" runat="server" CssClass="btn btn-primary" CausesValidation="True" CommandName="Update" Text="Update" />--%>
                            
                                            <asp:Button ID="btnUpdateButton"  runat="server" OnClientClick="return validateCustomFieldsUpdate();" Text="Update" CommandName="Update" CssClass="btn btn-primary" />

                        </div>


                    </EditItemTemplate>

                   
                </asp:FormView>
                <asp:Label ID="lblCandidatesEditError" Text="" Style="color: Red" runat="server"></asp:Label>
            </div>
        </div>

    </div>
     <!-- Modal Edit -->
    <div class="modal fade" id="DelegateRegisterModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                 <div class="modal-header">
                    <h4>Register Delegate</h4>
                </div>
                                        <div class="modal-body">
                                            <div class="form m-3">

                                                <div class="form-group row">
                                                    <asp:Label ID="Label8" AssociatedControlID="FirstNameTextBox" CssClass="control-label col-sm-4" runat="server" Text="First name:"></asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="FirstNameTextBox" ClientIDMode="Static" runat="server" CssClass="form-control small" />
                                                        <div id="fnamevalidate" class="text-danger small d-none">Required</div>
                                                          </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label9" AssociatedControlID="LastNameTextBox" CssClass="control-label col-sm-4" runat="server" Text="Last name:"></asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="LastNameTextBox" ClientIDMode="Static" CssClass="form-control" runat="server"  />
                                                       <div id="lnamevalidate" class="text-danger small d-none">Required</div></div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label10" AssociatedControlID="EmailAddressTextBox" CssClass="control-label col-sm-4" runat="server" Text="Email:"></asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="EmailAddressTextBox" ClientIDMode="Static" CssClass="form-control" runat="server"  />
                                                     <div id="emailvalidate" class="text-danger small d-none">Required</div> </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label11" AssociatedControlID="AliasIDTextBox" CssClass="control-label col-sm-4" runat="server" Text="Alias ID:"></asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="AliasIDTextBox" CssClass="form-control" runat="server"  />
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label12" AssociatedControlID="ddJobGroupInsert" CssClass="control-label col-sm-4" runat="server" Text="Job group:"></asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:DropDownList ID="ddJobGroupInsert" CssClass="form-control" runat="server" DataSourceID="dsJobGroups"
                                                            DataTextField="JobGroupName" DataValueField="JobGroupID">
                                                        </asp:DropDownList>

                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="lblAnswer1TextInsert" AssociatedControlID="txtAnswer1" CssClass="control-label col-sm-4" runat="server" Text="Label"></asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:HiddenField ID="hfField1Mand" Value="0" ClientIDMode="Static" runat="server" />
                                                        <asp:TextBox ID="txtAnswer1" ClientIDMode="Static" CssClass="form-control" runat="server" />
                                                        <asp:DropDownList CssClass="form-control" ClientIDMode="Static" ID="Answer1DropDown" Visible="True" runat="server" />
                                                        <div id="f1validate" class="text-danger small d-none">Required</div>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="lblAnswer2TextInsert" AssociatedControlID="txtAnswer2" CssClass="control-label col-sm-4" runat="server" Text="Label"></asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:HiddenField ID="hfField2Mand" Value="0" ClientIDMode="Static" runat="server" />
                                                        <asp:TextBox ID="txtAnswer2" ClientIDMode="Static" CssClass="form-control" runat="server" />
                                                        <asp:DropDownList CssClass="form-control" ClientIDMode="Static" ID="Answer2DropDown" Visible="True" runat="server" />
                                                        <div id="f2validate" class="text-danger small d-none">Required</div>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="lblAnswer3TextInsert" AssociatedControlID="txtAnswer3" CssClass="control-label col-sm-4" runat="server" Text="Label"></asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:HiddenField ID="hfField3Mand" Value="0" ClientIDMode="Static" runat="server" />
                                                        <asp:TextBox ID="txtAnswer3" ClientIDMode="Static" CssClass="form-control" runat="server" />
                                                        <asp:DropDownList CssClass="form-control" ClientIDMode="Static" ID="Answer3DropDown" Visible="True" runat="server" />
                                                        <div id="f3validate" class="text-danger small d-none">Required</div>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="lblAnswer4TextInsert" AssociatedControlID="txtAnswer4" CssClass="control-label col-sm-4" runat="server" Text="Label"></asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:HiddenField ID="hfField4Mand" Value="0" ClientIDMode="Static" runat="server" />
                                                        <asp:TextBox ID="txtAnswer4" ClientIDMode="Static" CssClass="form-control" runat="server" />
                                                        <asp:DropDownList ClientIDMode="Static" CssClass="form-control" ID="Answer4DropDown" Visible="True" runat="server" />
                                                        <div id="f4validate" class="text-danger small d-none">Required</div>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="lblAnswer5TextInsert" AssociatedControlID="txtAnswer5" CssClass="control-label col-sm-4" runat="server" Text="Label"></asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:HiddenField ID="hfField5Mand" Value="0" ClientIDMode="Static" runat="server" />
                                                        <asp:TextBox ID="txtAnswer5" ClientIDMode="Static" CssClass="form-control" runat="server" />
                                                        <asp:DropDownList CssClass="form-control" ID="Answer5DropDown" Visible="True" runat="server" />
                                                        <div id="f5validate" class="text-danger small d-none">Required</div>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="lblAnswer6TextInsert" AssociatedControlID="txtAnswer6" CssClass="control-label col-sm-4" runat="server" Text="Label"></asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:HiddenField ID="hfField6Mand" Value="0" ClientIDMode="Static" runat="server" />
                                                        <asp:TextBox ID="txtAnswer6" ClientIDMode="Static" CssClass="form-control" runat="server" />
                                                        <asp:DropDownList CssClass="form-control" ClientIDMode="Static" ID="Answer6DropDown" Visible="True" runat="server" />
                                                        <div id="f6validate" class="text-danger small d-none">Required</div>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label16" AssociatedControlID="ActiveCheckBox" CssClass="control-label col-sm-4" runat="server" Text="Active"></asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:CheckBox ID="ActiveCheckBox" ClientIDMode="static" runat="server" Checked="True" />
                                                    </div>
                                                     
                                                </div>
                                                 <div class="form-group row">
                                                    <asp:Label ID="LabelEmail" AssociatedControlID="EmailCheckBox" CssClass="control-label col-sm-4" runat="server" Text="Send welcome email?"></asp:Label>
                                                    <div class="col col-sm-1">
                                                        <asp:CheckBox ID="EmailCheckBox" ClientIDMode="static" runat="server" Checked="True" />
                                                    </div>
                                                     <div id="divSetPW" class="col col-sm-7 d-none">
                                                    <asp:TextBox ID="tbSetPassword"  ClientIDMode="Static" CssClass="form-control" placeholder="Set delegate password (optional)" runat="server" />
                                                         <div id="pwvalidate" class="text-danger small d-none">Minimum 8 characters with at least 1 letter, 1 number and 1 symbol</div>
                                                         </div>
                                                </div>
                                                 <div id="divDeliverAfter" class="form-group row">
                                                    <asp:Label ID="Label22" AssociatedControlID="bsdeDeliverAfterReg" CssClass="control-label col-sm-4" runat="server" Text="Deliver email on or after:"></asp:Label>
                                                    <div class="col col-sm-8">
                                                        <dx:BootstrapDateEdit ID="bsdeDeliverAfterReg" OnInit="bsdeDeliverAfterDate_Init" runat="server"></dx:BootstrapDateEdit>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer clearfix">
                                            <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">Cancel</button>
                                            <%--<asp:LinkButton ID="InsertButton" OnClientClick="return validateRegFields();" runat="server" CssClass="btn btn-primary" CausesValidation="True" Text="Submit" />--%>
                                            <asp:Button ID="btnRegister"  runat="server" OnClientClick="return validateCustomFields();" ValidationGroup="vgRegister" CausesValidation="true" Text="Register" CssClass="btn btn-primary" />
                                        </div>
                </div>
            </div>
        </div>
      <!-- Modal import-->
    <div class="modal fade" id="bulkuploadModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    
                    <h5 class="modal-title">
                        Bulk Upload / Update Delegates</h5><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <div class="m-3">
                        <div class="form-group row">
                             <asp:Label ID="Label6" AssociatedControlID="cbEmailBulk" CssClass="control-label col-sm-10" runat="server" Text="Send welcome email to registered delegates?"></asp:Label>
                                                    <div class="col col-sm-2">
                                                        <asp:CheckBox ID="cbEmailBulk" runat="server" Checked="True" />
                                                    </div>
                            </div>
                        <div class="form-group row">
                             <asp:Label ID="Label21" AssociatedControlID="bsdeDeliverAfterDate" CssClass="control-label col-sm-6" runat="server" Text="Deliver email on or after:"></asp:Label>
                                                    <div class="col col-sm-6">
                                                        <dx:BootstrapDateEdit ID="bsdeDeliverAfterDate" OnInit="bsdeDeliverAfterDate_Init" runat="server"></dx:BootstrapDateEdit>
                                                    </div>
                            </div>
                    <div class="form-group row">
                                    
                                    <div class="col col-sm-12">

                                       
                                        <div class="input-group">
                                        <span class="input-group-prepend">
                                            <span class="btn btn-outline-secondary btn-file">Browse&hellip;
                                                <asp:FileUpload AllowMultiple="false" ID="fupResource" runat="server" />

                                            </span>
                                        </span>
                                        <input type="text" class="form-control" readonly="readonly">
                                        <span class="input-group-append">
                                            <asp:LinkButton ID="lbtBulkUpload" CausesValidation="false" CommandName="BulkUpload" CssClass="btn btn-primary" ToolTip="Upload Delegate List for Bulk Processing" runat="server"><i aria-hidden="true" class="fas fa-cogs"></i> Upload and Process</asp:LinkButton>
                                        </span>
                                            </div>
                                    </div>
                                </div>

                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary float-right" data-dismiss="modal">Cancel</button>
                   
                </div>
            </div>
        </div>
    </div>
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
    <dx:BootstrapPopupControl ID="bsppSendWelcomes" ClientInstanceName="sendWelcomesPopup" ClientIDMode="Static" PopupHorizontalAlign="Center" PopupVerticalAlign="Middle"  ShowFooter="true" ShowCloseButton="false" CloseAction="CloseButton" Modal="True" ShowOnPageLoad="false" HeaderText="<h4>Send Welcome Messages <small>(centre registered delegates)</small></h4>" EncodeHtml="false" PopupElementCssSelector=".show-enrol" runat="server">
        <SettingsAdaptivity Mode="Always" MaxWidth="1024" SwitchAtWindowInnerWidth="1024" VerticalAlign="WindowCenter"
        FixedHeader="true" FixedFooter="true" />
                        
    <ContentCollection>
        <dx:ContentControl>
            <asp:ObjectDataSource ID="dsDelsForWelcome" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataForWelcomeEmails" TypeName="ITSP_TrackingSystemRefactor.centrecandidatesTableAdapters.CandidatesTableAdapter">
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="0" Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <dx:BootstrapGridView ID="bsgvWelcomeDelegates" runat="server" AutoGenerateColumns="False" DataSourceID="dsDelsForWelcome" KeyFieldName="CandidateID">
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
                                <%--<DataItemTemplate>
                                    <asp:Literal ID="litDel" runat="server" EnableViewState="false" Text='<%# Eval("Delegate") %>'></asp:Literal>
                                </DataItemTemplate>--%>
                                <DataItemTemplate>
                                    <asp:Label EnableViewState="false" ID="Label10" runat="server" Text='<%# Eval("FirstName") & " " & Eval("LastName") & ", <b>" & Eval("CandidateNumber") & "</b>" %>'></asp:Label><asp:Label ID="Label11" Visible='<%#Eval("EmailAddress").ToString.Length > 0 %>' runat="server" Text='<%# ", (" & Eval("EmailAddress") & ")" %>'></asp:Label>
                                </DataItemTemplate>
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
                            <dx:BootstrapGridViewTextColumn FieldName="CandidateNumber" ShowInCustomizationDialog="false" VisibleIndex="10" CssClasses-HeaderCell="d-none" CssClasses-GroupFooterCell="d-none" CssClasses-DataCell="d-none" CssClasses-EditCell="d-none" CssClasses-FilterCell="d-none" CssClasses-FooterCell="d-none">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="EmailAddress" Visible="false" ShowInCustomizationDialog="false" VisibleIndex="11" CssClasses-HeaderCell="d-none" CssClasses-GroupFooterCell="d-none" CssClasses-DataCell="d-none" CssClasses-EditCell="d-none" CssClasses-FilterCell="d-none" CssClasses-FooterCell="d-none">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewCheckColumn Caption="Welcome Sent" FieldName="Approved" ToolTip="Welcome Email Sent" VisibleIndex="9">
                            </dx:BootstrapGridViewCheckColumn>
                        </Columns>
                    </dx:BootstrapGridView>
            <div class="form-group row mt-1">
                                                    <asp:Label ID="Label23" AssociatedControlID="bsdeSendWelcomeDeliverDate" CssClass="control-label col-sm-4" runat="server" Text="Deliver email on or after:"></asp:Label>
                                                    <div class="col col-sm-8">
                                                        <dx:BootstrapDateEdit ID="bsdeSendWelcomeDeliverDate" OnInit="bsdeDeliverAfterDate_Init" runat="server"></dx:BootstrapDateEdit>
                                                    </div>
                                                </div>
            </dx:ContentControl>
        </ContentCollection>
                        <FooterTemplate>
                            <button type="button" class="btn btn-outline-secondary" onclick="javascript:sendWelcomesPopup.Hide();return false;">Cancel</button>
                            <asp:LinkButton CssClass="btn btn-primary" ID="lbtSendWelcomes" OnCommand="lbtSendWelcomes_Command" runat="server">Send Welcome Emails</asp:LinkButton>
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
    <!-- Modal promote to admin-->
    <div class="modal fade" id="promoteUserModal" tabindex="-1" role="dialog" aria-labelledby="promoteUserModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="promoteUserModalLabel">Promote Centre Delegate to Admin</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group row">
                        <asp:Label ID="lblAdminEmail" AssociatedControlID="tbUserEmail" runat="server" CssClass="col col-sm-4 control-label">Email address:</asp:Label>
                        <div class="col col-sm-8">
                            <asp:HiddenField ID="hfCandidateID" runat="server" />
                            <asp:TextBox ID="tbUserEmail" Enabled="false" CssClass="form-control" runat="server" />
                        </div>
                    </div>  
                    <div class="form-group row">
                        <asp:Label ID="Label18" AssociatedControlID="ddCategory" runat="server" CssClass="col col-sm-4 control-label">Learning Category:</asp:Label>
                        <div class="col col-sm-8">
                            <asp:DropDownList ID="ddCategory" DataSourceID="dsCategories" DataTextField="CategoryName" DataValueField="CourseCategoryID" CssClass="form-control" runat="server"></asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group row">
                        <asp:Label ID="Label20" AssociatedControlID="cbCentreAdmin" runat="server" CssClass="col col-sm-4 control-label">Centre Admin:</asp:Label>
                        <div class="col col-sm-8">
                            <asp:CheckBox ID="cbCentreAdmin" CssClass="checkbox" runat="server" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <asp:Label ID="lblSupervisorCb" AssociatedControlID="cbSupervisor" runat="server" CssClass="col col-sm-4 control-label">Supervisor:</asp:Label>
                        <div class="col col-sm-8">
                            <asp:CheckBox ID="cbSupervisor" CssClass="checkbox" runat="server" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <asp:Label ID="Label19" AssociatedControlID="cbTrainer" runat="server" CssClass="col col-sm-4 control-label">Trainer:</asp:Label>
                        <div class="col col-sm-8">
                            <asp:CheckBox ID="cbTrainer" CssClass="checkbox" runat="server" />
                        </div>
                    </div>
                  
                    <div class="form-group row">
                        <asp:Label ID="Label2" AssociatedControlID="ddCMSRole" runat="server" CssClass="col col-sm-4 control-label">CMS Roles:</asp:Label>
                        <div class="col col-sm-8">
                            <asp:DropDownList ID="ddCMSRole" CssClass="form-control" runat="server">
                                <asp:ListItem Text="None" Value="0">
                                </asp:ListItem>
                                <asp:ListItem Text="Administrator" Value="1">
                                </asp:ListItem>
                                <asp:ListItem Text="Manager" Value="2">
                                </asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group row">
                        <asp:Label ID="Label3" AssociatedControlID="cbCCLicence" runat="server" CssClass="col col-sm-4 control-label">Content Creator Licence:</asp:Label>
                        <div class="col col-sm-8">
                            <asp:CheckBox ID="cbCCLicence" CssClass="checkbox" runat="server" />
                        </div>
                    </div>
                    

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary mr-auto float-left" data-dismiss="modal">Close</button>
                    <asp:LinkButton ID="lbtPromoteToAdminSubmit" OnCommand="lbtPromoteToAdminSubmit_Command" CssClass="btn btn-primary float-right" runat="server">Submit</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <uc1:DelegatesModals runat="server" id="DelegatesModals" />
    <script>
        Sys.Application.add_load(BindEvents);
     </script> 
</asp:Content>
