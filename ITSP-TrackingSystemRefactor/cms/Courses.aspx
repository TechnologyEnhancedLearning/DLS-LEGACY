<%@ Page Title="Courses" Language="vb" AutoEventWireup="false" MasterPageFile="~/cms/CMS.Master" CodeBehind="Courses.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.Courses" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>


<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .aspNetDisabled {
            cursor: not-allowed
        }
    </style>
    <%--<link href="../Content/morris.css" rel="stylesheet" />--%>
    <script src="https://www.gstatic.com/charts/loader.js"></script>
    <script src="../Scripts/bs.pagination.js"></script>
    <script src="../Scripts/cms.js"></script>
    <script src="../Scripts/bsasper.js"></script>
    <script>
        function BindEvents() {
            $(document).ready(function () {
                google.charts.load('current', { 'packages': ['corechart'] });
                $("input, textarea").bsasper({
                    placement: "right", createContent: function (errors) {
                        return '<span class="text-danger">' + errors[0] + '</span>';
                    }
                });

                $('[data-toggle="popover"]').popover();

            });
        };
        function binaryImageUploaded(s, e) {
            e.processOnServer = true;
            e.usePostBack = true;
        }
    </script>
    <div class="row">
        <div class="col-md-6">
            <h2>Manage Courses</h2>
        </div>
        <div class="col-md-6">
            <div id="pnlUsage" runat="server" class="card card-info">
                <div class="card-header">
                    <h4 class="mb-2 text-center">Live Custom Courses: 
                    <asp:Label ID="lblUsed" runat="server" Text="Used"></asp:Label>
                        /
                    <asp:Label ID="lblAvailable" runat="server" Text="Available"></asp:Label></h4>
                </div>
                <div class="card-body">
                    <div class="progress">
                        <div class="progress-bar progress-bar-info" runat="server" id="progbar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
                            <asp:Label ID="lblPercent" runat="server" Text="60%"></asp:Label>
                        </div>
                    </div>
                    <asp:Panel ID="pnlExceeded" Visible="false" CssClass="card-text text-center" runat="server">
                        <p>To create custom courses, please archive content or upgrade.</p>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>
    <hr />
    <asp:MultiView ID="mvCourses" runat="server" ActiveViewIndex="0">
        <asp:View ID="vCourseList" runat="server">

            <asp:ObjectDataSource ID="dsCourses" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetForUser" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.ApplicationsTableAdapter">
                <SelectParameters>
                    <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                    <asp:ControlParameter ControlID="cbIncludeArchived" Name="ShowArchived" PropertyName="Checked" Type="Boolean" />
                    <asp:SessionParameter DefaultValue="0" Name="PublishToAll" SessionField="UserPublishToAll" Type="Boolean" />
                    <asp:ControlParameter ControlID="cbFilterForCentre" Name="ShowOnlyMine" PropertyName="Checked" Type="Boolean" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <div class="card card-primary">
                <div class="card-header">
                    Courses
                    <div class="float-right">
                        <asp:CheckBox ID="cbIncludeArchived" TextAlign="Right" Font-Bold="false" Font-Size="Smaller" AutoPostBack="true" Text="Show archived courses?" runat="server" />
                        <asp:CheckBox ID="cbFilterForCentre" runat="server" TextAlign="Right" Font-Bold="false" Font-Size="Smaller" Text="Show only my centre's courses?" Checked="true" AutoPostBack="True" />
                    </div>
                </div>
                <div class="card-body">
                    <dx:BootstrapGridView ID="bsgvCourses" runat="server" AutoGenerateColumns="False" DataSourceID="dsCourses" KeyFieldName="ApplicationID" SettingsCustomizationDialog-Enabled="True" SettingsBootstrap-Sizing="Large" SettingsBootstrap-Striped="True" Settings-GridLines="None">
                        <CssClasses Table="table table-striped" />

                        <SettingsBootstrap Sizing="Large" Striped="True" />

                        <Settings ShowHeaderFilterButton="True" />
                        <SettingsCookies Enabled="True" Version="0.122" />
                        <SettingsPager PageSize="15">
                        </SettingsPager>
                        <Columns>
                            <dx:BootstrapGridViewTextColumn Caption="Edit" Name="Edit" ShowInCustomizationDialog="false" VisibleIndex="0">
                                <DataItemTemplate>
                                    <settings allowheaderfilter="False" />
                                    <div class="dropdown">
                                        <button class="btn btn-primary dropdown-toggle" type="button" id='<%# "dropdownMenu" & Eval("ApplicationID")  %>' data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                            <i aria-hidden="true" class="fas fa-cog"></i>

                                        </button>
                                        <div class="dropdown-menu dropdown-menu-buttons" role="menu" aria-labelledby='<%# "#dropdownMenu" & Eval("ApplicationID")  %>'>

                                            <asp:LinkButton CssClass="dropdown-item" EnableViewState="false" ID="lbtEdit" runat="server" CausesValidation="False" ToolTip="Edit Course Details" OnCommand="EditDetails_Click" CommandArgument='<%#Eval("ApplicationID")%>' Text=""><i aria-hidden="true" class="fas fa-pencil-alt mr-1"></i> Edit details</asp:LinkButton>

                                            <asp:LinkButton CssClass='<%#IIf(Eval("ArchivedDate").ToString.Length = 0, "dropdown-item", "dropdown-item disabled")%>' EnableViewState="false" ID="lbtManageContentShares" Enabled='<%# Eval("ArchivedDate").ToString.Length = 0 %>' runat="server" CausesValidation="False" ToolTip="Manage Content" OnCommand="ManageContent_Click" CommandArgument='<%#Eval("ApplicationID")%>' Text=""><i aria-hidden="true" class="fas fa-edit mr-1"></i> Manage content</asp:LinkButton>


                                            <asp:LinkButton CssClass='<%#IIf(Eval("Debug"), "dropdown-item disabled", "dropdown-item")%>' EnableViewState="false" Enabled='<%# Not Eval("Debug")%>' ID="lbtPublish" runat="server" CausesValidation="False" ToolTip="Publish Course" OnCommand="Publish_Click" CommandArgument='<%#Eval("ApplicationID")%>' Text=""><i aria-hidden="true" class="fas fa-share-square mr-1"></i> Publish</asp:LinkButton>
                                            <div class="dropdown-divider"></div>

                                            <asp:LinkButton CssClass="dropdown-item" EnableViewState="false" ID="lbtStats" OnClientClick='<%#"doChart(" & Eval("ApplicationID") & ");return false;"%>' runat="server" CausesValidation="False" ToolTip="View Usage Stats" Text=""><i aria-hidden="true" class="fas fa-chart-bar mr-1"></i> Statistics</asp:LinkButton>
                                            <asp:LinkButton CssClass="dropdown-item" EnableViewState="false" ID="lbtExportStats" CausesValidation="False" OnCommand="ExportStats_Click" CommandArgument='<%#Eval("ApplicationID")%>' ToolTip="Export to Excel" runat="server"><i aria-hidden="true" class="fas fa-file-download mr-1"></i> Export Stats to Excel</asp:LinkButton>
                                            <div class="dropdown-divider"></div>

                                            <asp:LinkButton CssClass="dropdown-item text-danger" EnableViewState="false" ID="lbtArchive" Visible='<%# Eval("ArchivedDate").ToString.Length = 0 %>' runat="server" CausesValidation="False" ToolTip="Archive Course" OnCommand="Archive_Click" CommandArgument='<%#Eval("ApplicationID")%>' Text=""><i aria-hidden="true" class="fas fa-trash mr-1"></i> Archive</asp:LinkButton>
                                            <asp:LinkButton CssClass="dropdown-item text-success" EnableViewState="false" ID="lbtUnarchive" Visible='<%# Eval("ArchivedDate").ToString.Length > 0 %>' runat="server" CausesValidation="False" ToolTip="Archive Course" OnCommand="lbtUnarchive_Command" CommandArgument='<%#Eval("ApplicationID")%>' Text=""><i aria-hidden="true" class="fas fa-redo mr-1"></i> Unarchive</asp:LinkButton>

                                        </div>
                                    </div>
                                    <%--<asp:LinkButton EnableViewState="false" ID="lbtEditCentre" CssClass="btn btn-outline-secondary btn-sm" ToolTip="Edit Centre" OnCommand="EditCentre_Click" CommandArgument='<%# Eval("CentreID") %>' runat="server"><i aria-hidden="true" class="fas fa-pencil-alt"></i></asp:LinkButton>--%>
                                </DataItemTemplate>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn Caption="Course" FieldName="ApplicationName" VisibleIndex="1">
                            </dx:BootstrapGridViewTextColumn>

                            <dx:BootstrapGridViewTextColumn FieldName="Dimensions" ReadOnly="True" VisibleIndex="2">
                            </dx:BootstrapGridViewTextColumn>

                            <dx:BootstrapGridViewCheckColumn Caption="InDev" FieldName="Debug" VisibleIndex="7">
                            </dx:BootstrapGridViewCheckColumn>

                            <dx:BootstrapGridViewTextColumn FieldName="CreatedBy" ReadOnly="True" VisibleIndex="12">
                            </dx:BootstrapGridViewTextColumn>

                            <dx:BootstrapGridViewTextColumn Caption="Centre" FieldName="CreatedByCentre" ReadOnly="True" VisibleIndex="14">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewDateColumn Caption="Created" FieldName="CreatedDate" VisibleIndex="15">
                            </dx:BootstrapGridViewDateColumn>


                            <dx:BootstrapGridViewCheckColumn FieldName="DiagAssess" Visible="False" VisibleIndex="19">
                            </dx:BootstrapGridViewCheckColumn>
                            <dx:BootstrapGridViewCheckColumn FieldName="PLAssess" Visible="False" VisibleIndex="20">
                            </dx:BootstrapGridViewCheckColumn>

                            <dx:BootstrapGridViewCheckColumn FieldName="CoreContent" Visible="False" VisibleIndex="22">
                            </dx:BootstrapGridViewCheckColumn>
                            <dx:BootstrapGridViewCheckColumn FieldName="IncludeLearningLog" Visible="False" Caption="Learn Log" VisibleIndex="23">
                            </dx:BootstrapGridViewCheckColumn>
                            <dx:BootstrapGridViewComboBoxColumn Caption="Brand" FieldName="BrandID" ReadOnly="True" Visible="False" VisibleIndex="3">
                                <PropertiesComboBox DataSourceID="dsBrands" TextField="BrandName" ValueField="BrandID">
                                </PropertiesComboBox>
                            </dx:BootstrapGridViewComboBoxColumn>
                            <dx:BootstrapGridViewComboBoxColumn Caption="Category" FieldName="CourseCategoryID" ReadOnly="True" Visible="False" VisibleIndex="4">
                                <PropertiesComboBox DataSourceID="dsCategories" TextField="CategoryName" ValueField="CourseCategoryID">
                                </PropertiesComboBox>
                            </dx:BootstrapGridViewComboBoxColumn>
                            <dx:BootstrapGridViewComboBoxColumn Caption="Topic" FieldName="CourseTopicID" ReadOnly="True" Visible="False" VisibleIndex="5">
                                <PropertiesComboBox DataSourceID="dsTopics" TextField="CourseTopic" ValueField="CourseTopicID">
                                </PropertiesComboBox>
                            </dx:BootstrapGridViewComboBoxColumn>
                            <dx:BootstrapGridViewTextColumn Caption="Size" FieldName="ServerSpace" VisibleIndex="6">
                                <Settings FilterMode="DisplayText" />
                                <DataItemTemplate>
                                    <%#NiceBytes(Eval("ServerSpace")) %>
                                </DataItemTemplate>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewDateColumn Caption="Archived" FieldName="ArchivedDate" VisibleIndex="24">
                            </dx:BootstrapGridViewDateColumn>
                        </Columns>

                        <Toolbars>
                            <dx:BootstrapGridViewToolbar Position="Top">
                                <Items>
                                    <dx:BootstrapGridViewToolbarItem Command="ClearGrouping" IconCssClass="fa fa-caret-square-o-down" />
                                    <dx:BootstrapGridViewToolbarItem Command="ClearSorting" IconCssClass="fa fa-sort" />
                                    <dx:BootstrapGridViewToolbarItem Command="ClearFilter" />
                                    <dx:BootstrapGridViewToolbarItem Command="ShowCustomizationDialog" Text="Customise Grid" />


                                </Items>
                            </dx:BootstrapGridViewToolbar>
                        </Toolbars>
                        <SettingsCustomizationDialog Enabled="True" />
                        <SettingsSearchPanel Visible="True" AllowTextInputTimer="false" />
                    </dx:BootstrapGridView>


                </div>
                <div class="card-footer clearfix">
                    <asp:LinkButton ID="lbtAdd" min-width="25%" CssClass="btn btn-primary float-right" runat="server"><i aria-hidden="true" class="fas fa-plus"></i> Add Course</asp:LinkButton>

                </div>
            </div>
        </asp:View>
        <asp:View ID="vCourseDetails" runat="server">
            <asp:ObjectDataSource ID="dsCourseDetails" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GeByApplicationID" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.ApplicationsTableAdapter" UpdateMethod="UpdateQuery" DeleteMethod="Delete" InsertMethod="InsertQuery">
                <DeleteParameters>
                    <asp:Parameter Name="Original_ApplicationID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ApplicationName" Type="String" />
                    <asp:Parameter Name="ApplicationInfo" Type="String" />
                    <asp:Parameter Name="CourseCategoryID" Type="Int32" />
                    <asp:Parameter Name="Debug" Type="Boolean" />
                    <asp:Parameter Name="ShortAppName" Type="String" />
                    <asp:Parameter Name="CourseTopicID" Type="Int32" />
                    <asp:Parameter Name="CreatedByID" Type="Int32" />
                    <asp:Parameter Name="CreatedByCentreID" Type="Int32" />
                    <asp:Parameter Name="hEmbedRes" Type="Int32" />
                    <asp:Parameter Name="vEmbedRes" Type="Int32" />
                    <asp:Parameter Name="AssessAttempts" Type="Int32" />
                    <asp:Parameter Name="DiagAssess" Type="Boolean" />
                    <asp:Parameter Name="PLAssess" Type="Boolean" />
                    <asp:Parameter Name="PLAPassThreshold" Type="Int32" />
                    <asp:Parameter Name="CoreContent" Type="Boolean" />
                    <asp:Parameter Name="BrandID" Type="Int32" />
                    <asp:Parameter Name="CourseImage" Type="Object" />
                    <asp:Parameter Name="IncludeLearningLog" Type="Boolean" />
                    <asp:Parameter Name="IncludeCertification" Type="Boolean" />
                    <asp:Parameter Name="DefaultContentTypeID" Type="Int32" />
                    <asp:Parameter Name="DisplayFormatID" Type="Int32" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="34" Name="ApplicationID" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ApplicationName" Type="String" />
                    <asp:Parameter Name="ApplicationInfo" Type="String" />
                    <asp:Parameter Name="CourseCategoryID" Type="Int32" />
                    <asp:Parameter Name="Debug" Type="Boolean" />
                    <asp:Parameter Name="ShortAppName" Type="String" />
                    <asp:Parameter Name="CourseTopicID" Type="Int32" />
                    <asp:Parameter Name="hEmbedRes" Type="Int32" />
                    <asp:Parameter Name="vEmbedRes" Type="Int32" />
                    <asp:Parameter Name="AssessAttempts" Type="Int32" />
                    <asp:Parameter Name="DiagAssess" Type="Boolean" />
                    <asp:Parameter Name="PLAssess" Type="Boolean" />
                    <asp:Parameter Name="PLAPassThreshold" Type="Int32" />
                    <asp:Parameter Name="CoreContent" Type="Boolean" />
                    <asp:Parameter Name="BrandID" Type="Int32" />
                    <asp:Parameter Name="CourseImage" Type="Object" />
                    <asp:Parameter Name="IncludeLearningLog" Type="Boolean" />
                    <asp:Parameter Name="IncludeCertification" Type="Boolean" />
                    <asp:Parameter Name="DefaultContentTypeID" Type="Int32" />
                    <asp:Parameter Name="DisplayFormatID" Type="Int32" />
                    <asp:Parameter Name="Original_ApplicationID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="dsBrands" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.BrandsTableAdapter"></asp:ObjectDataSource>
            <asp:ObjectDataSource ID="dsCategories" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActiveForCentre" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.CourseCategoriesTableAdapter">
                <SelectParameters>
                    <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                    <asp:SessionParameter DefaultValue="0" Name="IsSuperAdmin" SessionField="UserPublishToAll" Type="Boolean" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="dsTopics" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActiveForCentre" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.CourseTopicsTableAdapter">
                <SelectParameters>
                    <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                    <asp:SessionParameter DefaultValue="0" Name="IsSuperAdmin" SessionField="UserPublishToAll" Type="Boolean" />
                </SelectParameters>
            </asp:ObjectDataSource>

            <div class="card card-primary">
                <div class="card-header">
                    <asp:Label ID="lblCourseFormHeading" runat="server" Text="Edit Course Details"></asp:Label>
                </div>
                <asp:FormView ID="fvCourseDetail" RenderOuterTable="False" runat="server" DataKeyNames="ApplicationID" DataSourceID="dsCourseDetails" DefaultMode="Edit">
                    <EditItemTemplate>

                        <div class="card-body">
                            <div class="m-3">
                                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("ApplicationID") %>' />
                                <div class="form-group row">
                                    <asp:Label ID="lblCourseName" CssClass="control-label col-3" runat="server" AssociatedControlID="ApplicationNameTextBox">Course name:</asp:Label>
                                    <div class="col-9">
                                        <asp:TextBox ID="ApplicationNameTextBox" runat="server" Text='<%# Bind("ApplicationName") %>' CssClass="form-control" />
                                        <asp:RequiredFieldValidator ID="rfvApplicationName" ValidationGroup="vgCourseEdit" ControlToValidate="ApplicationNameTextBox" runat="server" ErrorMessage="Required" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblDescription" CssClass="control-label col-3" runat="server" AssociatedControlID="ApplicationInfoTextBox">Description:</asp:Label>

                                    <div class="col-9">
                                        <asp:TextBox ID="ApplicationInfoTextBox" TextMode="MultiLine" Rows="3" runat="server" Text='<%# Bind("ApplicationInfo") %>' CssClass="form-control" />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label10" CssClass="control-label col-3" runat="server" AssociatedControlID="ddDisplayFormat">Course format:</asp:Label>
                                    <div class="col-9">
                                        <asp:DropDownList CssClass="form-control"  SelectedValue='<%# Bind("DisplayFormatID") %>' ID="ddDisplayFormat" runat="server">
                                            <asp:ListItem Text="Multi-section course" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Single section course" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Single tutorial course" Value="3"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label9" CssClass="control-label col-3" runat="server" AssociatedControlID="ddContentType">Default Content:</asp:Label>
                                    <div class="col-9">
                                        <asp:DropDownList CssClass="form-control"  SelectedValue='<%# Bind("DefaultContentTypeID") %>' ID="ddContentType" runat="server">
                                            <asp:ListItem Text="Online learning" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Offline learning" Enabled="false" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Classroom learning" Enabled="false" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="Self Assessment" Value="4"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblDimensions" CssClass="control-label col-3" runat="server" AssociatedControlID="hEmbedResTextBox">Dimensions:</asp:Label>
                                    <div class="col-4">
                                        <div class="input-group">
                                            <span class="input-group-prepend"><span class="input-group-text">Width:</span></span>
                                            <asp:TextBox ID="hEmbedResTextBox" runat="server" Text='<%# Bind("hEmbedRes")%>' CssClass="form-control " TextMode="Number" /><span class="input-group-append"><span class="input-group-text">px</span></span>
                                            <asp:RequiredFieldValidator ID="rfvHEmbedRes" ControlToValidate="hEmbedResTextBox" ValidationGroup="vgCourseEdit" Display="Dynamic" runat="server" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <div class="input-group">
                                            <span class="input-group-prepend"><span class="input-group-text">Height:</span></span>
                                            <asp:TextBox ID="tbvEmbedRes" runat="server" Text='<%# Bind("vEmbedRes")%>' CssClass="form-control " TextMode="Number" /><span class="input-group-append"><span class="input-group-text">px</span></span>
                                            <asp:RequiredFieldValidator ID="rfvVEmbedRes" ControlToValidate="hEmbedResTextBox" ValidationGroup="vgCourseEdit" Display="Dynamic" runat="server" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <asp:Label ID="lblInDev" CssClass="control-label col-3" runat="server" AssociatedControlID="DebugCheckBox">In Development:</asp:Label>
                                    <div class="col-9">
                                        <asp:CheckBox ID="DebugCheckBox" runat="server" Checked='<%# Bind("Debug") %>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblShortName" CssClass="control-label col-3" runat="server" AssociatedControlID="ShortAppNameTextBox">Short Course Name:</asp:Label>

                                    <div class="col-9">
                                        <asp:TextBox ID="ShortAppNameTextBox" runat="server" Text='<%# Bind("ShortAppName") %>' CssClass="form-control" ToolTip="The name displayed in the Knowledge Bank" />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblBrand" CssClass="control-label col-3" runat="server" AssociatedControlID="ddBrand">Brand:</asp:Label>

                                    <div class="col-9">
                                        <asp:DropDownList CssClass="form-control" ID="ddBrand" runat="server" SelectedValue='<%# Bind("BrandID") %>' DataSourceID="dsBrands" DataTextField="BrandName" DataValueField="BrandID"></asp:DropDownList>

                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblCategory" CssClass="control-label col-3" runat="server" AssociatedControlID="ddCategory">Category:</asp:Label>

                                    <div class="col-9">
                                        <asp:DropDownList CssClass="form-control" ID="ddCategory" runat="server" ToolTip="Add Categories using the Config Tab" SelectedValue='<%# Bind("CourseCategoryID") %>' DataSourceID="dsCategories" DataTextField="CategoryName" DataValueField="CourseCategoryID"></asp:DropDownList>

                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblTopic" CssClass="control-label col-3" runat="server" AssociatedControlID="ddTopic">Topic:</asp:Label>

                                    <div class="col-9">
                                        <asp:DropDownList CssClass="form-control" ID="ddTopic" runat="server" ToolTip="Add Topics using the Config Tab" SelectedValue='<%# Bind("CourseTopicID") %>' DataSourceID="dsTopics" DataTextField="CourseTopic" DataValueField="CourseTopicID"></asp:DropDownList>

                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label6" CssClass="control-label col-3" runat="server" AssociatedControlID="bimgCourseImage">Image:</asp:Label>

                                    <div class="col-9">
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true">
                                            <ContentTemplate>
                                                <dx:ASPxBinaryImage ID="bimgCourseImage" ClientSideEvents-ValueChanged="binaryImageUploaded" OnValueChanged="bimgCourseImage_ValueChanged" Value='<%# Bind("CourseImage") %>' EditingSettings-Enabled="true" EditingSettings-EmptyValueText="" runat="server" Height="150" EmptyImage-Url="~/Images/nothumb.png"></dx:ASPxBinaryImage>

                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblCreatedBy" CssClass="control-label col-3" runat="server" AssociatedControlID="CreatedByTextBox">Created By:</asp:Label>
                                    <div class="col-9">
                                        <asp:TextBox CssClass="form-control" ID="CreatedByTextBox" Enabled="false" runat="server" Text='<%# Eval("CreatedBy")%>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label2" CssClass="control-label col-3" runat="server" AssociatedControlID="cbDiagnostic">Includes diagnostic:</asp:Label>
                                    <div class="col-9">
                                        <asp:CheckBox ID="cbDiagnostic" runat="server" Checked='<%# Bind("DiagAssess")%>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label3" CssClass="control-label col-3" runat="server" AssociatedControlID="CheckBox1">Includes assessment:</asp:Label>
                                    <div class="col-9">
                                        <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("PLAssess")%>' />
                                    </div>
                                </div>
                                 
                                <div class="form-group row">
                                    <asp:Label ID="Label1" CssClass="control-label col-3" runat="server" AssociatedControlID="bspinAssessAttempts">Max Assessment Attempts:</asp:Label>
                                    <div class="col-9">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text">0 = infinite</div>
                                            </div>
                                            <dx:BootstrapSpinEdit ID="bspinAssessAttempts" runat="server" Number='<%# Bind("AssessAttempts")%>' MaxValue="10" NumberType="Integer"></dx:BootstrapSpinEdit>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label4" CssClass="control-label col-3" runat="server" AssociatedControlID="bspinAssessPassThreshold">Assessment pass threshold:</asp:Label>
                                    <div class="col-9">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text">More than or equal to</div>
                                            </div>
                                            <dx:BootstrapSpinEdit ID="bspinAssessPassThreshold" runat="server" Number='<%# Bind("PLAPassThreshold")%>' MaxValue="100" NumberType="Integer"></dx:BootstrapSpinEdit>
                                            <div class="input-group-append">
                                                <div class="input-group-text">%</div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label7" CssClass="control-label col-3" runat="server" AssociatedControlID="CheckBox1">Includes development log:</asp:Label>
                                    <div class="col-9">
                                        <asp:CheckBox ID="cbLearningLog" ClientIDMode="Static" runat="server" Checked='<%# Bind("IncludeLearningLog")%>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblCentre" CssClass="control-label col-3" runat="server" AssociatedControlID="CreatedByCentreIDTextBox">Centre:</asp:Label>
                                    <div class="col-9">
                                        <asp:TextBox CssClass="form-control" Enabled="false" ID="CreatedByCentreIDTextBox" runat="server" Text='<%# Eval("CreatedByCentre")%>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblCreatedDate" CssClass="control-label col-3" runat="server" AssociatedControlID="CreatedDateTextBox">Created:</asp:Label>
                                    <div class="col-9">
                                        <asp:TextBox CssClass="form-control" Enabled="false" ID="CreatedDateTextBox" runat="server" Text='<%# Eval("CreatedDate") %>' />
                                    </div>
                                </div>
                                <asp:Panel CssClass="form-group row" ID="pnlCoreContent" Visible='<%# Session("UserPublishToAll") %>' runat="server">
                                    <asp:Label ID="Label5" CssClass="control-label col-3" runat="server" AssociatedControlID="cbCoreContent">Core ITSP Content:</asp:Label>
                                    <div class="col-9">
                                        <asp:CheckBox ID="cbCoreContent" runat="server" Checked='<%# Bind("CoreContent")%>' />
                                    </div>
                                </asp:Panel>
                                 <div class="card">
                                    <div class="card-header collapse-card collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="colCourseSettings" data-target="#colCourseSettings"><span class="pl-1">Custom Labels and Settings</span></div>
                                    <div class="card-body collapse" id="colCourseSettings">
                                        <h4 class="mb-2">Content Menu</h4>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label32" CssClass="control-label col-3" runat="server" AssociatedControlID="cbShowPercentage">Show Percentage Completed:</asp:Label>
                                            <div class="col-9">
                                                <asp:CheckBox ID="cbShowPercentage" Checked='<%# GetCS("LearnMenu.ShowPercentage") %>' runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label34" CssClass="control-label col-3" runat="server" AssociatedControlID="cbShowTime">Show Time Taken / Average Time:</asp:Label>
                                            <div class="col-9">
                                                <asp:CheckBox ID="cbShowTime" Checked='<%# GetCS("LearnMenu.ShowTime") %>' runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label35" CssClass="control-label col-3" runat="server" AssociatedControlID="cbShowLearnStatus">Show Learning Status (Started/Complete):</asp:Label>
                                            <div class="col-9">
                                                <asp:CheckBox ID="cbShowLearnStatus" Checked='<%# GetCS("LearnMenu.ShowLearnStatus") %>' runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label37" CssClass="control-label col-3" runat="server" AssociatedControlID="cbCert">Show Completion Panel:</asp:Label>
                                            <div class="col-9">
                                                <asp:CheckBox ID="cbCert" runat="server" Checked='<%# Bind("IncludeCertification")%>' />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label11" CssClass="control-label col-3" runat="server" AssociatedControlID="tbSupervisor">Supervisor:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Supervisor" ID="tbSupervisor" Text='<%# GetCS("LearnMenu.Supervisor") %>' runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label12" CssClass="control-label col-3" runat="server" AssociatedControlID="tbVerification">Verification:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Verification" Text='<%# GetCS("LearnMenu.Verification") %>' ID="tbVerification" runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label13" CssClass="control-label col-3" runat="server" AssociatedControlID="tbSupportingInformation">Supporting Information:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Supporting Information" Text='<%# GetCS("LearnMenu.SupportingInformation") %>' ID="tbSupportingInformation" runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label14" CssClass="control-label col-3" runat="server" AssociatedControlID="tbConsolidationExercise">Consolidation Exercise:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Consolidation Exercise" Text='<%# GetCS("LearnMenu.ConsolidationExercise") %>' ID="tbConsolidationExercise" runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label15" CssClass="control-label col-3" runat="server" AssociatedControlID="tbReview">Review:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Review" Text='<%# GetCS("LearnMenu.Review") %>' ID="tbReview" runat="server" />
                                            </div>
                                        </div>
                                        <script>
                                            $('#cbLearningLog').change(function () {
    if (this.checked) {
        $('#dvDevLogSettings').collapse('show');
    }
    else {
        $('#dvDevLogSettings').collapse('hide');
    }
});
                                        </script>
                                        <div id="dvDevLogSettings" <%# IIf(Eval("IncludeLearningLog"), "collapse", "class=""collapse collapsed""")%> >
                                        <h4 class="mb-2">Development Log</h4>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label36" CssClass="control-label col-3" runat="server" AssociatedControlID="cbShowPlanned">Show Planned Actions:</asp:Label>
                                            <div class="col-9">
                                                <asp:CheckBox ID="cbShowPlanned" Checked='<%# GetCS("DevelopmentLog.ShowPlanned") %>' runat="server" />
                                            </div>
                                        </div>
                                         <div class="form-group row ml-1">
                                            <asp:Label ID="Label38" CssClass="control-label col-3" runat="server" AssociatedControlID="cbShowCompleted">Show Completed Actions:</asp:Label>
                                            <div class="col-9">
                                                <asp:CheckBox ID="cbShowCompleted" Checked='<%# GetCS("DevelopmentLog.ShowCompleted") %>' runat="server" />
                                            </div>
                                        </div>
                                            <div class="form-group row ml-1">
                                            <asp:Label ID="Label39" CssClass="control-label col-3" runat="server" AssociatedControlID="cbReflectiveAccount">Include Reflective Account:</asp:Label>
                                            <div class="col-9">
                                                <asp:CheckBox ID="cbReflectiveAccount" Checked='<%# GetCS("DevelopmentLog.IncludeReflectiveAccount") %>' runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label16" CssClass="control-label col-3" runat="server" AssociatedControlID="tbDevelopmentLog">Development Log:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Development Log" Text='<%# GetCS("DevelopmentLog.DevelopmentLog") %>' ID="tbDevelopmentLog" runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label17" CssClass="control-label col-3" runat="server" AssociatedControlID="tbPlanned">Planned:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Planned" Text='<%# GetCS("DevelopmentLog.Planned") %>' ID="tbPlanned" runat="server" />
                                            </div>
                                        </div>
                                         <div class="form-group row ml-1">
                                            <asp:Label ID="Label18" CssClass="control-label col-3" runat="server" AssociatedControlID="tbCompleted">Completed:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Completed" Text='<%# GetCS("DevelopmentLog.Completed") %>' ID="tbCompleted" runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label19" CssClass="control-label col-3" runat="server" AssociatedControlID="tbAddPlanned">Add Planned:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Add Planned" Text='<%# GetCS("DevelopmentLog.AddPlanned") %>' ID="tbAddPlanned" runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label20" CssClass="control-label col-3" runat="server" AssociatedControlID="tbAddCompleted">Add Completed:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Add Completed" Text='<%# GetCS("DevelopmentLog.AddCompleted") %>' ID="tbAddCompleted" runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label21" CssClass="control-label col-3" runat="server" AssociatedControlID="tbExpectedOutcomes">Expected Outcomes:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Expected Outcomes" Text='<%# GetCS("DevelopmentLog.ExpectedOutcomes") %>' ID="tbExpectedOutcomes" runat="server" />
                                            </div>
                                        </div>
                                        <h4 class="mb-2">Development Log Form</h4>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label22" CssClass="control-label col-3" runat="server" AssociatedControlID="cbShowDLSCourses">Show DLS Courses Dropdown:</asp:Label>
                                            <div class="col-9">
                                                <asp:CheckBox ID="cbShowDLSCourses" Checked='<%# GetCS("DevelopmentLogForm.ShowDLSCourses") %>' runat="server" />
                                            </div>
                                        </div>
                                         <div class="form-group row ml-1">
                                            <asp:Label ID="Label23" CssClass="control-label col-3" runat="server" AssociatedControlID="cbShowMethod">Show Method Dropdown:</asp:Label>
                                            <div class="col-9">
                                                <asp:CheckBox ID="cbShowMethod" Checked='<%# GetCS("DevelopmentLogForm.ShowMethod") %>' runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label24" CssClass="control-label col-3" runat="server" AssociatedControlID="cbShowFileUpload">Show Evidence File Upload:</asp:Label>
                                            <div class="col-9">
                                                <asp:CheckBox ID="cbShowFileUpload" Checked='<%# GetCS("DevelopmentLogForm.ShowFileUpload") %>' runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label8" CssClass="control-label col-3" runat="server" AssociatedControlID="cbShowSkillMapping">Show Skill/Objective/Requirement Mapping:</asp:Label>
                                            <div class="col-9">
                                                <asp:CheckBox ID="cbShowSkillMapping" Checked='<%# GetCS("DevelopmentLogForm.ShowSkillMapping") %>' runat="server" />
                                            </div>
                                        </div>
                                         <div class="form-group row ml-1">
                                            <asp:Label ID="Label33" CssClass="control-label col-3" runat="server" AssociatedControlID="tbReview">Skill (Objective/Requirement):</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Skills" Text='<%# GetCS("DevelopmentLogForm.Skill") %>' ID="tbSkills" runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label25" CssClass="control-label col-3" runat="server" AssociatedControlID="tbRecordPlannedDevelopmentActivity">Record Planned Development Activity:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Record Planned Development Activity" Text='<%# GetCS("DevelopmentLogForm.RecordPlannedDevelopmentActivity") %>' ID="tbRecordPlannedDevelopmentActivity" runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label26" CssClass="control-label col-3" runat="server" AssociatedControlID="tbRecordCompletedDevelopmentActivityEvidence">Record Completed Development Activity:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Record Completed Development Activity" Text='<%# GetCS("DevelopmentLogForm.RecordCompletedDevelopmentActivityEvidence") %>' ID="tbRecordCompletedDevelopmentActivityEvidence" runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label27" CssClass="control-label col-3" runat="server" AssociatedControlID="tbMethod">Method:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Method" ID="tbMethod" Text='<%# GetCS("DevelopmentLogForm.Method") %>' runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label28" CssClass="control-label col-3" runat="server" AssociatedControlID="tbActivity">Activity:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Activity" ID="tbActivity" Text='<%# GetCS("DevelopmentLogForm.Activity") %>' runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label29" CssClass="control-label col-3" runat="server" AssociatedControlID="tbDueDateTime">Due Date and Time:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Due Date and Time" ID="tbDueDateTime" Text='<%# GetCS("DevelopmentLogForm.DueDateTime") %>' runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label30" CssClass="control-label col-3" runat="server" AssociatedControlID="tbCompletedDate">Completed Date:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Completed Date" ID="tbCompletedDate" Text='<%# GetCS("DevelopmentLogForm.CompletedDate") %>' runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label31" CssClass="control-label col-3" runat="server" AssociatedControlID="tbDuration">Duration:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Duration" ID="tbDuration" Text='<%# GetCS("DevelopmentLogForm.Duration") %>' runat="server" />
                                            </div>
                                        </div>
                                       </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer clearfix">
                            <asp:LinkButton ID="UpdateCancelButton" CssClass="btn btn-outline-secondary mr-auto" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                            <asp:LinkButton ID="UpdateButton" ValidationGroup="vgCourseEdit" CssClass="btn btn-primary float-right" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />

                        </div>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <div class="card-body">
                            <div class="m-3">
                                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("ApplicationID") %>' />
                                <div class="form-group row">
                                    <asp:Label ID="lblCourseName" CssClass="control-label col-3" runat="server" AssociatedControlID="ApplicationNameTextBox">Course name:</asp:Label>
                                    <div class="col-9">
                                        <asp:TextBox ID="ApplicationNameTextBox" runat="server" Text='<%# Bind("ApplicationName") %>' CssClass="form-control" />
                                        <asp:RequiredFieldValidator ID="rfvApplicationName" ValidationGroup="vgCourseAdd" ControlToValidate="ApplicationNameTextBox" runat="server" ErrorMessage="Required" Display="Dynamic"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblDescription" CssClass="control-label col-3" runat="server" AssociatedControlID="ApplicationInfoTextBox">Description:</asp:Label>

                                    <div class="col-9">
                                        <asp:TextBox ID="ApplicationInfoTextBox" TextMode="MultiLine" Rows="3" runat="server" Text='<%# Bind("ApplicationInfo") %>' CssClass="form-control" />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label10" CssClass="control-label col-3" runat="server" AssociatedControlID="ddDisplayFormat">Course format:</asp:Label>
                                    <div class="col-9">
                                        <asp:DropDownList CssClass="form-control"  SelectedValue='<%# Bind("DisplayFormatID") %>' ID="ddDisplayFormat" runat="server">
                                            <asp:ListItem Text="Multi-section course" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Single section course" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Single tutorial course" Value="3"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label9" CssClass="control-label col-3" runat="server" AssociatedControlID="ddContentType">Default Content:</asp:Label>
                                    <div class="col-9">
                                        <asp:DropDownList CssClass="form-control"  SelectedValue='<%# Bind("DefaultContentTypeID") %>' ID="ddContentType" runat="server">
                                            <asp:ListItem Text="Online learning" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Offline learning" Enabled="false" Value="2"></asp:ListItem>
                                                <asp:ListItem Text="Classroom learning" Enabled="false" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="Self Assessment" Value="4"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblDimensions" CssClass="control-label col-3" runat="server" AssociatedControlID="hEmbedResTextBox">Dimensions:</asp:Label>
                                    <div class="col-4">
                                        <div class="input-group">
                                            <span class="input-group-prepend"><span class="input-group-text">Width:</span></span>
                                            <asp:TextBox ID="hEmbedResTextBox" runat="server" Text='<%# Bind("hEmbedRes")%>' CssClass="form-control " TextMode="Number" /><span class="input-group-append"><span class="input-group-text">px</span></span>
                                            <asp:RequiredFieldValidator ID="rfvHEmbedRes" ControlToValidate="hEmbedResTextBox" ValidationGroup="vgCourseAdd" Display="Dynamic" runat="server" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <div class="input-group">
                                            <span class="input-group-prepend"><span class="input-group-text">Height:</span></span>
                                            <asp:TextBox ID="tbvEmbedRes" runat="server" Text='<%# Bind("vEmbedRes")%>' CssClass="form-control " TextMode="Number" /><span class="input-group-append"><span class="input-group-text">px</span></span>
                                            <asp:RequiredFieldValidator ID="rfvVEmbedRes" ControlToValidate="hEmbedResTextBox" ValidationGroup="vgCourseAdd" Display="Dynamic" runat="server" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <asp:Label ID="lblInDev" CssClass="control-label col-3" runat="server" AssociatedControlID="DebugCheckBox">In Development:</asp:Label>

                                    <div class="col-9">

                                        <asp:CheckBox ID="DebugCheckBox" runat="server" Checked='<%# Bind("Debug") %>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblShortName" CssClass="control-label col-3" runat="server" AssociatedControlID="ShortAppNameTextBox">Short Course Name:</asp:Label>

                                    <div class="col-9">
                                        <asp:TextBox ID="ShortAppNameTextBox" runat="server" Text='<%# Bind("ShortAppName") %>' CssClass="form-control" />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblBrand" CssClass="control-label col-3" runat="server" AssociatedControlID="ddBrand">Brand:</asp:Label>

                                    <div class="col-9">
                                        <asp:DropDownList CssClass="form-control" ID="ddBrand" runat="server" SelectedValue='<%# Bind("BrandID") %>' DataSourceID="dsBrands" DataTextField="BrandName" DataValueField="BrandID"></asp:DropDownList>

                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblCategory" CssClass="control-label col-3" runat="server" AssociatedControlID="ddCategory">Category:</asp:Label>

                                    <div class="col-9">
                                        <asp:DropDownList CssClass="form-control" ID="ddCategory" runat="server" SelectedValue='<%# Bind("CourseCategoryID") %>' DataSourceID="dsCategories" DataTextField="CategoryName" DataValueField="CourseCategoryID"></asp:DropDownList>

                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblTopic" CssClass="control-label col-3" runat="server" AssociatedControlID="ddTopic">Topic:</asp:Label>

                                    <div class="col-9">
                                        <asp:DropDownList CssClass="form-control" ID="ddTopic" runat="server" SelectedValue='<%# Bind("CourseTopicID") %>' DataSourceID="dsTopics" DataTextField="CourseTopic" DataValueField="CourseTopicID"></asp:DropDownList>

                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label6" CssClass="control-label col-3" runat="server" AssociatedControlID="bimgCourseImageAdd">Image:</asp:Label>

                                    <div class="col-9">
                                        <asp:UpdatePanel ID="UpdatePanel2" runat="server" ChildrenAsTriggers="true">
                                            <ContentTemplate>
                                                <dx:ASPxBinaryImage ID="bimgCourseImageAdd" ClientSideEvents-ValueChanged="binaryImageUploaded" OnValueChanged="bimgCourseImage_ValueChanged" Value='<%# Bind("CourseImage") %>' EditingSettings-Enabled="true" EditingSettings-EmptyValueText="" runat="server" Height="150" EmptyImage-Url="~/Images/nothumb.png"></dx:ASPxBinaryImage>

                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label2" CssClass="control-label col-3" runat="server" AssociatedControlID="cbDiagnostic">Includes diagnostic:</asp:Label>
                                    <div class="col-9">
                                        <asp:CheckBox ID="cbDiagnostic" runat="server" Checked='<%# Bind("DiagAssess")%>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label3" CssClass="control-label col-3" runat="server" AssociatedControlID="CheckBox1">Includes assessment:</asp:Label>
                                    <div class="col-9">
                                        <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("PLAssess")%>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label1" CssClass="control-label col-3" runat="server" AssociatedControlID="bspinAssessAttempts">Max Assessment Attempts:</asp:Label>
                                    <div class="col-9">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text">0 = infinite</div>
                                            </div>
                                            <dx:BootstrapSpinEdit ID="bspinAssessAttempts" runat="server" Number='<%# Bind("AssessAttempts")%>' MaxValue="10" NumberType="Integer"></dx:BootstrapSpinEdit>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label4" CssClass="control-label col-3" runat="server" AssociatedControlID="bspinAssessPassThreshold">Assessment pass threshold:</asp:Label>
                                    <div class="col-9">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text">More than or equal to</div>
                                            </div>
                                            <dx:BootstrapSpinEdit ID="bspinAssessPassThreshold" runat="server" Number='<%# Bind("PLAPassThreshold")%>' MaxValue="100" NumberType="Integer"></dx:BootstrapSpinEdit>
                                            <div class="input-group-append">
                                                <div class="input-group-text">%</div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label7" CssClass="control-label col-3" runat="server" AssociatedControlID="CheckBox1">Includes development log:</asp:Label>
                                    <div class="col-9">
                                        <asp:CheckBox ID="cbLearningLog" ClientIDMode="Static" runat="server" Checked='<%# Bind("IncludeLearningLog")%>' />
                                    </div>
                                </div>
                               
                                <div class="form-group row">
                                    <asp:Label ID="lblCreatedBy" CssClass="control-label col-3" runat="server" AssociatedControlID="CreatedByTextBox">Created By:</asp:Label>
                                    <div class="col-9">
                                        <asp:HiddenField ID="hfCreatedByID" runat="server" Value='<%# Bind("CreatedByID") %>' />
                                        <asp:TextBox CssClass="form-control" ID="CreatedByTextBox" Enabled="false" runat="server" Text='<%# Eval("CreatedBy")%>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblCentre" CssClass="control-label col-3" runat="server" AssociatedControlID="CreatedByCentreIDTextBox">Centre:</asp:Label>
                                    <div class="col-9">
                                        <asp:HiddenField ID="hfCreatedByCentreID" runat="server" Value='<%# Bind("CreatedByCentreID") %>' />
                                        <asp:TextBox CssClass="form-control" Enabled="false" ID="CreatedByCentreIDTextBox" runat="server" Text='<%# Eval("CreatedByCentre")%>' />
                                    </div>
                                </div>
                                <asp:Panel CssClass="form-group row" ID="pnlCoreContentAdd" Visible='<%# Session("UserPublishToAll") %>' runat="server">
                                    <asp:Label ID="Label5" CssClass="control-label col-3" runat="server" AssociatedControlID="cbCoreContentAdd">Core ITSP Content:</asp:Label>
                                    <div class="col-9">
                                        <asp:CheckBox ID="cbCoreContentAdd" runat="server" Checked='<%# Bind("CoreContent")%>' />
                                    </div>
                                </asp:Panel>
                                <script>
                                            $('#cbLearningLog').change(function () {
    if (this.checked) {
        $('#dvDevLogSettings').collapse('show');
    }
    else {
        $('#dvDevLogSettings').collapse('hide');
    }
});
                                        </script>
                                <div class="card">
                                    <div class="card-header collapse-card collapsed" data-toggle="collapse" aria-expanded="false" aria-controls="colCourseSettings" data-target="#colCourseSettings"><span class="pl-1">Custom Labels and Settings</span></div>
                                    <div class="card-body collapse" id="colCourseSettings">
                                        <h4 class="mb-2">Content Menu</h4>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label32" CssClass="control-label col-3" runat="server" AssociatedControlID="cbShowPercentage">Show Percentage Completed:</asp:Label>
                                            <div class="col-9">
                                                <asp:CheckBox ID="cbShowPercentage" Checked='<%# GetCS("LearnMenu.ShowPercentage") %>' runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label34" CssClass="control-label col-3" runat="server" AssociatedControlID="cbShowTime">Show Time Taken / Average Time:</asp:Label>
                                            <div class="col-9">
                                                <asp:CheckBox ID="cbShowTime" Checked='<%# GetCS("LearnMenu.ShowTime") %>' runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label35" CssClass="control-label col-3" runat="server" AssociatedControlID="cbShowLearnStatus">Show Learning Status (Started/Complete):</asp:Label>
                                            <div class="col-9">
                                                <asp:CheckBox ID="cbShowLearnStatus" Checked='<%# GetCS("LearnMenu.ShowLearnStatus") %>' runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label37" CssClass="control-label col-3" runat="server" AssociatedControlID="cbCert">Show Completion Panel:</asp:Label>
                                            <div class="col-9">
                                                <asp:CheckBox ID="cbCert" runat="server" Checked='<%# Bind("IncludeCertification")%>' />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label11" CssClass="control-label col-3" runat="server" AssociatedControlID="tbSupervisor">Supervisor:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Supervisor" ID="tbSupervisor" Text='<%# GetCS("LearnMenu.Supervisor") %>' runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label12" CssClass="control-label col-3" runat="server" AssociatedControlID="tbVerification">Verification:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Verification" Text='<%# GetCS("LearnMenu.Verification") %>' ID="tbVerification" runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label13" CssClass="control-label col-3" runat="server" AssociatedControlID="tbSupportingInformation">Supporting Information:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Supporting Information" Text='<%# GetCS("LearnMenu.SupportingInformation") %>' ID="tbSupportingInformation" runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label14" CssClass="control-label col-3" runat="server" AssociatedControlID="tbConsolidationExercise">Consolidation Exercise:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Consolidation Exercise" Text='<%# GetCS("LearnMenu.ConsolidationExercise") %>' ID="tbConsolidationExercise" runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label15" CssClass="control-label col-3" runat="server" AssociatedControlID="tbReview">Review:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Review" Text='<%# GetCS("LearnMenu.Review") %>' ID="tbReview" runat="server" />
                                            </div>
                                        </div>
                                        <div id="dvDevLogSettings" <%# IIf(Eval("IncludeLearningLog"), "collapse", "class=""collapse collapsed""")%> >
                                        <h4 class="mb-2">Development Log</h4>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label36" CssClass="control-label col-3" runat="server" AssociatedControlID="cbShowPlanned">Show Planned Actions:</asp:Label>
                                            <div class="col-9">
                                                <asp:CheckBox ID="cbShowPlanned" Checked='<%# GetCS("DevelopmentLog.ShowPlanned") %>' runat="server" />
                                            </div>
                                        </div>
                                         <div class="form-group row ml-1">
                                            <asp:Label ID="Label38" CssClass="control-label col-3" runat="server" AssociatedControlID="cbShowCompleted">Show Completed Actions:</asp:Label>
                                            <div class="col-9">
                                                <asp:CheckBox ID="cbShowCompleted" Checked='<%# GetCS("DevelopmentLog.ShowCompleted") %>' runat="server" />
                                            </div>
                                        </div>
                                            <div class="form-group row ml-1">
                                            <asp:Label ID="Label39" CssClass="control-label col-3" runat="server" AssociatedControlID="cbReflectiveAccount">Include Reflective Account:</asp:Label>
                                            <div class="col-9">
                                                <asp:CheckBox ID="cbReflectiveAccount" Checked='<%# GetCS("DevelopmentLog.IncludeReflectiveAccount") %>' runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label16" CssClass="control-label col-3" runat="server" AssociatedControlID="tbDevelopmentLog">Development Log:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Development Log" Text='<%# GetCS("DevelopmentLog.DevelopmentLog") %>' ID="tbDevelopmentLog" runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label17" CssClass="control-label col-3" runat="server" AssociatedControlID="tbPlanned">Planned:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Planned" Text='<%# GetCS("DevelopmentLog.Planned") %>' ID="tbPlanned" runat="server" />
                                            </div>
                                        </div>
                                         <div class="form-group row ml-1">
                                            <asp:Label ID="Label18" CssClass="control-label col-3" runat="server" AssociatedControlID="tbCompleted">Completed:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Completed" Text='<%# GetCS("DevelopmentLog.Completed") %>' ID="tbCompleted" runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label19" CssClass="control-label col-3" runat="server" AssociatedControlID="tbAddPlanned">Add Planned:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Add Planned" Text='<%# GetCS("DevelopmentLog.AddPlanned") %>' ID="tbAddPlanned" runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label20" CssClass="control-label col-3" runat="server" AssociatedControlID="tbAddCompleted">Add Completed:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Add Completed" Text='<%# GetCS("DevelopmentLog.AddCompleted") %>' ID="tbAddCompleted" runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label21" CssClass="control-label col-3" runat="server" AssociatedControlID="tbExpectedOutcomes">Expected Outcomes:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Expected Outcomes" Text='<%# GetCS("DevelopmentLog.ExpectedOutcomes") %>' ID="tbExpectedOutcomes" runat="server" />
                                            </div>
                                        </div>
                                        <h4 class="mb-2">Development Log Form</h4>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label22" CssClass="control-label col-3" runat="server" AssociatedControlID="cbShowDLSCourses">Show DLS Courses Dropdown:</asp:Label>
                                            <div class="col-9">
                                                <asp:CheckBox ID="cbShowDLSCourses" Checked='<%# GetCS("DevelopmentLogForm.ShowDLSCourses") %>' runat="server" />
                                            </div>
                                        </div>
                                         <div class="form-group row ml-1">
                                            <asp:Label ID="Label23" CssClass="control-label col-3" runat="server" AssociatedControlID="cbShowMethod">Show Method Dropdown:</asp:Label>
                                            <div class="col-9">
                                                <asp:CheckBox ID="cbShowMethod" Checked='<%# GetCS("DevelopmentLogForm.ShowMethod") %>' runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label24" CssClass="control-label col-3" runat="server" AssociatedControlID="cbShowFileUpload">Show Evidence File Upload:</asp:Label>
                                            <div class="col-9">
                                                <asp:CheckBox ID="cbShowFileUpload" Checked='<%# GetCS("DevelopmentLogForm.ShowFileUpload") %>' runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label8" CssClass="control-label col-3" runat="server" AssociatedControlID="cbShowSkillMapping">Show Skill/Objective/Requirement Mapping:</asp:Label>
                                            <div class="col-9">
                                                <asp:CheckBox ID="cbShowSkillMapping" Checked='<%# GetCS("DevelopmentLogForm.ShowSkillMapping") %>' runat="server" />
                                            </div>
                                        </div>
                                         <div class="form-group row ml-1">
                                            <asp:Label ID="Label33" CssClass="control-label col-3" runat="server" AssociatedControlID="tbReview">Skill (Objective/Requirement):</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Skills" Text='<%# GetCS("DevelopmentLogForm.Skill") %>' ID="tbSkills" runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label25" CssClass="control-label col-3" runat="server" AssociatedControlID="tbRecordPlannedDevelopmentActivity">Record Planned Development Activity:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Record Planned Development Activity" Text='<%# GetCS("DevelopmentLogForm.RecordPlannedDevelopmentActivity") %>' ID="tbRecordPlannedDevelopmentActivity" runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label26" CssClass="control-label col-3" runat="server" AssociatedControlID="tbRecordCompletedDevelopmentActivityEvidence">Record Completed Development Activity:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Record Completed Development Activity" Text='<%# GetCS("DevelopmentLogForm.RecordCompletedDevelopmentActivityEvidence") %>' ID="tbRecordCompletedDevelopmentActivityEvidence" runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label27" CssClass="control-label col-3" runat="server" AssociatedControlID="tbMethod">Method:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Method" ID="tbMethod" Text='<%# GetCS("DevelopmentLogForm.Method") %>' runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label28" CssClass="control-label col-3" runat="server" AssociatedControlID="tbActivity">Activity:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Activity" ID="tbActivity" Text='<%# GetCS("DevelopmentLogForm.Activity") %>' runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label29" CssClass="control-label col-3" runat="server" AssociatedControlID="tbDueDateTime">Due Date and Time:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Due Date and Time" ID="tbDueDateTime" Text='<%# GetCS("DevelopmentLogForm.DueDateTime") %>' runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label30" CssClass="control-label col-3" runat="server" AssociatedControlID="tbCompletedDate">Completed Date:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Completed Date" ID="tbCompletedDate" Text='<%# GetCS("DevelopmentLogForm.CompletedDate") %>' runat="server" />
                                            </div>
                                        </div>
                                        <div class="form-group row ml-1">
                                            <asp:Label ID="Label31" CssClass="control-label col-3" runat="server" AssociatedControlID="tbDuration">Duration:</asp:Label>
                                            <div class="col-9">
                                                <asp:TextBox CssClass="form-control" ToolTip="Optional override label: Duration" ID="tbDuration" Text='<%# GetCS("DevelopmentLogForm.Duration") %>' runat="server" />
                                            </div>
                                        </div>
                                       </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer clearfix">
                            <asp:LinkButton ID="UpdateCancelButton" CssClass="btn btn-outline-secondary mr-auto" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                            <asp:LinkButton ID="InsertButton" CssClass="btn btn-primary float-right" ValidationGroup="vgCourseAdd" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />

                        </div>
                    </InsertItemTemplate>
                </asp:FormView>
            </div>
            <script>
                (function ($) {
                    $('.spinner .btn:first-of-type').on('click', function () {
                        $('.spinner input').val(parseInt($('.spinner input').val(), 10) + 1);
                    });
                    $('.spinner .btn:last-of-type').on('click', function () {
                        $('.spinner input').val(parseInt($('.spinner input').val(), 10) - 1);
                    });
                    $('.spinner2 .btn:first-of-type').on('click', function () {
                        $('.spinner2 input').val(parseInt($('.spinner2 input').val(), 10) + 1);
                    });
                    $('.spinner2 .btn:last-of-type').on('click', function () {
                        $('.spinner2 input').val(parseInt($('.spinner2 input').val(), 10) - 1);
                    });
                })(jQuery);
            </script>
        </asp:View>

    </asp:MultiView>
    <!-- Standard Modal Message  -->
    <div id="modalMessage" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="lblModalText" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">

                    <h5 class="modal-title">
                        <asp:Label ID="lblModalHeading" runat="server"></asp:Label></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <p>
                        <asp:Label ID="lblModalText" runat="server"></asp:Label>
                    </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary float-right" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal Chart Message  -->
    <div id="modalStats" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="lblUsageChartHeading" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">

                    <h5 class="modal-title">
                        <label id="lblChartHeading"></label>
                    </h5>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <div id="activity-chart" style="height: 400px;"></div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-primary float-right" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal Confirm Archive Message  -->
    <div id="modalArchiveConfirm" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="lblArchiveCourse" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">

                    <h5 class="modal-title">
                        <asp:Label ID="lblArchiveCourse" runat="server" Text="Label"></asp:Label>
                        <small>Permanently Delete Uploaded Content?</small>
                    </h5>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hfArchiveCourseID" runat="server" />
                    <asp:HiddenField ID="hfCourseTitle" runat="server" />
                    <div class="alert alert-warning"><b>WARNING:</b> Archiving a course will make it unavailable to learners. If learners are currently accessing this course, please click Cancel.</div>
                    <p>Would you like to <b>permanently delete uploaded course content</b> from the server?</p>
                    <p>Deleting content will free up storage space for other courses.</p>
                    <p>If you are likely to use this course again in future, we recommend that you don't delete uploaded content.</p>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary mr-auto float-left" data-dismiss="modal">Cancel</button>
                    <asp:LinkButton ID="lbtArchiveDelete" class="btn btn-primary mr-auto float-left" runat="server">Yes (delete content)</asp:LinkButton>
                    <asp:LinkButton ID="lbtArchiveOnly" class="btn btn-secondary float-right" runat="server">No (archive only)</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <script>
        Sys.Application.add_load(BindEvents);
    </script>
</asp:Content>
