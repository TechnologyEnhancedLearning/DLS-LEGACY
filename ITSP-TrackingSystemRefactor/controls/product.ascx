<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="product.ascx.vb" Inherits="ITSP_TrackingSystemRefactor.product" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Src="~/controls/newstimeline.ascx" TagPrefix="uc1" TagName="newstimeline" %>
<%@ Register Src="~/controls/quotes.ascx" TagPrefix="uc1" TagName="quotes" %>


<asp:ObjectDataSource ID="dsProducts" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetByProductID" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.pl_ProductsTableAdapter">

    <SelectParameters>
        <asp:SessionParameter DefaultValue="" Name="ProductID" SessionField="plProductID" Type="Int32" />
    </SelectParameters>
 
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="dsFeatures" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActive" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.pl_FeaturesTableAdapter">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="10" Name="ResultCount" Type="Int32" />
                        <asp:SessionParameter DefaultValue="" Name="ProductID" SessionField="plProductID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
<asp:Repeater ID="rptProducts" DataSourceID="dsProducts" runat="server">
                  <ItemTemplate>
          <asp:HiddenField ID="hfProductID" Value='<%# Eval("ProductID") %>' runat="server" />
                <%--Product heading etc here--%>
                      <div class="ms-hero-page ms-hero-img-coffee ms-hero-bg-dark no-pb overflow-hidden ms-bg-fixed">
        <div class="container">
          <div class="text-center color-white">
            <%--<span class="ms-logo ms-logo-whit animated bounceInDown animation-delay-5">M</span>--%>
            <h1 class="animated bounceInDown animation-delay-6"><%# Eval("ProductName") %></h1>
            <p class="lead lead-lg animated bounceInDown animation-delay-7"><%# Eval("ProductHeading") %></p>
          </div>
          <div class="img-browser-container mt-6">
              <dx:ASPxBinaryImage ID="ASPxBinaryImage1" CssClass="img-fluid img-browser animated slideInUp" Value='<%# Eval("ProductScreenshot") %>' runat="server"></dx:ASPxBinaryImage>           
        </div>
           
      </div>

                  </ItemTemplate>
              </asp:Repeater>
<div class="intro-full-next"></div>
<asp:Repeater ID="rptFeatures" DataSourceID="dsFeatures" runat="server">
    <ItemTemplate>
        <%--Features repeater here--%>
        <div class='<%# "ms-hero-bg-" & Eval("FeatureColourClass").ToString.ToLower() & " pt-2 pb-2" %>'>
        <div class="container">
          <h4 class="text-center text-light mb-6 wow fadeInDown animation-delay-2" style="visibility: visible; animation-name: fadeInDown;"><%# Eval("FeatureHeading").Replace("digital learning", "<strong>digital learning</strong>") %></h4>
          <div class="row">
            <div class="col col-lg-6 order-lg-2 mb-4  center-block">
                <asp:Panel ID="Panel1" Visible='<%# Not Eval("FeatureVideoURL").ToString() = "" %>' CssClass="embed-responsive embed-responsive-16by9 imgborder wow zoomIn animation-delay-6"  runat="server">
                <video src='<%# Eval("FeatureVideoURL") %>' runat="server" class="img-fluid imgborder center-block wow zoomIn animation-delay-6" controls="controls" ></video></asp:Panel>
                <dx:ASPxBinaryImage Width="500px" ID="ASPxBinaryImage1" Visible='<%# Not Eval("FeatureScreenshot") Is DBNull.Value %>' CssClass="img-fluid imgborder center-block wow zoomIn animation-delay-6" style="visibility: visible; animation-name: zoomIn;" Value='<%# Eval("FeatureScreenshot") %>' runat="server"></dx:ASPxBinaryImage>      
               </div>
            <div class="col col-lg-6 order-lg-1 pr-6">
                <div class="wow mb-3 text-light bounceInLeft animation-delay-4">
                <asp:Literal ID="Literal1" Text='<%# Eval("FeatureDescription") %>' runat="server"></asp:Literal></div>
              </div>
            </div>
          </div>
        </div>
      </div>


    </ItemTemplate>
    <AlternatingItemTemplate>
         <%--Features repeater here--%>
        <div class='<%# "ms-hero-bg-" & Eval("FeatureColourClass").ToString.ToLower() & " ms-hero-img-csbkg ms-bg-fixed pt-2 pb-2" %>'>
        <div class="container">
          <h4 class="text-center text-light mb-6 wow fadeInDown animation-delay-2" style="visibility: visible; animation-name: fadeInDown;"><%# Eval("FeatureHeading").Replace("digital learning", "<strong>digital learning</strong>") %></h4>
          <div class="row">
              <div class="col col-lg-6 mb-4  center-block">
                <asp:Panel ID="Panel1" Visible='<%# Not Eval("FeatureVideoURL").ToString() = "" %>'  CssClass="embed-responsive embed-responsive-16by9 imgborder wow zoomIn animation-delay-6" runat="server">
                <video src='<%# Eval("FeatureVideoURL") %>' runat="server" class="img-fluid imgborder center-block wow zoomIn animation-delay-6" controls="controls" ></video></asp:Panel>
                <dx:ASPxBinaryImage Width="500px" ID="ASPxBinaryImage1" Visible='<%# Not Eval("FeatureScreenshot") Is DBNull.Value %>' CssClass="img-fluid imgborder center-block wow zoomIn animation-delay-6" style="visibility: visible; animation-name: zoomIn;" Value='<%# Eval("FeatureScreenshot") %>' runat="server"></dx:ASPxBinaryImage>      
               </div>
              <div class="col col-lg-6 pr-6">
                    <div class="wow mb-3 text-light bounceInRight animation-delay-4">
                <asp:Literal ID="Literal1" Text='<%# Eval("FeatureDescription") %>' runat="server"></asp:Literal></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </AlternatingItemTemplate>
</asp:Repeater>
<uc1:quotes runat="server" ID="quotes" ResultCount="100" BrandID="0"/>
<uc1:newstimeline runat="server" ID="newstimeline" ResultCount="100" BrandID="0"/>

