<%@ Page Title="Supervise" Language="vb" AutoEventWireup="false" MasterPageFile="~/tracking/Site.Master" CodeBehind="supervise.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.supervise" %>

<%@ Register Assembly="DevExpress.Web.ASPxScheduler.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxScheduler" TagPrefix="dxwschs" %>

<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Src="~/controls/filemx.ascx" TagPrefix="uc1" TagName="filemx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="breadtray" runat="server">
    <link href="../Content/resources.css" rel="stylesheet" />
    <ol class="breadcrumb breadcrumb-slash">
        <li class="breadcrumb-item active">Supervise</li>
    </ol>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <asp:MultiView ID="mvSupervise" runat="server" ActiveViewIndex="0">
        <asp:View ID="vSupervisionGrid" runat="server">
           
 <asp:ObjectDataSource ID="dsSupervise" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.SuperviseDataTableAdapters.ProgressTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="SAdminID" SessionField="UserAdminID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>

      <div class="table-responsive">
        <dx:ASPxGridViewExporter ID="DelegateGridViewExporter" GridViewID="bsgvSuperviseDelegates" FileName="DLS Supervised Delegates" runat="server"></dx:ASPxGridViewExporter>
    <dx:BootstrapGridView ID="bsgvSuperviseDelegates" runat="server"  SettingsCustomizationDialog-Enabled="True" OnToolbarItemClick="GridViewCustomToolbar_ToolbarItemClick" AutoGenerateColumns="False" DataSourceID="dsSupervise" KeyFieldName="ProgressID">
            <SettingsBootstrap  Striped="True" />
            <Settings GridLines="None" ShowHeaderFilterButton="True" />
            <SettingsCookies Enabled="True" Version="0.1" />
            <SettingsPager PageSize="15">
            </SettingsPager>
            <Columns>
                <dx:BootstrapGridViewTextColumn ReadOnly="True" Caption=" " VisibleIndex="0">
                    <SettingsEditForm Visible="False" />
                    <DataItemTemplate>
                        <asp:LinkButton ID="lbtReview" EnableViewState="false" OnCommand="lbtReview_Command" CssClass="btn btn-primary" CommandArgument='<%# Eval("ProgressID") %>' runat="server"><i aria-hidden="true" class="fas fa-search"></i> Review</asp:LinkButton>
                    </DataItemTemplate>
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewTextColumn FieldName="Name" ReadOnly="True" VisibleIndex="1">
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewTextColumn FieldName="Activity" ReadOnly="True" VisibleIndex="2">
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewDateColumn FieldName="Enrolled" VisibleIndex="3">
                </dx:BootstrapGridViewDateColumn>
                <dx:BootstrapGridViewDateColumn FieldName="LastAccess" VisibleIndex="4">
                </dx:BootstrapGridViewDateColumn>
                <dx:BootstrapGridViewDateColumn FieldName="CompleteBy" VisibleIndex="5">
                </dx:BootstrapGridViewDateColumn>
                <dx:BootstrapGridViewDateColumn FieldName="Completed" VisibleIndex="6">
                </dx:BootstrapGridViewDateColumn>
                
                <dx:BootstrapGridViewTextColumn HorizontalAlign="Left" Caption="Ver Req" FieldName="VerificationRequests" ReadOnly="True" VisibleIndex="7">
                </dx:BootstrapGridViewTextColumn>
            </Columns>
            <SettingsCustomizationDialog Enabled="True" />
            <SettingsSearchPanel Visible="True" />
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
    </dx:BootstrapGridView>
          </div>
        </asp:View>



        <asp:View ID="vSuperviseDetail" runat="server">
                        <div class="card card-primary">
                <div class="card-header">
                    
<div class="h3"><button type="button" class="btn btn-lg  btn-light" data-toggle="modal" aria-label="Show delegate and progress info" data-target="#infoModal">
  <i class="fas fa-info-circle"></i>
</button> 
                        <asp:Label ID="lblDelegate" runat="server" Text="Label"></asp:Label></div>
                    <div class="h4 ml-4 pl-1">
                        <asp:Label ID="lblCourse" runat="server" Text="Label"></asp:Label></div>
                        </div>
                <div class="card-body">

                     <div class="card card-default">
 <asp:ObjectDataSource ID="dsSections" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.SuperviseDataTableAdapters.SectionsTableAdapter">
                <SelectParameters>
                    <asp:Parameter Name="ProgressID" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:Repeater ID="rptSections" DataSourceID="dsSections" runat="server">
                <ItemTemplate>
                  
                     <div class='<%# IIf(Eval("DisplayFormatID") = 1, "card-header clickable clearfix collapse-card collapsed", "card-header clearfix") %>' data-toggle="collapse" data-target='<%# ".Accordion" & Eval("SectionID")%>'>
                                                    <asp:Label CssClass="card-title h5" ID="lblSectionHeader" runat="server" Text='<%#Eval("SectionName")%>'></asp:Label>
                                                    <div class="float-right">
                                                        <asp:Label ID="lblVerificationRequests" runat="server"
                                                            Text='<%#Eval("VerificationRequests", "{0} verification requests")%>' />
                                                      
                                                    </div>
                                                </div>
                         <div id="TutsCollapse" class='<%# IIf(Eval("DisplayFormatID") = 1, "section-panel collapse Accordion" & Eval("SectionID"), "section-panel")%>' runat="server">
                                                    <div class="card-body">
                                                         <asp:HiddenField ID="hfSectionID" Value='<%#Eval("SectionID")%>' runat="server"></asp:HiddenField>
                                            <asp:HiddenField ID="hfRowNumber" Value='<%#Container.ItemIndex%>' runat="server"></asp:HiddenField>
                                            <asp:ObjectDataSource ID="dsLMTutorials" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.uspReturnProgressDetailTableAdapter">
                                                <SelectParameters>
                                                    <asp:SessionParameter Name="ProgressID" SessionField="TempProgressID" Type="Int32" />
                                                    <asp:ControlParameter Name="SectionID" Type="Int32" ControlID="hfSectionID" />

                                                </SelectParameters>
                                            </asp:ObjectDataSource>
    <dx:BootstrapGridView ID="bsgvTutorials" runat="server" AutoGenerateColumns="False" DataSourceID="dsLMTutorials" KeyFieldName="TutorialID">
        <SettingsBootstrap Striped="True" />
        <Settings GridLines="None" ShowHeaderFilterButton="True" />
        <Columns>
            <dx:BootstrapGridViewTextColumn Caption="Skill / Requirement" Settings-AllowHeaderFilter="False" FieldName="TutorialName" VisibleIndex="0">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewDateColumn FieldName="LastReviewed" Caption="Assessed" VisibleIndex="1">
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewTextColumn Caption="Self Assessment" FieldName="SelfAssessStatus" ReadOnly="True" VisibleIndex="2">
                <DataItemTemplate>
                    <asp:Label ID="Label6" ToolTip='<%# IIf(Eval("LastReviewed").ToString.Length > 0, "Self assessed on " & Eval("LastReviewed", "{0:d}"), "") %>' EnableViewState="false" runat="server" Text='<%# Eval("SelfAssessStatus") %>'></asp:Label>
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Evidence" Settings-AllowHeaderFilter="False" FieldName="LogCompleted" ReadOnly="True" VisibleIndex="3">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Actions" Settings-AllowHeaderFilter="False" FieldName="LogActions" ReadOnly="True" VisibleIndex="4">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewCheckColumn Caption="Verifiable" FieldName="SupervisorVerify" VisibleIndex="5">
            </dx:BootstrapGridViewCheckColumn>
            <dx:BootstrapGridViewDateColumn Caption="Ver. Requested" FieldName="SupervisorVerificationRequested" VisibleIndex="6">
                <DataItemTemplate>
                    <asp:Label ID="Label5" EnableViewState="false" Visible='<%# Eval("SupervisorVerificationRequested").ToString.Length > 0 %>' runat="server" CssClass="alert alert-warning small float-right ml-auto"><i class="fas fa-flag"></i> <%# Eval("SupervisorVerificationRequested", "{0:d}") %></asp:Label>
                </DataItemTemplate>
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewDateColumn Caption="Ver. Date" FieldName="SupervisorVerifiedDate" VisibleIndex="7">
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewTextColumn Caption="Ver. Outcome" FieldName="SupervisorOutcomeText" ReadOnly="True" VisibleIndex="8">
            </dx:BootstrapGridViewTextColumn>
        </Columns>
        <Templates>
            <DetailRow>
                  <asp:HiddenField ID="hfAPID" Value='<%# Eval("aspProgressID") %>' runat="server" />
    <asp:ObjectDataSource ID="dsSelfAssess" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.SkillAssessmentTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="hfAPID" Name="aspProgressID" PropertyName="Value" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource><div class="card card-secondary">
    <asp:FormView ID="fvSelfAssess" OnDataBound="fvSelfAssess_DataBound" RenderOuterTable="false" runat="server" DataKeyNames="aspProgressID" DataSourceID="dsSelfAssess">
        <ItemTemplate>
        
            <div class="card-header">
                <h6 class="mt-0 mb-0"><small>Skill / Requirement:</small> <%# Eval("TutorialName") %></h6>
            </div>
            <div class="card-body">
                <h6 class="mt-0 mb-0">Definition</h6>
                            <p>
                                <asp:Label ID="lblSADescription" runat="server" Text='<%# Eval("Description") %>'></asp:Label></p>
                            <h6 class="mt-0 mb-0">Requirements to be met:</h6>
                            <p>
                                <asp:Label ID="lblSAObjectives" runat="server" Text='<%# Eval("Objectives") %>'></asp:Label></p>
            </div>
             <div class="card-header">
                <h6 class="mt-0 mb-0"><small>Self Assessment Rating:</small> <asp:Label ID="lblSARating" runat="server" Text='<%# Eval("SelfAssessStatus") %>'></asp:Label></h6>
            </div>
            <div class="card-body">
                 <h6 class="mt-0 mb-0">Supporting comments:</h6>
                            <p>
                                <asp:Label ID="Label2" runat="server" Text='<%# IIf(Eval("OutcomesEvidence").ToString.Length > 0, Eval("OutcomesEvidence"), "No supporting comments supplied") %>'></asp:Label></p>
                </div>
            <div class="card-header">
                <h6 class="mt-0 mb-0"><button type="button" visible='<%# Eval("EvidenceText").ToString.Length > 0 %>' class="btn btn-light" data-toggle="modal" data-target="#modal-<%# Eval("aspProgressID") %>">
  <i class="fas fa-info-circle"></i>
</button><small> Evidence and Actions:</small></h6>
            </div>
             <div class="card-body">
                 <div class="card card-success mb-2">
                                <div class="card-header clickable clearfix collapse-card collapsed"  data-toggle="collapse" data-target="#evidence" aria-controls="evidence" aria-expanded="false" role="button"  style="cursor:pointer;">
                                    <div  class="d-flex justify-content-between"><h6 class="mt-0 mb-0">Evidence</h6>
                                     <div class="mt-0">Evidence items: <b>
                                         <asp:Label ID="lblEvidenceCount" runat="server" Text='<%# Eval("LogCompleted") %>'></asp:Label></b></div></div>
                                </div>
                                <div class="collapse" id="evidence">
                                    <asp:HiddenField ID="hfTutorialID" Value='<%# Eval("TutorialID") %>' runat="server" />
                                        <asp:ObjectDataSource ID="dsSkillEvidence" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetCompletedByProgTutID" TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.LearningLogItemsTableAdapter">
                                            <SelectParameters>
                                                <asp:SessionParameter Name="ProgressID" SessionField="TempProgressID" Type="Int32" />
                                                
                                                    <asp:ControlParameter Name="TutorialID" Type="Int32" ControlID="hfTutorialID" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                                                        <dx:BootstrapGridView ID="bsgvSkillEvidence" runat="server" AutoGenerateColumns="False" DataSourceID="dsSkillEvidence" KeyFieldName="LearningLogItemID">
                                                            <SettingsBootstrap Striped="True" />
                                                            <Settings GridLines="None" />
                                                            <SettingsDetail ShowDetailRow="True" ShowDetailButtons="true" AllowOnlyOneMasterRowExpanded="True"></SettingsDetail>    
                                                            <Columns>
                                                                
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
                                                            </Columns>
                                                            <Templates>
                                                                <DetailRow>
                                                                    <asp:Label ID="Label28" AssociatedControlID="tbOutcomes" CssClass="control-label" runat="server" Text="Outcomes:"></asp:Label>
                                            <asp:TextBox ID="tbOutcomes" CssClass="form-control mt-2 mb-2" Enabled="false" TextMode="MultiLine" Text='<%# Eval("Outcomes") %>' runat="server"></asp:TextBox>
                                                                    
                                                                        <asp:Label ID="Label29" AssociatedControlID="tbRelatesTo" CssClass="control-label" runat="server" Text="Linked to:"></asp:Label>
                                            <asp:TextBox ID="tbRelatesTo" CssClass="form-control mt-2 mb-2" Enabled="false" Text='<%# Eval("LinkedTo") %>' runat="server"></asp:TextBox>
                                                                     <asp:HiddenField ID="hfLogItemID" Value='<%# Eval("LearningLogItemID") %>' runat="server" />
                                                                   <div class="card card-info mb-1">
        <div class="card-header">Evidence Files</div>
         <asp:ObjectDataSource ID="dsFiles" EnableViewState="false" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.FilesDataTableAdapters.FilesTableAdapter">
             <SelectParameters>
                 <asp:ControlParameter Name="LearningLogItemID" Type="Int32" ControlID="hfLogItemID" />
             </SelectParameters>
         </asp:ObjectDataSource>
        <%-- <asp:UpdatePanel ID="UpdatePanel1" ChildrenAsTriggers="true" UpdateMode="Conditional" runat="server">
             <ContentTemplate>--%>
         <table class="table table-striped">
                                            <asp:Repeater ID="rptFiles" EnableViewState="false" runat="server" DataSourceID="dsFiles">
                                                <HeaderTemplate>
                                                    <div class="table-responsive">
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td>
                                                            <asp:HyperLink ID="hlFile" runat="server"
                                                                NavigateUrl='<%# Eval("FileID", "../GetFile.aspx?FileID={0}&src=supervise")%>'>
                                                                <i id="I1" aria-hidden="true" class='<%# GetIconClass(Eval("FileName"))%>' runat="server"></i>
                                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("FileName")%>'></asp:Label>
                                                            </asp:HyperLink>
                                                        </td>
                                                        <td><asp:Label ID="lblSize" runat="server" Text='<%# NiceBytes(Eval("FileSize"))%>'></asp:Label></td>
                                                        
                                                    </tr>
                                                </ItemTemplate>
                                                <FooterTemplate></div></FooterTemplate>
                                            </asp:Repeater>
                                            <tr runat="server" id="trNoFilesAdd" visible="false"><td>
                                                No files have been uploaded against this log item.
                                                                                              </td></tr>
                                        </table>
                                                   </DetailRow>
                                               </Templates>
                                                            <SettingsDetail ShowDetailRow="True" />
                                                            <SettingsSearchPanel Visible="True" />

                                                        </dx:BootstrapGridView>
                                         </div>
                                 </div>
                            <div class="card card-warning mb-2">
                                <div class="card-header clickable clearfix collapse-card collapsed"  data-toggle="collapse" data-target="#actionplan" aria-controls="actionplan" aria-expanded="false" role="button"  style="cursor:pointer;">
                                    <div  class="d-flex justify-content-between">
                                    <h6 class="mt-0 mb-0">Action Plan</h6>
                                    <div class="mt-0">Open actions: <b><asp:Label ID="lblActionsCount" runat="server" Text='<%# Eval("LogActions") %>'></asp:Label></b></div></div>
                                </div>
                                <div class="collapse" id="actionplan">
                                
                                     
                                            <asp:ObjectDataSource ID="dsSkillAction" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetPlannedByProgressTutorialID" TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.LearningLogItemsTableAdapter">
                                                <SelectParameters>
                                                    <asp:SessionParameter Name="ProgressID" SessionField="TempProgressID" Type="Int32" />
                                                    <asp:ControlParameter Name="TutorialID" Type="Int32" ControlID="hfTutorialID" />
                                                </SelectParameters>
                                            </asp:ObjectDataSource>
                                            <dx:BootstrapGridView ID="bsgvSkillActions" runat="server" AutoGenerateColumns="False" DataSourceID="dsSkillAction" KeyFieldName="LearningLogItemID">
                                                
                            <SettingsDetail ShowDetailRow="True" ShowDetailButtons="true" AllowOnlyOneMasterRowExpanded="True"></SettingsDetail>                
                                                <SettingsBootstrap Striped="True" />
                                                                <Settings GridLines="None" />
                                                                <Columns>
                                                                    
                                                                    <dx:BootstrapGridViewDateColumn FieldName="DueDate" Caption="Due" VisibleIndex="1">
                                                                    </dx:BootstrapGridViewDateColumn>
                                                                    <dx:BootstrapGridViewTextColumn Caption="Activity" FieldName="Topic" VisibleIndex="2">
                                                                        <DataItemTemplate>
                                                                            <asp:Label ID="lblActivity" EnableViewState="false" runat="server" Text='<%# IIf(Eval("MethodOther").ToString.Length > 0, Eval("MethodOther"), Eval("MethodFuture")) & " " & Eval("Topic") %>'></asp:Label>
                                                                        </DataItemTemplate>
                                                                    </dx:BootstrapGridViewTextColumn>
                                                                    <dx:BootstrapGridViewTextColumn Caption="Files" HorizontalAlign="Center" FieldName="FileCount" VisibleIndex="3">
                                                                </dx:BootstrapGridViewTextColumn>
                                                                    <dx:BootstrapGridViewDateColumn FieldName="LoggedDate" Caption="Logged" VisibleIndex="4">
                                                                    </dx:BootstrapGridViewDateColumn>
                                                                    <dx:BootstrapGridViewTextColumn FieldName="LoggedBy" Caption="By" ReadOnly="True" VisibleIndex="5">
                                                                    </dx:BootstrapGridViewTextColumn>
                                                                     
                                                                </Columns>
                                               <Templates>
                                                                <DetailRow>
                                                                   <asp:Label ID="Label28" AssociatedControlID="tbOutcomes" CssClass="control-label" runat="server" Text="Outcomes:"></asp:Label>
                                            <asp:TextBox ID="tbOutcomes" CssClass="form-control mt-2 mb-2" Enabled="false" TextMode="MultiLine" Text='<%# Eval("Outcomes") %>' runat="server"></asp:TextBox>
                                                                    
                                                                        <asp:Label ID="Label29" AssociatedControlID="tbRelatesTo" CssClass="control-label" runat="server" Text="Linked to:"></asp:Label>
                                            <asp:TextBox ID="tbRelatesTo" CssClass="form-control mt-2 mb-2" Enabled="false" Text='<%# Eval("LinkedTo") %>' runat="server"></asp:TextBox>
                                                                    <asp:HiddenField ID="hfLogItemID" Value='<%# Eval("LearningLogItemID") %>' runat="server" />
                                                                   <div class="card card-info mb-1">
        <div class="card-header">Evidence Files</div>
         <asp:ObjectDataSource ID="dsFiles" EnableViewState="false" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.FilesDataTableAdapters.FilesTableAdapter">
             <SelectParameters>
                 <asp:ControlParameter Name="LearningLogItemID" Type="Int32" ControlID="hfLogItemID" />
             </SelectParameters>
         </asp:ObjectDataSource>
        <%-- <asp:UpdatePanel ID="UpdatePanel1" ChildrenAsTriggers="true" UpdateMode="Conditional" runat="server">
             <ContentTemplate>--%>
         <table class="table table-striped">
                                            <asp:Repeater ID="rptFiles" EnableViewState="false" runat="server" DataSourceID="dsFiles">
                                                <HeaderTemplate>
                                                    <div class="table-responsive">
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td>
                                                            <asp:HyperLink ID="hlFile" runat="server"
                                                                NavigateUrl='<%# Eval("FileID", "../GetFile.aspx?FileID={0}&src=supervise")%>'>
                                                                <i id="I1" aria-hidden="true" class='<%# GetIconClass(Eval("FileName"))%>' runat="server"></i>
                                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("FileName")%>'></asp:Label>
                                                            </asp:HyperLink>
                                                        </td>
                                                        <td><asp:Label ID="lblSize" runat="server" Text='<%# NiceBytes(Eval("FileSize"))%>'></asp:Label></td>
                                                        
                                                    </tr>
                                                </ItemTemplate>
                                                <FooterTemplate></div></FooterTemplate>
                                            </asp:Repeater>
                                            <tr runat="server" id="trNoFilesAdd" visible="false"><td>
                                                No files have been uploaded against this log item.
                                                                                              </td></tr>
                                        </table>
             <%--</ContentTemplate>
             <Triggers>
                 <asp:PostBackTrigger ControlID="lbtDone" />
             </Triggers>
         </asp:UpdatePanel>--%>
            </div>
                                                   </DetailRow>
                                               </Templates>
                                                                <SettingsSearchPanel Visible="True" />
                                                            </dx:BootstrapGridView>
                                    
                                            </div>
             </div>
        </div>
          
<div class="modal fade" id="modal-<%# Eval("aspProgressID") %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Valid Evidence Examples</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <%# Eval("EvidenceText") %>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary float-right" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
            <asp:Panel ID="pnlSV" Visible='<%# Eval("SupervisorVerify") %>' CssClass='<%# IIf(Eval("SupervisorVerificationRequested").ToString.Length > 0, "card card-primary m-1", "card card-default m-1") %>' runat="server">
        <div id="superviseHeader" runat="server" class='<%# IIf(Eval("SupervisorVerificationRequested").ToString.Length > 0, "card-header clickable clearfix collapse-card", "card-header clickable clearfix collapse-card collapsed") %>' data-toggle="collapse" data-target="#supervisorstatus" aria-controls="supervisorstatus" aria-expanded="false"><div  class="card-title d-flex justify-content-between"><h6 class="mt-0 mb-0"><small>Supervisor verification status:</small> <asp:Label ID="lblSAVerificationStatus" CssClass="mr-auto" runat="server" Text='<%# Eval("SupervisorOutcomeText") %>'></asp:Label></h6><asp:Label ID="Label4" Visible='<%# Eval("SupervisorVerificationRequested").ToString.Length > 0 %>' runat="server" CssClass="alert alert-warning float-right ml-auto"><i class="fas fa-flag"></i> Requested <%# Eval("SupervisorVerificationRequested", "{0:d}") %></asp:Label></div></div>
                                        <div id="supervisorstatus" class='<%# IIf(Eval("SupervisorVerificationRequested").ToString.Length > 0, "card-body", " collapse") %>'>
        <asp:MultiView ID="mvSupervisorVerify" runat="server" ActiveViewIndex='<%# IIf(Eval("SupervisorOutcomeText").ToString.ToLower() = "not verified", 1, 0) %>'>
            <asp:View ID="vViewSupervisorOutcome" runat="server">
                 
                                        
                                            <h6>Supervisor</h6>
                                            <p>
                                                <asp:Label ID="lblSASupervisor" runat="server" Text='<%# Eval("Supervisor") %>'></asp:Label></p>
                                            <h6>Verification Outcome</h6>
                                            <p>Status:<b><asp:Label ID="lblSASupervisorStatus" CssClass="pl-1 pr-2" runat="server" Text='<%# Eval("SupervisorOutcomeText") %>'></asp:Label></b>&nbsp;&nbsp;Date:<b><asp:Label CssClass="pl-1 pr-2" ID="lblSAVerifiedDate" runat="server" Text='<%# Eval("SupervisorVerifiedDate") %>'></asp:Label></b></p>
                                            <h6>Verifier Comments</h6>
                                            <p>
                                                <asp:Label ID="lblSASupervisorComments" runat="server" Text='<%# Eval("SupervisorVerifiedComments") %>'></asp:Label></p>
                                       
                <asp:LinkButton ID="lbtReviseVerification" CssClass="btn btn-outline-primary float-right" OnCommand="lbtReviseVerification_Command" runat="server">Submit Revised Verification</asp:LinkButton>
                                    
            </asp:View>
            <asp:View ID="vSubmitVerification" runat="server">
                <h6>Submit New Supervisor Verification</h6>
                <asp:TextBox ID="tbSVComments" CssClass="form-control mt-2 mb-2" TextMode="MultiLine" placeholder="Supervisor comments on self assessment..." runat="server"></asp:TextBox>
                <div class="form-group row">
                    <asp:Label ID="Label3" runat="server" CssClass="col-sm-3" Text="Verification outcome:"></asp:Label>
                    <div class="col-sm-9">
                             <dx:BootstrapRadioButton ID="bsrbtSuccess" Text='<%# Eval("SupervisorSuccessText") %>' GroupName="rbgSVOutcome" runat="server"></dx:BootstrapRadioButton>
                            <dx:BootstrapRadioButton ID="bsrbtFail"  Text='<%# Eval("SupervisorFailText") %>' GroupName="rbgSVOutcome" runat="server"></dx:BootstrapRadioButton>
                    </div>
                </div>
              <asp:LinkButton CssClass="btn btn-primary float-right mb-2" OnCommand="lbtSVSubmit_Command" ID="lbtSVSubmit" runat="server">Submit</asp:LinkButton>
            </asp:View>
        </asp:MultiView>
            </div>
        </asp:Panel>
        </ItemTemplate>
    </asp:FormView>
        
         </div>
            </DetailRow>
        </Templates>
        <SettingsDetail ShowDetailRow="True" />
    </dx:BootstrapGridView>

                                                        </div>
                             </div>
                </ItemTemplate>
            </asp:Repeater>
                     </div>
                </div>
                            <div class="card-footer clearfix">
<asp:LinkButton ID="lbtCloseDetail" OnCommand="lbtCloseDetail_Command" CssClass="btn btn-secondary float-right" runat="server">Close</asp:LinkButton>
                            </div>
                </div>
           

            <!-- Modal -->
<div class="modal fade" id="infoModal" tabindex="-1" role="dialog" aria-labelledby="infoModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="infoModalLabel">Delegate and Progress Info</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
                              <div class="form-group row">
                                                    <asp:Label ID="Label10" AssociatedControlID="tbEmailAddress" CssClass="control-label col-sm-4" runat="server" Text="Email:"></asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbEmailAddress" Enabled="false" CssClass="form-control" runat="server"  />
                                                    </div>
                                                </div>                                               
                    <asp:Panel ID="pnlAnswer1" runat="server" CssClass="form-group row">
                                                
                                                    <asp:Label ID="lblAnswer1TextInsert" AssociatedControlID="txtAnswer1" CssClass="control-label col-sm-4" runat="server" Text="Label"></asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="txtAnswer1" Enabled="false" CssClass="form-control" runat="server" />
                                                    </div>
                                                </asp:Panel>
                                                <asp:Panel ID="pnlAnswer2" runat="server" CssClass="form-group row">
                                                    <asp:Label ID="lblAnswer2TextInsert" AssociatedControlID="txtAnswer2" CssClass="control-label col-sm-4" runat="server" Text="Label"></asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="txtAnswer2" Enabled="false" CssClass="form-control" runat="server" />
                                                    </div>
                                                </asp:Panel>
                                                <asp:Panel ID="pnlAnswer3" runat="server" CssClass="form-group row">
                                                    <asp:Label ID="lblAnswer3TextInsert" AssociatedControlID="txtAnswer3" CssClass="control-label col-sm-4" runat="server" Text="Label"></asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="txtAnswer3" Enabled="false" CssClass="form-control" runat="server" />
                                                    </div>
                                               </asp:Panel>
                                                <asp:Panel ID="pnlAnswer4" runat="server" CssClass="form-group row">
                                                    <asp:Label ID="lblAnswer4TextInsert" AssociatedControlID="txtAnswer4" CssClass="control-label col-sm-4" runat="server" Text="Label"></asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="txtAnswer4" Enabled="false" CssClass="form-control" runat="server" />
                                                    </div>
                                                </asp:Panel>
                                                <asp:Panel ID="pnlAnswer5" runat="server" CssClass="form-group row">
                                                    <asp:Label ID="lblAnswer5TextInsert" AssociatedControlID="txtAnswer5" CssClass="control-label col-sm-4" runat="server" Text="Label"></asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="txtAnswer5" Enabled="false" CssClass="form-control" runat="server" />
                                                    </div>
                                                </asp:Panel>
                                                <asp:Panel ID="pnlAnswer6" runat="server" CssClass="form-group row">
                                                    <asp:Label ID="lblAnswer6TextInsert" AssociatedControlID="txtAnswer6" CssClass="control-label col-sm-4" runat="server" Text="Label"></asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="txtAnswer6" Enabled="false" CssClass="form-control" runat="server" />
                                                    </div>
                                                </asp:Panel>
    <div class="form-group row">
        <asp:Label ID="Label1" runat="server" CssClass="control-label col-sm-4" Text="Enrolled:"></asp:Label>
         <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbEnrolled" Enabled="false" CssClass="form-control" runat="server" />
                                                    </div>
    </div>
    <div class="form-group row">
        <asp:Label ID="lblLastAccessed" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="tbLastAccessed" Text="Last Accessed:"></asp:Label>
         <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbLastAccessed" Enabled="false" CssClass="form-control" runat="server" />
                                                    </div>
    </div>
    <div class="form-group row">
        <asp:Label ID="lblLogins" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="tbLogins" Text="Times accessed:"></asp:Label>
         <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbLogins" Enabled="false" CssClass="form-control" runat="server" />
                                                    </div>
    </div>
    <div class="form-group row">
        <asp:Label ID="lblCompleteBy" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="tbCompleteBy" Text="Complete by:"></asp:Label>
         <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbCompleteBy" Enabled="false" CssClass="form-control" runat="server" />
                                                    </div>
    </div>
    <div class="form-group row">
        <asp:Label ID="lblCompleted" runat="server" CssClass="control-label col-sm-4" AssociatedControlID="tbCompleted" Text="Completed:"></asp:Label>
         <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbCompleted" Enabled="false" CssClass="form-control" runat="server" />
                                                    </div>
    </div>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary float-right" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
        </asp:View>
        
    </asp:MultiView>
                       
    
</asp:Content>
