<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="products.ascx.vb" Inherits="ITSP_TrackingSystemRefactor.products" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:ObjectDataSource ID="dsProducts" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActive" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.pl_ProductsTableAdapter">

    <SelectParameters>
        <asp:Parameter DefaultValue="1000" Name="ResultCount" Type="Int32" />
    </SelectParameters>
 
</asp:ObjectDataSource>
<div class="wrap ms-hero-bg-default">
<div class="container">
        <h2 class="font-light">Digital Learning Solutions Products</h2>
        <p class="lead color-primary mb-4">Create, deliver, manage and track digital learning using our suite of products.</p>
        <div class="panel panel-light panel-flat">
          <!-- Nav tabs -->
          <ul class="nav nav-tabs nav-tabs-transparent indicator-primary nav-tabs-full nav-tabs-5" role="tablist">
              <asp:Repeater ID="rptProductTabs" DataSourceID="dsProducts" runat="server">
                  <ItemTemplate>
            <li class='<%# "nav-item wow fadeInDown animation-delay-" & (7 - Container.ItemIndex).ToString()  %>' role="presentation">
              <a href='<%# "#" & Eval("ProductName").Replace(" ", "").ToLower() %>' aria-controls='<%# Eval("ProductName").Replace(" ", "").ToLower() %>' role="tab" data-toggle="tab" class='<%# IIf(Container.ItemIndex = 0, "nav-link withoutripple active", "nav-link withoutripple") %>'>
                <i aria-hidden="true" class='<%# Eval("ProductIconClass") %>'></i>
                <span class="d-none d-md-inline"><%# Eval("ProductName") %></span>
              </a>
            </li>
                  </ItemTemplate>
              </asp:Repeater>
          </ul>
          <div class="panel-body">
            <!-- Tab panes -->
            <div class="tab-content mt-4">
                <asp:Repeater ID="rptProductDetails"  DataSourceID="dsProducts" runat="server">
                    <ItemTemplate>
                        <div id='<%# Eval("ProductName").Replace(" ", "").ToLower() %>' role="tabpanel" class='<%# IIf(Container.ItemIndex = 0, "tab-pane fade active show", "tab-pane fade") %>'>
               <asp:HiddenField ID="hfProductID" Value='<%# Eval("ProductID") %>' runat="server" />
                <asp:ObjectDataSource ID="dsFeatures" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActive" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.pl_FeaturesTableAdapter">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="10" Name="ResultCount" Type="Int32" />
                        <asp:ControlParameter ControlID="hfProductID" DefaultValue="" Name="ProductID" PropertyName="Value" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>

                            <div class="row">
                  <div class="col col-lg-6 order-lg-2">
                      <img runat="server" src="~/Images/landing/mock-monitor.png" alt="" class="img-fluid" />
                      
                      <dx:ASPxBinaryImage ID="ASPxBinaryImage1" Width="520px" AlternateText=<%# Eval("ProductHeading", "Screenshot of {0}") %> CssClass="img-overlay-monitor animated zoomIn animation-delay-8" Value='<%# Eval("ProductScreenshot") %>' runat="server"></dx:ASPxBinaryImage>
                     </div>
                  <div class="col col-lg-6 order-lg-1">
                    <div class="h3 text-normal animated fadeInUp animation-delay-4"><%# Eval("ProductHeading") %></div>  
                      <p class="lead lead-md animated fadeInUp animation-delay-6"><%# Eval("ProductTagline") %></p>
                      <ul class="ms-hero-material-list">
                      <asp:Repeater ID="rptFeatures" DataSourceID="dsFeatures" runat="server">
                          <ItemTemplate>
  <li class="">
                            <div aria-hidden="true" class='<%# "ms-list-icon animated zoomInLeft animation-delay-" & (Container.ItemIndex + 9).ToString() %>'>
                              <span class='<%# "ms-icon ms-icon-circle ms-icon-xlg color-" & Eval("FeatureColourClass").ToString.ToLower() & " info shadow-3dp" %>'>
                                <i class='<%# Eval("FeatureIconClass") %>'></i>
                              </span>
                            </div>
                            <div class='<%# "ms-list-text animated zoomInRight animation-delay-" & (Container.ItemIndex + 10).ToString() %>'><%# Eval("FeatureHeading") %></div>
                          </li>
                          </ItemTemplate>
                      </asp:Repeater>
                        </ul>
                      <div class="">
                      <a href='<%# "Product?product=" & Eval("ProductName").Replace(" ", "") %>' class="btn btn-info btn-raised animated zoomIn animation-delay-18">
                        <i class="fas fa-play"></i> More info</a>
                      
                    </div>
                  </div>
                </div>
              </div>
                    </ItemTemplate>
                </asp:Repeater>
              
              
            </div>
          </div>
        </div>
        <!-- panel -->
      </div>
    </div>