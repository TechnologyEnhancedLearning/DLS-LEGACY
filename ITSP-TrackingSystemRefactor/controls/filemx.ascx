<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="filemx.ascx.vb" Inherits="ITSP_TrackingSystemRefactor.filemx" %>
<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<link href="../Content/resources.css" rel="stylesheet" />
<style>

</style>
<script>
			function onFileUploadComplete(s, e) {
					setTimeout(function () { WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions('btnDone', '', true, '', '', false, true)); }, 1);
			}
		</script>


     <div class="card card-itsp-green mb-1">
        <div class="card-header"><div class="row">
            <div class="col col-sm6">
Evidence Files
            </div>
            <div class="col col-sm3">
                
                    <div class="float-right">
                        Storage used:  <asp:Label ID="lblUsed" runat="server" Text="Used"></asp:Label>
                        <asp:HiddenField ID="hfExceeded" EnableViewState="true" Value="False"  runat="server" />
                    /
                    <asp:Label ID="lblAvailable" runat="server" Text="Available"></asp:Label></div>
                </div>
            <div class="col col-sm3">
                       <div class="progress">
                    <div class="progress-bar progress-bar-info" runat="server" id="progbar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
                        <asp:Label ID="lblPercent" runat="server" Text="60%"></asp:Label>
                    </div>
                </div>



            </div>
                                 </div></div>
         <asp:ObjectDataSource ID="dsFiles" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.FilesDataTableAdapters.FilesTableAdapter">
             <SelectParameters>
                 <asp:Parameter Name="LearningLogItemID" DefaultValue="0" Type="Int32" />
             </SelectParameters>
         </asp:ObjectDataSource>
        <%-- <asp:UpdatePanel ID="UpdatePanel1" ChildrenAsTriggers="true" UpdateMode="Conditional" runat="server">
             <ContentTemplate>--%>
         <table class="table table-striped">
                                            <asp:Repeater ID="rptFiles" OnItemCommand="rptFiles_ItemCommand" runat="server" DataSourceID="dsFiles">
                                                <HeaderTemplate>
                                                    <div class="table-responsive">
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td>
                                                            <asp:HyperLink ID="hlFile" runat="server"
                                                                NavigateUrl='<%# Eval("FileID", "../GetFile.aspx?FileID={0}&src=learn")%>'>
                                                                <i id="I1" aria-hidden="true" class='<%# GetIconClass(Eval("FileName"))%>' runat="server"></i>
                                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("FileName")%>'></asp:Label>
                                                            </asp:HyperLink>
                                                        </td>
                                                        <td><asp:Label ID="lblSize" runat="server" Text='<%# NiceBytes(Eval("FileSize"))%>'></asp:Label></td>
                                                        <td style="width: 20px">
                                                            <asp:LinkButton ID="lbtDelete" OnClientClick="return confirm('Are you sure you want delete this file?');" runat="server" CommandName="Delete" CommandArgument='<%# Eval("FileID")%>' CssClass="btn btn-danger btn-xs btn-delete-file" ToolTip="Delete File" CausesValidation="false"><i aria-hidden="true" class="fas fa-trash"></i><!--[if lt IE 8]>Delete<![endif]--></asp:LinkButton></td>
                                                    </tr>
                                                </ItemTemplate>
                                                <FooterTemplate></div></FooterTemplate>
                                            </asp:Repeater>
                                            <tr runat="server" id="trNoFilesAdd" visible="false"><td>
                                                No files have been uploaded against this item.
                                                                                              </td></tr>
                                        </table>
             <%--</ContentTemplate>
             <Triggers>
                 <asp:PostBackTrigger ControlID="lbtDone" />
             </Triggers>
         </asp:UpdatePanel>--%>
            </div>

<asp:Panel ID="pnlUpload" runat="server">
    <div class="card card-itsp-blue mb-1">
        <div class="card-header">Upload Evidence</div>
        <div class="card-body">
            <dx:BootstrapUploadControl ID="bsucEvidenceUpload" runat="server" ShowUploadButton="True"
    ShowClearFileSelectionButton="true" ShowProgressPanel="true" ShowTextBox="true"
    UploadMode="Advanced" OnFileUploadComplete="bsucEvidenceUpload_FileUploadComplete" CssClasses-UploadButton="btn btn-primary btn-block text-white float-right mt-1" CssClasses-RemoveButton="btn btn-danger text-white">
    <ValidationSettings MaxFileSize="20971520" AllowedFileExtensions=".jpg,.jpeg,.gif,.png,.doc,.docx,.pdf,.zip,.xls,.xlsx,.ppt,.pptx,.msg" />
                <AdvancedModeSettings EnableDragAndDrop="true" EnableMultiSelect="true" EnableFileList="true" />
    <ClientSideEvents FilesUploadComplete="onFileUploadComplete"  />
            </dx:BootstrapUploadControl>
 <asp:LinkButton ID="lbtDone" CssClass="d-none" runat="server">Done</asp:LinkButton>
        </div>
    </div></asp:Panel>
<!-- Modal -->
<div class="modal fade" id="noSpaceModal" tabindex="-1" role="dialog" aria-labelledby="noSpaceModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="noSpaceModalLabel">Personal Storage Limit Reached</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>You have insufficient free storage space to upload this file.</p> 
          <p>To free up space, please archive files that are no longer required or relevant.</p>
      </div>
      <div class="modal-footer">
        <button type="button" data-dismiss="modal" class="btn btn-primary float-right">OK</button>
      </div>
    </div>
  </div>
</div>
