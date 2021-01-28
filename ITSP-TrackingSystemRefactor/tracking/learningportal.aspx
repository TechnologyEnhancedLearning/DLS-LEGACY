<%@ Page Title="Learning Portal" Language="vb" AutoEventWireup="false" MasterPageFile="~/tracking/Site.Master" CodeBehind="learningportal.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.learningportal" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="breadtray" runat="server">
   <ol class="breadcrumb breadcrumb-slash">
       <li class="breadcrumb-item"><a href="dashboard">Centre </a></li>
        <li  class="breadcrumb-item active">Learning Portal Configuration</li>
    </ol>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ObjectDataSource ID="dsCentreLP" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.CentresKBTableAdapter" UpdateMethod="UpdateCentreKB">
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="kbPassword" Type="String" />
            <asp:Parameter Name="kbLoginPrompt" Type="String" />
            <asp:Parameter Name="kbSelfRegister" Type="Boolean" />
            <asp:Parameter Name="kbContact" Type="String" />
            <asp:Parameter Name="kbYouTube" Type="Boolean" />
            <asp:Parameter Name="kbDefaultOfficeVersion" Type="Int32" />
            <asp:Parameter Name="Original_CentreID" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsBrands" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetByCentreID" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.BrandsTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsCategories" runat="server"  OldValuesParameterFormatString="original_{0}" SelectMethod="GetActiveForCentre" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.CourseCategoriesTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
            <asp:Parameter Name="IsSuperAdmin" Type="Boolean" DefaultValue="False" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsKBUsage" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetKBUsageData" TypeName="ITSP_TrackingSystemRefactor.knowledgebankdataTableAdapters.KBUsageTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="CandidateDataSource" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetCandidate" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.CandidatesTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CandidateID" SessionField="KBCID" Type="Int32" />
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsSearches" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.knowledgebankdataTableAdapters.kbSearchesTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CandidateID" SessionField="KBCID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsVideos" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.knowledgebankdataTableAdapters.kbVideosTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CandidateID" SessionField="KBCID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsTutorials" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.knowledgebankdataTableAdapters.kbTutorialsTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CandidateID" SessionField="KBCID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsYouTube" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.knowledgebankdataTableAdapters.kbYouTubeTrackTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CandidateID" SessionField="KBCID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
            <asp:FormView ID="fvCentreKB" DataSourceID="dsCentreLP" DataKeyNames="CentreID" RenderOuterTable="false" DefaultMode="ReadOnly" runat="server">
                <EditItemTemplate>
                    <div class="card card-primary">
                        <div class="card-header">
                            <h4>Edit Centre Learning Portal Configuration</h4>
                        </div>
                        <div class="card-body">
                            <div class="form m-3">
                                <asp:HiddenField ID="HiddenField1" Value='<%# Bind("kbPassword") %>' runat="server" />
                               
                                <div class="form-group row">
                                    <asp:Label ID="Label2" CssClass="col col-sm-4 control-label" runat="server">Custom Login Prompt (optional - default &quot;User ID&quot;):</asp:Label>


                                    <div class="col col-sm-8">
                                        <asp:TextBox CssClass="form-control" ID="tbLoginPrompt" runat="server" Text='<%# Bind("kbLoginPrompt") %>' />
                                    </div>
                                </div>
                                  <div class="form-group row">
                                    <asp:Label ID="Label1" CssClass="col col-sm-4 control-label" runat="server">Brands EXCLUDED from Knowledge Bank searches:</asp:Label>

                                     
                                    <div class="col col-sm-8">
                                         <dx:BootstrapListBox ID="bslbBrands"  DataSourceID="dsBrands" TextField="BrandName" ValueField="BrandID" runat="server" SelectionMode="CheckColumn"></dx:BootstrapListBox>
                                    </div>
                                </div>
                                  <div class="form-group row">
                                    <asp:Label ID="Label3" CssClass="col col-sm-4 control-label" runat="server">Categories EXCLUDED from Knowledge Bank searches:</asp:Label>

                                      
                                    <div class="col col-sm-8">
                                        <dx:BootstrapListBox ID="bslCategories"  DataSourceID="dsCategories"  TextField="CategoryName" ValueField="CourseCategoryID"  runat="server" SelectionMode="CheckColumn"></dx:BootstrapListBox>
                                    </div>
                                </div>
                                <asp:HiddenField ID="HiddenField2" Value='<%# Bind("kbSelfRegister") %>' runat="server" />
                                <asp:HiddenField ID="HiddenField3" Value='<%# Bind("kbContact") %>' runat="server" />
                                <div class="form-group row">
                                    <asp:Label ID="Label5" CssClass="col col-sm-4 control-label" runat="server" Text=" Allow YouTube Searching in Knowledge Bank:"></asp:Label>
                                    <div class="col col-sm-8">
                                        <asp:CheckBox ID="cbYouTube" runat="server" Checked='<%# Bind("kbYouTube") %>' />
                                    </div>
                                </div>
                                <asp:HiddenField ID="HiddenField4" Value='<%# Bind("kbDefaultOfficeVersion") %>' runat="server" />
                                

                            </div>
                        </div>
                        <div class="card-footer clearfix">
                            <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False"
                                CommandName="Cancel" CssClass="btn btn-outline-secondary mr-auto"><i aria-hidden="true" class="fas fa-times"></i> Cancel</asp:LinkButton>
                            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                                CssClass="btn btn-primary float-right"><i aria-hidden="true" class="fas fa-check"></i> Update</asp:LinkButton>
                            
                        </div>
                    </div>


                </EditItemTemplate>
                <ItemTemplate>
                    <div class="card card-default">
                        <div class="card-header clearfix">
                            <h4>Centre Learning Portal Configuration 
                            <div class="btn-group float-right" role="group" aria-label="...">
                                <asp:LinkButton ID="lbtLaunchLearningPortal" CssClass="btn btn-outline-secondary" runat="server"><i aria-hidden="true" class="fas fa-link"></i> Launch Learning Portal</asp:LinkButton>
                                <asp:HyperLink ID="lbtSendLPMessage" CssClass="btn btn-outline-secondary" runat="server"><i aria-hidden="true" class="fas fa-envelope"></i> Generate Link Email</asp:HyperLink>
                            </div>
                            </h4>
                        </div>
                        <div class="card-body">
                            <div class="form m-3">
                                
                                <div class="form-group row">
                                    <asp:Label ID="Label2" CssClass="col col-sm-4 control-label" runat="server">Custom Login Prompt (optional - default &quot;User ID&quot;):</asp:Label>


                                    <div class="col col-sm-8">
                                        <asp:TextBox Enabled="false" CssClass="form-control" ID="tbLoginPrompt_RO" runat="server" Text='<%# Eval("kbLoginPrompt") %>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label1" CssClass="col col-sm-4 control-label" runat="server">Brands EXCLUDED from Knowledge Bank searches:</asp:Label>

                                      
                                    <div class="col col-sm-8">
                                        <dx:BootstrapListBox ID="bslbBrands" Enabled="false"  DataSourceID="dsBrands" TextField="BrandName" ValueField="BrandID" runat="server" SelectionMode="CheckColumn"></dx:BootstrapListBox>
                                    </div>
                                </div>
                                  <div class="form-group row">
                                    <asp:Label ID="Label3" CssClass="col col-sm-4 control-label" runat="server">Categories EXCLUDED from Knowledge Bank searches:</asp:Label>

                                      
                                    <div class="col col-sm-8">
                                        <dx:BootstrapListBox ID="bslCategories" Enabled="false"  DataSourceID="dsCategories"  TextField="CategoryName" ValueField="CourseCategoryID"  runat="server" SelectionMode="CheckColumn"></dx:BootstrapListBox>
                                    </div>
                                </div>
                               
                                <div class="form-group row">
                                    <asp:Label ID="Label5" CssClass="col col-sm-4 control-label" runat="server" Text=" Allow YouTube Searching in Knowledge Bank:"></asp:Label>
                                    <div class="col col-sm-8">
                                        <asp:CheckBox Enabled="false" ID="cbYouTube" runat="server" Checked='<%# Eval("kbYouTube") %>' />
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                        <div class="card-footer clearfix">
                            <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                                CssClass="btn btn-primary float-right"><i aria-hidden="true" class="fas fa-pencil-alt"></i> Edit</asp:LinkButton>
                        </div>
                    </div>

                </ItemTemplate>
            </asp:FormView>
            <div class="card card-default">
                <div class="card-header clearfix">
                    <h4>Knowledge Bank Usage
                            
                    </h4>
                </div>
                <div class="card-body">
                    <dx:ASPxGridViewExporter ID="bsGridViewExporter" GridViewID="bsgvKBUsage" FileName="DLS Knowledge Bank Usage" runat="server"></dx:ASPxGridViewExporter>
                    <dx:BootstrapGridView ID="bsgvKBUsage" runat="server" AutoGenerateColumns="False" DataSourceID="dsKBUsage" KeyFieldName="CandidateID" SettingsBootstrap-Striped="True" SettingsBootstrap-Sizing="NotSet" SettingsDetail-ShowDetailRow="True" SettingsDetail-AllowOnlyOneMasterRowExpanded="True" OnToolbarItemClick="GridViewCustomToolbar_ToolbarItemClick" Settings-ShowFooter="True">
                        <Settings ShowFooter="True" />
                         <SettingsCookies Enabled="True" Version="0.123" />
                        <SettingsBootstrap Striped="True" />

                        <Columns>
                            <dx:BootstrapGridViewTextColumn FieldName="CandidateNumber" Name="Delegate ID" Caption="Delegate ID" VisibleIndex="0">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Name" ReadOnly="True" VisibleIndex="1">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Searches" CssClasses-FooterCell="text-center" HorizontalAlign="Center" ReadOnly="True" VisibleIndex="2">
                              
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="VideosLaunched" CssClasses-FooterCell="text-center" HorizontalAlign="Center" ReadOnly="True" VisibleIndex="3">
                             
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="TutorialsViewed" CssClasses-FooterCell="text-center" HorizontalAlign="Center" ReadOnly="True" VisibleIndex="4">
                              
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="YouTubeVideosWatched" CssClasses-FooterCell="text-center" HorizontalAlign="Center" ReadOnly="True" VisibleIndex="5">
                              
                            </dx:BootstrapGridViewTextColumn>


                        </Columns>
                        <TotalSummary>
                            <dx:ASPxSummaryItem FieldName="Searches" DisplayFormat="Total: {0}" SummaryType="Sum"  />
                            <dx:ASPxSummaryItem FieldName="VideosLaunched" DisplayFormat="Total: {0}" SummaryType="Sum" />
                            <dx:ASPxSummaryItem FieldName="TutorialsViewed" DisplayFormat="Total: {0}" SummaryType="Sum" />
                            <dx:ASPxSummaryItem FieldName="YouTubeVideosWatched" DisplayFormat="Total: {0}" SummaryType="Sum" />
                        </TotalSummary>
                        <Templates>
                            <DetailRow>
                                <dx:BootstrapPageControl TabAlign="Justify" ID="bspcDetailRow" runat="server" EnableCallBacks="true" EnableCallbackAnimation="true">
                                    <TabPages>
                                        <dx:BootstrapTabPage Text="Searches">
                                            <ContentCollection>
                                                <dx:ContentControl runat="server" SupportsDisabledAttribute="True">
                                                    <dx:BootstrapGridView ID="bsgvSearches" OnBeforePerformDataSelect="detailGrid_DataSelect" runat="server" AutoGenerateColumns="False" DataSourceID="dsSearches">
                                                        <SettingsBootstrap Striped="True" />

                                                        <Columns>
                                                            <dx:BootstrapGridViewDateColumn FieldName="SearchDate" VisibleIndex="0">
                                                            </dx:BootstrapGridViewDateColumn>
                                                            <%--<dx:BootstrapGridViewTextColumn FieldName="OfficeVersionFilter" ReadOnly="True" VisibleIndex="1">
                                                            </dx:BootstrapGridViewTextColumn>
                                                            <dx:BootstrapGridViewTextColumn FieldName="ApplicationFilter" ReadOnly="True" VisibleIndex="2">
                                                            </dx:BootstrapGridViewTextColumn>
                                                            <dx:BootstrapGridViewTextColumn FieldName="LevelFilter" ReadOnly="True" VisibleIndex="3">
                                                            </dx:BootstrapGridViewTextColumn>--%>
                                                            <dx:BootstrapGridViewTextColumn FieldName="SearchTerm" ReadOnly="True" VisibleIndex="4">
                                                            </dx:BootstrapGridViewTextColumn>
                                                            <dx:BootstrapGridViewCheckColumn FieldName="ReportedPoor" VisibleIndex="5">
                                                            </dx:BootstrapGridViewCheckColumn>
                                                        </Columns>
                                                    </dx:BootstrapGridView>
                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:BootstrapTabPage>
                                        <dx:BootstrapTabPage Text="Videos Viewed">
                                            <ContentCollection>
                                                <dx:ContentControl runat="server" SupportsDisabledAttribute="True">
                                                    <dx:BootstrapGridView ID="bsgvVideos" runat="server" AutoGenerateColumns="False" DataSourceID="dsVideos">
                                                        <SettingsBootstrap Striped="True" />
                                                        <Columns>
                                                            <dx:BootstrapGridViewDateColumn FieldName="ViewedDate" VisibleIndex="0">
                                                            </dx:BootstrapGridViewDateColumn>
                                                            <dx:BootstrapGridViewTextColumn FieldName="Course" VisibleIndex="1">
                                                            </dx:BootstrapGridViewTextColumn>
                                                            <dx:BootstrapGridViewTextColumn FieldName="Section" VisibleIndex="2">
                                                            </dx:BootstrapGridViewTextColumn>
                                                            <dx:BootstrapGridViewTextColumn FieldName="Video" VisibleIndex="3">
                                                            </dx:BootstrapGridViewTextColumn>
                                                        </Columns>
                                                    </dx:BootstrapGridView>
                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:BootstrapTabPage>
                                        <dx:BootstrapTabPage Text="Tutorials Viewed">
                                            <ContentCollection>
                                                <dx:ContentControl runat="server" SupportsDisabledAttribute="True">
                                                    <dx:BootstrapGridView ID="bsgvTutorials" runat="server" AutoGenerateColumns="False" DataSourceID="dsTutorials">
                                                        <SettingsBootstrap Striped="True" />
                                                        <Columns>
                                                            <dx:BootstrapGridViewDateColumn FieldName="LaunchDate" VisibleIndex="0">
                                                            </dx:BootstrapGridViewDateColumn>
                                                            <dx:BootstrapGridViewTextColumn FieldName="Course" VisibleIndex="1">
                                                            </dx:BootstrapGridViewTextColumn>
                                                            <dx:BootstrapGridViewTextColumn FieldName="Section" VisibleIndex="2">
                                                            </dx:BootstrapGridViewTextColumn>
                                                            <dx:BootstrapGridViewTextColumn FieldName="Tutorial" VisibleIndex="3">
                                                            </dx:BootstrapGridViewTextColumn>
                                                        </Columns>
                                                    </dx:BootstrapGridView>
                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:BootstrapTabPage>
                                        <dx:BootstrapTabPage Text="YouTube Videos Viewed">
                                            <ContentCollection>
                                                <dx:ContentControl runat="server" SupportsDisabledAttribute="True">
                                                    <dx:BootstrapGridView ID="bsgvYouTube" runat="server" AutoGenerateColumns="False" DataSourceID="dsYouTube">
                                                        <SettingsBootstrap Striped="True" />
                                                        <Columns>
                                                            <dx:BootstrapGridViewDateColumn FieldName="LaunchDateTime" VisibleIndex="0">
                                                            </dx:BootstrapGridViewDateColumn>
                                                            <dx:BootstrapGridViewTextColumn FieldName="YouTubeURL" VisibleIndex="1">
                                                            </dx:BootstrapGridViewTextColumn>
                                                            <dx:BootstrapGridViewTextColumn FieldName="VidTitle" VisibleIndex="2">
                                                            </dx:BootstrapGridViewTextColumn>
                                                        </Columns>
                                                    </dx:BootstrapGridView>
                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:BootstrapTabPage>
                                    </TabPages>
                                </dx:BootstrapPageControl>

                            </DetailRow>
                        </Templates>
                        <ClientSideEvents ToolbarItemClick="onToolbarItemClick" />
                        <Toolbars>
        <dx:BootstrapGridViewToolbar Position="Top">
            <Items>
                <dx:BootstrapGridViewToolbarItem Command="ClearSorting" IconCssClass="fas fa-sort" />
                <dx:BootstrapGridViewToolbarItem Command="ClearFilter" />
                <dx:BootstrapGridViewToolbarItem Command="ShowCustomizationDialog" Text="Customise Grid"/>
                    <dx:BootstrapGridViewToolbarItem Command="Custom" Name="ExcelExport" Text="Excel Export" IconCssClass="fas fa-file-export" />                
            </Items>
        </dx:BootstrapGridViewToolbar>
    </Toolbars>
                        
                         <SettingsCustomizationDialog Enabled="True" ShowGroupingPage="False" />
                        <SettingsSearchPanel Visible="True" AllowTextInputTimer="false" />
                        <SettingsDetail ShowDetailRow="True" />

                    </dx:BootstrapGridView>
                </div>
            </div>

</asp:Content>
