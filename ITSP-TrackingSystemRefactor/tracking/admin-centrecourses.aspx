<%@ Page Title="Admin - Centre Courses" Language="vb" AutoEventWireup="false" MasterPageFile="~/tracking/Site.Master" CodeBehind="admin-centrecourses.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.admin_centrecourses" %>
<asp:Content ID="Content1" ContentPlaceHolderID="breadtray" runat="server">
   <ol class="breadcrumb breadcrumb-slash">
        <li class="breadcrumb-item"><a href="admin-configuration">Admin </a></li>
        <li class="breadcrumb-item active">Centre Courses</li>
    </ol>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
      <asp:MultiView ID="mvPublishContent" ActiveViewIndex="0" runat="server">
        <asp:View ID="vChooseCourse" runat="server">
            <asp:ObjectDataSource ID="dsCourses" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetCoreContent" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.ApplicationsTableAdapter">
               
                <SelectParameters>
                    <asp:ControlParameter ControlID="cbFilterForCentre" Name="ShowOnlyCore" PropertyName="Checked" Type="String" />
                </SelectParameters>
             
            </asp:ObjectDataSource>
            <div class="card card-primary">
                <div class="card-header">
                    Choose a Course to Manage<div class="float-right">
                    <asp:CheckBox ID="cbFilterForCentre" runat="server" TextAlign="Right" Font-Bold="false" Font-Size="Smaller" Text="Show only ITSP central courses?" Checked="true" AutoPostBack="True" /></div>
                </div>
                <div class="card-body">
                    <div class="m-3" id="frmSelectCourse" runat="server">
                        <div class="form-group row">
                            <asp:Label ID="lblSelectCourse" AssociatedControlID="ddCourse" CssClass="control-label col-xs-4" runat="server" Text="Select course:"></asp:Label>
                            <div class="col col-xs-8">
                                <asp:DropDownList CssClass="form-control" ID="ddCourse" runat="server" DataSourceID="dsCourses" DataTextField="ApplicationName" DataValueField="ApplicationID" AppendDataBoundItems="True">
                                    <asp:ListItem Text="Please select..." Value="0"></asp:ListItem>
                                </asp:DropDownList><asp:CompareValidator Display="Dynamic" ValidationGroup="vgCourseSelect" ID="CompareValidator1" ControlToValidate="ddCourse" ValueToCompare="0" Operator="GreaterThan" runat="server" ErrorMessage="Select a course"></asp:CompareValidator>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer clearfix">
                    <asp:LinkButton ID="lbtOK" CausesValidation="true" ValidationGroup="vgCourseSelect" CssClass="btn btn-primary float-right" runat="server">OK</asp:LinkButton>
                </div>
            </div>
        </asp:View>
         <asp:View ID="vPublish" runat="server">
             <div class="card card-primary">
                <div class="card-header">
                    <div class="row">
                        <div class="col col-md-9">
             <h4>
                        <asp:Label ID="lblCourseHeading" runat="server" Text=""></asp:Label></h4></div>
                        <div class="col col-md-3">
                            <asp:LinkButton ID="lbtBack" CssClass="btn btn-light float-right" ToolTip="Back to course selection" runat="server"><i aria-hidden="true" class="fas fa-arrow-left"></i> Back</asp:LinkButton></div>
                    </div>
                    </div>
                  <div class="card-body">
                     <div class="card card-default mb-2">
                <div class="card-header">
                    Publish Course to Centres
                    </div>
                         <div class="card-body">
    <asp:Panel ID="pnlFilterSearch" runat="server">
        
       
        
            <div class="card card-info">
                <div class="card-header">
                    <a data-toggle="collapse" href="#filterCollapse"><i aria-hidden="true" class="fas fa-caret-down"></i> Filter / search...</a>
                </div>
                <div class="card-body collapse in form-inline" id="filterCollapse"  >
                    <div  class="card-collapse" role="form">

                        <asp:ObjectDataSource ID="dsRegions" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.RegionsTableAdapter"></asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="dsCentreTypes" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.CentreTypesTableAdapter"></asp:ObjectDataSource>
                        <div class="form-group row">
                            <asp:Label ID="Label1" CssClass="control-label filter-col" runat="server" AssociatedControlID="ddCentreType" Text="Centre type:"></asp:Label><asp:DropDownList ID="ddCentreType" AppendDataBoundItems="True" runat="server" DataSourceID="dsCentreTypes" CssClass="form-control input-sm" DataTextField="CentreType" DataValueField="CentreTypeID">
                                <asp:ListItem Selected="True" Text="All" Value="-1"></asp:ListItem>

                            </asp:DropDownList>

                        </div>
                        <asp:Panel ID="pnlShareOrg" runat="server" CssClass="form-group row">
                            <asp:Label ID="lblSharedWith" CssClass="control-label filter-col" runat="server" AssociatedControlID="ddRegions" Text="Region:"></asp:Label><asp:DropDownList ID="ddRegions" AppendDataBoundItems="True" runat="server" DataSourceID="dsRegions" CssClass="form-control input-sm" DataTextField="RegionName" DataValueField="RegionID">
                                <asp:ListItem Selected="True" Text="All" Value="-1"></asp:ListItem>

                            </asp:DropDownList>
                        </asp:Panel>
                         <div class="form-group row">
                             <asp:Label ID="lblSearchTerm" CssClass="control-label filter-col" runat="server" AssociatedControlID="tbSearch" Text="Search term:"></asp:Label>
                             <asp:TextBox ID="tbSearch" CssClass="form-control input-sm" runat="server" placeholder="organisation name contains"></asp:TextBox>
                             </div>
                        <asp:LinkButton CssClass="btn btn-success float-right" ID="lbtUpdateFilter" runat="server"><i class="fas fa-cog"></i> Update</asp:LinkButton>

                    </div>
                </div>
            </div>
        
    </asp:Panel>
                             

    <asp:ObjectDataSource ID="dsNewsCentresForPub" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.CentresForPublishingTableAdapter">
       
        <SelectParameters>
            <asp:ControlParameter ControlID="ddCentreType" Name="CentreTypeID" PropertyName="SelectedValue" Type="Int32" DefaultValue="-1" />
            <asp:ControlParameter ControlID="ddRegions" Name="RegionID" PropertyName="SelectedValue" Type="Int32" DefaultValue="-1" />
            <asp:ControlParameter ControlID="tbSearch" ConvertEmptyStringToNull="False" Name="SearchTerm" PropertyName="Text" Type="String" />
            <asp:Parameter DefaultValue="0" Name="CourseID" Type="Int32" />
        </SelectParameters>
        
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsCentresForApp" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.CentreApplicationsTableAdapter">
        <SelectParameters>
            <asp:Parameter DefaultValue="0" Name="CourseID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <br />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
           <div class =" m-3">
            <div class="form-group row">
               
                <asp:Label ID="Label2" AssociatedControlID="ddCentresToAdd" CssClass="control-label col-sm-3" runat="server" Text="Centres available to publish to:"></asp:Label>
                  
                <div class="col col-sm-5">
                <asp:DropDownList ID="ddCentresToAdd" runat="server" DataSourceID="dsNewsCentresForPub" CssClass="form-control" DataTextField="CentreName" DataValueField="CentreID"></asp:DropDownList>
                    </div>
                <div class="col col-sm-2">
                <asp:LinkButton ID="lbtAdd" cssclass="btn btn-primary" ToolTip="Publish to selected centre in drop down list" runat="server"><i aria-hidden="true" class="fas fa-plus"></i> <b>Add To Centre</b> </asp:LinkButton>
                    </div>
                <div class="col col-sm-2">
                <asp:LinkButton ID="lbtAddAll" cssclass="btn btn-warning" ToolTip="Publish to all centres in drop down list" runat="server"><i aria-hidden="true" class="fas fa-plus"></i> <b>Add To All</b> </asp:LinkButton>
                    </div>
            </div></div></ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="lbtUpdateFilter" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
                         </div>
                         </div>
                         <div class="card card-default">
                <div class="card-header">
            Centres Published To
                    </div>
                             <div class="card-body">
                                 <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <div class="card card-default">
             <asp:GridView ID="gvPublishedToCentres" AllowPaging="True" PagerStyle-CssClass="bs-pagination" CssClass="table table-striped" EmptyDataText="This course is not published to any centres currently." AllowSorting="True" HeaderStyle-CssClass="sorted-none" GridLines="None" runat="server" AutoGenerateColumns="False" DataKeyNames="CentreApplicationID" DataSourceID="dsCentresForApp" PagerStyle-HorizontalAlign="Right">
        <Columns>
           
            <asp:BoundField DataField="CentreName" HeaderText="Centre Name" SortExpression="CentreName" />
            <asp:BoundField DataField="CentreType" HeaderText="Centre Type" SortExpression="CentreType" />
            <asp:BoundField DataField="RegionName" HeaderText="Region" SortExpression="RegionName" />
            <asp:TemplateField>
                <ItemTemplate>
                     <asp:LinkButton ID="lbtDelete" runat="server" CssClass="btn btn-danger btn-sm" CausesValidation="False" ToolTip="Remove course from centre." CommandName="DeleteCentreApp" CommandArgument='<%#Eval("CentreApplicationID")%>' Text=""><i aria-hidden="true" class="fas fa-times"></i></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>

        <HeaderStyle CssClass="sorted-none"></HeaderStyle>

<PagerStyle HorizontalAlign="Right" CssClass="bs-pagination"></PagerStyle>
    </asp:GridView></div></ContentTemplate><Triggers>
            <asp:AsyncPostBackTrigger ControlID="lbtAdd" EventName="Click" />
        <asp:AsyncPostBackTrigger ControlID="lbtAddAll" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
        </div></div>
                      </div>
                 </div>
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
