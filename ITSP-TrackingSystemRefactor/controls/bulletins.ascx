<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="bulletins.ascx.vb" Inherits="ITSP_TrackingSystemRefactor.bulletinscontrol" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
    <asp:ObjectDataSource ID="dsBulletins" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.pwBulletinsTableAdapter"></asp:ObjectDataSource>
    
     <div class="wrap ms-hero-img-news ms-hero-bg-info ms-bg-fixed">
            <div class="container">
          
               <h2 class="text-center color-white mb-4">Bulletins</h2>
        <div class="row masonry-container">
<asp:Repeater ID="rptBulletins" runat="server" DataSourceID="dsBulletins">
        <ItemTemplate>
<div class="col-lg-4 col-md-6 masonry-item wow fadeInUp animation-delay-2">
            <article class="card card-info mb-4 wow materialUp animation-delay-5">
                
                             
              <asp:Panel ID="pnlContentImage" Visible='<%# Eval("BulletinImage").ToString.Length > 10 %>' runat="server">
                  <figure class="ms-thumbnail ms-thumbnail-left">
                      <dx:ASPxBinaryImage ID="imgbBulletin" Value='<%# Eval("BulletinImage") %>' CssClass="img-fluid " runat="server"></dx:ASPxBinaryImage>
                <figcaption class="ms-thumbnail-caption text-center">
                  <div class="ms-thumbnail-caption-content">
<a title="open bulletin" target="_blank" href='<%# Eval("BulletinFileName", "bulletins/{0}") %>'>
                    <h3 class="ms-thumbnail-caption-title"><%#Eval("BulletinName") %></h3>
                    </a>
                   
                  </div>
                </figcaption>
              </figure>
                  </asp:Panel>
              <div class="card-body">
                <h4><a title="open bulletin" target="_blank" href='<%# Eval("BulletinFileName", "bulletins/{0}") %>'><%#Eval("BulletinName") %></a></h4>
                <p><%# Eval("BulletinDescription") %></p>
                <div class="row">
                  <div class="col-lg-12 col-md-12">

                    <a  title="open bulletin" target="_blank" href='<%# Eval("BulletinFileName", "bulletins/{0}") %>' class="btn btn-primary btn-sm btn-block animate-icon">Read more <i class="ml-1 no-mr fas fa-arrow-right"></i></a>
                  </div>
                </div>
              </div>
            </article>
          </div>
        </ItemTemplate>
    </asp:Repeater>
          
          
        </div>
      </div> <!-- container -->
         </div>
