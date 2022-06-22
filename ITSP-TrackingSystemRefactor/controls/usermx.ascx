<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="usermx.ascx.vb" Inherits="ITSP_TrackingSystemRefactor.usermx" %>
<%--<a href="javascript:void(0)" class="btn-circle btn-circle-primary no-focus animated zoomInDown animation-delay-8" data-toggle="modal" data-target="#ms-account-modal">
                                <i class="fas fa-user"></i>
                            </a>--%>
<asp:HyperLink ID="hlAccount" aria-label="Login or Register" CssClass="no-focus animated zoomInDown animation-delay-5" runat="server"><i class="fas fa-user"></i></asp:HyperLink>
<asp:HyperLink ID="hlAppSelect" aria-label="Switch between Digital Learning Solutions applications" Visible="false" CssClass="no-focus text-primary-lp animated tada animation-delay-5" runat="server"><i class="fas fa-th-large"></i>&nbsp;<i class="fas fa-ellipsis-v"></i></asp:HyperLink>
<%--<asp:LinkButton ID="lbtAccount" aria-label="Login or Register" CssClass="no-focus animated zoomInDown animation-delay-5" runat="server"><i class="fas fa-user"></i></asp:LinkButton>
<asp:LinkButton ID="lbtAppSelect" aria-label="Switch between Digital Learning Solutions applications" Visible="false" CssClass="no-focus text-primary-lp animated tada animation-delay-5" runat="server"><i class="fas fa-th-large"></i>&nbsp;<i class="fas fa-ellipsis-v"></i></asp:LinkButton>--%>
<!-- Modal -->

          