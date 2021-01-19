<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="newstimeline.ascx.vb" Inherits="ITSP_TrackingSystemRefactor.newstimeline" %>
<asp:Panel ID="pnlNews" runat="server" CssClass="wrap ms-hero-img-news ms-hero-bg-primary ms-bg-fixed">
<div class="container">
      <h3 class="text-center color-white fw-500 mb-4">
              <asp:Label ID="lblHeader" runat="server" Text="News"></asp:Label></h3>
<div class="card card-body card-body-big">
        
          <ul class="ms-timeline">
              <asp:Repeater ID="rptNews" runat="server">
                  <ItemTemplate>
<li class="ms-timeline-item wow materialUp" style="visibility: visible; animation-name: materialUp;">
                <div class="ms-timeline-date">
                  <time class="timeline-time" datetime='<%# Eval("NewsDate", "{0:yyyy}-{0:MM}-{0:dd} {0:hh}:{0:mm}")%>'><%# Eval("NewsDate", "{0:yyyy}")%>
                    <span><%# Eval("NewsDate", "{0:d MMM}")%></span>
                  </time>
                  <i class="ms-timeline-point"></i>
                </div>
                <div class="card card-info">
                  <div class="card-header">
                    <span class="card-title color-white"><%# Eval("NewsTitle")%></span>
                  </div>
                  <div class="card-body">
                      <asp:Literal ID="litDetail" Text='<%# Eval("NewsDetail")%>' runat="server"></asp:Literal></div>
                </div>
              </li>
                  </ItemTemplate>
              </asp:Repeater>
            </ul>
        </div></div></asp:Panel>