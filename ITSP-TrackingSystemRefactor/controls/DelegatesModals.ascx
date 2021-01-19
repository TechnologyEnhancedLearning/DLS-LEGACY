<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DelegatesModals.ascx.vb" Inherits="ITSP_TrackingSystemRefactor.DelegatesModals" %>
<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<div class="modal fade" tabindex="-1" id="modalConfirmComplete" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
       
        <h5 class="modal-title">Confirm Activity Complete</h5> <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
       <div class="form-group row">
 <asp:Label ID="lblComp" AssociatedControlID="bsdeCompleted" CssClass="control-label col-sm-3" runat="server" Text="Completed: "></asp:Label>
                                                            <div class="col-sm-9 input-group">
                                                               
                                                                <dx:BootstrapDateEdit ID="bsdeCompleted" runat="server" ViewStateMode="Enabled" EnableViewState="True"></dx:BootstrapDateEdit>
                                                                
                                                                <span class="input-group-append">
                                                                    <asp:LinkButton CssClass="btn btn-success" OnCommand="lbtMarkComplete_Command" ToolTip="Mark complete" ID="lbtMarkComplete" runat="server"><i aria-hidden="true" class="fas fa-check"></i></asp:LinkButton>
                                                                </span>
                                                            </div>
                                                          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-secondary ml-auto float-right" data-dismiss="modal">Cancel</button>
         
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div class="modal fade" tabindex="-1" id="modalSetTBC" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
       
        <h5 class="modal-title">Set Complete By Date</h5> <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
          <div class="form-group row">

                                                            <asp:Label ID="Label21" AssociatedControlID="bsdeCompleteBy" CssClass="control-label col-sm-3" runat="server" Text="Complete by: "></asp:Label>
                                                            <div class="input-group  col-sm-9">
                                                                <dx:BootstrapDateEdit ID="bsdeCompleteBy" runat="server"></dx:BootstrapDateEdit>
                                                                
                                                                <span class="input-group-append">
                                                                    <asp:LinkButton CssClass="btn btn-success" CausesValidation="true" ClientIDMode="Static" CommandName="SetTBC" OnCommand="lbtSetTBC_Command" ToolTip="Set complete by date" ID="lbtSetTBC" runat="server"><i aria-hidden="true" class="fas fa-check"></i></asp:LinkButton>
                                                                </span>
                                                            </div>
                                                            </div>
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-secondary ml-auto float-right" data-dismiss="modal">Cancel</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<div class="modal fade" tabindex="-1" id="modalSetSupervisor" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
       
        <h5 class="modal-title">Set Supervisor</h5> <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
          <asp:ObjectDataSource ID="dsSupervisors" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByCentre" TypeName="ITSP_TrackingSystemRefactor.customiseTableAdapters.SupervisorsTableAdapter">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" DefaultValue="0" />
                                        </SelectParameters>
									</asp:ObjectDataSource>
          <div class="form-group row">
                                                                <asp:Label ID="Label25" AssociatedControlID="ddSupervisor" CssClass="control-label col-sm-3" runat="server" Text="Supervisor: "></asp:Label>
                                                            <div class="input-group  col-sm-9">
                                                                    
											<asp:DropDownList ID="ddSupervisor" DataSourceID="dsSupervisors" CssClass="form-control" DataTextField="Name" AppendDataBoundItems="true" DataValueField="AdminID" runat="server">
												<asp:ListItem Selected="True" Text="Choose supervisor..." Value="0"></asp:ListItem> 
											</asp:DropDownList>
												 <div class="input-group-append">
                                                     <asp:LinkButton ID="lbtSetSV" OnCommand="lbtSetSV_Command" CssClass="btn btn-success" runat="server"> Set </asp:LinkButton>
												 </div>
										</div>

                                                            </div>
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-secondary ml-auto float-right" data-dismiss="modal">Cancel</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->