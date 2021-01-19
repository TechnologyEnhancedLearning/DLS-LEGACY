<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="brands.ascx.vb" Inherits="ITSP_TrackingSystemRefactor.brands" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>


<asp:ObjectDataSource ID="dsBrands" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataOrderByNumber" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.BrandsTableAdapter">
    <SelectParameters>
        <asp:Parameter DefaultValue="1000" Name="ResultCount" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<div class="wrap ms-hero-bg-info ms-hero-img-study ms-bg-fixed">
    <div class="container">
        <h2 class="text-center color-white mb-4">Learning content</h2>
        <div class="row">
            <div class="col col-md-12">
                <div class="row text-center">
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="dsBrands">
                        <ItemTemplate>
                            <div class="col col-lg-4 col-md-6">
                                <div class="card width-auto">
                                    <figure class="ms-thumbnail ms-thumbnail-horizontal">
                                        <dx:ASPxBinaryImage ID="bimgBrand" Value='<%# Eval("BrandImage") %>' AlternateText="product logo" CssClass="img-fluid" runat="server"></dx:ASPxBinaryImage>
                                        <figcaption class="ms-thumbnail-caption text-center">
                                            <div class="ms-thumbnail-caption-content">
                                                <div class="h4 ms-thumbnail-caption-title mb-2"><%# Eval("BrandName") %></div>
                                                <div class="ml-2 mr-2" style="text-align: left;">
                                                    <p>
                                                        <a href='<%# "Learning?brand=" & Eval("BrandName").Replace(" ", "") %>' aria-label='<%# "View " & Eval("Courses").ToString & " courses" %>' class="btn-circle btn-circle-raised btn-circle-sm mr-1 btn-circle-white color-info">
                                                            <i aria-hidden="true" class="fas fa-book"></i>
                                                        </a><%# CInt(Eval("Courses")).ToString("N0") %> courses
                                                    </p>
                                                    <p>
                                                        <a href='<%# "Learning?brand=" & Eval("BrandName").Replace(" ", "") %>' aria-label='<%# "View " & Eval("Courses").ToString & " courses" %>' class="btn-circle btn-circle-raised btn-circle-sm mr-1 btn-circle-white color-success">
                                                            <i aria-hidden="true" class="fas fa-users"></i>
                                                        </a><%# CInt(Eval("Learners")).ToString("N0") %> learners
                                                    </p>
                                                </div>
                                            </div>
                                        </figcaption>
                                    </figure>
                                    <div class="card-body overflow-hidden text-center">
                                        <a href='<%# "Learning?brand=" & Eval("BrandName").Replace(" ", "") %>' aria-label='<%# "View " & Eval("Courses").ToString & " courses" %>' class="btn-circle btn-circle-info btn-circle-raised btn-card-float right wow zoomInDown index-2" style="visibility: visible; animation-name: zoomInDown;">
                                            <i aria-hidden="true" class="fas fa-book"></i>
                                        </a>
                                        <div class="h4 color-info"><%# Eval("BrandName") %></div>
                                        <p><%# Eval("BrandDescription") %></p>

                                        <a href='<%# "Learning?brand=" & Eval("BrandName").Replace(" ", "") %>' class="btn btn-info btn-raised float-right">
                                            <i aria-hidden="true" class="fas fa-search"></i><%# "View " & Eval("Courses").ToString & " courses" %></a>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                        <AlternatingItemTemplate>
                            <div class="col col-lg-4 col-md-6">
                                <div class="card width-auto">
                                    <figure class="ms-thumbnail ms-thumbnail-horizontal">
                                        <dx:ASPxBinaryImage ID="bimgBrand" Value='<%# Eval("BrandImage") %>' AlternateText="product logo" CssClass="img-fluid" runat="server"></dx:ASPxBinaryImage>
                                        <figcaption class="ms-thumbnail-caption text-center">
                                            <div class="ms-thumbnail-caption-content">
                                                <div class="h4 ms-thumbnail-caption-title mb-2"><%# Eval("BrandName") %></div>
                                                <div class="ml-2 mr-2" style="text-align: left;">
                                                    <p>
                                                        <a href='<%# "Learning?brand=" & Eval("BrandName").Replace(" ", "") %>' aria-label='<%# "View " & Eval("Courses").ToString & " courses" %>' class="btn-circle btn-circle-raised btn-circle-sm mr-1 btn-circle-white color-royal">
                                                            <i aria-hidden="true" class="fas fa-book"></i>
                                                        </a><%# CInt(Eval("Courses")).ToString("N0") %> courses
                                                    </p>
                                                    <p>
                                                        <a href='<%# "Learning?brand=" & Eval("BrandName").Replace(" ", "") %>' aria-label='<%# "View " & Eval("Courses").ToString & " courses" %>' class="btn-circle btn-circle-raised btn-circle-sm mr-1 btn-circle-white color-success">
                                                            <i aria-hidden="true" class="fas fa-users"></i>
                                                        </a><%# CInt(Eval("Learners")).ToString("N0") %> learners
                                                    </p>
                                                </div>
                                            </div>
                                        </figcaption>
                                    </figure>
                                    <div class="card-body overflow-hidden text-center">
                                        <a href='<%# "Learning?brand=" & Eval("BrandName").Replace(" ", "") %>' aria-label='<%# "View " & Eval("Courses").ToString & " courses" %>' class="btn-circle btn-circle-royal btn-circle-raised btn-card-float right wow zoomInDown index-2" style="visibility: visible; animation-name: zoomInDown;">
                                            <i aria-hidden="true" class="fas fa-book"></i>
                                        </a>
                                        <div class="h4 color-info"><%# Eval("BrandName") %></div>
                                        <p><%# Eval("BrandDescription") %></p>

                                        <a href='<%# "Learning?brand=" & Eval("BrandName").Replace(" ", "") %>' class="btn btn-royal btn-raised float-right">
                                            <i aria-hidden="true" class="fas fa-search"></i><%# "View " & Eval("Courses").ToString & " courses" %></a>
                                    </div>
                                </div>
                            </div>
                        </AlternatingItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>
</div>
