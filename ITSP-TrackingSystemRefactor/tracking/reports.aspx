<%@ Page Title="Reports" Language="vb" AutoEventWireup="false" MasterPageFile="~/tracking/Site.Master" CodeBehind="reports.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.reports" %>


<asp:Content ID="Content1" ContentPlaceHolderID="breadtray" runat="server">
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/css/bootstrap-datepicker3.min.css">

    <script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/js/bootstrap-datepicker.min.js"></script>
    <script src="https://www.gstatic.com/charts/loader.js"></script>
   <ol class="breadcrumb breadcrumb-slash">
       <li class="breadcrumb-item"><a href="dashboard">Centre </a></li>
        <li  class="breadcrumb-item active">Reports</li>
    </ol>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <ul class="nav nav-pills">
        <li class="nav-item" role="presentation" id="tab2" runat="server">
            <asp:LinkButton CssClass="nav-link" ID="lbtUsageTrend" runat="server">Usage Chart</asp:LinkButton></li>
        <li class="nav-item" role="presentation" id="tab3" runat="server">
            <asp:LinkButton CssClass="nav-link" ID="lbtEvaluationTab" runat="server">Evaluation Summary</asp:LinkButton></li>
    </ul>
     <asp:MultiView ID="mvStats" ActiveViewIndex="0" runat="server">
         <asp:View ID="vUsageChart" runat="server">
           
            <!-- /.row -->
            <asp:ObjectDataSource ID="dsCourseCategories" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetActiveForCentre" TypeName="ITSP_TrackingSystemRefactor.customiseTableAdapters.CourseCategoriesTableAdapter">
                <SelectParameters>
                    <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                </SelectParameters>
             </asp:ObjectDataSource>
           
            <div class="row">
                <div class="col col-lg-12">
                    <div class="card card-default">
                        <div class="card-header clearfix">
                            <div class="form-header">
                                            <h5>Filter / Search</h5>
                                        </div>
                            <div class="row">
                                <div class="col col-lg-10">
                                    
                                    <div class="form-inline small">
                                        
                                        
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
                                            <asp:Label ID="Label2" AssociatedControlID="ddCustomisationID" runat="server" CssClass="filter-col" Text="Course:"></asp:Label>
                                            <asp:DropDownList CssClass="form-control input-sm" ID="ddCustomisationID" runat="server">
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
                                            <asp:Label ID="Label14" AssociatedControlID="ddPeriodType" runat="server" CssClass="filter-col " Text="Report by:"></asp:Label>
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
                        <div id="activity-chart" style="height: 395px;"></div>
                        <div class="card-footer clearfix">
                            <asp:LinkButton ID="lbtExportActivityChartDataToExcel" CssClass="btn btn-outline-secondary float-right" runat="server"><i aria-hidden="true" class="fas fa-file-export"></i> Download to Excel</asp:LinkButton>

                        </div>
                    </div>
                </div>
            </div>
            <script>
                $('.pick-date').datepicker({
                    format: "dd/mm/yyyy"
                });
            </script>
        </asp:View>
        <asp:View ID="vEvaluation" runat="server">

            <div class="row">
                <div class="col col-lg-12">
                    <div class="card card-default">
                        <div class="card-header clearfix">
                            <div class="form-header">
                                            <h5>Filter / Search</h5>
                                        </div>
                                      
                            <div class="row">
                                <div class="col col-lg-10">
                                    <div class="form-inline small">
                                        
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
                                            <asp:Label ID="Label1" AssociatedControlID="ddEvalCustomisationID" runat="server" CssClass="filter-col" Text="Course:"></asp:Label>
                                            <asp:DropDownList AppendDataBoundItems="True" CssClass="form-control input-sm" ID="ddEvalCustomisationID" runat="server">
                                                <asp:ListItem Value="-1">All</asp:ListItem>
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
                                <div class="card card-default"><div class="card-header">
                                    <h5>Increased productvity?</h5>
                                                                 </div>
                                <div id="eval-chart-Q1" style="height: 215px;"></div></div>
                            </div>
                            <div class="col col-md-4 col-lg-3 col-sm-6">
                                <div class="card card-default"><div class="card-header">
                                    <h5>Gained new skills?</h5>
                                                                 </div>
                                <div id="eval-chart-Q2" style="height: 215px;"></div></div>
                            </div>
                            <div class="col col-md-4 col-lg-3 col-sm-6">
                                <div class="card card-default"><div class="card-header">
                                    <h5>Perform faster?</h5>
                                                                 </div>
                                <div id="eval-chart-Q3" style="height: 215px;"></div></div>
                            </div>
                            <div class="col col-md-4 col-lg-3 col-sm-6"><div class="card card-default"><div class="card-header">
                                    <h5>Time saving per week</h5>
                                                                 </div>
                                <div id="eval-chart-Q4" style="height: 215px;"></div></div>
                            </div>
                            <div class="col col-md-4 col-lg-3 col-sm-6"><div class="card card-default"><div class="card-header">
                                    <h5>Pass on skills?</h5>
                                                                 </div>
                                <div id="eval-chart-Q5" style="height: 215px;"></div></div>
                            </div>
                            <div class="col col-md-4 col-lg-3 col-sm-6"><div class="card card-default"><div class="card-header">
                                    <h5>Help with patients / clients?</h5>
                                                                 </div>
                                <div id="eval-chart-Q6" style="height: 215px;"></div></div>
                            </div>
                            <div class="col col-md-4 col-lg-3 col-sm-6"><div class="card card-default"><div class="card-header">
                                    <h5>Recommend materials?</h5>
                                                                 </div>
                                <div id="eval-chart-Q7" style="height: 215px;"></div></div>
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
     </asp:MultiView>
</asp:Content>
