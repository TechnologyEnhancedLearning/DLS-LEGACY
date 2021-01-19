<%@ Page Title="Framework Assessment Report" Language="vb" AutoEventWireup="false" EnableEventValidation="false" MasterPageFile="~/tracking/Site.Master" CodeBehind="reportfwa.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.reportfwa" %>
<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="breadtray" runat="server">
     <script src="https://www.gstatic.com/charts/loader.js"></script>
      <ol class="breadcrumb breadcrumb-slash">
       <li class="breadcrumb-item"><a href="dashboard">Centre </a></li>
          <li class="breadcrumb-item"><a href="reports">Reports </a></li>
        <li  class="breadcrumb-item active">Framework Assessment Report</li>
    </ol>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <dx:BootstrapPageControl EnableViewState="false" ID="bspcFWAReport" TabIndex="0" runat="server" SettingsLoadingcard-Enabled="true" TabAlign="Justify" EnableCallBacks="true" EnableCallbackAnimation="true" ActiveTabIndex="0">
        <CssClasses Content="bstc-content" />
        <TabPages>
            <dx:BootstrapTabPage Text="Self Assessment Dashboard">
                <ContentCollection>
                    <dx:ContentControl>

                        <asp:ObjectDataSource ID="dsBrands" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataForSA" TypeName="ITSP_TrackingSystemRefactor.ITSPStatsTableAdapters.BrandsForCentreTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="dsCategories" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataForSA" TypeName="ITSP_TrackingSystemRefactor.ITSPStatsTableAdapters.CourseCategoriesForCentreTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="dsTopics" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataForSA" TypeName="ITSP_TrackingSystemRefactor.ITSPStatsTableAdapters.CourseTopicsForCentreTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="dsApplications" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataForSA" TypeName="ITSP_TrackingSystemRefactor.ITSPStatsTableAdapters.ApplicationsForCentreTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                                <asp:ControlParameter ControlID="ddBrand" DefaultValue="0" Name="BrandID" PropertyName="SelectedValue" Type="Int32" />
                                <asp:ControlParameter ControlID="ddCategory" DefaultValue="0" Name="CategoryID" PropertyName="SelectedValue" Type="Int32" />
                                <asp:ControlParameter ControlID="ddTopic" DefaultValue="0" Name="TopicID" PropertyName="SelectedValue" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="dsSections" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataForSA" TypeName="ITSP_TrackingSystemRefactor.ITSPStatsTableAdapters.SectionsForCentreTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                                <asp:ControlParameter ControlID="ddApplication" DefaultValue="0" Name="ApplicationID" PropertyName="SelectedValue" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="dsTutorials" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataForSA" TypeName="ITSP_TrackingSystemRefactor.ITSPStatsTableAdapters.TutorialsForCentreTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                                <asp:ControlParameter ControlID="ddSection" DefaultValue="" Name="SectionName" PropertyName="SelectedValue" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="dsJobGroups" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPStatsTableAdapters.JobGroupsForCentreTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="dsAnswers1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPStatsTableAdapters.CustomFieldResponsesTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="0" Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                                <asp:Parameter DefaultValue="1" Name="FieldNum" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="dsAnswers2" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPStatsTableAdapters.CustomFieldResponsesTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="0" Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                                <asp:Parameter DefaultValue="2" Name="FieldNum" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="dsAnswers3" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPStatsTableAdapters.CustomFieldResponsesTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="0" Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                                <asp:Parameter DefaultValue="3" Name="FieldNum" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="dsAnswers4" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPStatsTableAdapters.CustomFieldResponsesTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="0" Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                                <asp:Parameter DefaultValue="4" Name="FieldNum" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="dsAnswers5" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPStatsTableAdapters.CustomFieldResponsesTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="0" Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                                <asp:Parameter DefaultValue="5" Name="FieldNum" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="dsAnswers6" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPStatsTableAdapters.CustomFieldResponsesTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="0" Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                                <asp:Parameter DefaultValue="6" Name="FieldNum" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <div class="row">
                <div class="col col-lg-12">
                    <div class="card card-default">
                        <div class="card-header clearfix">
                            <div class="form-header">
                                            <h5>Report Filters</h5>
                                        </div>
                                      
                            <div class="row">
                                <div class="col col-lg-10">
                                   
                                    
                                    <div class="row">
                                        <div class="col-12">
                                             <div class="form-inline small">
<div class="form-group m-1">
                                            <asp:Label ID="Label10" AssociatedControlID="ddJobGroupID" runat="server" CssClass="filter-col " Text="Job group:"></asp:Label>
                                            <asp:DropDownList CssClass="form-control input-sm" ID="ddJobGroupID" AppendDataBoundItems="true" runat="server" DataSourceID="dsJobGroups" DataTextField="JobGroupName" DataValueField="JobGroupID">
                                                <asp:ListItem Value="-1">Any</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                                 <asp:Panel ID="pnlAnswer1" CssClass="form-group m-1" runat="server">
<asp:Label ID="lblA1" AssociatedControlID="ddAnswer1" runat="server" CssClass="filter-col " Text="Job group:"></asp:Label>
                                            <asp:DropDownList CssClass="form-control input-sm" ID="ddAnswer1" EnableViewState="true" AppendDataBoundItems="true" runat="server" DataSourceID="dsAnswers1" DataTextField="Response" DataValueField="ResponseID">
                                                 <asp:ListItem Value="-1">Any</asp:ListItem>
                                            </asp:DropDownList>
                                                 </asp:Panel>
                                                 <asp:Panel ID="pnlAnswer2" CssClass="form-group m-1" runat="server">
<asp:Label ID="lblA2" AssociatedControlID="ddAnswer2" runat="server" CssClass="filter-col " Text="Job group:"></asp:Label>
                                            <asp:DropDownList CssClass="form-control input-sm" ID="ddAnswer2" AppendDataBoundItems="true" runat="server" DataSourceID="dsAnswers2" DataTextField="Response" DataValueField="ResponseID">
                                                <asp:ListItem Value="-1">Any</asp:ListItem>
                                            </asp:DropDownList>
                                                 </asp:Panel>
                                                 <asp:Panel ID="pnlAnswer3" CssClass="form-group m-1" runat="server">
<asp:Label ID="lblA3" AssociatedControlID="ddAnswer3" runat="server" CssClass="filter-col " Text="Job group:"></asp:Label>
                                            <asp:DropDownList CssClass="form-control input-sm" ID="ddAnswer3" AppendDataBoundItems="true" runat="server" DataSourceID="dsAnswers3" DataTextField="Response" DataValueField="ResponseID">
                                                <asp:ListItem Value="-1">Any</asp:ListItem>
                                            </asp:DropDownList>
                                                 </asp:Panel>
                                                 <asp:Panel ID="pnlAnswer4" CssClass="form-group m-1" runat="server">
<asp:Label ID="lblA4" AssociatedControlID="ddAnswer4" runat="server" CssClass="filter-col " Text="Job group:"></asp:Label>
                                            <asp:DropDownList CssClass="form-control input-sm" ID="ddAnswer4" AppendDataBoundItems="true" runat="server" DataSourceID="dsAnswers4" DataTextField="Response" DataValueField="ResponseID">
                                                <asp:ListItem Value="-1">Any</asp:ListItem>
                                            </asp:DropDownList>
                                                 </asp:Panel>
                                                 <asp:Panel ID="pnlAnswer5" CssClass="form-group m-1" runat="server">
<asp:Label ID="lblA5" AssociatedControlID="ddAnswer5" runat="server" CssClass="filter-col " Text="Job group:"></asp:Label>
                                            <asp:DropDownList CssClass="form-control input-sm" ID="ddAnswer5" AppendDataBoundItems="true" runat="server" DataSourceID="dsAnswers5" DataTextField="Response" DataValueField="ResponseID">
                                                <asp:ListItem Value="-1">Any</asp:ListItem>
                                            </asp:DropDownList>
                                                 </asp:Panel>
                                                 <asp:Panel ID="pnlAnswer6" CssClass="form-group m-1" runat="server">
<asp:Label ID="lblA6" AssociatedControlID="ddAnswer6" runat="server" CssClass="filter-col " Text="Job group:"></asp:Label>
                                            <asp:DropDownList CssClass="form-control input-sm" ID="ddAnswer6" AppendDataBoundItems="true" runat="server" DataSourceID="dsAnswers6" DataTextField="Response" DataValueField="ResponseID">
                                                <asp:ListItem Value="-1">Any</asp:ListItem>
                                            </asp:DropDownList>
                                                 </asp:Panel>

                                                 </div>
                                        </div>
                                        </div>
                                        <div class="row">
                                        <div class="col-12">
 <%--<asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Always" RenderMode="Block" ChildrenAsTriggers="true" runat="server"><ContentTemplate>--%>
<div class="form-inline small">
                                        
                                        
                                            
                                        <div class="form-group m-1">
                                            <asp:Label ID="Label18" AssociatedControlID="ddBrand" runat="server" CssClass="filter-col " Text="Brand:"></asp:Label>
                                            <asp:DropDownList CssClass="form-control input-sm" ID="ddBrand" AutoPostBack="true" AppendDataBoundItems="True" runat="server" DataSourceID="dsBrands" DataTextField="BrandName" DataValueField="BrandID">
<asp:ListItem Value="-1">Any</asp:ListItem>
                                            </asp:DropDownList>


                                        </div>

                                        <div class="form-group m-1">
                                            <asp:Label ID="Label19" AssociatedControlID="ddCategory" runat="server" CssClass="filter-col " Text="Category:"></asp:Label>
                                            <asp:DropDownList CssClass="form-control input-sm" ID="ddCategory" AutoPostBack="true" runat="server"  AppendDataBoundItems="True" DataSourceID="dsCategories" DataTextField="CategoryName"
                                                DataValueField="CourseCategoryID">
                                                <asp:ListItem  Value="-1">Any</asp:ListItem>
                                            </asp:DropDownList>


                                        </div>
                                        
                                         <div class="form-group m-1">
                                            <asp:Label ID="Label1" AssociatedControlID="ddTopic" runat="server" CssClass="filter-col" Text="Topic:"></asp:Label>
                                            <asp:DropDownList AppendDataBoundItems="True" CssClass="form-control input-sm" ID="ddTopic" AutoPostBack="true" runat="server" DataSourceID="dsTopics" DataTextField="CourseTopic" DataValueField="CourseTopicID">
                                                <asp:ListItem Value="-1">Any</asp:ListItem>
                                            </asp:DropDownList>

                                        </div>
                                        <div class="form-group m-1">
                                            <asp:Label ID="Label2" AssociatedControlID="ddApplication" runat="server" CssClass="filter-col" Text="Course:"></asp:Label>
                                            <asp:DropDownList AppendDataBoundItems="True" CssClass="form-control input-sm" ID="ddApplication" AutoPostBack="true" runat="server" DataSourceID="dsApplications" DataTextField="ApplicationName" DataValueField="ApplicationID">
                                                <asp:ListItem Value="-1">Any</asp:ListItem>
                                            </asp:DropDownList>

                                        </div>
                                        <div class="form-group m-1">
                                            <asp:Label ID="Label3" AssociatedControlID="ddSection" runat="server" CssClass="filter-col" Text="Section:"></asp:Label>
                                            <asp:DropDownList AppendDataBoundItems="True" CssClass="form-control input-sm" ID="ddSection" AutoPostBack="true" runat="server" DataSourceID="dsSections" DataTextField="SectionName" DataValueField="SectionName">
                                                <asp:ListItem Value="Any">Any</asp:ListItem>
                                            </asp:DropDownList>

                                        </div>
                                        <div class="form-group m-1">
                                            <asp:Label ID="Label21" AssociatedControlID="ddSkill" runat="server" CssClass="filter-col " Text="Skill:"></asp:Label>
                                            <asp:DropDownList CssClass="form-control input-sm" ID="ddSkill" AppendDataBoundItems="true" runat="server" DataSourceID="dsTutorials" DataTextField="TutorialName" DataValueField="TutorialName">
                                                <asp:ListItem Value="Any">Any</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                     
                                        <div id="daterange" class="form-group m-1">
                                            <asp:Label ID="Label22" AssociatedControlID="tbStartDate" runat="server" CssClass="filter-col " Text="Date range:"></asp:Label>
                                            <div class="input-group">


                                                <asp:TextBox ID="tbStartDate" CssClass="form-control input-sm pick-date" placeholder="Start date" runat="server"></asp:TextBox>

                                                <span class="input-group-append input-group-prepend"><span class="input-group-text">to</span></span>
                                                <asp:TextBox ID="tbEndDate" CssClass="form-control input-sm pick-date" runat="server" placeholder="End date"></asp:TextBox>
                                            </div>

                                        </div>
                                        <div class="form-group m-1">
                                            <asp:CheckBox ID="cbSVVerified" runat="server" CssClass="filter-col" Text="Supervisor Verified Only?" />
                                        </div>

     
                                    </div><%--</ContentTemplate></asp:UpdatePanel>--%>
                                </div></div> 
                                        
                                    </div>
                                    
                                <div class="col col-lg-2">
                                    <div class="form small">
<div class="form-group m-1">
                                            <asp:CheckBox ID="cbStacked" runat="server" CssClass="filter-col" Text=" stacked bar" />
                                        </div>
     <div class="form-group m-1">
                                            <asp:CheckBox ID="cbPies" runat="server" CssClass="filter-col" Text=" donut" />
                                        </div>
                                        </div>
                                    <asp:LinkButton CssClass="btn btn-lg btn-block btn-primary" ID="lbtUpdateDashFilter" ToolTip="Apply selected filters" runat="server" CausesValidation="False" CommandName="Filter"><i aria-hidden="true" class="fas fa-filter"></i> Update</asp:LinkButton>

                                </div>
                            </div>


                        </div>
                        <div class="card-body">
                            <h6>
                                <asp:Label ID="lblMatchingDelegates" runat="server"></asp:Label></h6>
                        <div class="row">
                            <asp:Panel ID="pnlStacked" CssClass="col-sm-12" runat="server">
                            <div class="card card-default mb-1"><div class="card-header">
                                    <div class="font-weight-bolder">Self Assessment Responses by Skill</div>
                                                                 </div>
                                <div id="sa-stacked" style="height: 400px;"></div></div>
                            </asp:Panel>
                        <asp:Repeater ID="rptPies" runat="server">
                            <ItemTemplate>
                                <div class="col-md-4 col-lg-3 col-sm-6"><div class="card card-default mb-1"><div class="card-header">
                                    <div class="font-weight-bolder"><%# Eval("Skill") %></div>
                                                                 </div>
                                <div id="eval-chart-<%# StripChars(Eval("Skill").ToString) %>" style="height: 215px;"></div></div>
                            </div>
                            </ItemTemplate>
                        </asp:Repeater>
                            </div></div>
                        <div class="card-footer clearfix">
                            <asp:LinkButton ID="lbtExportDashStats" CssClass="btn btn-outline-secondary float-right" runat="server"><i aria-hidden="true" class="fas fa-file-export"></i> Download to Excel</asp:LinkButton>

                        </div>
                    </div>
                </div>
            </div>
                            
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:BootstrapTabPage>
            <dx:BootstrapTabPage Text="Management Detail">
                <ContentCollection>
                    <dx:ContentControl>
     <div class="row">
                <div class="col col-lg-12">
                    <div class="card card-default">
             <asp:ObjectDataSource ID="dsSAReport" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPStatsTableAdapters.SAReportTableAdapter">
                 <SelectParameters>
                     <asp:SessionParameter DefaultValue="0" Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                 </SelectParameters>
             </asp:ObjectDataSource>

             <dx:ASPxGridViewExporter ID="bsgvExporter" FileName="DLS Assessment Framework Report" GridViewID="bsgvSAReport" runat="server"></dx:ASPxGridViewExporter>
               <dx:BootstrapGridView ID="bsgvSAReport" runat="server" CssClasses-Control="mt-1" AutoGenerateColumns="False" DataSourceID="dsSAReport" KeyFieldName="aspProgressID" SettingsCustomizationDialog-Enabled="True" OnToolbarItemClick="GridViewCustomToolbar_ToolbarItemClick" SettingsBootstrap-Sizing="Small" SettingsCookies-StoreGroupingAndSorting="False">
        <CssClasses Table="table table-striped table-condensed small" />

        <SettingsBootstrap Sizing="Small"></SettingsBootstrap>

        <Settings ShowHeaderFilterButton="True" />
                   <SettingsBehavior AutoExpandAllGroups="True" />
        <SettingsCookies Enabled="True" Version="0.1" />
        <SettingsPager PageSize="100">
        </SettingsPager>
        <Columns>
            
            <dx:BootstrapGridViewTextColumn FieldName="Activity" GroupIndex="0" ReadOnly="True" VisibleIndex="0">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="Delegate" ReadOnly="True"  GroupIndex="1" VisibleIndex="1">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewDateColumn FieldName="Enrolled" Visible="False" VisibleIndex="2">
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewDateColumn Caption="Last Access" Visible="false" FieldName="LastAccessed" VisibleIndex="3">
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewTextColumn Caption="Section" Visible="false" FieldName="SectionName" VisibleIndex="4">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Skill" FieldName="TutorialName" VisibleIndex="5">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewDateColumn Caption="Self Assessed" FieldName="LastReviewed" VisibleIndex="6">
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewDateColumn Caption="Verified" FieldName="SupervisorVerifiedDate" VisibleIndex="7">
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewTextColumn Caption="Reg Prompt 1" FieldName="Answer1" Visible="False" VisibleIndex="8">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Reg Prompt 2" FieldName="Answer2" Visible="False" VisibleIndex="9">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Reg Prompt 3" FieldName="Answer3" Visible="False" VisibleIndex="10">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Reg Prompt 4" FieldName="Answer4" Visible="False" VisibleIndex="11">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Reg Prompt 5" FieldName="Answer5" Visible="False" VisibleIndex="12">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Reg Prompt 6" FieldName="Answer6" Visible="False" VisibleIndex="13">
            </dx:BootstrapGridViewTextColumn>
        </Columns>

        <Toolbars>
            <dx:BootstrapGridViewToolbar Position="Top">
                <Items>
                    <%--<dx:BootstrapGridViewToolbarItem Command="ClearGrouping" IconCssClass="far fa-caret-square-o-down" />--%>
                    <dx:BootstrapGridViewToolbarItem Command="ClearGrouping" IconCssClass="far fa-caret-square-down" />
                    <dx:BootstrapGridViewToolbarItem Command="ClearSorting" IconCssClass="fas fa-sort" />
                    <dx:BootstrapGridViewToolbarItem Command="ClearFilter" />
                    <dx:BootstrapGridViewToolbarItem Command="ShowCustomizationDialog" Text="Customise Grid" />
                    <dx:BootstrapGridViewToolbarItem Command="Custom" Name="ExcelExport" Text="Excel Export" BeginGroup="true" IconCssClass="fas fa-file-export" SettingsBootstrap-RenderOption="Success" >
<SettingsBootstrap RenderOption="Success"></SettingsBootstrap>
                    </dx:BootstrapGridViewToolbarItem>
                </Items>
            </dx:BootstrapGridViewToolbar>
        </Toolbars>
        <ClientSideEvents ToolbarItemClick="onToolbarItemClick" />

        <SettingsCustomizationDialog Enabled="True"></SettingsCustomizationDialog>

        <SettingsSearchPanel Visible="True" AllowTextInputTimer="false" />
    </dx:BootstrapGridView>
                        </div></div></div>
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:BootstrapTabPage>
            </TabPages>
         </dx:BootstrapPageControl>
</asp:Content>
