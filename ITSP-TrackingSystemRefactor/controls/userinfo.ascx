<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="userinfo.ascx.vb" Inherits="ITSP_TrackingSystemRefactor.userinfo" %>
<asp:Panel ID="pnlUser" Visible="false" runat="server">
                    <div class="small mb-1">
                        <asp:Label ID="lblUser" runat="server" Text=""></asp:Label>&nbsp;&nbsp;                       
           <asp:LinkButton ID="lbtLogout" runat="server"><i class="fas fa-sign-out-alt" aria-hidden="true"></i> Log out</asp:LinkButton>
                    </div>
                </asp:Panel>