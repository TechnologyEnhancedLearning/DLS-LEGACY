<%@ Page Title="Stats" Language="vb" AutoEventWireup="false" MasterPageFile="~/tracking/Site.Master" CodeBehind="statsdetail.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.statsdetail" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="breadtray" runat="server">
    <script src="https://www.gstatic.com/charts/loader.js"></script>

   <ol class="breadcrumb breadcrumb-slash">
        <li class="breadcrumb-item"><a href="admin-configuration">Admin </a></li>
        <li class="breadcrumb-item active">Stats</li>
    </ol>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <ul class="nav nav-pills">
        <li role="presentation" class="nav-item" id="tab1" runat="server">
            <asp:LinkButton ID="lbtUsageTab" class="nav-link" runat="server">Overall Stats</asp:LinkButton></li>
        <li role="presentation" class="nav-item" id="tab2" runat="server">
            <asp:LinkButton ID="lbtUsageTrend" class="nav-link" runat="server">Usage Chart</asp:LinkButton></li>
        <li role="presentation" class="nav-item" id="tab3" runat="server">
            <asp:LinkButton ID="lbtEvaluationTab" class="nav-link" runat="server">Evaluation Summary</asp:LinkButton></li>
        <li role="presentation" class="nav-item" id="tab5" runat="server">
            <asp:LinkButton ID="lbtDigitalCapabilityTab" class="nav-link" runat="server">Digital Capability SA</asp:LinkButton></li>
        <li role="presentation" class="nav-item" id="tab4" runat="server">
            <asp:LinkButton ID="lbtHelpDeskTab" class="nav-link" runat="server">Help Desk Usage</asp:LinkButton></li>
    </ul>
    <asp:MultiView ID="mvStats" ActiveViewIndex="0" runat="server">
        <asp:View ID="vOverallStats" runat="server">
            <div class="row">
                <div class="col col-md-12">
                    <h2 class="page-header mt-3 mb-3">Overall Usage Stats</h2>
                </div>

                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col col-md-4">
                    <div class="card card-default">
                        <div class="card-header">
                            <h4>Usage Overview</h4>
                        </div>
                        <asp:ObjectDataSource ID="dsOverviewData" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPStatsTableAdapters.OverviewStatsTableAdapter"></asp:ObjectDataSource>
                        <asp:FormView RenderOuterTable="false" ID="fvOverview" runat="server" DefaultMode="ReadOnly"
                            DataSourceID="dsOverviewData">

                            <ItemTemplate>
                                <table class="table table-striped">

                                    <tr>
                                        <td>Total Regions:
                                        </td>
                                        <td>
                                            <asp:Label ID="Label1" CssClass="float-right" runat="server" Text='<%# CInt(Eval("Regions")).ToString("N0") %>' Font-Bold="True" />
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>Active Centres:
                                        </td>
                                        <td>
                                            <asp:Label ID="Label9" CssClass="float-right" runat="server" Text='<%# CInt(Eval("ActiveCentres")).ToString("N0") %>' Font-Bold="True" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Total Centre Logins:<br />
                                        </td>
                                        <td>
                                            <asp:Label ID="Label8" CssClass="float-right" runat="server" Font-Bold="True" Text='<%# CInt(Eval("AdminLogins")).ToString("N0") %>' />
                                            <br />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Total Delegates:<br />
                                        </td>
                                        <td>
                                            <asp:Label ID="Label3" CssClass="float-right" runat="server" Text='<%# CInt(Eval("Delegates")).ToString("N0") %>' Font-Bold="True" />
                                            <br />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Total Delegate Logins:<br />
                                        </td>
                                        <td>
                                            <asp:Label ID="Label6" CssClass="float-right" runat="server" Text='<%# CInt(Eval("Logins")).ToString("N0") %>' Font-Bold="True" />
                                            <br />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Total Learning Time (hours):<br />
                                        </td>
                                        <td>
                                            <asp:Label ID="Label5" CssClass="float-right" runat="server" Text='<%# CInt(Eval("LearningTime")).ToString("N0") %>' Font-Bold="True" />
                                            <br />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Total Evaluations:<br />
                                        </td>
                                        <td>
                                            <asp:Label ID="Label7" CssClass="float-right" runat="server" Text='<%# CInt(Eval("Evaluations")).ToString("N0") %>' Font-Bold="True" />
                                            <br />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Total Completions:<br />
                                        </td>
                                        <td>
                                            <asp:Label ID="Label4" CssClass="float-right" runat="server" Text='<%# CInt(Eval("Completions")).ToString("N0") %>'  Font-Bold="True" />
                                            <br />
                                        </td>
                                    </tr>
                                </table>


                            </ItemTemplate>

                        </asp:FormView>
                        <div class="card-footer clearfix">
                            <asp:LinkButton ID="lbtExportUsageOverview" CssClass="btn btn-outline-secondary float-right" runat="server"><i aria-hidden="true" class="fas fa-file-export"></i> Download to Excel</asp:LinkButton>
                        </div>
                    </div>
                </div>
                <div class="col col-md-8">
                    <div class="card card-default">
                        <div class="card-header">
                            <h4>Activity by Course Level</h4>
                        </div>
                        <div class="card-body">
                            <div id="activity-by-level" style="height: 295px;"></div>
                        </div>
                        <div class="card-footer clearfix">
                            <asp:LinkButton ID="lbtExportActivityByLevel" CssClass="btn btn-outline-secondary float-right" runat="server"><i aria-hidden="true" class="fas fa-file-export"></i> Download to Excel</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </asp:View>
        <asp:View ID="vUsageChart" runat="server">
            <div class="row">
                <div class="col col-md-12">
                    <h2 class="page-header mt-3 mb-3">Usage Chart with Filters</h2>
                </div>

                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <asp:ObjectDataSource ID="dsCourseCategories" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetActiveForCentre" TypeName="ITSP_TrackingSystemRefactor.customiseTableAdapters.CourseCategoriesTableAdapter">
                <SelectParameters>
                    <asp:Parameter DefaultValue="0" Name="CentreID" Type="Int32" />
                </SelectParameters>
             </asp:ObjectDataSource>

            <div class="row">
                <div class="col col-lg-12">
                    <div class="card card-default">
                        <div class="card-header clearfix"> <div class="form-header">
                                            <h5>Filter / Search</h5>
                                        </div>
                            <div class="row">
                                <div class="col col-lg-10">
                                    <div class="form-inline small">
                                       
                                        <div class="form-group m-1">

                                            <asp:Label ID="Label1" AssociatedControlID="ddRegionID" CssClass="filter-col" runat="server" Text="Region:"></asp:Label>
                                            <asp:DropDownList CssClass="form-control input-sm" ID="ddRegionID" runat="server">
                                            </asp:DropDownList>
                                        </div>
                                        <div class="form-group m-1">
                                            <asp:Label ID="Label2" AssociatedControlID="ddCentreType" runat="server" CssClass="filter-col" Text="Centre type:"></asp:Label>
                                            <asp:DropDownList CssClass="form-control input-sm" ID="ddCentreType" runat="server">
                                            </asp:DropDownList>

                                        </div>
                                        <div class="form-group m-1">
                                            <asp:Label ID="Label10" AssociatedControlID="ddJobGroupID" runat="server" CssClass="filter-col " Text="Job group:"></asp:Label>
                                            <asp:DropDownList CssClass="form-control input-sm" ID="ddJobGroupID" runat="server">
                                            </asp:DropDownList>


                                        </div>
                                        <div class="form-group m-1">
                                            <asp:Label ID="Label11" AssociatedControlID="ddCourseCategory" runat="server" CssClass="filter-col " Text="Course category:"></asp:Label>
                                            <asp:DropDownList CssClass="form-control input-sm" ID="ddCourseCategory" runat="server" AppendDataBoundItems="True" DataSourceID="dsCourseCategories" DataTextField="CategoryName"
                                                DataValueField="CourseCategoryID">
                                                <asp:ListItem Selected="True" Value="-1">All</asp:ListItem>
                                            </asp:DropDownList>


                                        </div>
                                        <div class="form-group m-1">
                                            <asp:Label ID="Label12" AssociatedControlID="ddApplicationID" runat="server" CssClass="filter-col " Text="Course:"></asp:Label>
                                            <asp:DropDownList CssClass="form-control input-sm" ID="ddApplicationID" runat="server">
                                            </asp:DropDownList>


                                        </div>
                                        <div class="form-group m-1">
                                            <asp:Label ID="Label13" AssociatedControlID="ddAssessed" runat="server" CssClass="filter-col " Text="Assessed?"></asp:Label>
                                            <asp:DropDownList CssClass="form-control input-sm" ID="ddAssessed" runat="server">
                                                <asp:ListItem Value="-1">All</asp:ListItem>
                                                <asp:ListItem Value="0">No</asp:ListItem>
                                                <asp:ListItem Value="1">Yes</asp:ListItem>
                                            </asp:DropDownList>


                                        </div>
                                        <div class="form-group m-1">
                                            <asp:Label ID="lblStartDate" AssociatedControlID="tbStartDate" runat="server" CssClass="filter-col " Text="Date range:"></asp:Label>
                                            <div class="input-group">


                                                <asp:TextBox ID="tbStartDate" CssClass="form-control input-sm pick-date" placeholder="Start date" runat="server"></asp:TextBox>

                                                <span class="input-group-append input-group-prepend"><span class="input-group-text">to</span></span>
                                                <asp:TextBox ID="tbEndDate" CssClass="form-control input-sm pick-date" runat="server" placeholder="End date"></asp:TextBox>
                                            </div>

                                        </div>
                                        <div class="form-group m-1">
                                            <asp:Label ID="lblCoreContent" AssociatedControlID="ddCoreContent" runat="server" CssClass="filter-col " Text="Content:"></asp:Label>
                                            <asp:DropDownList CssClass="form-control input-sm" ID="ddCoreContent" runat="server">
                                                <asp:ListItem Value="-1">All</asp:ListItem>
                                                <asp:ListItem Value="1">Core</asp:ListItem>
                                                <asp:ListItem Value="0">External</asp:ListItem>
                                            </asp:DropDownList>


                                        </div>
                                        <div class="form-group m-1">
                                            <asp:Label ID="Label14" AssociatedControlID="ddPeriodType" runat="server" CssClass="filter-col " Text="Chart by:"></asp:Label>
                                            <asp:DropDownList ID="ddPeriodType" CssClass="form-control input-sm" runat="server">
                                                <asp:ListItem Value="1">Days</asp:ListItem>
                                                <asp:ListItem Value="2">Weeks</asp:ListItem>
                                                <asp:ListItem Value="3" Selected="True">Months</asp:ListItem>
                                                <asp:ListItem Value="4">Quarters</asp:ListItem>
                                                <asp:ListItem Value="5">Years</asp:ListItem>
                                                <asp:ListItem Value="6">All</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col col-lg-2">
                                    <asp:LinkButton CssClass="btn btn-outline-secondary float-right" ID="btnUpdateGraphs" runat="server" CausesValidation="False" CommandName="Filter"><i aria-hidden="true" class="fas fa-filter"></i> Apply filter</asp:LinkButton>

                                </div>
                            </div>


                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col col-lg-4">
                                    <div class="card card-default">
                                        <div class="card-header">
                                           <h4>Activity statistics - Filtered Totals</h4>
                                        </div>

                                        <asp:ObjectDataSource ID="RegCompTotalChartSource" runat="server"
                                            OldValuesParameterFormatString="original_{0}" SelectMethod="GetFilteredNew"
                                            TypeName="ITSP_TrackingSystemRefactor.ITSPStatsTableAdapters.uspGetRegCompNewTableAdapter">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="6" Name="PeriodType" Type="Int32" />
                                                <asp:ControlParameter ControlID="ddJobGroupID" DefaultValue="-1"
                                                    Name="JobGroupID" PropertyName="SelectedValue" Type="Int32" />
                                                <asp:ControlParameter ControlID="ddApplicationID" DefaultValue="-1"
                                                    Name="ApplicationID" PropertyName="SelectedValue" Type="Int32" />
                                                <asp:Parameter DefaultValue="-1" Name="CustomisationID" Type="Int32" />
                                                <asp:ControlParameter ControlID="ddRegionID" DefaultValue="-1" Name="RegionID"
                                                    PropertyName="SelectedValue" Type="Int32" />
                                                <asp:ControlParameter ControlID="ddCentreType" DefaultValue="-1" Name="CentreTypeID"
                                                    PropertyName="SelectedValue" Type="Int32" />
                                                <asp:Parameter DefaultValue="-1" Name="CentreID" Type="Int32" />
                                                <asp:ControlParameter ControlID="ddAssessed" DefaultValue="-1"
                                                    Name="IsAssessed" PropertyName="SelectedValue" Type="Int32" />
                                                <asp:ControlParameter ControlID="ddCourseCategory" DefaultValue="-1"
                                                    Name="CourseCategoryID" PropertyName="SelectedValue" Type="Int32" />
                                                <asp:ControlParameter ControlID="tbStartDate" Name="StartDate"
                                                    PropertyName="Text" Type="DateTime" />
                                                <asp:ControlParameter ControlID="tbEndDate" Name="EndDate" PropertyName="Text"
                                                    Type="DateTime" />
                                                <asp:ControlParameter ControlID="ddCoreContent" DefaultValue="-1" Name="CoreContent" PropertyName="SelectedValue" Type="Int32" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                                       
                                                <asp:FormView ID="FormView2" runat="server"
                                                    DataSourceID="RegCompTotalChartSource" RenderOuterTable="False">
                                                    <ItemTemplate>
                                                        <table class="table table-striped">
                                                            <tr>
                                                                <td>Course Registrations:
                                                                </td>
                                                                <td align="right">
                                                                    <asp:Label ID="Label12" runat="server" Font-Bold="True"
                                                                        Text='<%# Bind("registrations") %>' />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>Completions:
                                                                </td>
                                                                <td align="right">
                                                                    <asp:Label ID="Label13" runat="server" Font-Bold="True"
                                                                        Text='<%# Bind("completions") %>' />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>Evaluations:
                                                                </td>
                                                                <td align="right">
                                                                    <asp:Label ID="Label14" runat="server" Font-Bold="True"
                                                                        Text='<%# Bind("evaluations") %>' />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>Knowledge Bank searches:
                                                                </td>
                                                                <td align="right">
                                                                    <asp:Label ID="Label11" runat="server" Font-Bold="True"
                                                                        Text='<%# Bind("kbsearches") %>' />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>Knowledge Bank tutorials viewed:
                                                                </td>
                                                                <td align="right">
                                                                    <asp:Label ID="Label15" runat="server" Font-Bold="True"
                                                                        Text='<%# Bind("kbtutorials") %>' />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>Knowledge Bank videos viewed:
                                                                </td>
                                                                <td align="right">
                                                                    <asp:Label ID="Label16" runat="server" Font-Bold="True"
                                                                        Text='<%# Bind("kbvideos") %>' />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>Knowledge Bank YouTube videos viewed:
                                                                </td>
                                                                <td align="right">
                                                                    <asp:Label ID="Label17" runat="server" Font-Bold="True"
                                                                        Text='<%# Bind("kbyoutubeviews") %>' />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>

                                                </asp:FormView>
                                            
                                    </div>
                                </div>
                                <div class="col col-lg-8">
                                    <div class="card card-default">
                                        <div class="card-header">
                                            <h4>Activity over time</h4>
                                            
                                        </div>
                                   
                                   
                                            <div id="activity-chart" style="height: 395px;"></div>

                                         </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer clearfix">
                            <asp:LinkButton ID="lbtExportActivityChartDataToExcel" CssClass="btn btn-outline-secondary float-right" runat="server"><i aria-hidden="true" class="fas fa-file-export"></i> Download to Excel</asp:LinkButton>

                        </div>
                    </div>
                </div>
            </div>
        </asp:View>
        <asp:View ID="vEvaluation" runat="server">
            <div class="row">
                <div class="col col-md-12">
                    <h2 class="page-header mt-3 mb-3">Evaluation Stats</h2>
                </div>
            </div>
            <div class="row">
                <div class="col col-lg-12">
                    <div class="card card-default">
                        <div class="card-header clearfix"><div class="form-header">
                                            <h5>Filter / Search</h5>
                                        </div>
                            <div class="row">
                                <div class="col col-lg-10">
                                    <div class="form-inline small">
                                        
                                        <div class="form-group m-1">

                                            <asp:Label ID="Label16" AssociatedControlID="ddEvalRegionID" CssClass="filter-col" runat="server" Text="Region:"></asp:Label>
                                            <asp:DropDownList CssClass="form-control input-sm" ID="ddEvalRegionID" runat="server">
                                            </asp:DropDownList>
                                        </div>
                                        <div class="form-group m-1">
                                            <asp:Label ID="Label17" AssociatedControlID="ddEvalCentreType" runat="server" CssClass="filter-col" Text="Centre type:"></asp:Label>
                                            <asp:DropDownList CssClass="form-control input-sm" ID="ddEvalCentreType" runat="server">
                                            </asp:DropDownList>

                                        </div>
                                        <div class="form-group m-1">
                                            <asp:Label ID="Label18" AssociatedControlID="ddEvalJobGroupID" runat="server" CssClass="filter-col " Text="Job group:"></asp:Label>
                                            <asp:DropDownList CssClass="form-control input-sm" ID="ddEvalJobGroupID" runat="server">
                                            </asp:DropDownList>


                                        </div>
                                        <div class="form-group m-1">
                                            <asp:Label ID="Label19" AssociatedControlID="ddEvalCourseCategory" runat="server" CssClass="filter-col " Text="Course level:"></asp:Label>
                                            <asp:DropDownList CssClass="form-control input-sm" ID="ddEvalCourseCategory" runat="server"  AppendDataBoundItems="True" DataSourceID="dsCourseCategories" DataTextField="CategoryName"
                                                DataValueField="CourseCategoryID">
                                                <asp:ListItem Selected="True" Value="-1">All</asp:ListItem>
                                            </asp:DropDownList>


                                        </div>
                                        <div class="form-group m-1">
                                            <asp:Label ID="Label20" AssociatedControlID="ddEvalApplicationID" runat="server" CssClass="filter-col " Text="Course:"></asp:Label>
                                            <asp:DropDownList CssClass="form-control input-sm" ID="ddEvalApplicationID" runat="server">
                                            </asp:DropDownList>


                                        </div>
                                        <div class="form-group m-1">
                                            <asp:Label ID="Label21" AssociatedControlID="ddEvalAssessed" runat="server" CssClass="filter-col " Text="Assessed?"></asp:Label>
                                            <asp:DropDownList CssClass="form-control input-sm" ID="ddEvalAssessed" runat="server">
                                                <asp:ListItem Value="-1">All</asp:ListItem>
                                                <asp:ListItem Value="0">No</asp:ListItem>
                                                <asp:ListItem Value="1">Yes</asp:ListItem>
                                            </asp:DropDownList>


                                        </div>
                                        <div class="form-group m-1">
                                            <asp:Label ID="Label22" AssociatedControlID="tbEvalStartDate" runat="server" CssClass="filter-col " Text="Date range:"></asp:Label>
                                            <div class="input-group">


                                                <asp:TextBox ID="tbEvalStartDate" CssClass="form-control input-sm pick-date" placeholder="Start date" runat="server"></asp:TextBox>

                                                <span class="input-group-append input-group-prepend"><span class="input-group-text">to</span></span>
                                                <asp:TextBox ID="tbEvalEndDate" CssClass="form-control input-sm pick-date" runat="server" placeholder="End date"></asp:TextBox>
                                            </div>

                                        </div>

                                    </div>
                                </div>
                                <div class="col col-lg-2">
                                    <asp:LinkButton CssClass="btn btn-outline-secondary float-right" ID="lbtUpdateEvalFilter" runat="server" CausesValidation="False" CommandName="Filter"><i aria-hidden="true" class="fas fa-filter"></i> Apply filter</asp:LinkButton>

                                </div>
                            </div>


                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col col-md-4 col-lg-3 col-sm-6">
                                    <div class="card card-default">
                                        <div class="card-header">
                                            <h5>Increased productvity?</h5>
                                        </div>
                                        <div id="eval-chart-Q1" style="height: 215px;"></div>
                                    </div>
                                </div>
                                <div class="col col-md-4 col-lg-3 col-sm-6">
                                    <div class="card card-default">
                                        <div class="card-header">
                                            <h5>Gained new skills?</h5>
                                        </div>
                                        <div id="eval-chart-Q2" style="height: 215px;"></div>
                                    </div>
                                </div>
                                <div class="col col-md-4 col-lg-3 col-sm-6">
                                    <div class="card card-default">
                                        <div class="card-header">
                                            <h5>Perform faster?</h5>
                                        </div>
                                        <div id="eval-chart-Q3" style="height: 215px;"></div>
                                    </div>
                                </div>
                                <div class="col col-md-4 col-lg-3 col-sm-6">
                                    <div class="card card-default">
                                        <div class="card-header">
                                            <h5>Time saving per week</h5>
                                        </div>
                                        <div id="eval-chart-Q4" style="height: 215px;"></div>
                                    </div>
                                </div>
                                <div class="col col-md-4 col-lg-3 col-sm-6">
                                    <div class="card card-default">
                                        <div class="card-header">
                                            <h5>Pass on skills?</h5>
                                        </div>
                                        <div id="eval-chart-Q5" style="height: 215px;"></div>
                                    </div>
                                </div>
                                <div class="col col-md-4 col-lg-3 col-sm-6">
                                    <div class="card card-default">
                                        <div class="card-header">
                                            <h5>Help with patients / clients?</h5>
                                        </div>
                                        <div id="eval-chart-Q6" style="height: 215px;"></div>
                                    </div>
                                </div>
                                <div class="col col-md-4 col-lg-3 col-sm-6">
                                    <div class="card card-default">
                                        <div class="card-header">
                                            <h5>Recommend materials?</h5>
                                        </div>
                                        <div id="eval-chart-Q7" style="height: 215px;"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer clearfix">
                            <asp:LinkButton ID="lbtExportEvalStats" CssClass="btn btn-outline-secondary float-right" runat="server"><i aria-hidden="true" class="fas fa-file-export"></i> Download to Excel</asp:LinkButton>

                        </div>
                    </div>
                </div>
            </div>
        </asp:View>
        <asp:View ID="vHelpdesk" runat="server">
            <div class="row">
                <div class="col col-md-12">
                    <h2 class="page-header mt-3 mb-3">Helpdesk Ticket Usage and SLA Compliance</h2>
                </div>
            </div>
            <div class="row">
                <div class="col col-lg-5">
                    <div class="card card-default">
                        <div class="card-header clearfix">
                            <h4>This Month</h4>
                        </div>
                        <div id="helpdesk-donut" style="height: 445px;"></div>

                    </div>
                </div>
                <div class="col col-lg-7">
                    <div class="card card-default">
                        <div class="card-header clearfix">
                            <div class="row">
                                <div class="col col-lg-10">
                                    <div class="form-inline small">

                                        <div class="form-group row">

                                            <asp:Label ID="Label15" AssociatedControlID="ddRegionID" CssClass="filter-col" runat="server" Text="Months:"></asp:Label>
                                            <asp:DropDownList CssClass="form-control input-sm" ID="ddMonths" runat="server">
                                                <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                <asp:ListItem Text="12" Selected="True" Value="12"></asp:ListItem>
                                                <asp:ListItem Text="24" Value="24"></asp:ListItem>
                                                <asp:ListItem Text="36" Value="36"></asp:ListItem>
                                                <asp:ListItem Text="48" Value="48"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col col-lg-2">
                                    <asp:LinkButton CssClass="btn btn-outline-secondary float-right" ID="lbtUpdateHDStats" runat="server" CausesValidation="False"><i aria-hidden="true" class="fas fa-sync-alt"></i> Update</asp:LinkButton>

                                </div>
                            </div>
                        </div>
                        <div id="helpdesk-chart" style="height: 395px;"></div>
                        <div class="card-footer clearfix">
                            <asp:LinkButton ID="lbtDownloadHelpdeskStats" CssClass="btn btn-outline-secondary float-right" runat="server"><i aria-hidden="true" class="fas fa-file-export"></i> Download to Excel</asp:LinkButton>

                        </div>
                    </div>
                </div>

            </div>
        </asp:View>
        <asp:View ID="vDigitalCapability" runat="server">
             <div class="row">
                <div class="col col-md-12">
                    <h2 class="page-header mt-3 mb-3">Digital Capability Self Assessment Stats</h2>
                </div>
            </div>
                <div class="alert alert-success" role="alert">
                    <asp:Label ID="lblDCSACompleted" runat="server" Text="Label"></asp:Label>
</div>
                <div class="alert alert-warning" role="alert">
  <asp:Label ID="lblDCSAReviewing" runat="server" Text="Label"></asp:Label>
</div>
<div class="alert alert-danger" role="alert">
  <asp:Label ID="lblDCSAIncomplete" runat="server" Text="Label"></asp:Label>
</div>
            <asp:LinkButton ID="lbtDownloadDCSAReport" CssClass="btn btn-success float-right" runat="server"><i aria-hidden="true" class="fas fa-file-export"></i> Download to Excel</asp:LinkButton>
        </asp:View>
    </asp:MultiView>
</asp:Content>
