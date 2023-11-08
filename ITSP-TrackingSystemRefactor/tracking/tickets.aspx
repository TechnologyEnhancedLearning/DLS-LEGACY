<%@ Page Title="Support Tickets" Language="vb" AutoEventWireup="false" MasterPageFile="~/tracking/Site.Master" CodeBehind="tickets.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.tickets" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxHtmlEditor.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxHtmlEditor" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxSpellChecker.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxSpellChecker" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="breadtray" runat="server">
   <ol class="breadcrumb breadcrumb-slash">
        <li class="breadcrumb-item">Support</li>
        <li class="breadcrumb-item active">Tickets</li>
    </ol>
    <script src="../Scripts/plugindetect.js"></script>
    <script src="../Scripts/jquery.browser.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .avatar-left{
                width: 60px;
    height: 60px;
    border-radius: 100%;
    box-shadow: 0 2px 3px 0 rgba(0,0,0,.14), 0 2px 2px -2px rgba(0,0,0,.2), 0 1px 7px 0 rgba(0,0,0,.12);
    position: absolute;
    top: 0;
    left: 0;
    transform: translate(-25%,-25%);
    transition: all ease .3s;
    z-index: 2
        }
        .avatar-right{
                width: 60px;
    height: 60px;
    border-radius: 100%;
    box-shadow: 0 2px 3px 0 rgba(0,0,0,.14), 0 2px 2px -2px rgba(0,0,0,.2), 0 1px 7px 0 rgba(0,0,0,.12);
    position: absolute;
    top: 0;
    right: 0;
    transform: translate(25%,-25%);
    transition: all ease .3s;
    z-index: 2
        }
        .avatar-left:hover, .avatar-right:hover{
            box-shadow: 0 6px 10px 0 rgba(0,0,0,.14),0 1px 18px 0 rgba(0,0,0,.12),0 3px 5px -1px rgba(0,0,0,.2);
        /*transform: translate(-25%,-25%);*/
        width: 70px;
        height: 70px;
        z-index: 2
        }
        .pad-left{
            padding-left:25px;
        }
        .pad-right{
            padding-right:25px;
        }
        
    </style>
     <asp:MultiView ID="mvSupportTickets" ActiveViewIndex="0" runat="server">
        <asp:View ID="vTicketList" runat="server">
    <asp:ObjectDataSource ID="dsTickets" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetForAdminUserID" TypeName="ITSP_TrackingSystemRefactor.supportdataTableAdapters.TicketListTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="AdminUserID" SessionField="UserAdminID" Type="Int32" />
            <asp:ControlParameter ControlID="bscbIncludeArchive" Name="ShowArchivedTickets" PropertyName="Value" Type="Boolean" DefaultValue="0" />
        </SelectParameters>
    </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="dsReassigns" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.supportdataTableAdapters.SuperAdminUsersTableAdapter"></asp:ObjectDataSource>
            <asp:ObjectDataSource ID="dsTicketComments" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.supportdataTableAdapters.TicketCommentsTableAdapter">
                <SelectParameters>
                    <asp:Parameter DefaultValue="0" Name="TicketID" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="dsCustomisations" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.supportdataTableAdapters.CustomisationsTableAdapter">
                <SelectParameters>
                    <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="dsTicketTypes" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.supportdataTableAdapters.TicketTypesTableAdapter"></asp:ObjectDataSource>
            <asp:ObjectDataSource ID="dsCategoryID" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.supportdataTableAdapters.TicketCategoriesTableAdapter"></asp:ObjectDataSource>

            <div class="row">
                <div class="col">
                    <div class="float-right">
             <dx:BootstrapCheckBox ID="bscbIncludeArchive" Checked="false" runat="server" Text="Include archived?" AutoPostBack="True"></dx:BootstrapCheckBox></div>
                        </div></div>

                <dx:ASPxGridViewExporter ID="TicketGridViewExporter" FileName="DLS Tickets" GridViewID="bsgvTickets" runat="server"></dx:ASPxGridViewExporter>
                <div class="table-responsive">
                    <dx:BootstrapGridView ID="bsgvTickets" SettingsPager-Summary-EmptyText="No tickets to display" runat="server" AutoGenerateColumns="False" DataSourceID="dsTickets" KeyFieldName="TicketID" SettingsCustomizationDialog-Enabled="True" OnToolbarItemClick="GridViewCustomToolbar_ToolbarItemClick" Settings-GridLines="None" SettingsBootstrap-Sizing="Large" SettingsBootstrap-Striped="True">
                        
                        <SettingsBootstrap Striped="True" />
                        <Settings ShowHeaderFilterButton="True" />
                        <SettingsCookies Enabled="True" Version="0.14" />
                        <SettingsPager PageSize="15">
                        </SettingsPager>
                        <Columns>
                            <dx:BootstrapGridViewTextColumn Caption="ID" FieldName="TicketID" Name="ID" ReadOnly="True" VisibleIndex="0" Settings-AllowHeaderFilter="False">
                                <Settings AllowHeaderFilter="False" />
                                <SettingsEditForm Visible="False" />
                                <DataItemTemplate>
                                    <asp:LinkButton EnableViewState="false" ID="lbtOpenTicket" CausesValidation="false" runat="server" ToolTip='<%# "View ticket - Status: " & GetTicketStatus(Eval("TStatusID"))%>' OnCommand="OpenTicket_Click" CommandArgument='<%# Eval("TicketID")%>' CssClass='<%# GetTicketColourStatus(Eval("TStatusID"))%>'>
                                <i aria-hidden="true" class="fas fa-tag"></i>
                                <asp:Label ID="Label1" EnableViewState="false" runat="server" Text='<%#  Eval("TicketID")%>'></asp:Label>
                            </asp:LinkButton>
                                </DataItemTemplate>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn Caption="Subject" FieldName="QuerySubject" Name="Subject" VisibleIndex="1" Settings-AllowHeaderFilter="False">
                                
                                <Settings AllowHeaderFilter="False" />
                                
                                <DataItemTemplate>
                                     <asp:LinkButton runat="server" EnableViewState="false" OnCommand="OpenTicket_Click" CommandArgument='<%# Eval("TicketID")%>' ToolTip="View Ticket Details"
                                  Text='<%# DataBinder.Eval(Container.DataItem, "QuerySubject", "{0}") %>'></asp:LinkButton>
                                </DataItemTemplate>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Type" ReadOnly="True" Visible="False" VisibleIndex="2" SettingsHeaderFilter-Mode="CheckedList">
                                <SettingsHeaderFilter Mode="CheckedList">
                                </SettingsHeaderFilter>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Category" ReadOnly="True" Visible="False" VisibleIndex="3" SettingsHeaderFilter-Mode="CheckedList">
                                <SettingsHeaderFilter Mode="CheckedList">
                                </SettingsHeaderFilter>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn Caption="Centre" FieldName="CentreName" Name="Centre" VisibleIndex="4" SettingsHeaderFilter-Mode="CheckedList">
                                <SettingsHeaderFilter Mode="CheckedList">
                                </SettingsHeaderFilter>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn Caption="Reporter" FieldName="ReporterName" Name="Reporter" ReadOnly="True" VisibleIndex="5" SettingsHeaderFilter-Mode="CheckedList">
                                <SettingsHeaderFilter Mode="CheckedList">
                                </SettingsHeaderFilter>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Email" Visible="False" VisibleIndex="6">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewDateColumn FieldName="RaisedDate" Caption="Raised" Name="Raised" VisibleIndex="7">
                            </dx:BootstrapGridViewDateColumn>
                            <dx:BootstrapGridViewTextColumn Caption="Resolve By" FieldName="ResolveBy" Name="Resolve By" VisibleIndex="8" PropertiesTextEdit-DisplayFormatString="dd/MM/yyyy">
                               <DataItemTemplate>
                                   <asp:Label ID="lblTargetDateGV" EnableViewState="false" runat="server" CssClass='<%# GetSLACSS(Eval("ResolveBy"))%>' Text='<%# Eval("ResolveBy", "{0:d}")%>'></asp:Label>
                               </DataItemTemplate>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn Caption="Status" Visible="false" FieldName="TStatus" Name="Status" ReadOnly="True" VisibleIndex="9">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn Caption="Assigned To" FieldName="AssignedToName" Name="Assigned To" ReadOnly="True" VisibleIndex="10" SettingsHeaderFilter-Mode="CheckedList"> 
                                <SettingsHeaderFilter Mode="CheckedList">
                                </SettingsHeaderFilter>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn Caption="Assigned Email" Name="Assigned to Email" FieldName="AssignedToEmail"  ReadOnly="True" Visible="False" VisibleIndex="11" SettingsHeaderFilter-Mode="CheckedList">
                                <SettingsHeaderFilter Mode="CheckedList">
                                </SettingsHeaderFilter>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewDateColumn Caption="Last Activity" FieldName="LastActivityDate" Name="Last Activity" ReadOnly="True" VisibleIndex="12">
                            </dx:BootstrapGridViewDateColumn>
                            <dx:BootstrapGridViewDateColumn FieldName="ArchivedDate" Caption="Archived" Name="Archived" VisibleIndex="13">
                                <DataItemTemplate>
                                      <asp:Label ID="lblClosedDateGV" runat="server" Text='<%# Eval("ArchivedDate", "{0:d}")%>'></asp:Label>
                            <asp:LinkButton ID="lbtCloseTicket" CausesValidation="false" Visible='<%# Eval("ArchivedDate").ToString() = ""%>' OnClientClick="return confirm('Are you sure you wish to archive this ticket?');" OnCommand="ArchiveTicket_Click" CommandArgument='<%# Eval("TicketID")%>' ToolTip="Archive ticket" CssClass="btn btn-outline-danger btn-sm" runat="server"><i aria-hidden="true" class="fas fa-trash"></i> Archive</asp:LinkButton>
                       
                                </DataItemTemplate>
                            </dx:BootstrapGridViewDateColumn>
                            
                        </Columns>
                          <ClientSideEvents ToolbarItemClick="onToolbarItemClick" />
                        <Toolbars>
        <dx:BootstrapGridViewToolbar Name="gvToolbar" Position="Top">
            <Items>
                <dx:BootstrapGridViewToolbarItem Command="ClearGrouping" IconCssClass="far fa-caret-square-down" />
                <dx:BootstrapGridViewToolbarItem Command="ClearSorting" IconCssClass="fas fa-sort" />
                <dx:BootstrapGridViewToolbarItem Command="ClearFilter" />
                <dx:BootstrapGridViewToolbarItem Command="ShowCustomizationDialog" Text="Customise Grid"/>
                    <dx:BootstrapGridViewToolbarItem Command="Custom" Name="ExcelExport" Text="Excel Export" IconCssClass="fas fa-file-export" />                
            </Items>
        </dx:BootstrapGridViewToolbar>
    </Toolbars>
                        <SettingsSearchPanel Visible="True" AllowTextInputTimer="false" />
                    </dx:BootstrapGridView>
                    </div>
            </asp:View>
         
         <asp:View ID="vManageTicket" runat="server">
             <asp:HiddenField ID="hfTicketID" runat="server" />
            <asp:HiddenField ID="hfReporterEmail" runat="server" />
             <asp:HiddenField ID="hfReporterAUID" runat="server" />
            <div class="card card-primary" style="padding: 2%;">
                <div class="card-body">
                <div class="clearfix">
                    
                    <b>
                        <i aria-hidden="true" class="fas fa-tag"></i>
                        <asp:Label ID="lblTicketHeader" runat="server" Text="Ticket"></asp:Label> (Status: <asp:Label ID="lblTicketStatus" runat="server" Text="Label"></asp:Label>)</b>
                    <div class="btn-group float-right" role="group" aria-label="...">
                            <asp:LinkButton ID="lbtCloseTicket" CssClass="btn btn-outline-secondary" CausesValidation="false" ToolTip="Close ticket" runat="server"><i aria-hidden="true" class="fas fa-times"></i></asp:LinkButton>
                        </div>
                    <div class="btn-toolbar float-right">
                        <div class="btn-group" role="group" aria-label="...">
                            <asp:LinkButton ID="lbtArchiveTicket" CssClass="btn btn-outline-danger" ToolTip="Archive Ticket" OnClientClick="return confirm('Are you sure you wish to archive this ticket?');" runat="server"><i aria-hidden="true" class="fas fa-trash"></i> Archive</asp:LinkButton>
                             <asp:Panel ID="pnlAssignTo" runat="server" CssClass="btn-group">
                                <button type="button" id="btnAssignTo" runat="server" class="btn btn-outline-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <asp:Label ID="lblAssignTo" runat="server" Text="Assign to"></asp:Label>
                                    <span class="caret"></span>
                                </button>
                                
                                
                                <ul class="dropdown-menu">
                                    <asp:Repeater DataSourceID="dsReassigns" ID="rptAssignTo" runat="server">
                                        <ItemTemplate>
                                            <li>
                                                <asp:LinkButton ID="lbtAssign" CommandName="AssignTo" CommandArgument='<%# Eval("AdminID")%>' runat="server" Text='<%# Eval("SuperAdminEmail")%>'></asp:LinkButton></li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <li role="separator" class="divider"></li>
                                    <li>
                                        <asp:LinkButton ID="lbtRemoveAssign" runat="server" Text="Remove Assignment"></asp:LinkButton></li>
                                </ul>

                            </asp:Panel>
                            <asp:Panel ID="pnlPriority" runat="server" CssClass="btn-group">
                                <button type="button" id="Button1" runat="server" class="btn btn-outline-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <asp:Label ID="lblResolveByDD" runat="server" Text="Resolve target"></asp:Label>
                                    <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu">
                                    <li>
                                        <asp:LinkButton ID="lbtSameDay" runat="server">Critical (Same day)</asp:LinkButton></li>
                                    <li>
                                        <asp:LinkButton ID="lbtNextDay" runat="server">High (Next day)</asp:LinkButton></li>
                                    <li>
                                        <asp:LinkButton ID="lbtOneWeek" runat="server">Medium (One week)</asp:LinkButton></li>
                                    <li>
                                        <asp:LinkButton ID="lbtChangeRequest" runat="server">Low / Change request (90 days)</asp:LinkButton></li>
                                </ul>
                            </asp:Panel>
                        </div>
                        
                    </div>
                    </div>
 <div class="row">
     <asp:Panel ID="pnlTicketHeader" CssClass="col-12 col-md-8"  runat="server">
         <div class="clearfix">
                       <h3>
                        <asp:Label ID="lblTicketSubject" runat="server" Text="New"></asp:Label></h3>
             </div>
                            <div class="row">
 <div class="col-12">
                    

                    <br />
                            Added&nbsp;By:  <b>
                                <asp:Label ID="lblAddedBy" runat="server" Text="My Organisation"></asp:Label></b>
                        
                            on: <b>
                                <asp:Label ID="lblAddedDate" runat="server" Text="New"></asp:Label></b>
                        </div>
                    </div>
                    <div class="row">
                        

                        <div class="col-3">
                            Last&nbsp;update:  </div><div class="col-3"><b>
                                <asp:Label ID="lblLastUpdate" runat="server" Text="My Organisation"></asp:Label></b>
                        </div>
                                
                        <div id="resby1" runat="server" class="col-3">
                            Resolve&nbsp;by:</div><div class="col-3" id="resby2" runat="server"><b>
                                <asp:Label ID="lblResolveBy" runat="server" Text="My Organisation"></asp:Label></b></div>
                        </div>
 
     <asp:Panel ID="pnlCatType" CssClass="mt-2" runat="server">
     <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" ChildrenAsTriggers="true" runat="server"><ContentTemplate>
     <div class="form-group row">
         <div class="col-2  control-label">Type:</div>
         <div class="col-4">
     <asp:DropDownList ID="ddTicketTypeManage" AutoPostBack="true" CssClass="form-control" runat="server" DataSourceID="dsTicketTypes" DataTextField="TicketType" DataValueField="TicketTypeID"></asp:DropDownList>
         </div>
         <div class="col-2 control-label">Category:</div>
         <div class="col-4">
     <asp:DropDownList ID="ddTicketCategoryManage" AutoPostBack="true" CssClass="form-control" runat="server" DataSourceID="dsCategoryID" DataTextField="TicketCategory" DataValueField="TicketCategoryID"></asp:DropDownList>
         </div></div></ContentTemplate></asp:UpdatePanel>
     </asp:Panel>
 
                    
                       </asp:Panel>
                        <asp:Panel ID="pnlProblemContext" CssClass="col-md-4 col-12" runat="server">
                            <div class="alert alert-info small" style="padding-left:15px;margin-top:15px;">
                                <div class="row"><div class="col-12">
                                <h5>Problem context</h5></div></div>
                                
                                <div class="row"><div class="col">Link:</div><div class="col-8">
                                    <asp:LinkButton ID="lbtLaunchCourse" Font-Bold="true" runat="server" Text=""></asp:LinkButton><asp:Label ID="lblNoCourse" Font-Bold="true" runat="server" Text="Not supplied"></asp:Label></div>
                                   
                                    </div>
                                <div class="row">
 <div class="col">Del:</div><div class="col-8">
                                    <asp:Label ID="lblDelID" Font-Bold="true" runat="server" Text="Label"></asp:Label></div>
                                </div>
                               
                                <div class="row"></div>
                            </div>
                        </asp:Panel>
                        
                    </div>
                    

                <h3>Ticket Comments</h3>
                <div class="card card-default">

                    <div class="card-body">
                        <div class="clearfix">
                            <button type="button" class="btn btn-primary float-right" data-toggle="collapse" data-target="#NewCommentPanel">
                                <i aria-hidden="true" class="fas fa-plus"></i> Add Comment
                            </button>
                        </div>
                        <asp:Panel ID="NewCommentPanel" runat="server" class="collapse filter-panel" ClientIDMode="Static">
                            <div class="card card-primary">
                                <div class="card-header">Add Comment</div>
                                <div class="card-body">
                                    <dx:ASPxHtmlEditor ID="htmlAddComment" Height="200px" ClientVisible="false" ClientInstanceName="htmlAdd" runat="server" Settings-AllowPreview="False" Settings-AllowHtmlView="false" Width="100%">
                                           <SettingsDialogs>
                                            <InsertImageDialog>
                                                <SettingsImageUpload>
                                                    <FileSystemSettings UploadFolder="~\Images\uploaded\tickets\" />
                                                </SettingsImageUpload>
                                            </InsertImageDialog>
                                        </SettingsDialogs>
                                    </dx:ASPxHtmlEditor>
                                </div>
                                <div class="card-footer clearfix">
                                    <button type="button" class="btn btn-outline-secondary mr-auto" data-toggle="collapse" data-target="#NewCommentPanel">
                                        Cancel
                                    </button>
                                    <asp:LinkButton ID="lbtSubmitNewComment" CssClass="btn btn-primary float-right" runat="server">Submit</asp:LinkButton>
                                </div>
                            </div>
                        </asp:Panel>
                        <br />
                        <asp:Repeater ID="rptComments" runat="server" DataSourceID="dsTicketComments">
                            <ItemTemplate>
                                <div class='<%#IIf(Eval("IsSuperAdmin"), "col-11 offset-1", "col-11") %>'>
                                    <dx:ASPxBinaryImage ID="ASPxBinaryImage1" Value='<%# Eval("ProfileImage")%>' CssClass='<%#IIf(Eval("IsSuperAdmin"), "avatar-right", "avatar-left") %>' runat="server" EmptyImage-Url="~/Images/avatar.png"></dx:ASPxBinaryImage>
                                <div class='<%# "card mb-2 card-" & IIf(Eval("IsSuperAdmin"), "success", "warning") %>'>
                                    <div class="card-header clearfix">
                                        <div class='<%# "pull-" & IIf(Eval("IsSuperAdmin"), "right", "left") %>'>
                                            <asp:Label ID="Label10" CssClass="pad-left" runat="server" Text='<%#IIf(Eval("IsSuperAdmin"), "Response on:", "Comment on:") %>'></asp:Label>
                                        <asp:Label ID="lblCommentAddedDate" Font-Bold="true" runat="server" Text='<%# Eval("TCDate")%>'></asp:Label>
                                        By:
                                        <asp:Label Font-Bold="true" CssClass="pad-right" ID="lblCommentAddedBy" runat="server" Text='<%# Eval("Email")%>'></asp:Label></div>
                                    </div>
                                    <div class="card-body">
                                        <asp:Literal ID="litComment" runat="server" Text='<%# Eval("TCText")%>'></asp:Literal>
                                    </div>
                                </div></div>

                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
                </div>
             </asp:View>
         </asp:MultiView>

            <%--standard modal--%>
       <div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="lblModalTitle">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        
        <h5 class="modal-title">
            <asp:Label ID="lblModalTitle" runat="server" Text="Label"></asp:Label></h5><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
        <p>
            <asp:Label ID="lblModalBody" runat="server" Text="Label"></asp:Label></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-secondary float-right" data-dismiss="modal">OK</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
    <script src="../Scripts/tickets.js"></script>
</asp:Content>
