<%@ Page Title="Admin - Landing Content" Language="vb" AutoEventWireup="false" MasterPageFile="~/tracking/Site.Master" CodeBehind="admin-landing.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.admin_landing" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.ASPxHtmlEditor.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxHtmlEditor" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxSpellChecker.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxSpellChecker" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="breadtray" runat="server">
   <ol class="breadcrumb breadcrumb-slash">
        <li class="breadcrumb-item"><a href="admin-configuration">Admin </a></li>
        <li class="breadcrumb-item active">Landing Content</li>
    </ol>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" type="text/css" href="https://unpkg.com/@fonticonpicker/fonticonpicker/dist/css/base/jquery.fonticonpicker.min.css">
    <link rel="stylesheet" type="text/css" href="https://unpkg.com/@fonticonpicker/fonticonpicker/dist/css/themes/bootstrap-theme/jquery.fonticonpicker.bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <script src="https://unpkg.com/@fonticonpicker/fonticonpicker/dist/js/jquery.fonticonpicker.min.js"></script>
    <script src="../Scripts/fontpicker.js"></script>
    <style>
        .color-primary {
            color: #005eb8 !important
        }

        .color-info {
            color: #00bcd4 !important
        }

        .color-success {
            color: #4caf50 !important
        }

        .color-warning {
            color: #ff9800 !important
        }

        .color-danger {
            color: #f44336 !important
        }

        .color-royal {
            color: #9c27b0 !important
        }

        iframe {
            width: 100%;
            height: 900px;
        }

        .dxbs-gridview .dxbs-popup {
            width: 120% !important; /* you can use custom width or different widths for different resolutions using media queries */
            height: 80% !important; /* you can use custom height or different heights for different resolution using media queries */
            left: 0 !important;
            right: 0 !important;
            top: 0 !important;
            bottom: 0 !important;
            margin: auto !important;
        }

        .mygrid .dxbs-popup .modal-content {
            max-height: 100%;
            overflow-y: auto;
        }
        @media (min-width: 992px) {
    .dxbs-popup {
        width: 95%;
        max-width: 700px;
    }
}

@media (min-width: 1200px) {
    .dxbs-popup {
        width:95%;
        max-width: 800px;
    }
}
    </style>
    <dx:BootstrapPageControl EnableViewState="false" ID="bspcLandingTabs" TabIndex="0" runat="server" SettingsLoadingcard-Enabled="true" TabAlign="Justify" EnableCallBacks="true" EnableCallbackAnimation="true" ActiveTabIndex="0">
        <CssClasses Content="bstc-content" />
        <TabPages>
            <dx:BootstrapTabPage Text="Brands">
                <ContentCollection>
                    <dx:ContentControl>
                        <asp:ObjectDataSource ID="dsOrganisations" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.CentresTableAdapter"></asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="dsBrands" runat="server" DeleteMethod="Delete" InsertMethod="InsertQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.BrandsTableAdapter" UpdateMethod="UpdateQuery">
                            <DeleteParameters>
                                <asp:Parameter Name="Original_BrandID" Type="Int32" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="BrandName" Type="String" />
                                <asp:Parameter Name="BrandDescription" Type="String" />
                                <asp:Parameter Name="BrandImage" Type="Object" />
                                <asp:Parameter Name="ImageFileType" Type="String" />
                                <asp:Parameter Name="IncludeOnLanding" Type="Boolean" />
                                <asp:Parameter Name="ContactEmail" Type="String" />
                                <asp:Parameter Name="OwnerOrganisationID" Type="Int32" />
                                <asp:Parameter Name="Active" Type="Boolean" />
                                <asp:Parameter Name="BrandLogo" Type="Object" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="BrandName" Type="String" />
                                <asp:Parameter Name="BrandDescription" Type="String" />
                                <asp:Parameter Name="BrandImage" Type="Object" />
                                <asp:Parameter Name="ImageFileType" Type="String" />
                                <asp:Parameter Name="IncludeOnLanding" Type="Boolean" />
                                <asp:Parameter Name="ContactEmail" Type="String" />
                                <asp:Parameter Name="OwnerOrganisationID" Type="Int32" />
                                <asp:Parameter Name="Active" Type="Boolean" />
                                <asp:Parameter Name="OrderByNumber" Type="Int32" />
                                <asp:Parameter Name="BrandLogo" Type="Object" />
                                <asp:Parameter Name="Original_BrandID" Type="Int32" />
                            </UpdateParameters>
                        </asp:ObjectDataSource>
                        <dx:BootstrapGridView ID="bsgvBrands" OnInitNewRow="InitNewRow_DefaultActive" OnCellEditorInitialize="bsgv_CellEditorInitialize" OnRowUpdating="bsgvBrands_RowUpdating" OnRowInserting="bsgvBrands_RowInserting" OnBeforeGetCallbackResult="bsgv_BeforeGetCallbackResult" SettingsText-ConfirmDelete="Are you sure you wish to delete this brand?" SettingsBehavior-ConfirmDelete="true" Settings-GridLines="None" SettingsBootstrap-Striped="true" runat="server" AutoGenerateColumns="False" DataSourceID="dsBrands" KeyFieldName="BrandID" OnToolbarItemClick="GridViewCustomToolbar_ToolbarItemClick">
                            <SettingsBootstrap Striped="True"></SettingsBootstrap>
                            <SettingsCommandButton>
                                <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="fas fa-plus" RenderMode="Button" />
                                <UpdateButton ButtonType="Button" CssClass="btn btn-primary float-right" IconCssClass="fas fa-check" RenderMode="Button" Text="Submit" />
                                <CancelButton ButtonType="Button" CssClass="btn btn-outline-secondary float-left" IconCssClass="fas fa-close" RenderMode="Button" />
                                <EditButton ButtonType="Button" CssClass="btn btn-outline-secondary" IconCssClass="fas fa-pencil-alt" RenderMode="Button" Text=" " />
                                <DeleteButton ButtonType="Button" CssClass="btn btn-outline-danger" IconCssClass="fas fa-trash" RenderMode="Button" Text=" " />
                            </SettingsCommandButton>
                            <Settings GridLines="None"></Settings>

                            <SettingsBehavior ConfirmDelete="True"></SettingsBehavior>

                            <SettingsEditing Mode="PopupEditForm">
                            </SettingsEditing>
                            <SettingsPopup>
                                <EditForm AllowResize="True" Modal="True" MinWidth="800px">
                                </EditForm>
                            </SettingsPopup>

                            <SettingsText ConfirmDelete="Are you sure you wish to delete this brand?"></SettingsText>

                            <SettingsDataSecurity AllowDelete="True" AllowEdit="True" AllowInsert="True" />
                            <Columns>
                                <dx:BootstrapGridViewCommandColumn Caption=" " Name="Edit" ShowEditButton="True" VisibleIndex="0">
                                </dx:BootstrapGridViewCommandColumn>
                                <dx:BootstrapGridViewTextColumn Caption=" " SettingsEditForm-Visible="false" VisibleIndex="1">
                                    <SettingsEditForm Visible="False"></SettingsEditForm>
                                    <DataItemTemplate>
                                        <asp:LinkButton ID="lbtViewBrand" EnableViewState="false" CommandArgument='<%# Eval("BrandID") %>' ToolTip="View Brand" OnCommand="lbtViewBrand_Command" CssClass="btn btn-outline-info" runat="server"><i class="fas fa-search"></i></asp:LinkButton>
                                    </DataItemTemplate>
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="BrandName" SettingsEditForm-ColumnSpan="12" VisibleIndex="1">
                                    <SettingsEditForm ColumnSpan="12"></SettingsEditForm>
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="ContactEmail" SettingsEditForm-ColumnSpan="12" VisibleIndex="5">
                                    <SettingsEditForm ColumnSpan="12"></SettingsEditForm>
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewComboBoxColumn Caption="Organisation" SettingsEditForm-ColumnSpan="12" FieldName="OwnerOrganisationID" VisibleIndex="6">
                                    <PropertiesComboBox DataSourceID="dsOrganisations" TextField="CentreName" ValueField="CentreID" DropDownButton-Visible="True">
                                    </PropertiesComboBox>

                                    <SettingsEditForm ColumnSpan="12"></SettingsEditForm>
                                </dx:BootstrapGridViewComboBoxColumn>
                                <dx:BootstrapGridViewCheckColumn FieldName="IncludeOnLanding" VisibleIndex="6" Caption="On Landing">
                                </dx:BootstrapGridViewCheckColumn>
                                <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="9">
                                </dx:BootstrapGridViewCheckColumn>
                                <dx:BootstrapGridViewMemoColumn Caption="Description" FieldName="BrandDescription" SettingsEditForm-ColumnSpan="12" Visible="False" VisibleIndex="2">
                                    <SettingsEditForm Visible="True" />
                                </dx:BootstrapGridViewMemoColumn>
                                <dx:BootstrapGridViewBinaryImageColumn FieldName="BrandImage" Caption="Image" Visible="False" SettingsEditForm-ColumnSpan="12" VisibleIndex="3">
                                    <PropertiesBinaryImage ImageWidth="200px">
                                    </PropertiesBinaryImage>
                                    <SettingsEditForm Visible="True" />
                                </dx:BootstrapGridViewBinaryImageColumn>
                                <dx:BootstrapGridViewBinaryImageColumn FieldName="BrandLogo" Caption="Image" Visible="False" SettingsEditForm-ColumnSpan="12" VisibleIndex="4">
                                    <PropertiesBinaryImage ImageWidth="300px">
                                    </PropertiesBinaryImage>
                                    <SettingsEditForm Visible="True" />
                                </dx:BootstrapGridViewBinaryImageColumn>
                                <dx:BootstrapGridViewTextColumn Caption="Order" FieldName="OrderByNumber" VisibleIndex="8" SettingsEditForm-Visible="False">
                                    <SettingsEditForm Visible="False"></SettingsEditForm>
                                    <DataItemTemplate>

                                        <asp:LinkButton ID="lbtMoveUpBrand" EnableViewState="false" ToolTip="Move Up" CssClass="btn btn-sm btn-outline-info" CommandArgument='<%# Eval("BrandID") %>' OnCommand="lbtMoveUpBrand_Command" runat="server"><i aria-hidden="true" class="fas fa-arrow-up"></i></asp:LinkButton>
                                        <asp:LinkButton ID="lbtMoveDownBrand" EnableViewState="false" ToolTip="Move Up" CssClass="btn btn-sm btn-outline-info" CommandArgument='<%# Eval("BrandID") %>' OnCommand="lbtMoveDownBrand_Command" runat="server"><i aria-hidden="true" class="fas fa-arrow-down"></i></asp:LinkButton>

                                    </DataItemTemplate>
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewCommandColumn Caption=" " Name="Delete" ShowDeleteButton="True" VisibleIndex="8"></dx:BootstrapGridViewCommandColumn>
                            </Columns>
                            <Toolbars>
                                <dx:BootstrapGridViewToolbar Position="Bottom">
                                    <Items>
                                        <dx:BootstrapGridViewToolbarItem Command="New" CssClass="btn-lg" Text="Add Brand" IconCssClass="fas fa-plus" SettingsBootstrap-RenderOption="Primary" >
<SettingsBootstrap RenderOption="Primary"></SettingsBootstrap>
                                        </dx:BootstrapGridViewToolbarItem>
                                        <dx:BootstrapGridViewToolbarItem Command="Custom" Name="PreviewBrands" CssClass="btn-lg btn-outline-primary" Text="Preview" IconCssClass="fas fa-search" SettingsBootstrap-RenderOption="None">
<SettingsBootstrap RenderOption="None"></SettingsBootstrap>
                                        </dx:BootstrapGridViewToolbarItem>
                                    </Items>
                                </dx:BootstrapGridViewToolbar>
                            </Toolbars>
                            <SettingsSearchPanel Visible="True" />
                            <ClientSideEvents ToolbarItemClick="onToolbarItemClick" />
                        </dx:BootstrapGridView>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:BootstrapTabPage>
            <dx:BootstrapTabPage Text="Products / Features">
                <ContentCollection>
                    <dx:ContentControl>
                        <asp:ObjectDataSource ID="dsProducts" runat="server" DeleteMethod="Delete" InsertMethod="InsertQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.pl_ProductsTableAdapter" UpdateMethod="Update">
                            <DeleteParameters>
                                <asp:Parameter Name="Original_ProductID" Type="Int32" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="ProductName" Type="String" />
                                <asp:Parameter Name="ProductHeading" Type="String" />
                                <asp:Parameter Name="ProductTagline" Type="String" />
                                <asp:Parameter Name="ProductScreenshot" Type="Object" />
                                <asp:Parameter Name="ProductDemoVidURL" Type="String" />
                                <asp:Parameter Name="Active" Type="Boolean" />
                                <asp:Parameter Name="ProductIconClass" Type="String" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="ProductName" Type="String" />
                                <asp:Parameter Name="ProductHeading" Type="String" />
                                <asp:Parameter Name="ProductTagline" Type="String" />
                                <asp:Parameter Name="ProductScreenshot" Type="Object" />
                                <asp:Parameter Name="ProductDemoVidURL" Type="String" />
                                <asp:Parameter Name="OrderByNumber" Type="Int32" />
                                <asp:Parameter Name="Active" Type="Boolean" />
                                <asp:Parameter Name="ProductIconClass" Type="String" />
                                <asp:Parameter Name="Original_ProductID" Type="Int32" />
                            </UpdateParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="dsFeatures" runat="server" DeleteMethod="Delete" InsertMethod="InsertQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.pl_FeaturesTableAdapter" UpdateMethod="Update">
                            <DeleteParameters>
                                <asp:Parameter Name="Original_FeatureID" Type="Int32" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:SessionParameter Name="ProductID" SessionField="dvProductID" Type="Int32" />
                                <asp:Parameter Name="FeatureHeading" Type="String" />
                                <asp:Parameter Name="FeatureDescription" Type="String" />
                                <asp:Parameter Name="FeatureIconClass" Type="String" />
                                <asp:Parameter Name="FeatureColourClass" Type="String" />
                                <asp:Parameter Name="FeatureScreenshot" Type="Object" />
                                <asp:Parameter Name="FeatureVideoURL" Type="String" />
                                <asp:Parameter Name="Active" Type="Boolean" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:SessionParameter Name="ProductID" SessionField="dvProductID" Type="Int32" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:SessionParameter Name="ProductID" SessionField="dvProductID" Type="Int32" />
                                <asp:Parameter Name="FeatureHeading" Type="String" />
                                <asp:Parameter Name="FeatureDescription" Type="String" />
                                <asp:Parameter Name="FeatureIconClass" Type="String" />
                                <asp:Parameter Name="FeatureColourClass" Type="String" />
                                <asp:Parameter Name="FeatureScreenshot" Type="Object" />
                                <asp:Parameter Name="FeatureVideoURL" Type="String" />
                                <asp:Parameter Name="Active" Type="Boolean" />
                                <asp:Parameter Name="OrderByNumber" Type="Int32" />
                                <asp:Parameter Name="Original_FeatureID" Type="Int32" />
                            </UpdateParameters>
                        </asp:ObjectDataSource>

                        <dx:BootstrapGridView ID="bsgvProducts" OnInitNewRow="InitNewRow_DefaultActive" OnRowInserting="bsgvProducts_RowInserting" OnRowUpdating="bsgvProducts_RowUpdating" ClientSideEvents-EndCallback="InitialiseFontPicker()" OnCellEditorInitialize="bsgv_CellEditorInitialize" runat="server" OnBeforeGetCallbackResult="bsgv_BeforeGetCallbackResult" AutoGenerateColumns="False" DataSourceID="dsProducts" KeyFieldName="ProductID"  OnToolbarItemClick="GridViewCustomToolbar_ToolbarItemClick">
                            <SettingsBootstrap Striped="True"></SettingsBootstrap>
                            <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="True"></SettingsDetail>
                            <SettingsCommandButton>
                                <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="fas fa-plus" RenderMode="Button" />
                                <UpdateButton ButtonType="Button" CssClass="btn btn-primary float-right" IconCssClass="fas fa-check" RenderMode="Button" Text="Submit" />
                                <CancelButton ButtonType="Button" CssClass="btn btn-outline-secondary float-left" IconCssClass="fas fa-close" RenderMode="Button" />
                                <EditButton ButtonType="Button" CssClass="btn btn-outline-secondary" IconCssClass="fas fa-pencil-alt" RenderMode="Button" Text=" " />
                                <DeleteButton ButtonType="Button" CssClass="btn btn-outline-danger" IconCssClass="fas fa-trash" RenderMode="Button" Text=" " />
                            </SettingsCommandButton>
                            <Settings GridLines="None"></Settings>

                            <SettingsBehavior ConfirmDelete="True"></SettingsBehavior>

                            <SettingsEditing Mode="PopupEditForm">
                            </SettingsEditing>
                            <SettingsPopup>
                                <EditForm AllowResize="True" Modal="True">
                                </EditForm>
                            </SettingsPopup>

                            <SettingsText ConfirmDelete="Are you sure you wish to delete this Product?"></SettingsText>

                            <SettingsDataSecurity AllowDelete="True" AllowEdit="True" AllowInsert="True" />
                            <Columns>
                                <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0">
                                </dx:BootstrapGridViewCommandColumn>
                                <dx:BootstrapGridViewTextColumn Caption=" " SettingsEditForm-Visible="false" VisibleIndex="1">
                                    <SettingsEditForm Visible="False"></SettingsEditForm>
                                    <DataItemTemplate>
                                        <asp:LinkButton ID="lbtViewProduct" EnableViewState="false" ToolTip="View Product" OnCommand="lbtViewProduct_Click" CommandArgument='<%# Eval("ProductID") %>' CssClass="btn btn-outline-info" runat="server"><i class="fas fa-search"></i></asp:LinkButton>
                                    </DataItemTemplate>
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn Caption="Icon Class" SettingsEditForm-ColumnSpan="4" FieldName="ProductIconClass" VisibleIndex="3" Visible="False">
                                                <SettingsEditForm Visible="True" />
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="tbIconClass" ClientIDMode="static" CssClass="icomoon-font-pick" Text='<%# Bind("ProductIconClass") %>' runat="server"></asp:TextBox>
                                                    <%--<asp:DropDownList ClientIDMode="Static" ID="ddIconClass" CssClass="bs-font-picker" runat="server"></asp:DropDownList>--%>
                                                    
                                                </EditItemTemplate>
                                            </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="ProductName" SettingsEditForm-ColumnSpan="8" VisibleIndex="2">
                                    <SettingsEditForm ColumnSpan="8"></SettingsEditForm>
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="ProductHeading" SettingsEditForm-ColumnSpan="12" VisibleIndex="4" Caption="Heading">
                                    <SettingsEditForm ColumnSpan="12"></SettingsEditForm>
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="ProductTagline" SettingsEditForm-ColumnSpan="12" VisibleIndex="5" Caption="Tagline">
                                    <SettingsEditForm ColumnSpan="12"></SettingsEditForm>

                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewBinaryImageColumn FieldName="ProductScreenshot" SettingsEditForm-ColumnSpan="12" VisibleIndex="6" Caption="Screenshot">
                                    <PropertiesBinaryImage ImageWidth="200px">
                                    </PropertiesBinaryImage>
                                    <SettingsEditForm Visible="True" />
                                </dx:BootstrapGridViewBinaryImageColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="ProductDemoVidURL" SettingsEditForm-ColumnSpan="12" VisibleIndex="7" Caption="Demo Video URL" Visible="False">
                                    <SettingsEditForm Visible="True" />
                                </dx:BootstrapGridViewTextColumn>

                                <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="8">
                                </dx:BootstrapGridViewCheckColumn>
                                <dx:BootstrapGridViewTextColumn Caption="Order" FieldName="OrderByNumber" VisibleIndex="9" SettingsEditForm-Visible="False">
                                    <SettingsEditForm Visible="False"></SettingsEditForm>
                                    <DataItemTemplate>

                                        <asp:LinkButton ID="lbtMoveUpProduct" EnableViewState="false" ToolTip="Move Up" CssClass="btn btn-sm btn-outline-info" CommandArgument='<%# Eval("ProductID") %>' OnCommand="lbtMoveUpProduct_Command" runat="server"><i aria-hidden="true" class="fas fa-arrow-up"></i></asp:LinkButton>
                                        <asp:LinkButton ID="lbtMoveDownProduct" EnableViewState="false" ToolTip="Move Up" CssClass="btn btn-sm btn-outline-info" CommandArgument='<%# Eval("ProductID") %>' OnCommand="lbtMoveDownProduct_Command" runat="server"><i aria-hidden="true" class="fas fa-arrow-down"></i></asp:LinkButton>

                                    </DataItemTemplate>
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewCommandColumn ShowDeleteButton="True" VisibleIndex="10">
                                </dx:BootstrapGridViewCommandColumn>
                            </Columns>
                            <ClientSideEvents EndCallback="InitialiseFontPicker" />
                            <Toolbars>
                                <dx:BootstrapGridViewToolbar Position="Bottom">
                                    <Items>
                                        <dx:BootstrapGridViewToolbarItem Command="New" CssClass="btn-lg" Text="Add Product" IconCssClass="fas fa-plus" SettingsBootstrap-RenderOption="Primary" >
<SettingsBootstrap RenderOption="Primary"></SettingsBootstrap>
                                        </dx:BootstrapGridViewToolbarItem>
                                          <dx:BootstrapGridViewToolbarItem Command="Custom" Name="PreviewProducts" CssClass="btn-outline-primary" Text="Preview" IconCssClass="fas fa-search" SettingsBootstrap-RenderOption="None">
<SettingsBootstrap RenderOption="None"></SettingsBootstrap>
                                        </dx:BootstrapGridViewToolbarItem>
                                  
                                    </Items>
                                </dx:BootstrapGridViewToolbar>
                            </Toolbars>
                            <Templates>
                                <DetailRow>
                                    <dx:BootstrapGridView ID="bsgvFeatures" OnInitNewRow="InitNewRow_DefaultActive" OnRowInserting="bsgvFeatures_RowInserting" OnRowUpdating="bsgvFeatures_RowUpdating" OnCellEditorInitialize="bsgv_CellEditorInitialize" OnBeforeGetCallbackResult="bsgv_BeforeGetCallbackResult" OnBeforePerformDataSelect="bsgvFeatures_BeforePerformDataSelect" Settings-GridLines="Horizontal" SettingsBehavior-ConfirmDelete="true" SettingsText-ConfirmDelete="Are you sure you wish to remove this Feature from the Product?" runat="server" AutoGenerateColumns="False" DataSourceID="dsFeatures" KeyFieldName="FeatureID" ClientSideEvents-EndCallback="InitialiseFontPicker()">
                                        <Settings GridLines="Horizontal"></Settings>
                                        <SettingsEditing Mode="PopupEditForm">
                                        </SettingsEditing>
                                        <SettingsPopup>
                                            <EditForm AllowResize="True" Modal="True">
                                            </EditForm>
                                        </SettingsPopup>
                                        <SettingsBehavior ConfirmDelete="True"></SettingsBehavior>

                                        <SettingsText ConfirmDelete="Are you sure you wish to remove this Feature from the Product?"></SettingsText>
                                        <SettingsCommandButton>
                                            <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="fas fa-plus" RenderMode="Button" />
                                            <UpdateButton ButtonType="Button" CssClass="btn btn-primary float-right" IconCssClass="fas fa-check" RenderMode="Button" Text="Submit" />
                                            <CancelButton ButtonType="Button" CssClass="btn btn-outline-secondary float-left" IconCssClass="fas fa-close" RenderMode="Button" />
                                            <EditButton ButtonType="Button" CssClass="btn btn-outline-secondary" IconCssClass="fas fa-pencil-alt" RenderMode="Button" Text=" " />
                                            <DeleteButton ButtonType="Button" CssClass="btn btn-outline-danger" IconCssClass="fas fa-trash" RenderMode="Button" Text=" " />
                                        </SettingsCommandButton>
                                        <SettingsDataSecurity AllowDelete="True" AllowInsert="true" AllowEdit="True" />
                                        <Columns>
                                            <dx:BootstrapGridViewCommandColumn Caption=" " ShowEditButton="True" VisibleIndex="0">
                                            </dx:BootstrapGridViewCommandColumn>
                                            <dx:BootstrapGridViewTextColumn FieldName="FeatureHeading" SettingsEditForm-ColumnSpan="12" VisibleIndex="2" Caption="Feature">
                                            </dx:BootstrapGridViewTextColumn>
                                            <dx:BootstrapGridViewMemoColumn Caption="Description" FieldName="FeatureDescription" SettingsEditForm-ColumnSpan="12" Visible="False" VisibleIndex="3">
                                                <SettingsEditForm Visible="True" />
                                                <DataItemTemplate>
                                                    <asp:Literal ID="litDescription" EnableViewState="false" Text='<%# Eval("FeatureDescription") %>' runat="server"></asp:Literal>
                                                </DataItemTemplate>
                                                <EditItemTemplate>
                                                    <dx:ASPxHtmlEditor ID="htmlDescription" Html='<%#Bind("FeatureDescription") %>' runat="server" Width="100%" Height="250px" ToolbarMode="Menu" SettingsHtmlEditing-AllowedDocumentType="HTML5" SettingsHtmlEditing-PasteMode="PlainText" SettingsHtmlEditing-AllowObjectAndEmbedElements="True" SettingsHtmlEditing-AllowHTML5MediaElements="True">
                                           <Toolbars>
                                <dx:HtmlEditorToolbar Name="StandardToolbar2">
                                    <Items>
                                        <dx:ToolbarBoldButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarBoldButton>
                                        <dx:ToolbarItalicButton AdaptivePriority="1">
                                        </dx:ToolbarItalicButton>
                                        <dx:ToolbarUnderlineButton AdaptivePriority="1">
                                        </dx:ToolbarUnderlineButton>
                                        <dx:ToolbarStrikethroughButton AdaptivePriority="1">
                                        </dx:ToolbarStrikethroughButton>
                                        <dx:ToolbarJustifyLeftButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarJustifyLeftButton>
                                        <dx:ToolbarJustifyCenterButton AdaptivePriority="1">
                                        </dx:ToolbarJustifyCenterButton>
                                        <dx:ToolbarJustifyRightButton AdaptivePriority="1">
                                        </dx:ToolbarJustifyRightButton>
                                    </Items>
                                </dx:HtmlEditorToolbar>
                                <dx:HtmlEditorToolbar Name="StandardToolbar1">
                                    <Items>
                                        <dx:ToolbarCutButton AdaptivePriority="2">
                                        </dx:ToolbarCutButton>
                                        <dx:ToolbarCopyButton AdaptivePriority="2">
                                        </dx:ToolbarCopyButton>
                                        <dx:ToolbarPasteButton AdaptivePriority="2">
                                        </dx:ToolbarPasteButton>
                                        <dx:ToolbarUndoButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarUndoButton>
                                        <dx:ToolbarRedoButton AdaptivePriority="1">
                                        </dx:ToolbarRedoButton>
                                        <dx:ToolbarRemoveFormatButton AdaptivePriority="2" BeginGroup="True">
                                        </dx:ToolbarRemoveFormatButton>
                                        <dx:ToolbarSuperscriptButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarSuperscriptButton>
                                        <dx:ToolbarSubscriptButton AdaptivePriority="1">
                                        </dx:ToolbarSubscriptButton>
                                        <dx:ToolbarInsertOrderedListButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarInsertOrderedListButton>
                                        <dx:ToolbarInsertUnorderedListButton AdaptivePriority="1">
                                        </dx:ToolbarInsertUnorderedListButton>
                                        <dx:ToolbarIndentButton AdaptivePriority="2" BeginGroup="True">
                                        </dx:ToolbarIndentButton>
                                        <dx:ToolbarOutdentButton AdaptivePriority="2">
                                        </dx:ToolbarOutdentButton>
                                        <dx:ToolbarInsertLinkDialogButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarInsertLinkDialogButton>
                                        <dx:ToolbarUnlinkButton AdaptivePriority="1">
                                        </dx:ToolbarUnlinkButton>
                                        <dx:ToolbarTableOperationsDropDownButton AdaptivePriority="2" BeginGroup="True">
                                            <Items>
                                                <dx:ToolbarInsertTableDialogButton BeginGroup="True" Text="Insert Table..." ToolTip="Insert Table...">
                                                </dx:ToolbarInsertTableDialogButton>
                                                <dx:ToolbarTablePropertiesDialogButton BeginGroup="True">
                                                </dx:ToolbarTablePropertiesDialogButton>
                                                <dx:ToolbarTableRowPropertiesDialogButton>
                                                </dx:ToolbarTableRowPropertiesDialogButton>
                                                <dx:ToolbarTableColumnPropertiesDialogButton>
                                                </dx:ToolbarTableColumnPropertiesDialogButton>
                                                <dx:ToolbarTableCellPropertiesDialogButton>
                                                </dx:ToolbarTableCellPropertiesDialogButton>
                                                <dx:ToolbarInsertTableRowAboveButton BeginGroup="True">
                                                </dx:ToolbarInsertTableRowAboveButton>
                                                <dx:ToolbarInsertTableRowBelowButton>
                                                </dx:ToolbarInsertTableRowBelowButton>
                                                <dx:ToolbarInsertTableColumnToLeftButton>
                                                </dx:ToolbarInsertTableColumnToLeftButton>
                                                <dx:ToolbarInsertTableColumnToRightButton>
                                                </dx:ToolbarInsertTableColumnToRightButton>
                                                <dx:ToolbarSplitTableCellHorizontallyButton BeginGroup="True">
                                                </dx:ToolbarSplitTableCellHorizontallyButton>
                                                <dx:ToolbarSplitTableCellVerticallyButton>
                                                </dx:ToolbarSplitTableCellVerticallyButton>
                                                <dx:ToolbarMergeTableCellRightButton>
                                                </dx:ToolbarMergeTableCellRightButton>
                                                <dx:ToolbarMergeTableCellDownButton>
                                                </dx:ToolbarMergeTableCellDownButton>
                                                <dx:ToolbarDeleteTableButton BeginGroup="True">
                                                </dx:ToolbarDeleteTableButton>
                                                <dx:ToolbarDeleteTableRowButton>
                                                </dx:ToolbarDeleteTableRowButton>
                                                <dx:ToolbarDeleteTableColumnButton>
                                                </dx:ToolbarDeleteTableColumnButton>
                                            </Items>
                                        </dx:ToolbarTableOperationsDropDownButton>
                                        <dx:ToolbarFindAndReplaceDialogButton AdaptivePriority="2" BeginGroup="True">
                                        </dx:ToolbarFindAndReplaceDialogButton>
                                        <dx:ToolbarFullscreenButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarFullscreenButton>
                                    </Items>
                                </dx:HtmlEditorToolbar>
                            </Toolbars>
                            <CssFiles>
                                <dx:HtmlEditorCssFile FilePath="~/Content/landing.css" />
                            </CssFiles>
                            <SettingsHtmlEditing PasteMode="PlainText">
                            </SettingsHtmlEditing>
                            <SettingsSpellChecker Culture="en-GB">
                            </SettingsSpellChecker>
                                                    </dx:ASPxHtmlEditor>
                                                </EditItemTemplate>
                                            </dx:BootstrapGridViewMemoColumn>

                                            <dx:BootstrapGridViewTextColumn Caption="Icon Class" SettingsEditForm-ColumnSpan="6" FieldName="FeatureIconClass" VisibleIndex="6" Visible="False">
                                                <SettingsEditForm Visible="True" />
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="tbIconClass" ClientIDMode="static" CssClass="icomoon-font-pick" Text='<%# Bind("FeatureIconClass") %>' runat="server"></asp:TextBox>
                                                    <%--<asp:DropDownList ClientIDMode="Static" ID="ddIconClass" CssClass="bs-font-picker" runat="server"></asp:DropDownList>--%>
                                                    
                                                </EditItemTemplate>
                                            </dx:BootstrapGridViewTextColumn>
                                            <dx:BootstrapGridViewBinaryImageColumn FieldName="FeatureScreenshot" SettingsEditForm-ColumnSpan="12" VisibleIndex="4" Caption="Image">
                                                <PropertiesBinaryImage ImageWidth="200px">
                                                </PropertiesBinaryImage>
                                                <SettingsEditForm Visible="True" />
                                            </dx:BootstrapGridViewBinaryImageColumn>
                                            <dx:BootstrapGridViewTextColumn Caption="Video" SettingsEditForm-ColumnSpan="12" FieldName="FeatureVideoURL" Visible="False" VisibleIndex="7">
                                                <EditItemTemplate>
                                                    <script>
		function OnUploadComplete(args) {
			callbackPanel.PerformCallback(args.callbackData);
		}
	</script>
                                                    <dx:BootstrapUploadControl ID="bsupVideo" OnFileUploadComplete="bsupVideo_FileUploadComplete" runat="server" ShowUploadButton="true" ValidationSettings-AllowedFileExtensions=".mp4" ValidationSettings-MaxFileCount="1" ShowProgressPanel="True">
                                                        <ClientSideEvents FileUploadComplete="function(s, e) { callbackPanel.PerformCallback(e.callbackData);; }" />
                                                        <CssClasses UploadButton="btn btn-outline-info" />
                                                    </dx:BootstrapUploadControl>

                                                   <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" 
			ClientInstanceName="callbackPanel" runat="server"  
			oncallback="ASPxCallbackPanel1_Callback">
			<PanelCollection>
				<dx:PanelContent runat="server">
                                                    <dx:BootstrapTextBox ID="bstbFeaureVideoURL" Text='<%# Bind("FeatureVideoURL") %>' OnDataBound="bstb_DataBound" runat="server"></dx:BootstrapTextBox>
                    </dx:PanelContent>
			</PanelCollection>
		</dx:ASPxCallbackPanel>
                                                </EditItemTemplate>
                                                <SettingsEditForm Visible="True" />
                                            </dx:BootstrapGridViewTextColumn>
                                            <dx:BootstrapGridViewCheckColumn FieldName="Active" SettingsEditForm-ColumnSpan="12" VisibleIndex="8">
                                            </dx:BootstrapGridViewCheckColumn>
                                            <dx:BootstrapGridViewComboBoxColumn Caption="Colour Class" SettingsEditForm-ColumnSpan="5" FieldName="FeatureColourClass" Visible="False" VisibleIndex="6">
                                                <PropertiesComboBox>
                                                    <Items>
                                                        <dx:BootstrapListEditItem Text="Primary" TextCssClass="color-primary" Value="Primary">
                                                        </dx:BootstrapListEditItem>
                                                        <dx:BootstrapListEditItem Text="Info" TextCssClass="color-info" Value="Info">
                                                        </dx:BootstrapListEditItem>
                                                        <dx:BootstrapListEditItem Text="Success" TextCssClass="color-success" Value="Success">
                                                        </dx:BootstrapListEditItem>
                                                        <dx:BootstrapListEditItem Text="Warning" TextCssClass="color-warning" Value="Warning">
                                                        </dx:BootstrapListEditItem>
                                                        <dx:BootstrapListEditItem Text="Danger" TextCssClass="color-danger" Value="Danger">
                                                        </dx:BootstrapListEditItem>
                                                        <dx:BootstrapListEditItem Text="Royal" TextCssClass="color-royal" Value="Royal">
                                                        </dx:BootstrapListEditItem>
                                                    </Items>
                                                </PropertiesComboBox>
                                                <SettingsEditForm Visible="True" />
                                            </dx:BootstrapGridViewComboBoxColumn>
                                            <dx:BootstrapGridViewTextColumn Caption="Order" FieldName="OrderByNumber" VisibleIndex="9" SettingsEditForm-Visible="False">
                                                <DataItemTemplate>

                                                    <asp:LinkButton ID="lbtMoveUpFeature" EnableViewState="false" ToolTip="Move Up" CssClass="btn btn-sm btn-outline-info" CommandArgument='<%# Eval("FeatureID") %>' OnCommand="lbtMoveUpFeature_Command" runat="server"><i aria-hidden="true" class="fas fa-arrow-up"></i></asp:LinkButton>
                                                    <asp:LinkButton ID="lbtMoveDownFeature" EnableViewState="false" ToolTip="Move Up" CssClass="btn btn-sm btn-outline-info" CommandArgument='<%# Eval("FeatureID") %>' OnCommand="lbtMoveDownFeature_Command" runat="server"><i aria-hidden="true" class="fas fa-arrow-down"></i></asp:LinkButton>

                                                </DataItemTemplate>
                                            </dx:BootstrapGridViewTextColumn>
                                            <dx:BootstrapGridViewCommandColumn Caption=" " ShowDeleteButton="True" VisibleIndex="10">
                                            </dx:BootstrapGridViewCommandColumn>
                                        </Columns>
                                        <Toolbars>
                                            <dx:BootstrapGridViewToolbar Position="Bottom">
                                                <Items>
                                                    <dx:BootstrapGridViewToolbarItem Command="New" Text="Add Feature" IconCssClass="fas fa-plus" SettingsBootstrap-RenderOption="Primary" />
                                                </Items>
                                            </dx:BootstrapGridViewToolbar>
                                        </Toolbars>
                                        <ClientSideEvents EndCallback="InitialiseFontPicker" />
                                    </dx:BootstrapGridView>
                                </DetailRow>
                            </Templates>
                            
                            <ClientSideEvents ToolbarItemClick="onToolbarItemClick" />
                            <SettingsSearchPanel Visible="True" />
                        </dx:BootstrapGridView>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:BootstrapTabPage>


            <dx:BootstrapTabPage Text="Bulletins">
                <ContentCollection>
                    <dx:ContentControl>
                        <asp:ObjectDataSource ID="dsBulletins" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.pwBulletinsTableAdapter" UpdateMethod="Update">
                            <DeleteParameters>
                                <asp:Parameter Name="Original_BulletinID" Type="Int32" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="BulletinName" Type="String" />
                                <asp:Parameter Name="BulletinDescription" Type="String" />
                                <asp:Parameter Name="BulletinFileName" Type="String" />
                                <asp:Parameter Name="BulletinDate" Type="DateTime" />
                                <asp:Parameter Name="BulletinImage" Type="Object" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="BulletinName" Type="String" />
                                <asp:Parameter Name="BulletinDescription" Type="String" />
                                <asp:Parameter Name="BulletinFileName" Type="String" />
                                <asp:Parameter Name="BulletinDate" Type="DateTime" />
                                <asp:Parameter Name="BulletinImage" Type="Object" />
                                <asp:Parameter Name="Original_BulletinID" Type="Int32" />
                            </UpdateParameters>
                        </asp:ObjectDataSource>
                        <dx:BootstrapGridView ID="bsgvBulletins" runat="server" OnRowInserting="bsgvBulletins_RowInserting" OnToolbarItemClick="GridViewCustomToolbar_ToolbarItemClick" OnRowUpdating="bsgvBulletins_RowUpdating"  OnCellEditorInitialize="bsgv_CellEditorInitialize"  OnBeforeGetCallbackResult="bsgv_BeforeGetCallbackResult" Settings-GridLines="Horizontal" SettingsBehavior-ConfirmDelete="true" SettingsText-ConfirmDelete="Are you sure you wish to delete this bulletin?" AutoGenerateColumns="False" DataSourceID="dsBulletins" KeyFieldName="BulletinID">
                             <SettingsBootstrap Striped="True"></SettingsBootstrap>
                            <SettingsCommandButton>
                                <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="fas fa-plus" RenderMode="Button" />
                                <UpdateButton ButtonType="Button" CssClass="btn btn-primary float-right" IconCssClass="fas fa-check" RenderMode="Button" Text="Submit" />
                                <CancelButton ButtonType="Button" CssClass="btn btn-outline-secondary float-left" IconCssClass="fas fa-close" RenderMode="Button" />
                                <EditButton ButtonType="Button" CssClass="btn btn-outline-secondary" IconCssClass="fas fa-pencil-alt" RenderMode="Button" Text=" " />
                                <DeleteButton ButtonType="Button" CssClass="btn btn-outline-danger" IconCssClass="fas fa-trash" RenderMode="Button" Text=" " />
                            </SettingsCommandButton>
                            <Settings GridLines="None"></Settings>
                            <ClientSideEvents ToolbarItemClick="onToolbarItemClick" />
                            <SettingsBehavior ConfirmDelete="True"></SettingsBehavior>

                            <SettingsEditing Mode="PopupEditForm">
                            </SettingsEditing>
                            <SettingsPopup>
                                <EditForm AllowResize="True" Modal="True">
                                </EditForm>
                            </SettingsPopup>

                            <SettingsText ConfirmDelete="Are you sure you wish to delete this Product?"></SettingsText>

                            <SettingsDataSecurity AllowDelete="True" AllowEdit="True" AllowInsert="True" />
                            <ClientSideEvents ToolbarItemClick="onToolbarItemClick" />
                            <SettingsSearchPanel Visible="True" />
                            <Columns>
                                <dx:BootstrapGridViewCommandColumn Caption=" " ShowEditButton="True" VisibleIndex="0">
                                            </dx:BootstrapGridViewCommandColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="BulletinName" SettingsEditForm-ColumnSpan="12" Caption="Title" VisibleIndex="2">
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="BulletinDescription" SettingsEditForm-ColumnSpan="12" Visible="false" SettingsEditForm-Visible="True" VisibleIndex="3">
                                    <EditItemTemplate>
                                                    <dx:ASPxHtmlEditor ID="htmlContentText" Html='<%# Bind("BulletinDescription") %>' runat="server" Width="100%" Height="250px" ToolbarMode="Menu" SettingsHtmlEditing-AllowedDocumentType="HTML5" SettingsHtmlEditing-PasteMode="PlainText" SettingsHtmlEditing-AllowObjectAndEmbedElements="True" SettingsHtmlEditing-AllowHTML5MediaElements="True">
                                                        <Toolbars>
                                <dx:HtmlEditorToolbar Name="StandardToolbar2">
                                    <Items>
                                        <dx:ToolbarBoldButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarBoldButton>
                                        <dx:ToolbarItalicButton AdaptivePriority="1">
                                        </dx:ToolbarItalicButton>
                                        <dx:ToolbarUnderlineButton AdaptivePriority="1">
                                        </dx:ToolbarUnderlineButton>
                                        <dx:ToolbarStrikethroughButton AdaptivePriority="1">
                                        </dx:ToolbarStrikethroughButton>
                                        <dx:ToolbarJustifyLeftButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarJustifyLeftButton>
                                        <dx:ToolbarJustifyCenterButton AdaptivePriority="1">
                                        </dx:ToolbarJustifyCenterButton>
                                        <dx:ToolbarJustifyRightButton AdaptivePriority="1">
                                        </dx:ToolbarJustifyRightButton>
                                    </Items>
                                </dx:HtmlEditorToolbar>
                                <dx:HtmlEditorToolbar Name="StandardToolbar1">
                                    <Items>
                                        <dx:ToolbarCutButton AdaptivePriority="2">
                                        </dx:ToolbarCutButton>
                                        <dx:ToolbarCopyButton AdaptivePriority="2">
                                        </dx:ToolbarCopyButton>
                                        <dx:ToolbarPasteButton AdaptivePriority="2">
                                        </dx:ToolbarPasteButton>
                                        <dx:ToolbarUndoButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarUndoButton>
                                        <dx:ToolbarRedoButton AdaptivePriority="1">
                                        </dx:ToolbarRedoButton>
                                        <dx:ToolbarRemoveFormatButton AdaptivePriority="2" BeginGroup="True">
                                        </dx:ToolbarRemoveFormatButton>
                                        <dx:ToolbarSuperscriptButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarSuperscriptButton>
                                        <dx:ToolbarSubscriptButton AdaptivePriority="1">
                                        </dx:ToolbarSubscriptButton>
                                        <dx:ToolbarInsertOrderedListButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarInsertOrderedListButton>
                                        <dx:ToolbarInsertUnorderedListButton AdaptivePriority="1">
                                        </dx:ToolbarInsertUnorderedListButton>
                                        <dx:ToolbarIndentButton AdaptivePriority="2" BeginGroup="True">
                                        </dx:ToolbarIndentButton>
                                        <dx:ToolbarOutdentButton AdaptivePriority="2">
                                        </dx:ToolbarOutdentButton>
                                        <dx:ToolbarInsertLinkDialogButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarInsertLinkDialogButton>
                                        <dx:ToolbarUnlinkButton AdaptivePriority="1">
                                        </dx:ToolbarUnlinkButton>
                                        <dx:ToolbarTableOperationsDropDownButton AdaptivePriority="2" BeginGroup="True">
                                            <Items>
                                                <dx:ToolbarInsertTableDialogButton BeginGroup="True" Text="Insert Table..." ToolTip="Insert Table...">
                                                </dx:ToolbarInsertTableDialogButton>
                                                <dx:ToolbarTablePropertiesDialogButton BeginGroup="True">
                                                </dx:ToolbarTablePropertiesDialogButton>
                                                <dx:ToolbarTableRowPropertiesDialogButton>
                                                </dx:ToolbarTableRowPropertiesDialogButton>
                                                <dx:ToolbarTableColumnPropertiesDialogButton>
                                                </dx:ToolbarTableColumnPropertiesDialogButton>
                                                <dx:ToolbarTableCellPropertiesDialogButton>
                                                </dx:ToolbarTableCellPropertiesDialogButton>
                                                <dx:ToolbarInsertTableRowAboveButton BeginGroup="True">
                                                </dx:ToolbarInsertTableRowAboveButton>
                                                <dx:ToolbarInsertTableRowBelowButton>
                                                </dx:ToolbarInsertTableRowBelowButton>
                                                <dx:ToolbarInsertTableColumnToLeftButton>
                                                </dx:ToolbarInsertTableColumnToLeftButton>
                                                <dx:ToolbarInsertTableColumnToRightButton>
                                                </dx:ToolbarInsertTableColumnToRightButton>
                                                <dx:ToolbarSplitTableCellHorizontallyButton BeginGroup="True">
                                                </dx:ToolbarSplitTableCellHorizontallyButton>
                                                <dx:ToolbarSplitTableCellVerticallyButton>
                                                </dx:ToolbarSplitTableCellVerticallyButton>
                                                <dx:ToolbarMergeTableCellRightButton>
                                                </dx:ToolbarMergeTableCellRightButton>
                                                <dx:ToolbarMergeTableCellDownButton>
                                                </dx:ToolbarMergeTableCellDownButton>
                                                <dx:ToolbarDeleteTableButton BeginGroup="True">
                                                </dx:ToolbarDeleteTableButton>
                                                <dx:ToolbarDeleteTableRowButton>
                                                </dx:ToolbarDeleteTableRowButton>
                                                <dx:ToolbarDeleteTableColumnButton>
                                                </dx:ToolbarDeleteTableColumnButton>
                                            </Items>
                                        </dx:ToolbarTableOperationsDropDownButton>
                                        <dx:ToolbarFindAndReplaceDialogButton AdaptivePriority="2" BeginGroup="True">
                                        </dx:ToolbarFindAndReplaceDialogButton>
                                        <dx:ToolbarFullscreenButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarFullscreenButton>
                                    </Items>
                                </dx:HtmlEditorToolbar>
                            </Toolbars>
                            <CssFiles>
                                <dx:HtmlEditorCssFile FilePath="~/Content/landing.css" />
                            </CssFiles>
                            <SettingsHtmlEditing PasteMode="PlainText">
                            </SettingsHtmlEditing>
                            <SettingsSpellChecker Culture="en-GB">
                            </SettingsSpellChecker>
                                                    </dx:ASPxHtmlEditor>
                                                </EditItemTemplate>
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="BulletinFileName" SettingsEditForm-ColumnSpan="12" Visible="false" SettingsEditForm-Visible="True" Caption="PDF Filename" VisibleIndex="4">
                                    <EditItemTemplate>
                                        <script>
		function OnBltUploadComplete(args) {
			callbackPanel.PerformCallback(args.callbackData);
		}
	</script>
                                                    <dx:BootstrapUploadControl ID="bsupBulletin" OnFileUploadComplete="bsupBulletin_FileUploadComplete" runat="server" ShowUploadButton="true" ValidationSettings-AllowedFileExtensions=".pdf" ValidationSettings-MaxFileCount="1" ShowProgressPanel="True">
                                                        <ClientSideEvents FileUploadComplete="function(s, e) { callbackPanel.PerformCallback(e.callbackData);; }" />
                                                        <CssClasses UploadButton="btn btn-outline-info" />
                                                    </dx:BootstrapUploadControl>

                                                   <dx:ASPxCallbackPanel ID="ASPxCallbackPanel1" 
			ClientInstanceName="callbackPanel" runat="server"  
			oncallback="ASPxCallbackPanel1_Callback">
			<PanelCollection>
				<dx:PanelContent runat="server">
                                                    <dx:BootstrapTextBox ID="bstbBulletinFileName" Text='<%# Bind("BulletinFileName") %>' OnDataBound="bstb_DataBound" runat="server"></dx:BootstrapTextBox>
                    </dx:PanelContent>
			</PanelCollection>
		</dx:ASPxCallbackPanel>
                                    </EditItemTemplate>
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewBinaryImageColumn FieldName="BulletinImage" SettingsEditForm-ColumnSpan="12" VisibleIndex="5" Caption="Image">
                                                <PropertiesBinaryImage ImageWidth="200px">
                                                </PropertiesBinaryImage>
                                                <SettingsEditForm Visible="True" />
                                            </dx:BootstrapGridViewBinaryImageColumn>
                                <dx:BootstrapGridViewDateColumn FieldName="BulletinDate" SettingsEditForm-ColumnSpan="12" VisibleIndex="6">
                                </dx:BootstrapGridViewDateColumn>
                                <dx:BootstrapGridViewCommandColumn Caption=" " ShowDeleteButton="True" VisibleIndex="7">
                                            </dx:BootstrapGridViewCommandColumn>
                            </Columns>
                            <Toolbars>
                                            <dx:BootstrapGridViewToolbar Position="Bottom">
                                                <Items>
                                                    <dx:BootstrapGridViewToolbarItem Command="New" Text="Add Bulletin" IconCssClass="fas fa-plus" SettingsBootstrap-RenderOption="Primary" />
                                                    <dx:BootstrapGridViewToolbarItem Command="Custom" Name="PreviewBulletins" CssClass="btn-outline-primary" Text="Preview" IconCssClass="fas fa-search" SettingsBootstrap-RenderOption="None">
<SettingsBootstrap RenderOption="None"></SettingsBootstrap>
                                        </dx:BootstrapGridViewToolbarItem>
                                                </Items>
                                            </dx:BootstrapGridViewToolbar>
                                        </Toolbars>
                        </dx:BootstrapGridView>

                    </dx:ContentControl>
                </ContentCollection>
            </dx:BootstrapTabPage>


            <dx:BootstrapTabPage Text="Case studies">
                <ContentCollection>
                    <dx:ContentControl>
                       
                        <asp:ObjectDataSource ID="dsCaseStudies" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.pl_CaseStudiesTableAdapter" UpdateMethod="Update">
                            <DeleteParameters>
                                <asp:Parameter Name="Original_CaseStudyID" Type="Int32" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="CaseHeading" Type="String" />
                                <asp:Parameter Name="CaseSubHeading" Type="String" />
                                <asp:Parameter Name="CaseDate" Type="DateTime" />
                                <asp:Parameter Name="ProductID" Type="Int32" />
                                <asp:Parameter Name="BrandID" Type="Int32" />
                                <asp:Parameter Name="Active" Type="Boolean" />
                                <asp:Parameter Name="CaseImage" Type="Object" />
                                <asp:Parameter Name="CaseStudyGroup" Type="String" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:Parameter DefaultValue="1000" Name="ResultCount" Type="Int32" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="CaseHeading" Type="String" />
                                <asp:Parameter Name="CaseSubHeading" Type="String" />
                                <asp:Parameter Name="CaseDate" Type="DateTime" />
                                <asp:Parameter Name="ProductID" Type="Int32" />
                                <asp:Parameter Name="BrandID" Type="Int32" />
                                <asp:Parameter Name="Active" Type="Boolean" />
                                <asp:Parameter Name="CaseImage" Type="Object" />
                                <asp:Parameter Name="CaseStudyGroup" Type="String" />
                                <asp:Parameter Name="Original_CaseStudyID" Type="Int32" />
                            </UpdateParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="dsCaseContent" runat="server" DeleteMethod="Delete" InsertMethod="InsertQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByCaseStudyID" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.pl_CaseContentTableAdapter" UpdateMethod="Update">
                            <DeleteParameters>
                                <asp:Parameter Name="Original_CaseContentID" Type="Int32" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:SessionParameter Name="CaseStudyID" SessionField="dvCaseStudyID" Type="Int32" />
                                <asp:Parameter Name="ContentHeading" Type="String" />
                                <asp:Parameter Name="ContentText" Type="String" />
                                <asp:Parameter Name="ContentImage" Type="Object" />
                                <asp:Parameter Name="ContentQuoteText" Type="String" />
                                <asp:Parameter Name="ContentQuoteAttr" Type="String" />
                                <asp:Parameter Name="Active" Type="Boolean" />
                                <asp:Parameter Name="ImageWidth" Type="Int32" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:SessionParameter Name="CaseStudyID" SessionField="dvCaseStudyID" Type="Int32" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:SessionParameter Name="CaseStudyID" SessionField="dvCaseStudyID" Type="Int32" />
                                <asp:Parameter Name="ContentHeading" Type="String" />
                                <asp:Parameter Name="ContentText" Type="String" />
                                <asp:Parameter Name="ContentImage" Type="Object" />
                                <asp:Parameter Name="ContentQuoteText" Type="String" />
                                <asp:Parameter Name="ContentQuoteAttr" Type="String" />
                                <asp:Parameter Name="OrderByNumber" Type="Int32" />
                                <asp:Parameter Name="Active" Type="Boolean" />
                                <asp:Parameter Name="ImageWidth" Type="Int32" />
                                <asp:Parameter Name="Original_CaseContentID" Type="Int32" />
                            </UpdateParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="dsCSGroups" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.CSGroupsTableAdapter"></asp:ObjectDataSource>
                          <dx:BootstrapGridView ID="bsgvCaseStudies" OnInitNewRow="InitNewRow_DefaultActive" OnRowInserting="bsgvCaseStudies_RowInserting" OnRowUpdating="bsgvCaseStudies_RowUpdating" OnBeforeGetCallbackResult="bsgv_BeforeGetCallbackResult" runat="server" AutoGenerateColumns="False" DataSourceID="dsCaseStudies" KeyFieldName="CaseStudyID" OnToolbarItemClick="GridViewCustomToolbar_ToolbarItemClick">
                            <SettingsBootstrap Striped="True"></SettingsBootstrap>
                            <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="True"></SettingsDetail>
                            <SettingsCommandButton>
                               <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="fas fa-plus" RenderMode="Button" />
                                <UpdateButton ButtonType="Button" CssClass="btn btn-primary float-right" IconCssClass="fas fa-check" RenderMode="Button" Text="Submit" />
                                <CancelButton ButtonType="Button" CssClass="btn btn-outline-secondary float-left" IconCssClass="fas fa-close" RenderMode="Button" />
                                <EditButton ButtonType="Button" CssClass="btn btn-outline-secondary" IconCssClass="fas fa-pencil-alt" RenderMode="Button" Text=" " />
                                <DeleteButton ButtonType="Button" CssClass="btn btn-outline-danger" IconCssClass="fas fa-trash" RenderMode="Button" Text=" " />
                            </SettingsCommandButton>
                            <Settings GridLines="None"></Settings>

                            <SettingsBehavior ConfirmDelete="True"></SettingsBehavior>

                            <SettingsEditing Mode="PopupEditForm">
                            </SettingsEditing>
                            <SettingsPopup>
                                <EditForm AllowResize="True" Modal="True">
                                </EditForm>
                            </SettingsPopup>

                            <SettingsText ConfirmDelete="Are you sure you wish to delete this Case Study?"></SettingsText>
                            <SettingsDataSecurity AllowDelete="True" AllowEdit="True" AllowInsert="True" />
                            <Columns>
                                <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" Caption=" ">
                                </dx:BootstrapGridViewCommandColumn>
                                <dx:BootstrapGridViewTextColumn Caption=" " SettingsEditForm-Visible="false" VisibleIndex="1">
                                    <SettingsEditForm Visible="False"></SettingsEditForm>
                                    <DataItemTemplate>
                                        <asp:LinkButton EnableViewState="false" ID="lbtViewCase" ToolTip="View Case" OnCommand="lbtViewCase_Click" CommandArgument='<%# Eval("CaseStudyID") %>' CssClass="btn btn-outline-info" runat="server"><i class="fas fa-search"></i></asp:LinkButton>
                                    </DataItemTemplate>
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn Caption="Heading" SettingsEditForm-ColumnSpan="12" FieldName="CaseHeading" VisibleIndex="1">
                                  
<SettingsEditForm ColumnSpan="12"></SettingsEditForm>
                                  
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn Caption="Sub Heading" SettingsEditForm-ColumnSpan="12" FieldName="CaseSubHeading" VisibleIndex="2">
                                   
<SettingsEditForm ColumnSpan="12"></SettingsEditForm>
                                   
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewBinaryImageColumn FieldName="CaseImage" SettingsEditForm-ColumnSpan="12" VisibleIndex="3" Caption="Image">
                                    <PropertiesBinaryImage ImageSizeMode="FitProportional" ImageWidth="200px">
                                    </PropertiesBinaryImage>
                                    <SettingsEditForm Visible="True" />
                                </dx:BootstrapGridViewBinaryImageColumn>

                                <dx:BootstrapGridViewComboBoxColumn Caption="Associated Product" SettingsEditForm-ColumnSpan="12" Visible="false" SettingsEditForm-Visible="True" FieldName="ProductID" VisibleIndex="4">
                                    <PropertiesComboBox AllowNull="True" DataSourceID="dsProducts" TextField="ProductName" ValueField="ProductID">
                                    </PropertiesComboBox>

                                    <SettingsEditForm Visible="True"></SettingsEditForm>
                                </dx:BootstrapGridViewComboBoxColumn>
                                <dx:BootstrapGridViewComboBoxColumn Caption="Associated Brand" SettingsEditForm-ColumnSpan="12" Visible="false" SettingsEditForm-Visible="True" FieldName="BrandID" VisibleIndex="5">
                                    <PropertiesComboBox AllowNull="True" DataSourceID="dsBrands" TextField="BrandName" ValueField="BrandID">
                                    </PropertiesComboBox>

                                    <SettingsEditForm Visible="True"></SettingsEditForm>
                                </dx:BootstrapGridViewComboBoxColumn>
                                <dx:BootstrapGridViewComboBoxColumn Caption="Group" SettingsEditForm-ColumnSpan="12" FieldName="CaseStudyGroup" VisibleIndex="6">
                                    <PropertiesComboBox AllowNull="True" DataSourceID="dsCSGroups" NullDisplayText="None selected" NullText="None selected" TextField="CaseStudyGroup" ValueField="CaseStudyGroup">
                                    </PropertiesComboBox>

<SettingsEditForm ColumnSpan="12"></SettingsEditForm>

                                </dx:BootstrapGridViewComboBoxColumn>
                                <dx:BootstrapGridViewDateColumn Caption="Date" SettingsEditForm-ColumnSpan="12" FieldName="CaseDate" VisibleIndex="7">
<SettingsEditForm ColumnSpan="12"></SettingsEditForm>
                                </dx:BootstrapGridViewDateColumn>
                                <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="8">
                                </dx:BootstrapGridViewCheckColumn>
                                <dx:BootstrapGridViewCommandColumn ShowDeleteButton="True" VisibleIndex="9" Caption=" ">
                                </dx:BootstrapGridViewCommandColumn>

                            </Columns>
                            <Toolbars>
                                <dx:BootstrapGridViewToolbar Position="Bottom">
                                    <Items>
                                        <dx:BootstrapGridViewToolbarItem Command="New" CssClass="btn-lg" Text="Add Case Study" IconCssClass="fas fa-plus" SettingsBootstrap-RenderOption="Primary" >
<SettingsBootstrap RenderOption="Primary"></SettingsBootstrap>
                                        </dx:BootstrapGridViewToolbarItem>
                                        <dx:BootstrapGridViewToolbarItem Command="Custom" Name="PreviewCases" CssClass="btn-lg btn-outline-primary" Text="Preview" IconCssClass="fas fa-search" SettingsBootstrap-RenderOption="None">
<SettingsBootstrap RenderOption="None"></SettingsBootstrap>
                                        </dx:BootstrapGridViewToolbarItem>
                                    </Items>
                                </dx:BootstrapGridViewToolbar>
                            </Toolbars>
                            <Templates>
                                <DetailRow>
                                    <dx:BootstrapGridView ID="bsgvCaseContent" OnCellEditorInitialize="bsgv_CellEditorInitialize" OnRowInserting="bsgvCaseContent_RowInserting" OnRowUpdating="bsgvCaseContent_RowUpdating" OnInitNewRow="InitNewRow_DefaultActive" OnBeforeGetCallbackResult="bsgv_BeforeGetCallbackResult" OnBeforePerformDataSelect="bsgvCaseContent_BeforePerformDataSelect" Settings-GridLines="Horizontal" SettingsBehavior-ConfirmDelete="true" SettingsText-ConfirmDelete="Are you sure you wish to remove this Feature from the Product?" runat="server" AutoGenerateColumns="False" DataSourceID="dsCaseContent" KeyFieldName="CaseContentID">
                                        <Settings GridLines="Horizontal"></Settings>
                                        <SettingsEditing Mode="PopupEditForm">
                                        </SettingsEditing>
                                        <SettingsPopup>

                                            <EditForm SettingsAdaptivity-Mode="Always" HorizontalAlign="LeftSides" Modal="True">
                                            </EditForm>
                                        </SettingsPopup>
                                        <SettingsBehavior ConfirmDelete="True"></SettingsBehavior>

                                        <SettingsText ConfirmDelete="Are you sure you wish to remove this Content from the Case Study?"></SettingsText>
                                        <SettingsCommandButton>
                                            <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="fas fa-plus" RenderMode="Button" />
                                <UpdateButton ButtonType="Button" CssClass="btn btn-primary float-right" IconCssClass="fas fa-check" RenderMode="Button" Text="Submit" />
                                <CancelButton ButtonType="Button" CssClass="btn btn-outline-secondary float-left" IconCssClass="fas fa-close" RenderMode="Button" />
                                <EditButton ButtonType="Button" CssClass="btn btn-outline-secondary" IconCssClass="fas fa-pencil-alt" RenderMode="Button" Text=" " />
                                <DeleteButton ButtonType="Button" CssClass="btn btn-outline-danger" IconCssClass="fas fa-trash" RenderMode="Button" Text=" " />
                                        </SettingsCommandButton>
                                        <SettingsDataSecurity AllowDelete="True" AllowInsert="true" AllowEdit="True" />
                                        <Columns>
                                            <dx:BootstrapGridViewTextColumn FieldName="ContentHeading" SettingsEditForm-ColumnSpan="12" VisibleIndex="1" Caption="L3 Heading">
<SettingsEditForm ColumnSpan="12"></SettingsEditForm>
                                            </dx:BootstrapGridViewTextColumn>

                                            <dx:BootstrapGridViewTextColumn Caption="Quote" Visible="false" SettingsEditForm-Visible="true" SettingsEditForm-ColumnSpan="12" FieldName="ContentQuoteText" VisibleIndex="6">
<SettingsEditForm ColumnSpan="12" Visible="True"></SettingsEditForm>
                                            </dx:BootstrapGridViewTextColumn>
                                            <dx:BootstrapGridViewTextColumn Caption="Attribution" Visible="false" SettingsEditForm-Visible="true" SettingsEditForm-ColumnSpan="12" FieldName="ContentQuoteAttr" VisibleIndex="7">
<SettingsEditForm ColumnSpan="12" Visible="True"></SettingsEditForm>
                                            </dx:BootstrapGridViewTextColumn>
                                            <dx:BootstrapGridViewCheckColumn FieldName="Active" SettingsEditForm-ColumnSpan="12" VisibleIndex="8">
<SettingsEditForm ColumnSpan="12"></SettingsEditForm>
                                            </dx:BootstrapGridViewCheckColumn>
                                            <dx:BootstrapGridViewMemoColumn Caption="Content" FieldName="ContentText" SettingsEditForm-ColumnSpan="12" VisibleIndex="2">
<SettingsEditForm ColumnSpan="12"></SettingsEditForm>
                                                <DataItemTemplate>
                                                    <asp:Literal EnableViewState="false" ID="litContentText" Text='<%# Eval("ContentText") %>' runat="server"></asp:Literal>
                                                    <br />
                                                    <asp:Label EnableViewState="false" ID="lblQuote" runat="server" Text='<%# Eval("ContentQuoteText") %>' Font-Italic="True"></asp:Label>
                                                    <br />
                                                    <div class="float-right" style="text-align:right;">
                                                    <asp:Label EnableViewState="false" ID="lblAttribution" runat="server" Text='<%# Eval("ContentQuoteAttr") %>' ></asp:Label></div>
                                                </DataItemTemplate>
                                                <EditItemTemplate>
                                                    <dx:ASPxHtmlEditor ID="htmlContentText" Html='<%# Bind("ContentText") %>' runat="server" Width="100%" Height="250px" ToolbarMode="Menu" SettingsHtmlEditing-AllowedDocumentType="HTML5" SettingsHtmlEditing-PasteMode="PlainText" SettingsHtmlEditing-AllowObjectAndEmbedElements="True" SettingsHtmlEditing-AllowHTML5MediaElements="True">
                                                        <Toolbars>
                                <dx:HtmlEditorToolbar Name="StandardToolbar2">
                                    <Items>
                                        <dx:ToolbarBoldButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarBoldButton>
                                        <dx:ToolbarItalicButton AdaptivePriority="1">
                                        </dx:ToolbarItalicButton>
                                        <dx:ToolbarUnderlineButton AdaptivePriority="1">
                                        </dx:ToolbarUnderlineButton>
                                        <dx:ToolbarStrikethroughButton AdaptivePriority="1">
                                        </dx:ToolbarStrikethroughButton>
                                        <dx:ToolbarJustifyLeftButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarJustifyLeftButton>
                                        <dx:ToolbarJustifyCenterButton AdaptivePriority="1">
                                        </dx:ToolbarJustifyCenterButton>
                                        <dx:ToolbarJustifyRightButton AdaptivePriority="1">
                                        </dx:ToolbarJustifyRightButton>
                                    </Items>
                                </dx:HtmlEditorToolbar>
                                <dx:HtmlEditorToolbar Name="StandardToolbar1">
                                    <Items>
                                        <dx:ToolbarCutButton AdaptivePriority="2">
                                        </dx:ToolbarCutButton>
                                        <dx:ToolbarCopyButton AdaptivePriority="2">
                                        </dx:ToolbarCopyButton>
                                        <dx:ToolbarPasteButton AdaptivePriority="2">
                                        </dx:ToolbarPasteButton>
                                        <dx:ToolbarUndoButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarUndoButton>
                                        <dx:ToolbarRedoButton AdaptivePriority="1">
                                        </dx:ToolbarRedoButton>
                                        <dx:ToolbarRemoveFormatButton AdaptivePriority="2" BeginGroup="True">
                                        </dx:ToolbarRemoveFormatButton>
                                        <dx:ToolbarSuperscriptButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarSuperscriptButton>
                                        <dx:ToolbarSubscriptButton AdaptivePriority="1">
                                        </dx:ToolbarSubscriptButton>
                                        <dx:ToolbarInsertOrderedListButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarInsertOrderedListButton>
                                        <dx:ToolbarInsertUnorderedListButton AdaptivePriority="1">
                                        </dx:ToolbarInsertUnorderedListButton>
                                        <dx:ToolbarIndentButton AdaptivePriority="2" BeginGroup="True">
                                        </dx:ToolbarIndentButton>
                                        <dx:ToolbarOutdentButton AdaptivePriority="2">
                                        </dx:ToolbarOutdentButton>
                                        <dx:ToolbarInsertLinkDialogButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarInsertLinkDialogButton>
                                        <dx:ToolbarUnlinkButton AdaptivePriority="1">
                                        </dx:ToolbarUnlinkButton>
                                        <dx:ToolbarTableOperationsDropDownButton AdaptivePriority="2" BeginGroup="True">
                                            <Items>
                                                <dx:ToolbarInsertTableDialogButton BeginGroup="True" Text="Insert Table..." ToolTip="Insert Table...">
                                                </dx:ToolbarInsertTableDialogButton>
                                                <dx:ToolbarTablePropertiesDialogButton BeginGroup="True">
                                                </dx:ToolbarTablePropertiesDialogButton>
                                                <dx:ToolbarTableRowPropertiesDialogButton>
                                                </dx:ToolbarTableRowPropertiesDialogButton>
                                                <dx:ToolbarTableColumnPropertiesDialogButton>
                                                </dx:ToolbarTableColumnPropertiesDialogButton>
                                                <dx:ToolbarTableCellPropertiesDialogButton>
                                                </dx:ToolbarTableCellPropertiesDialogButton>
                                                <dx:ToolbarInsertTableRowAboveButton BeginGroup="True">
                                                </dx:ToolbarInsertTableRowAboveButton>
                                                <dx:ToolbarInsertTableRowBelowButton>
                                                </dx:ToolbarInsertTableRowBelowButton>
                                                <dx:ToolbarInsertTableColumnToLeftButton>
                                                </dx:ToolbarInsertTableColumnToLeftButton>
                                                <dx:ToolbarInsertTableColumnToRightButton>
                                                </dx:ToolbarInsertTableColumnToRightButton>
                                                <dx:ToolbarSplitTableCellHorizontallyButton BeginGroup="True">
                                                </dx:ToolbarSplitTableCellHorizontallyButton>
                                                <dx:ToolbarSplitTableCellVerticallyButton>
                                                </dx:ToolbarSplitTableCellVerticallyButton>
                                                <dx:ToolbarMergeTableCellRightButton>
                                                </dx:ToolbarMergeTableCellRightButton>
                                                <dx:ToolbarMergeTableCellDownButton>
                                                </dx:ToolbarMergeTableCellDownButton>
                                                <dx:ToolbarDeleteTableButton BeginGroup="True">
                                                </dx:ToolbarDeleteTableButton>
                                                <dx:ToolbarDeleteTableRowButton>
                                                </dx:ToolbarDeleteTableRowButton>
                                                <dx:ToolbarDeleteTableColumnButton>
                                                </dx:ToolbarDeleteTableColumnButton>
                                            </Items>
                                        </dx:ToolbarTableOperationsDropDownButton>
                                        <dx:ToolbarFindAndReplaceDialogButton AdaptivePriority="2" BeginGroup="True">
                                        </dx:ToolbarFindAndReplaceDialogButton>
                                        <dx:ToolbarFullscreenButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarFullscreenButton>
                                    </Items>
                                </dx:HtmlEditorToolbar>
                            </Toolbars>
                            <CssFiles>
                                <dx:HtmlEditorCssFile FilePath="~/Content/landing.css" />
                            </CssFiles>
                            <SettingsHtmlEditing PasteMode="PlainText">
                            </SettingsHtmlEditing>
                            <SettingsSpellChecker Culture="en-GB">
                            </SettingsSpellChecker>
                                                    </dx:ASPxHtmlEditor>
                                                </EditItemTemplate>
                                            </dx:BootstrapGridViewMemoColumn>

                                            <dx:BootstrapGridViewBinaryImageColumn FieldName="ContentImage" Caption="Image" SettingsEditForm-ColumnSpan="12" VisibleIndex="3">
                                                <PropertiesBinaryImage ImageSizeMode="FitProportional" ImageWidth="200px"></PropertiesBinaryImage>

<SettingsEditForm ColumnSpan="12"></SettingsEditForm>
                                            </dx:BootstrapGridViewBinaryImageColumn>
                                            <dx:BootstrapGridViewCommandColumn ShowEditButton="True" VisibleIndex="0" Caption=" ">
                                            </dx:BootstrapGridViewCommandColumn>
                                            <dx:BootstrapGridViewTextColumn Caption="Order" FieldName="OrderByNumber" VisibleIndex="9" SettingsEditForm-Visible="False">
<SettingsEditForm Visible="False"></SettingsEditForm>
                                                <DataItemTemplate>

                                                    <asp:LinkButton EnableViewState="false" ID="lbtMoveUpCaseContent" ToolTip="Move Up" CssClass="btn btn-sm btn-outline-info" CommandArgument='<%# Eval("CaseContentID") %>' OnCommand="lbtMoveUpCaseContent_Command" runat="server"><i aria-hidden="true" class="fas fa-arrow-up"></i></asp:LinkButton>
                                                    <asp:LinkButton EnableViewState="false" ID="lbtMoveDownCaseContent" ToolTip="Move Up" CssClass="btn btn-sm btn-outline-info" CommandArgument='<%# Eval("CaseContentID") %>' OnCommand="lbtMoveDownCaseContent_Command" runat="server"><i aria-hidden="true" class="fas fa-arrow-down"></i></asp:LinkButton>

                                                </DataItemTemplate>
                                            </dx:BootstrapGridViewTextColumn>
                                            <dx:BootstrapGridViewCommandColumn ShowDeleteButton="True" VisibleIndex="10" Caption=" ">
                                            </dx:BootstrapGridViewCommandColumn>
                                            <dx:BootstrapGridViewComboBoxColumn Caption="Image width" FieldName="ImageWidth" Visible="False" VisibleIndex="5">
                                                <PropertiesComboBox DisplayFormatString="g">
                                                    <Items>
                                                        <dx:BootstrapListEditItem Selected="True" Text="33%" Value="33">
                                                        </dx:BootstrapListEditItem>
                                                        <dx:BootstrapListEditItem Text="50%" Value="50">
                                                        </dx:BootstrapListEditItem>
                                                        <dx:BootstrapListEditItem Text="66%" Value="66">
                                                        </dx:BootstrapListEditItem>
                                                        <dx:BootstrapListEditItem Text="100%" Value="100">
                                                        </dx:BootstrapListEditItem>
                                                    </Items>
                                                </PropertiesComboBox>
                                                <SettingsEditForm ColumnSpan="12" Visible="True" />
                                            </dx:BootstrapGridViewComboBoxColumn>
                                        </Columns>
                                        <Toolbars>
                                            <dx:BootstrapGridViewToolbar Position="Bottom">
                                                <Items>
                                                    <dx:BootstrapGridViewToolbarItem Command="New" CssClass="btn btn-primary" Text="Add Content" IconCssClass="fas fa-plus" />

                                                </Items>
                                            </dx:BootstrapGridViewToolbar>
                                        </Toolbars>

                                    </dx:BootstrapGridView>
                                </DetailRow>
                            </Templates>
                            <SettingsSearchPanel Visible="True" />
                            <ClientSideEvents ToolbarItemClick="onToolbarItemClick" />
                        </dx:BootstrapGridView>
                        
                    </dx:ContentControl>
                </ContentCollection>
            </dx:BootstrapTabPage>
            <dx:BootstrapTabPage Text="Quotes">
                <ContentCollection>
                    <dx:ContentControl>
                        <asp:ObjectDataSource ID="dsQuotes" runat="server" DeleteMethod="Delete" InsertMethod="InsertQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.pl_QuotesTableAdapter" UpdateMethod="Update">
                            <DeleteParameters>
                                <asp:Parameter Name="Original_QuoteID" Type="Int32" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="QuoteText" Type="String" />
                                <asp:Parameter Name="AttrIndividual" Type="String" />
                                <asp:Parameter Name="AttrOrganisation" Type="String" />
                                <asp:Parameter Name="QuoteDate" Type="DateTime" />
                                <asp:Parameter Name="ProductID" Type="Int32" />
                                <asp:Parameter Name="BrandID" Type="Int32" />
                                <asp:Parameter Name="Active" Type="Boolean" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="QuoteText" Type="String" />
                                <asp:Parameter Name="AttrIndividual" Type="String" />
                                <asp:Parameter Name="AttrOrganisation" Type="String" />
                                <asp:Parameter Name="QuoteDate" Type="DateTime" />
                                <asp:Parameter Name="ProductID" Type="Int32" />
                                <asp:Parameter Name="BrandID" Type="Int32" />
                                <asp:Parameter Name="Active" Type="Boolean" />
                                <asp:Parameter Name="Original_QuoteID" Type="Int32" />
                            </UpdateParameters>
                        </asp:ObjectDataSource>

                        <dx:BootstrapGridView ID="bsgvQuotes" OnInitNewRow="InitNewRow_DefaultActive" runat="server" SettingsText-ConfirmDelete="Are you sure you wish to delete this quote?" SettingsBehavior-ConfirmDelete="true" Settings-GridLines="None" SettingsBootstrap-Striped="true" AutoGenerateColumns="False" DataSourceID="dsQuotes" KeyFieldName="QuoteID" OnToolbarItemClick="GridViewCustomToolbar_ToolbarItemClick">
                            <SettingsBootstrap Striped="True"></SettingsBootstrap>
                            <SettingsDetail ShowDetailRow="True" AllowOnlyOneMasterRowExpanded="True"></SettingsDetail>
                            <SettingsCommandButton>
                                <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="fas fa-plus" RenderMode="Button" />
                                <UpdateButton ButtonType="Button" CssClass="btn btn-primary float-right" IconCssClass="fas fa-check" RenderMode="Button" Text="Submit" />
                                <CancelButton ButtonType="Button" CssClass="btn btn-outline-secondary float-left" IconCssClass="fas fa-close" RenderMode="Button" />
                                <EditButton ButtonType="Button" CssClass="btn btn-outline-secondary" IconCssClass="fas fa-pencil-alt" RenderMode="Button" Text=" " />
                                <DeleteButton ButtonType="Button" CssClass="btn btn-outline-danger" IconCssClass="fas fa-trash" RenderMode="Button" Text=" " />
                            </SettingsCommandButton>
                            <Settings GridLines="None"></Settings>

                            <SettingsBehavior ConfirmDelete="True"></SettingsBehavior>

                            <SettingsEditing Mode="PopupEditForm">
                            </SettingsEditing>
                            <SettingsPopup>
                                <EditForm AllowResize="True" Modal="True">
                                </EditForm>
                            </SettingsPopup>

                            <SettingsText ConfirmDelete="Are you sure you wish to delete this quote?"></SettingsText>

                            <SettingsDataSecurity AllowDelete="True" AllowEdit="True" AllowInsert="True" />
                            <SettingsSearchPanel Visible="True" />
                            <Columns>
                                <dx:BootstrapGridViewCommandColumn Caption=" " Name="Edit" ShowEditButton="True" VisibleIndex="0">
                                </dx:BootstrapGridViewCommandColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="AttrIndividual" SettingsEditForm-ColumnSpan="12" VisibleIndex="2" Caption="Attribution">
                                    <SettingsEditForm ColumnSpan="12"></SettingsEditForm>
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn SettingsEditForm-ColumnSpan="12" FieldName="AttrOrganisation" VisibleIndex="3">
                                    <SettingsEditForm ColumnSpan="12"></SettingsEditForm>
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewDateColumn FieldName="QuoteDate" SettingsEditForm-ColumnSpan="12" VisibleIndex="4">
                                    
<SettingsEditForm ColumnSpan="12"></SettingsEditForm>
                                    
                                </dx:BootstrapGridViewDateColumn>
                                <dx:BootstrapGridViewComboBoxColumn Caption="Associated Product" SettingsEditForm-ColumnSpan="12" Visible="false" SettingsEditForm-Visible="True" FieldName="ProductID" VisibleIndex="5">
                                    <PropertiesComboBox AllowNull="True" DataSourceID="dsProducts" TextField="ProductName" ValueField="ProductID">
                                    </PropertiesComboBox>

                                    <SettingsEditForm Visible="True"></SettingsEditForm>
                                </dx:BootstrapGridViewComboBoxColumn>
                                <dx:BootstrapGridViewComboBoxColumn Caption="Associated Brand" SettingsEditForm-ColumnSpan="12" Visible="false" SettingsEditForm-Visible="True" FieldName="BrandID" VisibleIndex="6">
                                    <PropertiesComboBox AllowNull="True" DataSourceID="dsBrands" TextField="BrandName" ValueField="BrandID">
                                    </PropertiesComboBox>

                                    <SettingsEditForm ColumnSpan="12" Visible="True"></SettingsEditForm>
                                </dx:BootstrapGridViewComboBoxColumn>
                                <dx:BootstrapGridViewCheckColumn FieldName="Active" SettingsEditForm-ColumnSpan="12" VisibleIndex="7">
                                    <SettingsEditForm ColumnSpan="12"></SettingsEditForm>
                                </dx:BootstrapGridViewCheckColumn>
                                <dx:BootstrapGridViewCommandColumn Caption=" " Name="Delete" ShowDeleteButton="True" VisibleIndex="8"></dx:BootstrapGridViewCommandColumn>
                                <dx:BootstrapGridViewMemoColumn FieldName="QuoteText" VisibleIndex="1">
                                    <PropertiesMemoEdit Rows="3">
                                    </PropertiesMemoEdit>

                                    <SettingsEditForm ColumnSpan="12" />
                                </dx:BootstrapGridViewMemoColumn>
                            </Columns>
                            <ClientSideEvents ToolbarItemClick="onToolbarItemClick" />
                            <Toolbars>
                                <dx:BootstrapGridViewToolbar Position="Bottom">
                                    <Items>
                                        <dx:BootstrapGridViewToolbarItem Command="New" CssClass="btn-lg" Text="Add Quote" IconCssClass="fas fa-plus" SettingsBootstrap-RenderOption="Primary" >
<SettingsBootstrap RenderOption="Primary"></SettingsBootstrap>
                                        </dx:BootstrapGridViewToolbarItem>
                                        <dx:BootstrapGridViewToolbarItem Command="Custom" Name="PreviewQuotes" CssClass="btn-lg btn-outline-info" Text="Preview" IconCssClass="fas fa-search" SettingsBootstrap-RenderOption="None">
<SettingsBootstrap RenderOption="None"></SettingsBootstrap>
                                        </dx:BootstrapGridViewToolbarItem>
                                    </Items>
                                </dx:BootstrapGridViewToolbar>
                            </Toolbars>
                        </dx:BootstrapGridView>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:BootstrapTabPage>
            <dx:BootstrapTabPage Text="News">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <asp:ObjectDataSource ID="dsNews" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.pwNewsTableAdapter" UpdateMethod="Update">
                            <DeleteParameters>
                                <asp:Parameter Name="Original_NewsID" Type="Int32" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="NewsDate" Type="DateTime" />
                                <asp:Parameter Name="NewsTitle" Type="String" />
                                <asp:Parameter Name="NewsDetail" Type="String" />
                                <asp:Parameter Name="Active" Type="Boolean" />
                                <asp:Parameter Name="ProductID" Type="Int32" />
                                <asp:Parameter Name="BrandID" Type="Int32" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="NewsDate" Type="DateTime" />
                                <asp:Parameter Name="NewsTitle" Type="String" />
                                <asp:Parameter Name="NewsDetail" Type="String" />
                                <asp:Parameter Name="Active" Type="Boolean" />
                                <asp:Parameter Name="ProductID" Type="Int32" />
                                <asp:Parameter Name="BrandID" Type="Int32" />
                                <asp:Parameter Name="Original_NewsID" Type="Int32" />
                            </UpdateParameters>
                        </asp:ObjectDataSource>
                         <dx:BootstrapGridView ID="bsgvNews" OnInitNewRow="InitNewRow_DefaultActive" runat="server" SettingsText-ConfirmDelete="Are you sure you wish to delete this quote?" SettingsBehavior-ConfirmDelete="true" Settings-GridLines="None" SettingsBootstrap-Striped="true" AutoGenerateColumns="False" DataSourceID="dsNews" KeyFieldName="NewsID" OnToolbarItemClick="GridViewCustomToolbar_ToolbarItemClick">
                            <SettingsBootstrap Striped="True"></SettingsBootstrap>
                            <SettingsCommandButton>
                                <NewButton ButtonType="Button" CssClass="btn btn-primary" IconCssClass="fas fa-plus" RenderMode="Button" />
                                <UpdateButton ButtonType="Button" CssClass="btn btn-primary float-right" IconCssClass="fas fa-check" RenderMode="Button" Text="Submit" />
                                <CancelButton ButtonType="Button" CssClass="btn btn-outline-secondary float-left" IconCssClass="fas fa-close" RenderMode="Button" />
                                <EditButton ButtonType="Button" CssClass="btn btn-outline-secondary" IconCssClass="fas fa-pencil-alt" RenderMode="Button" Text=" " />
                                <DeleteButton ButtonType="Button" CssClass="btn btn-outline-danger" IconCssClass="fas fa-trash" RenderMode="Button" Text=" " />
                            </SettingsCommandButton>
                            <Settings GridLines="None"></Settings>

                            <SettingsBehavior ConfirmDelete="True"></SettingsBehavior>

                            <SettingsEditing Mode="PopupEditForm">
                            </SettingsEditing>
                            <SettingsPopup EditForm-Width="70%">
                                <EditForm AllowResize="True" Modal="True">
                                </EditForm>
                            </SettingsPopup>

                            <SettingsText ConfirmDelete="Are you sure you wish to delete this quote?"></SettingsText>

                            <SettingsDataSecurity AllowDelete="True" AllowEdit="True" AllowInsert="True" />
                            <SettingsSearchPanel Visible="True" />
                            <Columns>
                                <dx:BootstrapGridViewCommandColumn Caption=" " Name="Edit" ShowEditButton="True" VisibleIndex="0">
                                </dx:BootstrapGridViewCommandColumn>
                                <dx:BootstrapGridViewDateColumn FieldName="NewsDate"  SettingsEditForm-ColumnSpan="12" Caption="Date" VisibleIndex="1">
<SettingsEditForm ColumnSpan="12"></SettingsEditForm>
                                </dx:BootstrapGridViewDateColumn>
                                <dx:BootstrapGridViewTextColumn FieldName="NewsTitle"  SettingsEditForm-ColumnSpan="12" Caption="Title" VisibleIndex="2">
<SettingsEditForm ColumnSpan="12"></SettingsEditForm>
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewCheckColumn FieldName="Active"  SettingsEditForm-ColumnSpan="12" VisibleIndex="6">
<SettingsEditForm ColumnSpan="12"></SettingsEditForm>
                                </dx:BootstrapGridViewCheckColumn>
                                <dx:BootstrapGridViewComboBoxColumn Caption="Associated Product" SettingsEditForm-ColumnSpan="12" Visible="false" SettingsEditForm-Visible="True" FieldName="ProductID" VisibleIndex="4">
                                    <PropertiesComboBox AllowNull="True" DataSourceID="dsProducts" TextField="ProductName" ValueField="ProductID">
                                    </PropertiesComboBox>

                                    <SettingsEditForm Visible="True"></SettingsEditForm>
                                </dx:BootstrapGridViewComboBoxColumn>
                                <dx:BootstrapGridViewComboBoxColumn Caption="Associated Brand" SettingsEditForm-ColumnSpan="12" Visible="false" SettingsEditForm-Visible="True" FieldName="BrandID" VisibleIndex="5">
                                    <PropertiesComboBox AllowNull="True" DataSourceID="dsBrands" TextField="BrandName" ValueField="BrandID">
                                    </PropertiesComboBox>

                                    <SettingsEditForm ColumnSpan="12" Visible="True"></SettingsEditForm>
                                </dx:BootstrapGridViewComboBoxColumn>
                                <dx:BootstrapGridViewMemoColumn  SettingsEditForm-ColumnSpan="12" FieldName="NewsDetail" VisibleIndex="3">
<SettingsEditForm ColumnSpan="12"></SettingsEditForm>
                                    <DataItemTemplate>
                                                    <asp:Literal EnableViewState="false" ID="litContentText" Text='<%# Eval("NewsDetail") %>' runat="server"></asp:Literal>
                                                   
                                                </DataItemTemplate>
                                    <EditItemTemplate>
                                                    <dx:ASPxHtmlEditor ID="htmlContentText" Html='<%# Bind("NewsDetail") %>'  runat="server" Width="100%" Height="250px" ToolbarMode="Menu" SettingsHtmlEditing-AllowedDocumentType="HTML5" SettingsHtmlEditing-PasteMode="PlainText" SettingsHtmlEditing-AllowObjectAndEmbedElements="True" SettingsHtmlEditing-AllowHTML5MediaElements="True">
                                                        <Toolbars>
                                <dx:HtmlEditorToolbar Name="StandardToolbar2">
                                    <Items>
                                        <dx:ToolbarBoldButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarBoldButton>
                                        <dx:ToolbarItalicButton AdaptivePriority="1">
                                        </dx:ToolbarItalicButton>
                                        <dx:ToolbarUnderlineButton AdaptivePriority="1">
                                        </dx:ToolbarUnderlineButton>
                                        <dx:ToolbarStrikethroughButton AdaptivePriority="1">
                                        </dx:ToolbarStrikethroughButton>
                                        <dx:ToolbarJustifyLeftButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarJustifyLeftButton>
                                        <dx:ToolbarJustifyCenterButton AdaptivePriority="1">
                                        </dx:ToolbarJustifyCenterButton>
                                        <dx:ToolbarJustifyRightButton AdaptivePriority="1">
                                        </dx:ToolbarJustifyRightButton>
                                    </Items>
                                </dx:HtmlEditorToolbar>
                                <dx:HtmlEditorToolbar Name="StandardToolbar1">
                                    <Items>
                                        <dx:ToolbarCutButton AdaptivePriority="2">
                                        </dx:ToolbarCutButton>
                                        <dx:ToolbarCopyButton AdaptivePriority="2">
                                        </dx:ToolbarCopyButton>
                                        <dx:ToolbarPasteButton AdaptivePriority="2">
                                        </dx:ToolbarPasteButton>
                                        <dx:ToolbarUndoButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarUndoButton>
                                        <dx:ToolbarRedoButton AdaptivePriority="1">
                                        </dx:ToolbarRedoButton>
                                        <dx:ToolbarRemoveFormatButton AdaptivePriority="2" BeginGroup="True">
                                        </dx:ToolbarRemoveFormatButton>
                                        <dx:ToolbarSuperscriptButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarSuperscriptButton>
                                        <dx:ToolbarSubscriptButton AdaptivePriority="1">
                                        </dx:ToolbarSubscriptButton>
                                        <dx:ToolbarInsertOrderedListButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarInsertOrderedListButton>
                                        <dx:ToolbarInsertUnorderedListButton AdaptivePriority="1">
                                        </dx:ToolbarInsertUnorderedListButton>
                                        <dx:ToolbarIndentButton AdaptivePriority="2" BeginGroup="True">
                                        </dx:ToolbarIndentButton>
                                        <dx:ToolbarOutdentButton AdaptivePriority="2">
                                        </dx:ToolbarOutdentButton>
                                        <dx:ToolbarInsertLinkDialogButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarInsertLinkDialogButton>
                                        <dx:ToolbarUnlinkButton AdaptivePriority="1">
                                        </dx:ToolbarUnlinkButton>
                                        <dx:ToolbarTableOperationsDropDownButton AdaptivePriority="2" BeginGroup="True">
                                            <Items>
                                                <dx:ToolbarInsertTableDialogButton BeginGroup="True" Text="Insert Table..." ToolTip="Insert Table...">
                                                </dx:ToolbarInsertTableDialogButton>
                                                <dx:ToolbarTablePropertiesDialogButton BeginGroup="True">
                                                </dx:ToolbarTablePropertiesDialogButton>
                                                <dx:ToolbarTableRowPropertiesDialogButton>
                                                </dx:ToolbarTableRowPropertiesDialogButton>
                                                <dx:ToolbarTableColumnPropertiesDialogButton>
                                                </dx:ToolbarTableColumnPropertiesDialogButton>
                                                <dx:ToolbarTableCellPropertiesDialogButton>
                                                </dx:ToolbarTableCellPropertiesDialogButton>
                                                <dx:ToolbarInsertTableRowAboveButton BeginGroup="True">
                                                </dx:ToolbarInsertTableRowAboveButton>
                                                <dx:ToolbarInsertTableRowBelowButton>
                                                </dx:ToolbarInsertTableRowBelowButton>
                                                <dx:ToolbarInsertTableColumnToLeftButton>
                                                </dx:ToolbarInsertTableColumnToLeftButton>
                                                <dx:ToolbarInsertTableColumnToRightButton>
                                                </dx:ToolbarInsertTableColumnToRightButton>
                                                <dx:ToolbarSplitTableCellHorizontallyButton BeginGroup="True">
                                                </dx:ToolbarSplitTableCellHorizontallyButton>
                                                <dx:ToolbarSplitTableCellVerticallyButton>
                                                </dx:ToolbarSplitTableCellVerticallyButton>
                                                <dx:ToolbarMergeTableCellRightButton>
                                                </dx:ToolbarMergeTableCellRightButton>
                                                <dx:ToolbarMergeTableCellDownButton>
                                                </dx:ToolbarMergeTableCellDownButton>
                                                <dx:ToolbarDeleteTableButton BeginGroup="True">
                                                </dx:ToolbarDeleteTableButton>
                                                <dx:ToolbarDeleteTableRowButton>
                                                </dx:ToolbarDeleteTableRowButton>
                                                <dx:ToolbarDeleteTableColumnButton>
                                                </dx:ToolbarDeleteTableColumnButton>
                                            </Items>
                                        </dx:ToolbarTableOperationsDropDownButton>
                                        <dx:ToolbarFindAndReplaceDialogButton AdaptivePriority="2" BeginGroup="True">
                                        </dx:ToolbarFindAndReplaceDialogButton>
                                        <dx:ToolbarFullscreenButton AdaptivePriority="1" BeginGroup="True">
                                        </dx:ToolbarFullscreenButton>
                                    </Items>
                                </dx:HtmlEditorToolbar>
                            </Toolbars>
                            <CssFiles>
                                <dx:HtmlEditorCssFile FilePath="~/Content/landing.css" />
                            </CssFiles>
                            <SettingsHtmlEditing PasteMode="PlainText">
                            </SettingsHtmlEditing>
                            <SettingsSpellChecker Culture="en-GB">
                            </SettingsSpellChecker>
                                                    </dx:ASPxHtmlEditor>
                                                </EditItemTemplate>
                                </dx:BootstrapGridViewMemoColumn>
                             <dx:BootstrapGridViewCommandColumn Caption=" " Name="Delete" ShowDeleteButton="True" VisibleIndex="8"></dx:BootstrapGridViewCommandColumn>
                            </Columns>
                            <ClientSideEvents ToolbarItemClick="onToolbarItemClick" />
                            <Toolbars>
                                <dx:BootstrapGridViewToolbar Position="Bottom">
                                    <Items>
                                        <dx:BootstrapGridViewToolbarItem Command="New" CssClass="btn-lg" Text="Add News" IconCssClass="fas fa-plus" SettingsBootstrap-RenderOption="Primary" >
<SettingsBootstrap RenderOption="Primary"></SettingsBootstrap>
                                        </dx:BootstrapGridViewToolbarItem>
                                        <dx:BootstrapGridViewToolbarItem Command="Custom" Name="PreviewNews" CssClass="btn-lg btn-outline-info" Text="Preview" IconCssClass="fas fa-search" SettingsBootstrap-RenderOption="None">
<SettingsBootstrap RenderOption="None"></SettingsBootstrap>
                                        </dx:BootstrapGridViewToolbarItem>
                                    </Items>
                                </dx:BootstrapGridViewToolbar>
                            </Toolbars>
                        </dx:BootstrapGridView>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:BootstrapTabPage>
            
        </TabPages>
    </dx:BootstrapPageControl>
    <dx:BootstrapPopupControl ID="bsppPreview" HeaderText=" " runat="server" PopupHorizontalAlign="Center" PopupVerticalAlign="Middle" ShowCloseButton="true" CloseAction="CloseButton" Modal="True" ShowOnPageLoad="false" EncodeHtml="false" Width="95%">
        <SettingsAdaptivity Mode="Always" MaxWidth="1200" MinWidth="95%" SwitchAtWindowInnerWidth="1024" VerticalAlign="WindowCenter"
            FixedHeader="true" FixedFooter="true" />
        <ContentCollection>
            <dx:ContentControl>
                <iframe runat="server" id="frmPreview" allowtransparency="true" scrolling="auto" align="middle"
                    frameborder="0" marginheight="0" marginwidth="0"></iframe>
            </dx:ContentControl>
        </ContentCollection>
    </dx:BootstrapPopupControl>
</asp:Content>
