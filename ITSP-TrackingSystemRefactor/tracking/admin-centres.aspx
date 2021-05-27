<%@ Page Title="Admin - Centres" Language="vb" AutoEventWireup="false" MasterPageFile="~/tracking/Site.Master" CodeBehind="admin-centres.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.admin_centres" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="breadtray" runat="server">
   <ol class="breadcrumb breadcrumb-slash">
        <li class="breadcrumb-item"><a href="admin-configuration">Admin </a></li>
        <li class="breadcrumb-item active">Centres</li>
    </ol>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        
    </script>

            

    <!-- /.row -->
    <asp:MultiView ID="mvCentres" ActiveViewIndex="0" runat="server">
        <asp:View ID="vCentreList" runat="server">
            <div class="folat-right">
            <asp:LinkButton ID="lbtAddCentre" CssClass="btn btn-primary float-right" ToolTip="Register new centre" runat="server"><i aria-hidden="true" class="fas fa-plus"></i> Add Centre</asp:LinkButton></div>
            <asp:ObjectDataSource ID="dsCentresList" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.CentresInfoTableAdapter">
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="dsContractTypes" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.ContractTypesTableAdapter"></asp:ObjectDataSource>
   
           <%-- <div class="card card-default">--%>
                <%--<div class="card-header clearfix">
                    <div class="btn-group  float-right">
                        <asp:LinkButton ID="lbtClearFilters" runat="server" CssClass="btn btn-outline-secondary btn-sm"><i aria-hidden="true" class="fas fa-times"></i> Clear filters</asp:LinkButton>
                             <asp:LinkButton ID="lbtDownloadDelegates" CssClass="btn btn-outline-secondary btn-sm" runat="server"><i aria-hidden="true" class="fas fa-file-export"></i> Download to Excel</asp:LinkButton>  
                    </div>
                </div>--%>
                <dx:ASPxGridViewExporter FileName="ITSP Centres Export" ID="CentresGridViewExporter" runat="server"></dx:ASPxGridViewExporter>
                <div class="table-responsive">
                    <dx:BootstrapGridView ID="bsgvCentres" CssClasses-Table="table table-striped small" OnHeaderFilterFillItems="bsgvCentres_HeaderFilterFillItems" runat="server" AutoGenerateColumns="False" DataSourceID="dsCentresList" KeyFieldName="CentreID" SettingsCustomizationDialog-Enabled="True" OnToolbarItemClick="GridViewCustomToolbar_ToolbarItemClick">
                        <CssClasses Table="table table-striped small" />

                        <Settings ShowHeaderFilterButton="True" />
                        <SettingsCookies Enabled="True" Version="0.121" />
                        <SettingsPager PageSize="15">
                        </SettingsPager>
                        <Columns>
                            <dx:BootstrapGridViewTextColumn Caption="Edit" Name="Edit" ShowInCustomizationDialog="false" VisibleIndex="0">
                                <DataItemTemplate>
                                    <Settings AllowHeaderFilter="False" />
                                    <asp:LinkButton EnableViewState="false" ID="lbtEditCentre" CssClass="btn btn-outline-secondary btn-sm" ToolTip="Edit Centre" OnCommand="EditCentre_Click" CommandArgument='<%# Eval("CentreID") %>' runat="server"><i aria-hidden="true" class="fas fa-pencil-alt"></i></asp:LinkButton>
                                </DataItemTemplate>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="CentreID" Name="CentreID" ReadOnly="True" VisibleIndex="1">
                                <Settings AllowHeaderFilter="False" />
                                <SettingsEditForm Visible="False" />
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn Caption="Centre" Name="Centre" FieldName="CentreName" VisibleIndex="2">
                                <Settings AllowHeaderFilter="False" />
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="CentreType" Name="CentreType" ReadOnly="True" VisibleIndex="3">
                                <SettingsHeaderFilter Mode="CheckedList">
                                </SettingsHeaderFilter>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn Caption="Region" Name="Region" FieldName="RegionName" ReadOnly="True" VisibleIndex="4">
                                <SettingsHeaderFilter Mode="CheckedList">
                                </SettingsHeaderFilter>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn Caption="Contact" Name="Contact" FieldName="Contact" VisibleIndex="5">
                                
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="ContactEmail" Name="ContactEmail" VisibleIndex="6">
                                <DataItemTemplate>
                                     <a enableviewstate="false" runat="server" href='<%# "mailto:" & Eval("ContactEmail") %>'>
                                        <asp:Label EnableViewState="false" ID="Label2" runat="server" Text='<%# Bind("ContactEmail") %>'></asp:Label></a>
                                </DataItemTemplate>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn Caption="Telephone" Name="Telephone" FieldName="ContactTelephone" VisibleIndex="7">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewCheckColumn FieldName="Active" Name="Active" VisibleIndex="9">
                            </dx:BootstrapGridViewCheckColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="IPPrefix" Name="IPPrefix" Visible="False" VisibleIndex="10">
                            </dx:BootstrapGridViewTextColumn>
                          
                            
                            <dx:BootstrapGridViewTextColumn Caption="Created" Name="Created" PropertiesTextEdit-DisplayFormatString="dd/MM/yyyy" FieldName="CentreCreated" Visible="False" VisibleIndex="8">
                                <PropertiesTextEdit DisplayFormatString="dd/MM/yyyy">
                                </PropertiesTextEdit>
                            </dx:BootstrapGridViewTextColumn>
                            
                            <dx:BootstrapGridViewTextColumn FieldName="Delegates" Name="Delegates" Visible="False" VisibleIndex="11">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="CourseRegistrations" Name="CourseRegistrations" Visible="False" VisibleIndex="12">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Completions" Name="Completions" Visible="False" VisibleIndex="13">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="AssessAttempts" Name="AssessAttempts" Visible="False" VisibleIndex="14">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="AssessPassed" Name="AssessPassed" Visible="False" VisibleIndex="15">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="LearningTimeHrs" Name="LearningTimeHrs" Visible="False" VisibleIndex="16">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="AdminUsers" Name="AdminUsers" Visible="False" VisibleIndex="17">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="LastLogin" Name="LastLogin" Visible="False" VisibleIndex="18">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Logins" Name="Logins" Visible="False" VisibleIndex="19">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="LastLearnerLogin" Name="LastLearnerLogin" Visible="False" VisibleIndex="20">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewComboBoxColumn Caption="Contract Type" FieldName="ContractTypeID" Name="ContractTypeID" Visible="False" VisibleIndex="21">
                                <PropertiesComboBox DataSourceID="dsContractTypes" TextField="ContractType" ValueField="ContractTypeID">
                                </PropertiesComboBox>
                            </dx:BootstrapGridViewComboBoxColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="ContractReviewDate" Name="ContractReviewDate" Caption="Contr Review" Visible="False" VisibleIndex="22">
                                <PropertiesTextEdit DisplayFormatString="dd/MM/yyyy">
                                </PropertiesTextEdit>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn Caption="CC Lic" FieldName="CCLicences" Visible="False" VisibleIndex="23">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn Caption="CMS Admins" FieldName="CMSAdministrators" Visible="False" VisibleIndex="24">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn Caption="CMS Mgrs" FieldName="CMSManagers" Visible="False" VisibleIndex="25">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Trainers" Visible="False" VisibleIndex="26">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn Caption="Server Space" FieldName="ServerSpaceBytes" Visible="False" VisibleIndex="27">
                                <Settings FilterMode="DisplayText" />
                                <DataItemTemplate>
                                    <%#NiceBytes(Eval("ServerSpaceBytes")) %>
                                </DataItemTemplate>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn Caption="Space Used" FieldName="ServerSpaceUsed" Visible="False" VisibleIndex="28">
                                <Settings FilterMode="DisplayText" />
                                <DataItemTemplate>
                                    <%#NiceBytes(Eval("ServerSpaceUsed")) %>
                                    <asp:LinkButton ID="lbtUpdateSpaceUsage" EnableViewState="false" CommandArgument='<%#Eval("CentreID") %>' OnCommand="lbtUpdateSpaceUsage_Command" runat="server"><i class="fas fa-refresh"></i></asp:LinkButton>
                                    <asp:LinkButton ID="lbtPurgeCentreSpace" EnableViewState="false" Tooltip="REMOVE ALL UNUSED CONTENT FROM SERVER" CommandArgument='<%#Eval("CentreID") %>' OnCommand="lbtPurgeCentreSpace_Command" runat="server"><i class="fas fa-warning"></i></asp:LinkButton>
                                </DataItemTemplate>
                            </dx:BootstrapGridViewTextColumn>
                        </Columns>
                        <ClientSideEvents ToolbarItemClick="onToolbarItemClick" />
                        <Toolbars>
        <dx:BootstrapGridViewToolbar Position="Top">
            <Items>
                <dx:BootstrapGridViewToolbarItem Command="ClearGrouping" IconCssClass="far fa-caret-square-down" />
                <dx:BootstrapGridViewToolbarItem Command="ClearSorting" IconCssClass="fas fa-sort" />
                <dx:BootstrapGridViewToolbarItem Command="ClearFilter" />
                <dx:BootstrapGridViewToolbarItem Command="ShowCustomizationDialog" Text="Customise Grid"/>
                <dx:BootstrapGridViewToolbarItem Command="Custom" Name="ExcelExport" Text="Export Current Columns" IconCssClass="fas fa-file-export"/>
                <dx:BootstrapGridViewToolbarItem Command="Custom" Name="ExcelExportAll" Text="Export All Columns" IconCssClass="fas fa-file-export"/>                                  
            </Items>
        </dx:BootstrapGridViewToolbar>
    </Toolbars>
                        <SettingsCustomizationDialog Enabled="True" />
                        <SettingsSearchPanel Visible="True" AllowTextInputTimer="false" />
                    </dx:BootstrapGridView>
                  
                </div>
         <%--   </div>--%>
    
        </asp:View>
        <asp:View ID="vCentreAddEdit" runat="server">
            <asp:HiddenField ID="hfCentreID" runat="server" />
            <asp:ObjectDataSource ID="dsCentreDetails" runat="server" InsertMethod="uspCentreInsertWithDefaults" OldValuesParameterFormatString="original_{0}" SelectMethod="GetByCentreID" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.CentresTableAdapter" UpdateMethod="UpdateWithoutSignature" DeleteMethod="Delete">
                <DeleteParameters>
                    <asp:Parameter Name="Original_CentreID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="RegionID" Type="Int32" />
                    <asp:Parameter Name="CentreName" Type="String" />
                    <asp:Parameter Name="ContactForename" Type="String" />
                    <asp:Parameter Name="ContactSurname" Type="String" />
                    <asp:Parameter Name="ContactEmail" Type="String" />
                    <asp:Parameter Name="ContactTelephone" Type="String" />
                    <asp:Parameter Name="AutoRegisterManagerEmail" Type="String" />
                    <asp:Parameter Name="CentreTypeID" Type="Int32" />
                    <asp:Parameter Name="AddCourses" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="hfCentreID" DefaultValue="0" Name="CentreID" PropertyName="Value" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="RegionID" Type="Int32" />
                    <asp:Parameter Name="CentreName" Type="String" />
                    <asp:Parameter Name="ContactForename" Type="String" />
                    <asp:Parameter Name="ContactSurname" Type="String" />
                    <asp:Parameter Name="ContactEmail" Type="String" />
                    <asp:Parameter Name="ContactTelephone" Type="String" />
                    <asp:Parameter Name="PriorCandidates" Type="Int32" />
                    <asp:Parameter Name="AutoRegistered" Type="Boolean" />
                    <asp:Parameter Name="AutoRegisterManagerEmail" Type="String" />
                    <asp:Parameter Name="BetaTesting" Type="Boolean" />
                    <asp:Parameter Name="CentreTypeID" Type="Int32" />
                    <asp:Parameter Name="IPPrefix" Type="String" />
                    <asp:Parameter Name="CMSAdministrators" Type="Int32" />
                    <asp:Parameter Name="CMSManagers" Type="Int32" />
                    <asp:Parameter Name="CustomCourses" Type="Int32" />
                    <asp:Parameter Name="CCLicences" Type="Int32" />
                    <asp:Parameter Name="Trainers" Type="Int32" />
                    <asp:Parameter Name="ContractTypeID" Type="Int32" />
                    <asp:Parameter Name="ContractReviewDate" Type="String" />
                    <asp:Parameter Name="ServerSpaceBytes" Type="Int64" />
                    <asp:Parameter Name="CandidateByteLimit" Type="Int64" />
                    <asp:Parameter Name="Original_CentreID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="dsRegions" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.RegionsTableAdapter"></asp:ObjectDataSource>
            <asp:ObjectDataSource ID="dsCentreTypes" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.CentreTypesTableAdapter"></asp:ObjectDataSource>
            <asp:FormView ID="fvCentreDetails" DefaultMode="Insert" RenderOuterTable="False" runat="server" DataKeyNames="CentreID" DataSourceID="dsCentreDetails">
                <EditItemTemplate>
                    <div class="card card-primary">
                        <div class="card-header">
                            <h3>Edit Centre Details</h3>
                        </div>
                        <div class="card-body">
                            <div class="m-3">
                                <div class="form-group row">
                                    <asp:Label ID="Label3" AssociatedControlID="tbCentreName" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Centre name:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:TextBox ID="tbCentreName" CssClass="form-control" runat="server" Text='<%# Bind("CentreName") %>' />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="tbCentreName" Display="Dynamic" runat="server" ValidationGroup="vgEditCentre" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label4" AssociatedControlID="tbContactForename" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Contact first name:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:TextBox ID="tbContactForename" CssClass="form-control" runat="server" Text='<%# Bind("ContactForename") %>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label5" AssociatedControlID="tbContactSurname" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Contact last name:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:TextBox ID="tbContactSurname" CssClass="form-control" runat="server" Text='<%# Bind("ContactSurname") %>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label6" AssociatedControlID="tbEmail" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Contact email:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:TextBox ID="tbEmail" CssClass="form-control" onkeypress="return RestrictSpace()" TextMode="Email" runat="server" Text='<%# Bind("ContactEmail") %>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label7" AssociatedControlID="tbPhone" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Contact phone:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:TextBox ID="tbPhone" CssClass="form-control" TextMode="Phone" runat="server" Text='<%# Bind("ContactTelephone") %>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label8" AssociatedControlID="ddCentreType" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Centre type:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:DropDownList ID="ddCentreType" CssClass="form-control" runat="server" SelectedValue='<%# Bind("CentreTypeID") %>' DataSourceID="dsCentreTypes" DataTextField="CentreType" DataValueField="CentreTypeID"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label9" AssociatedControlID="ddRegion" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Region:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:DropDownList ID="ddRegion" runat="server" CssClass="form-control" SelectedValue='<%# Bind("RegionID") %>' DataSourceID="dsRegions" DataTextField="RegionName" DataValueField="RegionID"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label10" AssociatedControlID="tbAutoRegEmail" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Registration email:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:TextBox ID="tbAutoRegEmail" onkeypress="return RestrictSpace()" placeholder="Email address of centre manager for registration" CssClass="form-control" TextMode="Email" runat="server" Text='<%# Bind("AutoRegisterManagerEmail") %>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label11" AssociatedControlID="tbIPPrefix" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">IP Prefix:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                         <div class="input-group">
                                             
                                        <asp:TextBox ID="tbIPPrefix" ValidationGroup="editCent" ToolTip="IP Addresses for Pre-approved Learner Registrations" CssClass="form-control" runat="server" Text='<%# Bind("IPPrefix") %>' />
                                             <span class="input-group-append">
                                                <span class="input-group-text">
                                                    Separate IP patterns using a comma
                                                </span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label17" AssociatedControlID="pnlStatus" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Status:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:Panel ID="pnlStatus" CssClass="cb-panel" runat="server">
                                            <div class="checkbox">
                                                <asp:Label ID="Label18" runat="server">
                                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Active") %>' />
                                                    Active</asp:Label>
                                            </div>
                                        </asp:Panel>
                                    </div>
                                </div>
                                <hr />
                                <h6>Contract info</h6>
                                <asp:UpdatePanel ID="UpdatePanel1" ChildrenAsTriggers="true" runat="server"><ContentTemplate>
                                <div class="form-group row">
                                    <asp:Label ID="Label1" AssociatedControlID="ddContractType" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Contract Type:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:DropDownList ID="ddContractType" OnSelectedIndexChanged="ddContractType_SelectedIndexChanged" runat="server" AutoPostBack="true" CssClass="form-control" SelectedValue='<%# Bind("ContractTypeID") %>' DataSourceID="dsContractTypes" DataTextField="ContractType" DataValueField="ContractTypeID"></asp:DropDownList>
                                    </div>
                                </div>
                                    <div class="form-group row">
                                    <asp:Label ID="Label13" AssociatedControlID="tbCMSAdministrators" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">CMS Administrators:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                         <div class="input-group">
                                             <span class="input-group-prepend">
                                                <span class="input-group-text">
                                                    -1 = unlimited
                                                </span>
                                            </span>
                                        <asp:TextBox ID="tbCMSAdministrators" ToolTip="-1 = unlimited"  CssClass="form-control" TextMode="Number" runat="server" Text='<%# Bind("CMSAdministrators") %>' />
                                             </div>
                                    </div>
                                </div>
                                    <div class="form-group row">
                                    <asp:Label ID="Label14" AssociatedControlID="tbCMSManagers" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">CMS Managers:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                         <div class="input-group">
                                             <span class="input-group-prepend">
                                                <span class="input-group-text">
                                                    -1 = unlimited
                                                </span>
                                            </span>
                                        <asp:TextBox ID="tbCMSManagers" ToolTip="-1 = unlimited" CssClass="form-control" TextMode="Number" runat="server" Text='<%# Bind("CMSManagers") %>' />
                                             </div>
                                    </div>
                                </div>
                                    <div class="form-group row">
                                    <asp:Label ID="Label21" AssociatedControlID="tbCCLicences" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Content Creator Licences:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                         <div class="input-group">
                                             <span class="input-group-prepend">
                                                <span class="input-group-text">
                                                    -1 = unlimited
                                                </span>
                                            </span>
                                        <asp:TextBox ID="tbCCLicences" ToolTip="-1 = unlimited" CssClass="form-control" TextMode="Number" runat="server" Text='<%# Bind("CCLicences") %>' />
                                             </div>
                                    </div>
                                </div>
                                    <div class="form-group row">
                                    <asp:Label ID="Label15" AssociatedControlID="tbCustomCourses" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Custom Courses:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                         <div class="input-group">
                                             <span class="input-group-prepend">
                                                <span class="input-group-text">
                                                    -1 = unlimited
                                                </span>
                                            </span>
                                        <asp:TextBox ID="tbCustomCourses" ToolTip="-1 = unlimited" CssClass="form-control" TextMode="Number" runat="server" Text='<%# Bind("CustomCourses") %>' />
                                             </div>
                                    </div>
                                </div>
                                    <div class="form-group row">
                                    <asp:Label ID="Label16" AssociatedControlID="tbTrainers" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Trainers:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <div class="input-group">
                                             <span class="input-group-prepend">
                                                <span class="input-group-text">
                                                    -1 = unlimited
                                                </span>
                                            </span>
<asp:TextBox ID="tbTrainers" ToolTip="-1 = unlimited" CssClass="form-control" TextMode="Number" runat="server" Text='<%# Bind("Trainers") %>' />
                                           
                                        </div>
                                        
                                    </div>
                                </div>
                                    
                                    <div class="form-group row">
                                    <asp:Label ID="Label20" AssociatedControlID="ddServerSpaceBytes" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Server Space:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:DropDownList CssClass="form-control" ID="ddServerSpaceBytes" SelectedValue='<%# Bind("ServerSpaceBytes") %>' runat="server">
                                            <asp:ListItem Text="None" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="5GB" Value="5368709120"></asp:ListItem>
                                            <asp:ListItem Text="10GB" Value="10737418240"></asp:ListItem>
                                            <asp:ListItem Text="15GB" Value="16106127360"></asp:ListItem>
                                            <asp:ListItem Text="20GB" Value="21474836480"></asp:ListItem>
                                            <asp:ListItem Text="25GB" Value="26843545600"></asp:ListItem>
                                            <asp:ListItem Text="30GB" Value="32212254720"></asp:ListItem>
                                            <asp:ListItem Text="40GB" Value="42949672960"></asp:ListItem>
                                            <asp:ListItem Text="50GB" Value="53687091200"></asp:ListItem>
                                            <asp:ListItem Text="60GB" Value="64424509440"></asp:ListItem>
                                            <asp:ListItem Text="70GB" Value="75161927680"></asp:ListItem>
                                            <asp:ListItem Text="80GB" Value="85899345920"></asp:ListItem>
                                            <asp:ListItem Text="90GB" Value="96636764160"></asp:ListItem>
                                            <asp:ListItem Text="100GB" Value="107374182400"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                    <div class="form-group row">
                                    <asp:Label ID="Label22" AssociatedControlID="ddSDelegateSpace" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Per Delegate Upload Space:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:DropDownList CssClass="form-control" ID="ddSDelegateSpace" SelectedValue='<%# Bind("CandidateByteLimit") %>' runat="server">
                                            <asp:ListItem Text="None" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="10MB" Value="10485760"></asp:ListItem>
                                            <asp:ListItem Text="25MB" Value="26214400"></asp:ListItem>
                                            <asp:ListItem Text="50MB" Value="52428800"></asp:ListItem>
                                            <asp:ListItem Text="100MB" Value="104857600"></asp:ListItem>
                                            <asp:ListItem Text="200MB" Value="209715200"></asp:ListItem>
                                            <asp:ListItem Text="500MB" Value="524288000"></asp:ListItem>
                                            <asp:ListItem Text="1GB" Value="1073741824"></asp:ListItem>
                                        </asp:DropDownList>
                                        
                                    </div>
                                </div>
                                    <div class="form-group row">
                                    <asp:Label ID="Label19" AssociatedControlID="bsdeContractReviewDate" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Contract Review Date:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <dx:BootstrapDateEdit ID="bsdeContractReviewDate" Value='<%# Bind("ContractReviewDate") %>' runat="server" DisplayFormatString="{0:d}"></dx:BootstrapDateEdit>
                                        <%--<asp:TextBox ID="tbContractReviewDate" CssClass="form-control" TextMode="Date" runat="server" Text='<%# Bind("ContractReviewDate", "{0:d}") %>' />--%>
                                    </div>
                                </div>
                                    </ContentTemplate></asp:UpdatePanel>
                                <asp:HiddenField ID="HiddenField2" runat="server" Value='<%# Bind("PriorCandidates") %>' />
                                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("AutoRegistered") %>' />
                                <asp:HiddenField ID="HiddenField3" runat="server" Value='<%# Bind("BetaTesting") %>' />

                            </div>

                        </div>
                        <div class="card-footer clearfix">
                            <asp:LinkButton ID="UpdateCancelButton" CssClass="btn btn-outline-secondary mr-auto" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                            <asp:LinkButton ID="UpdateButton" ValidationGroup="vgEditCentre" runat="server" CssClass="btn btn-primary float-right" CausesValidation="True" CommandName="Update" Text="Update" />
                            
                        </div>
                    </div>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <div class="card card-primary">
                        <div class="card-header">
                            <h3>Register New Centre</h3>
                        </div>
                        <div class="card-body">
                            <div class="m-3">
                                <div class="form-group row">
                                    <asp:Label ID="Label3" AssociatedControlID="tbCentreName" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Centre name:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:TextBox ID="tbCentreName" CssClass="form-control" runat="server" Text='<%# Bind("CentreName") %>' />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="tbCentreName" Display="Dynamic" runat="server" ValidationGroup="vgAddCentre" ErrorMessage="Required"></asp:RequiredFieldValidator>   
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label4" AssociatedControlID="tbContactForename" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Contact first name:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:TextBox ID="tbContactForename" CssClass="form-control" runat="server" Text='<%# Bind("ContactForename") %>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label5" AssociatedControlID="tbContactSurname" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Contact last name:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:TextBox ID="tbContactSurname" CssClass="form-control" runat="server" Text='<%# Bind("ContactSurname") %>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label6" AssociatedControlID="tbEmail" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Contact email:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:TextBox ID="tbEmail" CssClass="form-control" TextMode="Email" runat="server" Text='<%# Bind("ContactEmail") %>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label7" AssociatedControlID="tbPhone" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Contact phone:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:TextBox ID="tbPhone" CssClass="form-control" TextMode="Phone" runat="server" Text='<%# Bind("ContactTelephone") %>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label8" AssociatedControlID="ddCentreType" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Centre type:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:DropDownList ID="ddCentreType" runat="server" CssClass="form-control" AppendDataBoundItems="true" SelectedValue='<%# Bind("CentreTypeID") %>' DataSourceID="dsCentreTypes" DataTextField="CentreType" DataValueField="CentreTypeID">
                                            <asp:ListItem Selected="True" Text="Please select..." Value="0"></asp:ListItem>
                                            
                                        </asp:DropDownList><asp:CompareValidator ControlToValidate="ddCentreType" ValidationGroup="vgAddCentre" Display="Dynamic" ValueToCompare="0" Type="Integer"  runat="server" ErrorMessage="Select a Centre Type" Operator="GreaterThan"></asp:CompareValidator>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label9" AssociatedControlID="ddRegion" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Region:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:DropDownList ID="ddRegion" CssClass="form-control" AppendDataBoundItems="true" runat="server" SelectedValue='<%# Bind("RegionID") %>' DataSourceID="dsRegions" DataTextField="RegionName" DataValueField="RegionID">
                                            <asp:ListItem Selected="True" Text="Please select..." Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:CompareValidator ControlToValidate="ddRegion" ValueToCompare="0" ValidationGroup="vgAddCentre" Display="Dynamic" Type="Integer"  runat="server" ErrorMessage="Select a Region" Operator="GreaterThan"></asp:CompareValidator>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label10" AssociatedControlID="tbAutoRegEmail" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Registration email:</asp:Label>
                                    <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:TextBox ID="tbAutoRegEmail" placeholder="Email address of centre manager for registration" CssClass="form-control" TextMode="Email" runat="server" Text='<%# Bind("AutoRegisterManagerEmail") %>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label12" AssociatedControlID="cbAddCourses" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label">Add ITSP courses?</asp:Label>
                                     <div class="col col-sm-8 col-md-9 col-lg-10">
                                    <asp:CheckBox ID="cbAddCourses" runat="server" Checked='<%# Bind("AddCourses") %>' />
                                       </div>   

                            </div>

                        </div></div>
                        <div class="card-footer clearfix">
                            <asp:LinkButton ID="InsertCancelButton" CssClass="btn btn-outline-secondary mr-auto" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                            <asp:LinkButton ID="InsertButton" ValidationGroup="vgAddCentre" runat="server" CssClass="btn btn-primary float-right" CausesValidation="True" CommandName="Insert" Text="Insert" />
                            
                        </div>
                    </div>
                </InsertItemTemplate>

            </asp:FormView>
        </asp:View>
    </asp:MultiView>
      <!-- Modal -->
    <div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                   
                    <h5 class="modal-title" id="myModalLabel">
                        <asp:Label ID="lblModalHeading" runat="server" Text=""></asp:Label></h5> <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
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
