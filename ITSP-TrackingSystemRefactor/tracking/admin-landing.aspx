<%@ Page Title="Admin - Landing Content" Language="vb" AutoEventWireup="false" MasterPageFile="~/tracking/Site.Master" CodeBehind="admin-landing.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.admin_landing" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.ASPxHtmlEditor.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxHtmlEditor" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxSpellChecker.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxSpellChecker" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="breadtray" runat="server">
   <h1>Brands</h1>
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
