<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="cstories.ascx.vb" Inherits="ITSP_TrackingSystemRefactor.cstories" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<div class="wrap ms-hero-img-csbkg ms-hero-bg-royal ms-bg-fixed">
            <div class="container">
          
               <h2 class="text-center color-white mb-4">Customer Stories</h2>
                <asp:ObjectDataSource ID="dsCStories" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.pl_CaseStudiesTableAdapter">
                
                <SelectParameters>
                    <asp:ControlParameter ControlID="hfResultCount" DefaultValue="8" Name="ResultCount" PropertyName="Value" Type="Int32" />
                </SelectParameters>
                
                </asp:ObjectDataSource>
                <asp:HiddenField ID="hfResultCount" runat="server" Value="8" />
 <div class="row masonry-container">
                <asp:Repeater ID="rptCases" runat="server" DataSourceID="dsCStories">
                    <ItemTemplate>
                        <div class="col col-md-6 masonry-item wow fadeInUp animation-delay-2">
                         <article class="card card-info mb-4 wow materialUp animation-delay-5" style="visibility: visible; animation-name: materialUp;">
                             <div style="min-height:1px;">
                             <dx:ASPxBinaryImage ID="ASPxBinaryImage1" CssClass="img-fluid"  Value='<%# Eval("CaseImage")%>' runat="server"></dx:ASPxBinaryImage>
                  </div>
                  <div class="card-body">
                    <div class="h4 strong">
                      <a href='<%# "customerstories?Story=" & Eval("CaseHeading").Replace(" ", "") %>'><asp:Label ID="Label1" runat="server" Text='<%# Eval("CaseHeading")%>' /></a>
                    </div>
                    
                    <p style="color:#757575"><asp:Label CssClass="color-normal" ID="Label4" runat="server" Text='<%# GetTruncatedString(Eval("CaseSubHeading"), 288)%>' /></p>
                      <small class="float-right">
                      <a class="btn btn-primary btn-sm" href='<%# "customerstories?Story=" & Eval("CaseHeading").Replace(" ", "") %>'>read more...</a></small>
                  </div></article>
                             </div>
                    </ItemTemplate>
                </asp:Repeater>
        </div></div></div>


