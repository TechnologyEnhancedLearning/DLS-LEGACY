<%@ Page Title="Admin - Resources" Language="vb" AutoEventWireup="false" MasterPageFile="~/tracking/Site.Master" CodeBehind="admin-resources.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.admin_resources" %>

<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="breadtray" runat="server">
    <link href="../Content/themes/base/jquery-ui.min.css" rel="stylesheet" />
    <link href="../Content/fileup.css" rel="stylesheet" />
    <script src="../Scripts/jquery-ui-1.12.1.min.js"></script>
   <h1>Resources</h1>
    <script>
       function BindEvents() {

           $(document).on('change', '.btn-file :file', function () {
               var input = $(this),
                   numFiles = input.get(0).files ? input.get(0).files.length : 1,
                   label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
               input.trigger('fileselect', [numFiles, label]);
           });
           $(document).ready(function () {
               //$('.bs-pagination td table').each(function (index, obj) {
               //    convertToPagination(obj)
               //});
               //$('input, textarea').placeholder({ customClass: 'my-placeholder' });
               $('.btn-file :file').on('fileselect', function (event, numFiles, label) {

                   var input = $(this).parents('.input-group').find(':text'),
                       log = numFiles > 1 ? numFiles + ' files selected' : label;

                   if (input.length) {
                       input.val(log);
                   } else {
                       if (log) alert(log);
                   }

               });
           });
       };
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   
        
        <!-- /.col-lg-12 -->
    <!-- /.row -->
    <asp:MultiView ID="mvResources" ActiveViewIndex="0" runat="server">
        <asp:View ID="vResourcesList" runat="server">
            <div class="float-right">
            <asp:LinkButton ID="lbtAddNewResource" CssClass="btn btn-primary float-right" ToolTip="Add new resource" runat="server"><i aria-hidden="true" class="fas fa-plus"></i> Add Resource</asp:LinkButton>
        </div>
            <asp:ObjectDataSource ID="dsResources" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActive" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.DownloadsTableAdapter">

            </asp:ObjectDataSource>
            <%--<div class="card card-default">
                 <div class="card-header clearfix">
                    <div class="btn-group  float-right">
                        <asp:LinkButton ID="lbtClearFilters" runat="server" CssClass="btn btn-outline-secondary btn-sm"><i aria-hidden="true" class="fas fa-times"></i> Clear filters</asp:LinkButton>
                             <asp:LinkButton ID="lbtDownloadResources" CssClass="btn btn-outline-secondary btn-sm" runat="server"><i aria-hidden="true" class="fas fa-file-export"></i> Download to Excel</asp:LinkButton>  
                    </div>
                </div>--%>

                <div class="table-responsive">
                    <dx:ASPxGridViewExporter FileName="ITSP Downloads Export" ID="DownloadsGridViewExporter" runat="server"></dx:ASPxGridViewExporter>
                    <dx:BootstrapGridView ID="bsgvDownloads" runat="server" AutoGenerateColumns="False" DataSourceID="dsResources" KeyFieldName="DownloadID" SettingsCustomizationDialog-Enabled="True" OnToolbarItemClick="GridViewCustomToolbar_ToolbarItemClick">
                        <CssClasses Table="table table-striped small" />
                        <Settings ShowHeaderFilterButton="True" />
                        <SettingsCookies Enabled="True" Version="0.121" />
                        <SettingsPager PageSize="7">
                        </SettingsPager>
                        <Columns>
                            <dx:BootstrapGridViewTextColumn Name="Edit" ShowInCustomizationDialog="false" ReadOnly="True" VisibleIndex="0">
                                <SettingsEditForm Visible="False" />
                                <DataItemTemplate>
                                     <asp:LinkButton ID="lbtEditResource" EnableViewState="false" CommandArgument='<%# Eval("DownloadID")%>' CssClass="btn btn-outline-secondary btn-sm" OnCommand="EditResource_Click" runat="server"><i aria-hidden="true" class="fas fa-pencil-alt"></i></asp:LinkButton>
                                </DataItemTemplate>
                                <Settings AllowHeaderFilter="False" />
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Filename" VisibleIndex="1">
                                <DataItemTemplate>
                                      <asp:LinkButton EnableViewState="false" ToolTip="Test download" CommandName="Download" ID="lbtDownload" PostBackUrl='<%# "~/tracking/download?content=" & Eval("Tag") %>' runat="server"><i aria-hidden="true" class="fas fa-file-export"></i>&nbsp;<asp:Label ID="Label1" runat="server" Text='<%# Bind("Filename") %>'></asp:Label></asp:LinkButton>
                                </DataItemTemplate>
                                <Settings AllowHeaderFilter="False" />
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Description" VisibleIndex="2">
                                <Settings AllowHeaderFilter="False" />
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Category" VisibleIndex="3">
                                <SettingsHeaderFilter Mode="CheckedList">
                                </SettingsHeaderFilter>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewDateColumn Caption="Added" FieldName="UploadDTT" Name="Added" VisibleIndex="4">
                            </dx:BootstrapGridViewDateColumn>
                            <dx:BootstrapGridViewTextColumn Caption="Downloads" FieldName="DLCount" Name="Downloads" VisibleIndex="5">
                                <Settings AllowHeaderFilter="False" />
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewCheckColumn FieldName="Active" VisibleIndex="6">
                            </dx:BootstrapGridViewCheckColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Tag" Visible="False" VisibleIndex="7">
                                <Settings AllowHeaderFilter="False" />
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewCheckColumn Caption="Ctre Mgr Only" FieldName="CentreManagers" Name="Ctre Mgr Only" Visible="False" VisibleIndex="8">
                            </dx:BootstrapGridViewCheckColumn>
                            <dx:BootstrapGridViewTextColumn Caption="Type" FieldName="ContentType" Name="Type" Visible="False" VisibleIndex="9">
                                <SettingsHeaderFilter Mode="CheckedList">
                                </SettingsHeaderFilter>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="FileSize" Visible="False" VisibleIndex="10">
                                <Settings AllowHeaderFilter="False" />
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn Name="Delete" ShowInCustomizationDialog="false" VisibleIndex="11">
                                <SettingsEditForm Visible="False" />
                                <DataItemTemplate>
                                       <asp:LinkButton ID="lbtRemoveResource" EnableViewState="false" CssClass="btn btn-danger btn-xs" CommandArgument='<%# Eval("DownloadID")%>' OnClientClick="return confirm('Are you sure you wish to completely remove this resource, including deleting the file from the server?');" OnCommand="RemoveResource_Click" runat="server"><i aria-hidden="true" class="fas fa-minus"></i></asp:LinkButton>
                                </DataItemTemplate>
                            </dx:BootstrapGridViewTextColumn>
                        </Columns>         
                        <ClientSideEvents ToolbarItemClick="onToolbarItemClick" />
                        <Toolbars>
        <dx:BootstrapGridViewToolbar Position="Top">
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
           <%-- </div>--%>
        </asp:View>
        <asp:View ID="vAddEditResource" runat="server">
            <asp:ObjectDataSource ID="dsAddEditResource" runat="server" InsertMethod="InsertWithDefaultDate" OldValuesParameterFormatString="original_{0}" SelectMethod="GetByID" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.DownloadsTableAdapter" UpdateMethod="Update">
                <InsertParameters>
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Filename" Type="String" />
                    <asp:Parameter Name="Tag" Type="String" />
                    <asp:Parameter Name="CentreManagers" Type="Boolean" />
                    <asp:Parameter Name="Description" Type="String" />
                    <asp:Parameter Name="FileSize" Type="Int32" />
                    <asp:Parameter Name="Category" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="0" Name="DownloadID" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="UploadDTT" Type="DateTime" />
                    <asp:Parameter Name="Filename" Type="String" />
                    <asp:Parameter Name="Tag" Type="String" />
                    <asp:Parameter Name="CentreManagers" Type="Boolean" />
                    <asp:Parameter Name="Description" Type="String" />
                    <asp:Parameter Name="ContentType" Type="String" />
                    <asp:Parameter Name="FileSize" Type="Int32" />
                    <asp:Parameter Name="DLCount" Type="Int32" />
                    <asp:Parameter Name="Category" Type="String" />
                    <asp:Parameter Name="Original_DownloadID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <div class="card card-primary">
                <asp:FormView ID="fvResource" RenderOuterTable="False" runat="server" DataKeyNames="DownloadID"  DefaultMode="Edit" DataSourceID="dsAddEditResource">
                    <EditItemTemplate>
                        <div class="card-header">
                            Edit Resource
                        </div>
                        <div class="card-body">
                            <div class="m-3">
                                <asp:HiddenField ID="HiddenField2" Value='<%# Eval("DownloadID")%>' runat="server" />
                                <asp:HiddenField ID="hfContentType" Value='<%# Bind("ContentType")%>' runat="server" />
                                <asp:HiddenField ID="HiddenField1" Value='<%# Bind("DLCount")%>' runat="server" />
                                <div class="form-group row">
                                    <asp:Label ID="Label2" CssClass="col col-sm-5 col-md-4 col-lg-3 control-label" runat="server" AssociatedControlID="ResourceTextBox">Resource File:</asp:Label>
                                    <div class="col col-sm-7 col-md-8 col-lg-9">

                                        <asp:TextBox ID="ResourceTextBox" runat="server" Text='<%# Bind("Filename")%>' CssClass="form-control" />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="vgEditResource" ControlToValidate="ResourceTextBox" Display="Dynamic" runat="server" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                        <div class="input-group">
                                        <span class="input-group-prepend">
                                            <span class="btn btn-outline-secondary btn-file">Browse&hellip;
                                                <asp:FileUpload AllowMultiple="false" ID="fupResource" runat="server" />

                                            </span>
                                        </span>
                                        <input type="text" class="form-control" readonly="readonly">
                                        <span class="input-group-append">
                                            <asp:LinkButton ID="lbtUploadResource" CausesValidation="false" CommandName="UploadResource" CssClass="btn btn-outline-secondary" ToolTip="Upload Resource" runat="server"><i aria-hidden="true" class="fas fa-file-upload"></i> Upload</asp:LinkButton>
                                        </span>
                                            </div>
                                    </div>
                                </div>
                                 <div class="form-group row mt-1">
                                    <asp:Label ID="Label8" CssClass="col col-sm-5 col-md-4 col-lg-3 control-label" runat="server" AssociatedControlID="tbResDescription">Description:</asp:Label>
                                    <div class="col col-sm-7 col-md-8 col-lg-9">
                                        <asp:TextBox ID="tbResDescription" TextMode="MultiLine" CssClass="form-control" runat="server" Text='<%# Bind("Description") %>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label9" CssClass="col col-sm-5 col-md-4 col-lg-3 control-label" runat="server" AssociatedControlID="tbCategory">Category:</asp:Label>
                                    <div class="col col-sm-7 col-md-8 col-lg-9">
                                        <asp:TextBox ID="tbCategory" CssClass="form-control auto-category" runat="server" Text='<%# Bind("Category") %>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label6" CssClass="col col-sm-5 col-md-4 col-lg-3 control-label" runat="server" AssociatedControlID="tbTag">Tag:</asp:Label>
                                    <div class="col col-sm-7 col-md-8 col-lg-9">
                                        <asp:TextBox ID="tbTag" CssClass="form-control" runat="server" Text='<%# Bind("Tag") %>' />
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <asp:Label ID="Label4" AssociatedControlID="tbFileSize" runat="server" CssClass="col col-sm-5 col-md-4 col-lg-3 control-label">File size:</asp:Label>
                                    <div class="col col-sm-7 col-md-8 col-lg-9">
                                        <div class="input-group">
                                            <asp:TextBox ID="tbFileSize" Enabled="false" CssClass="form-control" runat="server" Text='<%# Bind("FileSize") %>' /><span class="input-group-append" id="basic-addon2"><span class="input-group-text">bytes</span></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label3" CssClass="col col-sm-5 col-md-4 col-lg-3 control-label" runat="server" AssociatedControlID="cbActive">Active?</asp:Label>
                                    <div class="col col-sm-7 col-md-8 col-lg-9">
                                        <asp:CheckBox ID="cbActive" Checked='<%# Bind("Active")%>' runat="server" />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label7" CssClass="col col-sm-5 col-md-4 col-lg-3 control-label" runat="server" AssociatedControlID="cbMgrOnly">Centre Managers Only?</asp:Label>
                                    <div class="col col-sm-7 col-md-8 col-lg-9">
                                        <asp:CheckBox ID="cbMgrOnly" Checked='<%# Bind("CentreManagers")%>' runat="server" />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label5" AssociatedControlID="tbAddedDate" runat="server" CssClass="col col-sm-5 col-md-4 col-lg-3 control-label">Upload date:</asp:Label>
                                    <div class="col col-sm-7 col-md-8 col-lg-9">
                                        <asp:TextBox ID="tbAddedDate" CssClass="form-control" Enabled="false" runat="server" Text='<%# Bind("UploadDTT") %>' />
                                    </div>
                                </div>
                            </div>
                            </div>
                        <div class="card-footer clearfix">
                            <asp:LinkButton ID="UpdateCancelButton" CssClass="btn btn-outline-secondary mr-auto" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                            <asp:LinkButton ID="UpdateButton" ValidationGroup="vgEditResource" runat="server" CssClass="btn btn-primary float-right" CausesValidation="True" CommandName="Update" Text="Update" />
                            
                        </div>

                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <div class="card-header">
                            Add Resource
                        </div>
                        <div class="card-body">
                            <div class="m-3">
                                <div class="form-group row">
                                    <asp:Label ID="Label2" CssClass="col col-sm-5 col-md-4 col-lg-3 control-label" runat="server" AssociatedControlID="ResourceTextBox">Resource File:</asp:Label>
                                    <div class="col col-sm-7 col-md-8 col-lg-9">

                                        <asp:TextBox ID="ResourceTextBox" runat="server" Text='<%# Bind("Filename")%>' CssClass="form-control" />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="ResourceTextBox" Display="Dynamic" ValidationGroup="vgAddResource" runat="server" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                        <div class="input-group">
                                        <span class="input-group-prepend">
                                            <span class="btn btn-outline-secondary btn-file">Browse&hellip;
                                                <asp:FileUpload AllowMultiple="false" ID="fupResource" runat="server" />

                                            </span>
                                        </span>
                                           
                                        <input type="text" class="form-control" readonly="readonly">
                                        <span class="input-group-append">
                                            <asp:LinkButton ID="lbtUploadResource" CausesValidation="false" CommandName="UploadResource" CssClass="btn btn-outline-secondary" ToolTip="Upload Resource" runat="server"><i aria-hidden="true" class="fas fa-file-upload"></i> Upload</asp:LinkButton>
                                        </span>
                                            </div>
                                    </div>
                                </div>
                                <div class="form-group row mt-1">
                                    <asp:Label ID="Label8" CssClass="col col-sm-5 col-md-4 col-lg-3 control-label" runat="server" AssociatedControlID="tbResDescription">Description:</asp:Label>
                                    <div class="col col-sm-7 col-md-8 col-lg-9">
                                        <asp:TextBox ID="tbResDescription" TextMode="MultiLine" CssClass="form-control" runat="server" Text='<%# Bind("Description") %>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label9" CssClass="col col-sm-5 col-md-4 col-lg-3 control-label" runat="server" AssociatedControlID="tbCategory">Category:</asp:Label>
                                    <div class="col col-sm-7 col-md-8 col-lg-9">
                                        <asp:TextBox ID="tbCategory" CssClass="form-control auto-category" runat="server" Text='<%# Bind("Category") %>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label6" CssClass="col col-sm-5 col-md-4 col-lg-3 control-label" runat="server" AssociatedControlID="tbTag">Tag:</asp:Label>
                                    <div class="col col-sm-7 col-md-8 col-lg-9">
                                        <asp:TextBox ID="tbTag" CssClass="form-control" runat="server" Text='<%# Bind("Tag") %>' />
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <asp:Label ID="Label4" AssociatedControlID="tbFileSize" runat="server" CssClass="col col-sm-5 col-md-4 col-lg-3 control-label">File size:</asp:Label>
                                    <div class="col col-sm-7 col-md-8 col-lg-9">
                                        <div class="input-group">
                                            <asp:TextBox ID="tbFileSize" Enabled="false" CssClass="form-control" runat="server" Text='<%# Bind("FileSize") %>' /><span class="input-group-append" id="basic-addon2"><span class="input-group-text">bytes</span></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label3" CssClass="col col-sm-5 col-md-4 col-lg-3 control-label" runat="server" AssociatedControlID="cbActive">Active?</asp:Label>
                                    <div class="col col-sm-7 col-md-8 col-lg-9">
                                        <asp:CheckBox ID="cbActive" Checked='<%# Bind("Active")%>' runat="server" />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label7" CssClass="col col-sm-5 col-md-4 col-lg-3 control-label" runat="server" AssociatedControlID="cbMgrOnly">Centre Managers Only?</asp:Label>
                                    <div class="col col-sm-7 col-md-8 col-lg-9">
                                        <asp:CheckBox ID="cbMgrOnly" Checked='<%# Bind("CentreManagers")%>' runat="server" />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label5" AssociatedControlID="tbAddedDate" runat="server" CssClass="col col-sm-5 col-md-4 col-lg-3 control-label">Upload date:</asp:Label>
                                    <div class="col col-sm-7 col-md-8 col-lg-9">
                                        <asp:TextBox ID="tbAddedDate" CssClass="form-control" Enabled="false" runat="server" Text=""/>
                                    </div>
                                </div>
                        </div>
                            </div>
                        <div class="card-footer clearfix">
                            <asp:LinkButton ID="InsertCancelButton" CssClass="btn btn-outline-secondary mr-auto" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                            <asp:LinkButton ID="InsertButton" ValidationGroup="vgAddResource" runat="server" CssClass="btn btn-primary float-right" CausesValidation="True" CommandName="Insert" Text="Insert" />
                            
                        </div>
                    </InsertItemTemplate>
                </asp:FormView>
            </div>
        </asp:View>
    </asp:MultiView>
    
    <script>
         Sys.Application.add_load(BindEvents);
     </script> 
</asp:Content>
