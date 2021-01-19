<%@ Page Title="Publish" Language="vb" AutoEventWireup="false" MasterPageFile="~/cms/CMS.Master" CodeBehind="Publish.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.Publish" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>


<%@ Register assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        function BindEvents() {
            $(document).ready(function () {
                $('.bs-pagination td table').each(function (index, obj) {
                    convertToPagination(obj)
                });
                $('[data-toggle="popover"]').popover();
            });
        };
    </script>
    <script src="../Scripts/bs.pagination.js"></script>
    <h2>Publishing Options</h2>
    <hr />
     <asp:MultiView ID="mvPublishContent" runat="server">
        <asp:View ID="vChooseCourse" runat="server">
            <asp:ObjectDataSource ID="dsCourses" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetForPublish" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.ApplicationsTableAdapter">
               
                <SelectParameters>
                   <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                   <asp:SessionParameter DefaultValue="False" Name="PublishToAll" SessionField="UserPublishToAll" Type="Boolean" />
                    <asp:ControlParameter ControlID="cbFilterForCentre" DefaultValue="1" Name="ShowOnlyMine" PropertyName="Checked" Type="Boolean" />
                </SelectParameters>
             
            </asp:ObjectDataSource>
            <div class="card card-primary">
                <div class="card-header">
                    Choose a Course to Publish<div class="float-right">
                    <asp:CheckBox ID="cbFilterForCentre" runat="server" TextAlign="Right" Font-Bold="false" Font-Size="Smaller" Text="Show only my centre's courses?" Checked="true" AutoPostBack="True" /></div>
                </div>
                <div class="card-body">
                    <div class="m-3" id="frmSelectCourse" runat="server">
                        <div class="form-group row">
                            <asp:Label ID="lblSelectCourse" AssociatedControlID="ddCourse" CssClass="control-label col-xs-4" runat="server" Text="Select course:"></asp:Label>
                            <div class="col col-xs-8">
                                <asp:DropDownList CssClass="form-control" ID="ddCourse" runat="server" DataSourceID="dsCourses" DataTextField="ApplicationName" DataValueField="ApplicationID" AppendDataBoundItems="True">
                                    <asp:ListItem Text="Please select..." Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer clearfix">
                    <asp:LinkButton ID="lbtOK" CssClass="btn btn-primary float-right" runat="server">OK</asp:LinkButton>
                </div>
            </div>
        </asp:View>
         <asp:View ID="vPublish" runat="server">
             <div class="card card-primary">
                <div class="card-header">
             <h4>
                        <asp:Label ID="lblCourseHeading" runat="server" Text=""></asp:Label></h4>
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
                    <a data-toggle="collapse" class="text-white" href="#filterCollapse"><i aria-hidden="true" class="fas fa-caret-down"></i> Filter / search...</a>
                </div>
                <div class="card-body collapse in" id="filterCollapse"  >
                    <div  class="card-collapse form-inline" role="form">

                        <asp:ObjectDataSource ID="dsRegions" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.RegionsTableAdapter"></asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="dsCentreTypes" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.CentreTypesTableAdapter"></asp:ObjectDataSource>
                        <div class="form-group mb-1">
                            <asp:Label ID="Label1" CssClass="control-label col" runat="server" AssociatedControlID="ddCentreType" Text="Centre type:"></asp:Label><asp:DropDownList ID="ddCentreType" AppendDataBoundItems="True" runat="server" DataSourceID="dsCentreTypes" CssClass="form-control input-sm" DataTextField="CentreType" DataValueField="CentreTypeID">
                                <asp:ListItem Selected="True" Text="All" Value="-1"></asp:ListItem>

                            </asp:DropDownList>

                        </div>
                        <div class="form-group mb-1">
                            <asp:Label ID="lblSharedWith" CssClass="control-label col" runat="server" AssociatedControlID="ddRegions" Text="Region:"></asp:Label>
                            <asp:DropDownList ID="ddRegions" AppendDataBoundItems="True" runat="server" DataSourceID="dsRegions" CssClass="form-control input-sm" DataTextField="RegionName" DataValueField="RegionID">
                                <asp:ListItem Selected="True" Text="All" Value="-1"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                         <div class="form-group mb-1 mr-1">
                             <asp:Label ID="lblSearchTerm" CssClass="control-label col" runat="server" AssociatedControlID="tbSearch" Text="Search term:"></asp:Label>
                             <asp:TextBox ID="tbSearch" CssClass="form-control input-sm" runat="server" placeholder="organisation name contains"></asp:TextBox>
                             </div>
                        <div class="form-group mb-1">
                        <asp:LinkButton CssClass="btn btn-success float-right" ID="lbtUpdateFilter" runat="server"><i class="fas fa-cog"></i> Update</asp:LinkButton>
                            </div>
                    </div>
                </div>
            </div>
        
    </asp:Panel>
                             

    <asp:ObjectDataSource ID="dsNewsCentresForPub" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetNewCentresForPublishing" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.CentresTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddCentreType" Name="CentreTypeID" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="ddRegions" Name="RegionID" PropertyName="SelectedValue" Type="Int32" />
            <asp:SessionParameter Name="UserCentreID" SessionField="UserCentreID" Type="Int32" />
            <asp:ControlParameter ControlID="tbSearch" Name="SearchTerm" PropertyName="Text" Type="String" ConvertEmptyStringToNull="False" />
            <asp:SessionParameter Name="PublishToAll" SessionField="UserPublishToAll" Type="String" />
            <asp:QueryStringParameter Name="CourseID" QueryStringField="courseid" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsCentresForApp" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.CentreApplicationsTableAdapter">
        <SelectParameters>
            <asp:QueryStringParameter Name="CourseID" QueryStringField="courseid" Type="Int32" />
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
             
            <dx:BootstrapGridView ID="bsgvPublishedToCentres" runat="server" AutoGenerateColumns="False" DataSourceID="dsCentresForApp" KeyFieldName="CentreApplicationID" SettingsBootstrap-Striped="True" SettingsBootstrap-Sizing="Large" Settings-GridLines="None">
                <Columns>
                    <dx:BootstrapGridViewTextColumn FieldName="CentreName" VisibleIndex="0">
                    </dx:BootstrapGridViewTextColumn>
                    <dx:BootstrapGridViewTextColumn FieldName="CentreType" VisibleIndex="1">
                    </dx:BootstrapGridViewTextColumn>
                    <dx:BootstrapGridViewTextColumn Caption="Region" FieldName="RegionName" VisibleIndex="2">
                    </dx:BootstrapGridViewTextColumn>
                    <dx:BootstrapGridViewTextColumn Caption=" " Name="DeleteCmd" VisibleIndex="3">
                       <DataItemTemplate>
                            <asp:LinkButton ID="lbtDelete" EnableViewState="false" runat="server" CssClass="btn btn-danger btn-sm" CausesValidation="False" ToolTip="Remove course from centre." OnCommand="lbtDelete_Command" CommandArgument='<%#Eval("CentreApplicationID")%>' Text=""><i aria-hidden="true" class="fas fa-times"></i></asp:LinkButton>
                       </DataItemTemplate>
                    </dx:BootstrapGridViewTextColumn>
                </Columns>
             </dx:BootstrapGridView>
            <asp:Panel ID="pnlOutcome" Visible="false" CssClass="alert alert-info"  runat="server"><asp:Label ID="lblPublished" runat="server" Text=""></asp:Label></asp:Panel>
            

        </ContentTemplate><Triggers>
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
    <script>
        Sys.Application.add_load(BindEvents);
    </script>
</asp:Content>
