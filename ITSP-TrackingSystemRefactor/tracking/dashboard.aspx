<%@ Page Title="Centre Dashboard" Language="vb" AutoEventWireup="false" MasterPageFile="~/tracking/Site.Master" ValidateRequest="false" CodeBehind="dashboard.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.dashboard" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="breadtray" runat="server">
    <link  href="../Content/dashboard.css" rel="stylesheet" />
    
    <script src="https://www.gstatic.com/charts/loader.js"></script>
    
   <ol class="breadcrumb breadcrumb-slash">
        <li class="breadcrumb-item active">Centre Dashboard</li>
    </ol>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%--<div class="row">
        <div class="col col-lg-12">
            <h1 class="page-header">Dashboard</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>--%>
    <!-- /.row -->
    <asp:ObjectDataSource ID="dsDashboardInfo" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.CentreDashboardTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
            <asp:SessionParameter Name="AdminCategoryID" SessionField="AdminCategoryID" Type="Int32" />
        </SelectParameters>

    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsCustomPrompts" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActive" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.CustomPromptsTableAdapter"></asp:ObjectDataSource>
    <div>
    <div class="row mb-1">
        <asp:FormView ID="fvDash" RenderOuterTable="false" runat="server" DataKeyNames="CentreID" DataSourceID="dsDashboardInfo">

           
            <ItemTemplate> 
                <div class="col-sm-12"><div class="alert alert-light">Welcome <b><%# Session("UserForename") %></b>. You are Managing <b><%# Eval("CategoryName") %></b> Courses</div></div>
                </div>
            <div class="row mb-3">
                <div class="col col-md-3">
                    <div class="card card-itsp-purple">
                        <div class="card-header">
                            <div class="row p-2">
                                <div class="col col-xs-3">
                                    <i class="fas fa-users fa-4x"></i>
                                </div>
                                <div class="col col-xs-9 text-right">
                                    <div class="fa-2x">
                                        <asp:Label ID="lblCentreDelegateCount" runat="server" Text='<%# Eval("CentreDelegates") %>'></asp:Label>
                                    </div>
                                    <div>Delegates</div>
                                </div>
                            </div>
                        </div>
                        <a href="delegates">
                            <div class="card-footer">
                                <span class="float-left mr-auto">Manage Delegates</span>
                                <span class="float-right"><i class="fas fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col col-md-3">
                    <div class="card card-itsp-pink">
                        <div class="card-header">
                            <div class="row p-2">
                                <div class="col col-xs-3">
                                    <i class="fas fa-book fa-4x"></i>
                                </div>
                                <div class="col col-xs-9 text-right">
                                    <div class="fa-2x">
                                        <asp:Label ID="lblCentreCourseCount" runat="server" Text='<%# Eval("CentreCourses") %>'></asp:Label>
                                    </div>
                                    <div>Courses</div>
                                </div>
                            </div>
                        </div>
                        <a href="coursesetup">
                            <div class="card-footer">
                                <span class="float-left mr-auto">Manage Courses</span>
                                <span class="float-right"><i class="fas fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col col-md-3">
                    <div class="card card-itsp-blue">
                        <div class="card-header">
                            <div class="row p-2">
                                <div class="col col-xs-3">
                                    <i class="fas fa-user-circle fa-4x"></i>
                                </div>
                                <div class="col col-xs-9 text-right">
                                    <div class="fa-2x">
                                        <asp:Label ID="lblAdminsCount" runat="server" Text='<%# Eval("CentreAdmins") %>'></asp:Label>
                                    </div>
                                    <div>Administrators</div>
                                </div>
                            </div>
                        </div>
                        <a <%# IIf(Not Session("UserCentreManager"), "style='display:none;'", "") %> href="centrelogins">
                            <div class="card-footer">
                                <span class="float-left mr-auto">Manage Administrators</span>
                                <span class="float-right"><i class="fas fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col col-md-3">
                    <div class="card card-itsp-green">
                        <div class="card-header">
                            <div class="row p-2">
                                <div class="col col-xs-3">
                                    <i class="far fa-life-ring fa-4x"></i>
                                </div>
                                <div class="col col-xs-9 text-right">
                                    <div class="fa-2x">
                                        <asp:Label ID="lblSupportTicketCount" runat="server" Text='<%# Eval("OpenTickets") %>'></asp:Label>
                                    </div>
                                    <div>Help Tickets</div>
                                </div>
                            </div>
                        </div>
                        <a href="tickets">
                            <div class="card-footer">
                                <span class="float-left mr-auto">View Tickets</span>
                                <span class="float-right"><i class="fas fa-arrow-circle-right"></i></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
                </div>
                </div>
                <div class="row mb-3">
                <div class="col col-md-5">
                    <div class="card card-info">
                        <div class="card-header">
                            Centre Details
                        </div>
                        <table class="table">
                            <tr>
                                <td>Centre name:</td>
                                <td><b><%# Eval("CentreName") %></b></td>

                            </tr>
                            <tr>
                                <td>Centre number:</td>
                                <td><b><%# Eval("CentreID").ToString %></b></td>

                            </tr>
                            <tr>
                                <td>Region:</td>
                                <td><b><%# Eval("RegionName") %></b></td>

                            </tr>
                            <tr>
                                <td>Contract Type:</td>
                                <td><button type="button" class="btn btn-info" title="Click for contract usage dashboard" data-toggle="modal" data-target="#contractDashModal"><b><i class="fas fa-tachometer-alt"></i> <%# Eval("ContractType") %></b></td>

                            </tr>
                            <tr>
                                <td>Centre manager:</td>
                                <td><b><%# Eval("Contact") %></b></td>

                            </tr>
                            <tr>
                                <td>Email:</td>
                                <td><b><%# Eval("ContactEmail") %></b></td>

                            </tr>
                            <tr>
                                <td>Contact number:</td>
                                <td><b><%# Eval("ContactTelephone") %></b></td>

                            </tr>
                            <tr>
                                <td>Banner text:</td>
                                <td><b><%# Eval("BannerText") %></b></td>

                            </tr>
                            <tr>
                                <td>Your IP address:</td>
                                <td><b><%# HttpContext.Current.Request.ServerVariables("REMOTE_ADDR").ToString() %></b></td>

                            </tr>
                            <tr>
                                <td>
                                    <div class="control-label">Pre-approved IP:</div>
                                </td>
                                <td><b><%# Eval("IPPrefix") %></b></td>

                            </tr>
                        </table>
                        <div class="card-footer clearfix">
                            <asp:LinkButton ID="LinkButton1" PostBackUrl="centredetails" class="btn btn-outline-secondary float-right" runat="server">Edit Details</asp:LinkButton>
                           
                            <%--   <asp:LinkButton ID="lbtEditCentreDetails" ToolTip="Edit Centre Details" CssClass="btn btn-outline-secondary float-right" runat="server">Edit Details</asp:LinkButton>--%>
                        </div>
                    </div>
                </div>

                <!-- /.row -->

            </ItemTemplate>
        </asp:FormView>
        <div class="col col-md-7">
            <div class="card card-default">
                <div class="card-header">Usage Chart</div>
                <div id="activity-chart" style="height: 332px;"></div>
                <div class="card-footer clearfix">
                    <asp:LinkButton ID="lbtMoreStats" PostBackUrl="~/tracking/reports" ToolTip="View Centre Stats" CssClass="btn btn-outline-secondary float-right" runat="server">More Statistics</asp:LinkButton>
                </div>
            </div>

        </div></div><div class="row mb-3">
        <div class="col col-md-7">

            <div class="card card-default">
                <div class="card-header">
                    Top Courses<asp:ObjectDataSource ID="dsDashboardCourses" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.DashboardCoursesTableAdapter">
                        <SelectParameters>
                             <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
            <asp:SessionParameter Name="AdminCategoryID" SessionField="AdminCategoryID" Type="Int32" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                </div>
                <dx:BootstrapGridView ID="bsgvCentreCourses" runat="server" AutoGenerateColumns="False" DataSourceID="dsDashboardCourses" SettingsPager-PageSize="8" Settings-GridLines="horizontal" SettingsBootstrap-Striped="true" KeyFieldName="CustomisationID">
                    <Columns>
                        <dx:BootstrapGridViewTextColumn FieldName="CustomisationName" ReadOnly="True" VisibleIndex="1">
                            <DataItemTemplate>
                                 <asp:HyperLink ID="linkCourseCustomisations" EnableViewState="false" runat="server" ToolTip="View delegates for course"
                                    NavigateUrl='<%# Eval("CustomisationID", "~/tracking/coursedelegates?tab=course&CustomisationID={0}") %>'><%#Eval("CustomisationName")%></asp:HyperLink>
                            </DataItemTemplate>
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="CandidateCountCompleted" Caption="Completed" ReadOnly="True" VisibleIndex="3">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="CandidateCountAll" Caption="Delegates" ReadOnly="True" VisibleIndex="2">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="CandidateCountInProgress" Caption="In&nbsp;Progress" ReadOnly="True" VisibleIndex="4">
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="PercentAttemptPassed" Caption="Pass Ratio" ReadOnly="True" VisibleIndex="5">
                            <DataItemTemplate>
                                <%# Eval("PercentAttemptPassed", "{0:F0}%") %>
                            </DataItemTemplate>
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewTextColumn Caption=" " ReadOnly="True" VisibleIndex="6">
                            <DataItemTemplate>
                                 <asp:LinkButton EnableViewState="false" ID="lbtViewCourse" PostBackUrl='<%# Eval("CustomisationID", "~/tracking/reports?tab=course&CustomisationID={0}") %>' CssClass="btn btn-outline-secondary" runat="server"><i aria-hidden="true" class="fas fa-chart-line"></i></asp:LinkButton>
                            </DataItemTemplate>
                        </dx:BootstrapGridViewTextColumn>
                    </Columns>
                </dx:BootstrapGridView>
               

            </div>
        </div>
            <div class="col col-md-5">
            <asp:ObjectDataSource ID="dsRankings" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.uspGetTopTenTableAdapter">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddDaysBack" Name="DaysBack" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="ddRegionID" Name="RegionID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:UpdatePanel ID="upCentreRanking" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="card card-default">
                        <div class="card-header">
                            <div class="form-inline small">
                                <div class="form-header">
                                    <h5>Centre Ranking</h5>
                                   
                                    <div class="form-group">
                                        <asp:Label ID="lblRegionTopTen" AssociatedControlID="ddRegionID" CssClass="filter-col" runat="server" Text="Region:"></asp:Label>
                                        <asp:DropDownList CssClass="form-control input-sm mr-1" ID="ddRegionID" AutoPostBack="true" runat="server" Font-Size="8" Width="120px">
                                        </asp:DropDownList>
                                        &nbsp
                                        <asp:Label ID="Label3" AssociatedControlID="ddDaysBack" CssClass="filter-col" runat="server" Text="for last:"></asp:Label>
                                        <asp:DropDownList CssClass="form-control input-sm" runat="server" ID="ddDaysBack" AutoPostBack="true" Font-Size="8" Width="100px">
                                            <asp:ListItem Value="7">Week</asp:ListItem>
                                            <asp:ListItem Selected="True" Value="14">Fortnight</asp:ListItem>
                                            <asp:ListItem Value="30">Month</asp:ListItem>
                                            <asp:ListItem Value="91">Quarter</asp:ListItem>
                                            <asp:ListItem Value="365">Year</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <asp:GridView runat="server" ID="gridviewTopTenList" GridLines="None" CssClass="table table-striped sm" AutoGenerateColumns="False"
                            DataSourceID="dsRankings">
                            <Columns>
                                <asp:BoundField DataField="Rank" HeaderText="Rank" ReadOnly="True" SortExpression="Rank"
                                    ItemStyle-HorizontalAlign="Center" />
                                <asp:TemplateField HeaderText="Centre" SortExpression="Centre">
                                    <ItemTemplate>
                                        <asp:Label Style="font-size: smaller" ID="Label1" runat="server" Text='<%# Bind("Centre") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="&sum;" SortExpression="Count" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label Style="font-size: smaller" ID="Label2" runat="server" Text='<%# Bind("Count") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                         

                                        <div class="alert alert-info">
<asp:Label ID="lblCentreRanking" runat="server" Text="Label"></asp:Label>
                                        </div>
                                        
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddDaysBack" />
                    <asp:AsyncPostBackTrigger ControlID="ddRegionID" />
                </Triggers>
            </asp:UpdatePanel>
        </div></div>
        


    </div>
    
   
    <!-- Modal messages-->
    <asp:ObjectDataSource ID="dsMessages" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetForAdminUserID" TypeName="ITSP_TrackingSystemRefactor.NotificationsTableAdapters.SANotificationsTableAdapter" DeleteMethod="AcknowledgeQuery">
        
        <DeleteParameters>
            <asp:Parameter Name="Original_SANotificationID" Type="Int32" />
            <asp:SessionParameter Name="AdminUserID" SessionField="UserAdminID" Type="Int32" />
        </DeleteParameters>
        
        <SelectParameters>
            <asp:SessionParameter Name="AdminUserID" SessionField="UserAdminID" Type="Int32" />
        </SelectParameters>
        
    </asp:ObjectDataSource>
    
    <div class="modal fade" id="messagesModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog modal-lg success" role="document">
            <div class="modal-content">
                <div class="modal-header">
                   
                    
                    <h5 class="modal-title" id="myModalLabel">
                        New system notifications</h5> <asp:LinkButton ID="lbtClose" OnCommand="CloseMsgs_Click" CssClass="close" data-dismiss="modal" runat="server"><span aria-hidden="true">&times;</span></asp:LinkButton>
                </div>
                <div class="modal-body">
                    <dx:BootstrapCardView SettingsText-EmptyCard="No more messages." SettingsDataSecurity-AllowDelete="true" SettingsBehavior-AllowFocusedCard="True" ID="bscvMessages" runat="server" AutoGenerateColumns="False" DataSourceID="dsMessages" KeyFieldName="SANotificationID">
        <SettingsLayout CardColSpanLg="12" CardColSpanMd="12" CardColSpanSm="12" CardColSpanXl="12" />
        <Columns>
            <dx:BootstrapCardViewTextColumn FieldName="SubjectLine" Caption="Subject" VisibleIndex="0">
                
            </dx:BootstrapCardViewTextColumn>
            <dx:BootstrapCardViewTextColumn Caption="Message" FieldName="BodyHTML" VisibleIndex="1">
                
                <DataItemTemplate>
                    <asp:Literal EnableViewState="false" ID="Literal1" runat="server" Text='<%# Eval("BodyHTML") %>'></asp:Literal>
                </DataItemTemplate>
            </dx:BootstrapCardViewTextColumn>
           
            <dx:BootstrapCardViewTextColumn FieldName="ExpiryDate" Caption="Expires" VisibleIndex="2">
                <DataItemTemplate>
                    <asp:Label EnableViewState="false" ID="Label28" runat="server" Text='<%# Eval("ExpiryDate", "{0:d}") %>'></asp:Label><%--<asp:LinkButton EnableViewState="false" ID="lbtAck" CssClass="btn btn-primary float-right" CommandArgument='<%# Eval("SANotificationID") %>' OnCommand="Acknowledge_Click" runat="server"><i aria-hidden="true" class="fas fa-check"></i> Acknowledge</asp:LinkButton>--%>
                </DataItemTemplate>
            </dx:BootstrapCardViewTextColumn>
        </Columns>
                  <Toolbars>
        <dx:BootstrapCardViewToolbar Position="Top">
            <Items>
                <dx:BootstrapCardViewToolbarItem Text="Acknowledge"  IconCssClass="fas fa-check" Command="Delete" ToolTip="This notification won't pop up again." />
            </Items>
        </dx:BootstrapCardViewToolbar>
    </Toolbars>    
        <SettingsPager ItemsPerPage="1" ShowNumericButtons="False">
            <PrevPageButton Text="Previous" />
            <Summary Text="Message {0} of {1}" EmptyText="No messages" />
        </SettingsPager>
                        
<SettingsExport ExportSelectedCardsOnly="False"></SettingsExport>

<StylesExport>
<Card BorderSize="1" BorderSides="All"></Card>

<Group BorderSize="1" BorderSides="All"></Group>

<TabbedGroup BorderSize="1" BorderSides="All"></TabbedGroup>

<Tab BorderSize="1"></Tab>
</StylesExport>
    </dx:BootstrapCardView>
                </div>
            </div>
        </div>
    </div>

    <asp:ObjectDataSource ID="dsContractDash" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.ContractUsageDashTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <div class="modal fade" id="contractDashModal" tabindex="-1" role="dialog" aria-labelledby="contractDashModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl" role="document">
    <div class="modal-content">
        <asp:Repeater ID="rptContractDash" DataSourceID="dsContractDash" runat="server">
              <ItemTemplate>
      <div class="modal-header">
        <h5 class="modal-title" id="contractDashModalLabel"><%# Eval("ContractType") & " Contract" & IIf(Eval("ContractReviewDate").ToString.Length > 0, " <small>(Review date: " & Eval("ContractReviewDate", "{0:dd/MM/yyyy}") & ")", "") %></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          
                  <div class="row">
                    <div class="col-lg-3 col-md-6 col-sm-6">
                      <div class="card card card-info text-center">
                        <div class="card-header">
                          <h3><%# Eval("CentreAdmins") %></h3>
                          <i class="mt-2 fa-4x fas fa-user-cog"></i>
                          <h5 class="mt-2 no-mb small-caps">Administrators</h5>
                        </div>
                      </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6">
                      <div class="card card card-<%#IIf(Eval("CMSAdministratorsLimit") = -1, "info", IIf(Eval("CMSAdmins") >= Eval("CMSAdministratorsLimit"), "danger", IIf(Eval("CMSAdmins") >= (Eval("CMSAdministratorsLimit") / 2), "warning", "success"))) %> text-center">
                        <div class="card-header">
                          <h3><%# Eval("CMSAdmins") & IIf(Eval("CMSAdministratorsLimit") = -1, "", "/" & Eval("CMSAdministratorsLimit")) %></h3>
                          <i class="mt-2 fas fa-4x fa-cog"></i>
                          <h4 class="mt-2 no-mb small-caps">CMS Administrators</h4>
                        </div>
                      </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6">
                      <div class="card card card-<%#IIf(Eval("CMSManagersLimit") = -1, "info", IIf(Eval("CMSManagers") >= Eval("CMSManagersLimit"), "danger", IIf(Eval("CMSManagers") >= (Eval("CMSManagersLimit") / 2), "warning", "success"))) %> text-center">
                        <div class="card-header">
                          <h3><%# Eval("CMSManagers") & IIf(Eval("CMSManagersLimit") = -1, "", "/" & Eval("CMSManagersLimit")) %></h3>
                          <i class="mt-2 fas fa-4x fa-cogs"></i>
                          <h5 class="mt-2 no-mb small-caps">CMS Managers</h5>
                        </div>
                      </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6">
                      <div class="card card card-<%#IIf(Eval("TrainersLimit") = -1, "info", IIf(Eval("Trainers") >= Eval("TrainersLimit"), "danger", IIf(Eval("Trainers") >= (Eval("TrainersLimit") / 2), "warning", "success"))) %> text-center">
                        <div class="card-header">
                          <h3><%# Eval("Trainers") & IIf(Eval("TrainersLimit") = -1, "", "/" & Eval("TrainersLimit")) %></h3>
                          <i class="mt-2 fas fa-4x fa-chalkboard-teacher"></i>
                          <h5 class="mt-2 no-mb small-caps">Trainers</h5>
                        </div>
                      </div>
                    </div>

                  </div>
           <div class="row mt-3">
                      
                    <div class="col-lg-3 col-md-6 col-sm-6">
                      <div class="card card card-<%#IIf(Eval("CCLicencesLimit") = -1, "info", IIf(Eval("CCLicences") >= Eval("CCLicencesLimit"), "danger", IIf(Eval("CCLicences") >= (Eval("CCLicencesLimit") / 2), "warning", "success"))) %> text-center">
                        <div class="card-header">
                          <h3><%# Eval("CCLicences") & IIf(Eval("CCLicencesLimit") = -1, "", "/" & Eval("CCLicencesLimit")) %></h3>
                          <i class="mt-2 fas fa-4x fa-pencil-ruler"></i>
                          <h4 class="mt-2 no-mb small-caps">Content Creators</h4>
                        </div>
                      </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6">
                      <div class="card card card-<%# IIf(Eval("CustomCoursesLimit") = -1, "info", IIf(Eval("CustomCourses") >= Eval("CustomCoursesLimit"), "danger", IIf(Eval("CustomCourses") >= (Eval("CustomCoursesLimit") / 2), "warning", "success"))) %> text-center">
                        <div class="card-header">
                          <h3><%# Eval("CustomCourses") & IIf(Eval("CustomCoursesLimit") = -1, "", "/" & Eval("CustomCoursesLimit")) %></h3>
                          <i class="mt-2 fas fa-4x fa-book"></i>
                          <h5 class="mt-2 no-mb small-caps">Custom Courses</h5>
                        </div>
                      </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6">
                      <div class="card card card-<%#IIf(Eval("ServerSpaceUsed") >= Eval("ServerSpaceBytes"), "danger", IIf(Eval("ServerSpaceUsed") >= (Eval("ServerSpaceBytes") / 2), "warning", "success")) %> text-center">
                        <div class="card-header">
                          <h3><%# NiceBytes(Eval("ServerSpaceUsed")) & "/" & NiceBytes(Eval("ServerSpaceBytes")) %></h3>
                          <i class="mt-2 fas fa-4x fa-cloud-upload-alt"></i>
                          <h5 class="mt-2 no-mb small-caps">Server Space</h5>
                        </div>
                      </div>
                    </div>
               <div class="col-lg-3 col-md-6 col-sm-6">
                   <a href="centrelogins" <%# IIf(Not Session("UserCentreManager"), "style='display:none;'", "") %> class="btn btn-outline-primary btn-block btn-lg mb-2"><i class="fas fa-user-cog"></i> Manage Users</a>
                    <a href="~/pricing" target="_blank" runat="server" class="btn btn-outline-info btn-block btn-lg"><i class="fas fa-shopping-basket"></i> Pricing Plans</a>
               </div>
           </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary float-right" data-dismiss="modal">Close</button>
      </div>   </ItemTemplate>
          </asp:Repeater>
    </div>
  </div>
</div>
</asp:Content>
