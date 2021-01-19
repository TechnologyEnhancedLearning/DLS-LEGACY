<%@ Page Title="Admin - Configuration" Language="vb" AutoEventWireup="false" MasterPageFile="~/tracking/Site.Master" CodeBehind="admin-configuration.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.admin_configuration" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.ASPxHtmlEditor.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxHtmlEditor" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="breadtray" runat="server">
   <ol class="breadcrumb breadcrumb-slash">
        <li class="breadcrumb-item active">Admin</li>
    </ol>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <ul class="nav nav-pills mb-4">
        <li role="presentation" id="tab1" class="nav-item" runat="server">
            <asp:LinkButton ID="lbtStatements" CssClass="nav-link" runat="server">System Configuration</asp:LinkButton></li>
        <li role="presentation" id="tab2" class="nav-item" runat="server">
            <asp:LinkButton ID="lbtManageLists" CssClass="nav-link" runat="server">Manage Lists</asp:LinkButton></li>
      
    </ul>
    <asp:MultiView ID="mvConfig" ActiveViewIndex="0" runat="server">
        <asp:View ID="vStatements" runat="server">
            <div class="row">
                <div class="col col-md-12">
                    <h4 class="page-header">System Configuration Items</h4>
                </div>

                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col col-lg-12">
                <div class="m-3">
                    <div class="form-group row">
                        <asp:Label ID="Label6" CssClass="col col-md-3 control-label" runat="server" AssociatedControlID="ddConfigItem" Text="Config Item:">

                        </asp:Label>
                <div class="col col-md-9">
                    <asp:ObjectDataSource ID="dsLoginMessage" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetByName" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.ConfigTableAdapter" UpdateMethod="Update" DeleteMethod="Delete" InsertMethod="Insert">
                        <DeleteParameters>
                            <asp:Parameter Name="Original_ConfigID" Type="Int32" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="ConfigName" Type="String" />
                            <asp:Parameter Name="ConfigText" Type="String" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddConfigItem" DefaultValue="LoginMessage" Name="ConfigName" PropertyName="SelectedValue" Type="String" />
                        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ConfigName" Type="String" />
            <asp:Parameter Name="ConfigText" Type="String" />
            <asp:Parameter Name="Original_ConfigID" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>

                    <asp:DropDownList ID="ddConfigItem" CssClass="form-control" AutoPostBack="true" runat="server">
                        <asp:ListItem Text="Login Message" Value="LoginMessage"></asp:ListItem>
                        <asp:ListItem Text="Content Creator Download URL" Value="ContentCreatorDownloadURL"></asp:ListItem>
                        <asp:ListItem Text="Content Creator Current Version" Value="ContentCreatorCurrentVersion"></asp:ListItem>
                        <asp:ListItem Text="Content Creator Release Notes" Value="CCReleaseNotes"></asp:ListItem>
                        <asp:ListItem Text="Privacy Notice" Value="PrivacyNotice"></asp:ListItem>
                        <asp:ListItem Text="Accessibility Notice" Value="AccessibilityNotice"></asp:ListItem>
                        <asp:ListItem Text="Terms And Conditions" Value="TermsAndConditions"></asp:ListItem>
                    </asp:DropDownList>
                    </div></div></div></div>
                <div class="col col-lg-12">
                <div class="card card-default mb-2">
                    <asp:FormView ID="fvLoginMessageHTML" RenderOuterTable="False" runat="server" DataKeyNames="ConfigID" DataSourceID="dsLoginMessage">
                    <EditItemTemplate>
                        <div class="card-header">
                            <h6>
                                <asp:Label ID="Label5" runat="server" Text='<%# "Edit " & undoCamelCase(Eval("ConfigName")) %>'></asp:Label></h6>
                        </div>

                        <div class="card-body">
                            <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("ConfigID") %>' />
                            <asp:HiddenField ID="HiddenField2" runat="server" Value='<%# Bind("ConfigName") %>' />
                            <asp:HiddenField ID="hfIsHtml" runat="server" Value='<%# Bind("IsHtml") %>' />
                            <dx:ASPxHtmlEditor ID="htmlConfigText" Html='<%# Bind("ConfigText") %>' Width="100%" Height="400px" runat="server" ToolbarMode="Menu" SettingsHtmlEditing-AllowedDocumentType="HTML5"></dx:ASPxHtmlEditor>
                              </div>
                        <div class="card-footer clearfix">
                            <asp:LinkButton ID="UpdateCancelButton" CssClass="btn btn-outline-secondary mr-auto" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                            <asp:LinkButton ID="UpdateButton" runat="server" CssClass="btn btn-primary float-right" CausesValidation="True" CommandName="Update" Text="Update" />
                        </div>

                    </EditItemTemplate>

                    <ItemTemplate>
                        <asp:HiddenField ID="hfIsHtml" runat="server" Value='<%# Eval("IsHtml") %>' />
                        <div class="card-header">
                            <h6> <asp:Label ID="Label5" runat="server" Text='<%# undoCamelCase(Eval("ConfigName")) %>'></asp:Label></h6>
                        </div>
                        <div class="card-body">
                            <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("ConfigID") %>' />

                            <asp:Literal ID="litConfigText" runat="server" Text='<%# Bind("ConfigText") %>'></asp:Literal>

                        </div>
                        <div class="card-footer clearfix">
                            <asp:LinkButton ID="EditButton" CssClass="btn btn-outline-secondary float-right" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                        </div>
                    </ItemTemplate>
                </asp:FormView>
                <asp:FormView ID="fvLoginMessage" RenderOuterTable="False" runat="server" DataKeyNames="ConfigID" DataSourceID="dsLoginMessage">
                    <EditItemTemplate>
                        <div class="card-header">
                            <h6>
                                <asp:Label ID="Label5" runat="server" Text='<%# "Edit " & undoCamelCase(Eval("ConfigName")) %>'></asp:Label></h6>
                        </div>

                        <div class="card-body">
                            <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("ConfigID") %>' />
                            <asp:HiddenField ID="HiddenField2" runat="server" Value='<%# Bind("ConfigName") %>' />
                            <asp:HiddenField ID="hfIsHtml" runat="server" Value='<%# Bind("IsHtml") %>' />
                             <asp:TextBox ID="tbConfigText" CssClass="form-control" Text='<%# Bind("ConfigText") %>' runat="server"></asp:TextBox>
                        </div>
                        <div class="card-footer clearfix">
                            <asp:LinkButton ID="UpdateCancelButton" CssClass="btn btn-outline-secondary mr-auto" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                            <asp:LinkButton ID="UpdateButton" runat="server" CssClass="btn btn-primary float-right" CausesValidation="True" CommandName="Update" Text="Update" />
                            
                        </div>

                    </EditItemTemplate>

                    <ItemTemplate>
                        <asp:HiddenField ID="hfIsHtml" runat="server" Value='<%# Eval("IsHtml") %>' />
                        <div class="card-header">
                            <h6> <asp:Label ID="Label5" runat="server" Text='<%# undoCamelCase(Eval("ConfigName")) %>'></asp:Label></h6>
                        </div>
                        <div class="card-body">
                            <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("ConfigID") %>' />

                            <asp:Literal ID="litConfigText" runat="server" Text='<%# Bind("ConfigText") %>'></asp:Literal>

                        </div>
                        <div class="card-footer clearfix">
                            <asp:LinkButton ID="EditButton" CssClass="btn btn-outline-secondary float-right" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                        </div>
                    </ItemTemplate>
                </asp:FormView>
            </div>

                </div>
            </div>
             
        </asp:View>
        <asp:View ID="vManageLists" runat="server">
            <div class="row mb-2">
                <div class="col col-md-12">
                    <h2 class="page-header">Manage Lists</h2>
                </div>

                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col col-lg-6">
                    <div class="card card-default mb-2">
                <asp:ObjectDataSource ID="dsJobGroups" runat="server" DeleteMethod="Delete" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.JobGroupsTableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_JobGroupID" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="JobGroupName" Type="String" />
                        <asp:Parameter Name="Original_JobGroupID" Type="Int32" />
                    </UpdateParameters>
                </asp:ObjectDataSource>
                <div class="card-header">
                    <h6>Job Groups</h6>
                </div>
                <asp:GridView ID="gvJobGroups" PageSize="10" GridLines="None" CssClass="table table-horizontal" runat="server" AutoGenerateColumns="False" DataKeyNames="JobGroupID" DataSourceID="dsJobGroups" AllowPaging="True">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                            <EditItemTemplate>
                                <asp:LinkButton ID="lbtUpdate" runat="server" CssClass="btn btn-sm btn-success" CausesValidation="True" CommandName="Update" ToolTip="Update"><i aria-hidden="true" class="fas fa-check"></i></asp:LinkButton>
                                &nbsp;<asp:LinkButton ID="lbtUpdateCancel" runat="server" CssClass="btn btn-sm btn-danger" CausesValidation="False" CommandName="Cancel" ToolTip="Cancel"><i aria-hidden="true" class="fas fa-times"></i></asp:LinkButton>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="lbtEdit" runat="server" CssClass="btn btn-sm btn-outline-secondary" CausesValidation="False" CommandName="Edit" ToolTip="Edit"><i aria-hidden="true" class="fas fa-pencil-alt"></i></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField ControlStyle-CssClass="form-control" DataField="JobGroupName" HeaderText="Job Group" SortExpression="JobGroupName" />
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="lbtDelete" runat="server" CssClass="btn btn-sm btn-danger" CausesValidation="False" OnClientClick="return confirm('Are you sure you wish to delete this Job Group? DO NOT DELETE IF ASSOCIATED WITH ANY DELEGATES.');" CommandName="Delete" ToolTip="Delete"><i aria-hidden="true" class="fas fa-trash"></i></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle CssClass="bs-pagination" HorizontalAlign="Right"></PagerStyle>
                </asp:GridView>
                <div class="card-footer clearfix">
                    <div class="form-group">
                    <div class="input-group">
                        <asp:TextBox ID="tbJobGroupAdd" placeholder="Job group to add" CssClass="form-control" runat="server"></asp:TextBox><span class="input-group-append"><asp:LinkButton ValidationGroup="vgAddJobGroup" CausesValidation="true" CssClass="btn btn-primary" ID="lbtAddJobGroup" runat="server">Add</asp:LinkButton></span>
                    </div></div>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="tbJobGroupAdd" runat="server" Display="Dynamic" ValidationGroup="vgAddJobGroup" ErrorMessage="Required"></asp:RequiredFieldValidator>
                </div>
            </div>
                       </div>
                <div class ="col col-lg-6">
                     <asp:ObjectDataSource ID="dsCentreTypes" runat="server" DeleteMethod="Delete" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.CentreTypesTableAdapter" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_CentreTypeID" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="CentreType" Type="String" />
                    <asp:Parameter Name="Original_CentreTypeID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <div class="card card-default mb-2">
                <div class="card-header">
                    <h6>Centre Types</h6>
                </div>
                <asp:GridView ID="gvCentreTypes" PageSize="10" GridLines="None" CssClass="table table-horizontal" runat="server" AutoGenerateColumns="False" DataKeyNames="CentreTypeID" DataSourceID="dsCentreTypes" AllowPaging="True">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                            <EditItemTemplate>
                                <asp:LinkButton ID="lbtUpdate" runat="server" CssClass="btn btn-sm btn-success" CausesValidation="True" CommandName="Update" ToolTip="Update"><i aria-hidden="true" class="fas fa-check"></i></asp:LinkButton>
                                &nbsp;<asp:LinkButton ID="lbtUpdateCancel" runat="server" CssClass="btn btn-sm btn-danger" CausesValidation="False" CommandName="Cancel" ToolTip="Cancel"><i aria-hidden="true" class="fas fa-times"></i></asp:LinkButton>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="lbtEdit" runat="server" CssClass="btn btn-sm btn-outline-secondary" CausesValidation="False" CommandName="Edit" ToolTip="Edit"><i aria-hidden="true" class="fas fa-pencil-alt"></i></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField ControlStyle-CssClass="form-control" DataField="CentreType" HeaderText="Centre Type" SortExpression="CentreType" />

                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="lbtDelete" runat="server" CssClass="btn btn-sm btn-danger" CausesValidation="False" OnClientClick="return confirm('Are you sure you wish to delete this centre type? DO NOT DELETE IF ASSOCIATED WITH ANY CENTRES.');" CommandName="Delete" ToolTip="Delete"><i aria-hidden="true" class="fas fa-trash"></i></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                    <PagerStyle CssClass="bs-pagination" HorizontalAlign="Right"></PagerStyle>
                </asp:GridView>
                <div class="card-footer">
                    <div class="form-group">
                    <div class="input-group">
                        <asp:TextBox ID="tbCentreTypeAdd" placeholder="Centre type to add" CssClass="form-control" runat="server"></asp:TextBox><span class="input-group-append"><asp:LinkButton ValidationGroup="vgAddCentreType" CausesValidation="true" CssClass="btn btn-primary" ID="lbtAddCentreType" runat="server">Add</asp:LinkButton></span>
                    </div>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="tbCentreTypeAdd" runat="server" Display="Dynamic" ValidationGroup="vgAddCentreType" ErrorMessage="Required"></asp:RequiredFieldValidator>
                </div></div>
            </div>
                </div>
                  <div class="col col-lg-6">
           
            <div class="card card-default mb-2">
                <asp:ObjectDataSource ID="dsRegions" runat="server" DeleteMethod="Delete" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.RegionsTableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_RegionID" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="RegionName" Type="String" />
                        <asp:Parameter Name="Original_RegionID" Type="Int32" />
                    </UpdateParameters>
                </asp:ObjectDataSource>
                <div class="card-header">
                    <h6>Regions</h6>
                </div>
                <asp:GridView ID="gvRegions" PageSize="10" GridLines="None" CssClass="table table-horizontal" runat="server" AutoGenerateColumns="False" DataKeyNames="RegionID" DataSourceID="dsRegions" AllowPaging="True">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                            <EditItemTemplate>
                                <asp:LinkButton ID="lbtUpdate" runat="server" CssClass="btn btn-sm btn-success" CausesValidation="True" CommandName="Update" ToolTip="Update"><i aria-hidden="true" class="fas fa-check"></i></asp:LinkButton>
                                &nbsp;<asp:LinkButton ID="lbtUpdateCancel" runat="server" CssClass="btn btn-sm btn-danger" CausesValidation="False" CommandName="Cancel" ToolTip="Cancel"><i aria-hidden="true" class="fas fa-times"></i></asp:LinkButton>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="lbtEdit" runat="server" CssClass="btn btn-sm btn-outline-secondary" CausesValidation="False" CommandName="Edit" ToolTip="Edit"><i aria-hidden="true" class="fas fa-pencil-alt"></i></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField ControlStyle-CssClass="form-control" DataField="RegionName" HeaderText="Region" SortExpression="RegionName" />
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="lbtDelete" runat="server" CssClass="btn btn-sm btn-danger" CausesValidation="False" OnClientClick="return confirm('Are you sure you wish to delete this region? DO NOT DELETE IF ASSOCIATED WITH ANY CENTRES.');" CommandName="Delete" ToolTip="Delete"><i aria-hidden="true" class="fas fa-trash"></i></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle CssClass="bs-pagination" HorizontalAlign="Right"></PagerStyle>
                </asp:GridView>
                <div class="card-footer clearfix">
                    <div class="form-group">
                    <div class="input-group">
                        <asp:TextBox ID="tbRegionAdd" placeholder="Region to add" CssClass="form-control" runat="server"></asp:TextBox><span class="input-group-append"><asp:LinkButton ValidationGroup="vgAddRegion" CausesValidation="true" CssClass="btn btn-primary" ID="lbtAddRegion" runat="server">Add</asp:LinkButton></span>
                    </div></div>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="tbRegionAdd" runat="server" Display="Dynamic" ValidationGroup="vgAddRegion" ErrorMessage="Required"></asp:RequiredFieldValidator>
                </div>
            </div>

        </div>
                <div class="col col-lg-6">
           
            <div class="card card-default mb-2">
                <asp:ObjectDataSource ID="dsCategories" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetCentralCategories" TypeName="ITSP_TrackingSystemRefactor.customiseTableAdapters.CourseCategoriesTableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_CourseCategoryID" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="CentreID" Type="Int32" />
                        <asp:Parameter Name="CategoryName" Type="String" />
                        <asp:Parameter Name="CategoryContactEmail" Type="String" />
                        <asp:Parameter Name="CategoryContactPhone" Type="String" />
                        <asp:Parameter Name="Active" Type="Boolean" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="CentreID" Type="Int32" />
                        <asp:Parameter Name="CategoryName" Type="String" />
                        <asp:Parameter Name="CategoryContactEmail" Type="String" />
                        <asp:Parameter Name="CategoryContactPhone" Type="String" />
                        <asp:Parameter Name="Active" Type="Boolean" />
                        <asp:Parameter Name="Original_CourseCategoryID" Type="Int32" />
                    </UpdateParameters>
                </asp:ObjectDataSource>
                  <div class="card-header">
                    <h6>Course Categories</h6>
                </div>
                <dx:BootstrapGridView ID="bsgvCategories" OnInitNewRow="InitNewRow_DefaultActive" runat="server" AutoGenerateColumns="False" DataSourceID="dsCategories" KeyFieldName="CourseCategoryID">
                    <SettingsDataSecurity AllowDelete="True" AllowEdit="True" AllowInsert="True" />
                    <SettingsBootstrap Striped="True"></SettingsBootstrap>
                            <SettingsCommandButton>
                                <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="fas fa-plus" RenderMode="Button" />
                                <UpdateButton ButtonType="Button" CssClass="btn btn-primary float-right" IconCssClass="fas fa-check" RenderMode="Button" Text="Submit" />
                                <CancelButton ButtonType="Button" CssClass="btn btn-outline-secondary mr-auto" IconCssClass="fas fa-close" RenderMode="Button" />
                                <EditButton ButtonType="Button" CssClass="btn btn-outline-secondary" IconCssClass="fas fa-pencil-alt" RenderMode="Button" Text=" " />
                                <DeleteButton ButtonType="Button" CssClass="btn btn-outline-danger" IconCssClass="fas fa-trash" RenderMode="Button" Text=" " />
                            </SettingsCommandButton>
                    <Columns>
                        <dx:BootstrapGridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="CentreID" Caption="Centre" Visible="False" VisibleIndex="1">
                            <SettingsEditForm Visible="True" ColumnSpan="12"  />
                            <EditItemTemplate>
                                <asp:HiddenField ID="hfCentreID" Value='<%# Bind("CentreID") %>' runat="server" />
                                <asp:Label ID="Label1" CssClass="form-control" disabled="disabled" runat="server" Text="N/A - Central"></asp:Label>
                            </EditItemTemplate>
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewTextColumn Caption="Category" FieldName="CategoryName" VisibleIndex="2">
                            <SettingsEditForm ColumnSpan="12" />
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewTextColumn Caption="Contact Email" FieldName="CategoryContactEmail" VisibleIndex="3">
                            <SettingsEditForm ColumnSpan="12" />
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewTextColumn Caption="Contact Phone" FieldName="CategoryContactPhone" VisibleIndex="4">
                            <SettingsEditForm ColumnSpan="12" />
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="5">
                            <SettingsEditForm ColumnSpan="12" />
                        </dx:BootstrapGridViewCheckColumn>
                        <dx:BootstrapGridViewCommandColumn ShowDeleteButton="True" VisibleIndex="6">
                        </dx:BootstrapGridViewCommandColumn>
                    </Columns>
                </dx:BootstrapGridView>
                </div>
                    </div>
                <div class="col col-lg-6">
           
            <div class="card card-default mb-2">
                <asp:ObjectDataSource ID="dsTopics" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetCentralTopics" TypeName="ITSP_TrackingSystemRefactor.customiseTableAdapters.CourseTopicsTableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_CourseTopicID" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="CentreID" Type="Int32" />
                        <asp:Parameter Name="CourseTopic" Type="String" />
                        <asp:Parameter Name="Active" Type="Boolean" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="CentreID" Type="Int32" />
                        <asp:Parameter Name="CourseTopic" Type="String" />
                        <asp:Parameter Name="Active" Type="Boolean" />
                        <asp:Parameter Name="Original_CourseTopicID" Type="Int32" />
                    </UpdateParameters>
                </asp:ObjectDataSource>
                  <div class="card-header">
                    <h6>Course Topics</h6>
                </div>
                <dx:BootstrapGridView ID="bsgvTopics" runat="server" OnInitNewRow="InitNewRow_DefaultActive" AutoGenerateColumns="False" DataSourceID="dsTopics" KeyFieldName="CourseTopicID">
                    <SettingsDataSecurity AllowDelete="True" AllowEdit="True" AllowInsert="True" />
                    <SettingsBootstrap Striped="True"></SettingsBootstrap>
                            <SettingsCommandButton>
                                <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="fas fa-plus" RenderMode="Button" />
                                <UpdateButton ButtonType="Button" CssClass="btn btn-primary float-right" IconCssClass="fas fa-check" RenderMode="Button" Text="Submit" />
                                <CancelButton ButtonType="Button" CssClass="btn btn-outline-secondary mr-auto" IconCssClass="fas fa-close" RenderMode="Button" />
                                <EditButton ButtonType="Button" CssClass="btn btn-outline-secondary" IconCssClass="fas fa-pencil-alt" RenderMode="Button" Text=" " />
                                <DeleteButton ButtonType="Button" CssClass="btn btn-outline-danger" IconCssClass="fas fa-trash" RenderMode="Button" Text=" " />
                            </SettingsCommandButton>
                    <Columns>
                        <dx:BootstrapGridViewCommandColumn ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                        </dx:BootstrapGridViewCommandColumn>
                        <dx:BootstrapGridViewTextColumn FieldName="CentreID" Caption="Centre" Visible="False" VisibleIndex="2">
                            <SettingsEditForm Visible="True" ColumnSpan="12" />
                            <EditItemTemplate>
                                <asp:HiddenField ID="hfCentreID" Value='<%# Bind("CentreID") %>' runat="server" />
                                <asp:Label ID="Label1" CssClass="form-control" disabled="disabled" runat="server" Text="N/A - Central"></asp:Label>
                            </EditItemTemplate>
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewTextColumn Caption="Topic" FieldName="CourseTopic" VisibleIndex="3">
                            <SettingsEditForm ColumnSpan="9" />
                        </dx:BootstrapGridViewTextColumn>
                        <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="4">
                            <SettingsEditForm ColumnSpan="3" />
                        </dx:BootstrapGridViewCheckColumn>
                        <dx:BootstrapGridViewCommandColumn ShowDeleteButton="True"  VisibleIndex="5">
                        </dx:BootstrapGridViewCommandColumn>
                    </Columns>
                </dx:BootstrapGridView>
                </div>
                    </div>
            </div>
        </asp:View>
     
        
    </asp:MultiView>

    
    <div class="row">
        <div class="col col-lg-8">
            
             
            
           
        </div>
       
    </div>
     <!-- Modal message-->
    <div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    
                    <h6 class="modal-title" id="myModalLabel">
                        <asp:Label ID="lblModalHeading" runat="server" Text=""></asp:Label></h6><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
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
