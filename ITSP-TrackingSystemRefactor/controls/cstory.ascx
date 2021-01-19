<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="cstory.ascx.vb" Inherits="ITSP_TrackingSystemRefactor.cstory" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:ObjectDataSource ID="dsStoryContent" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByCaseStudyID" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.pl_CaseContentTableAdapter">
    <SelectParameters>
        <asp:SessionParameter Name="CaseStudyID" SessionField="plCaseStudyID" DefaultValue="1" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>

<div class="material-background"></div>
<div class="header-spacer"></div>
<div class="container">
        <div class="row">
          <div class="col col-md-12">
            <div class="card animated materialUp animation-delay-5" "="">
                <div class="card-body card-body-big ">
                    <h1 class="no-mt ">
                        <asp:Label ID="lblHeading" runat="server" Text="Label"></asp:Label></h1>
                    <h2 class="no-mt color-info">
                    <asp:Label ID="lblSubheading" runat="server" Text="Label"></asp:Label></h2>
                    <div class="mb-4 ">
                        In <asp:LinkButton ID="lbtCategory" CssClass="ms-tag ms-tag-info " runat="server"></asp:LinkButton>
                        <span class="ml-1 d-none d-sm-inline "><i class="far fa-clock mr-05 color-info "></i> <span class="color-medium-dark ">
                            <asp:Label ID="lblDate" runat="server" Text="Label"></asp:Label></span></span>
                        <span class="ml-1 "><i class="fas fa-comment color-royal mr-05 "></i> <asp:Label ID="lblComments" runat="server" Text="0"></asp:Label></span>
                    </div>
                    <dx:ASPxBinaryImage ID="bimgMain" Width="100%" CssClass="img-fluid mb-4" runat="server"></dx:ASPxBinaryImage>
                 <asp:Repeater ID="rptStoryContent" runat="server" DataSourceID="dsStoryContent">
                     <ItemTemplate>
                         <div class="clearfix">
                         <asp:Panel ID="pnlContentHeading" Visible='<%# Eval("ContentHeading").ToString.Length > 0 %>' runat="server">
                            <h3 class="color-primary "><%# Eval("ContentHeading").ToString %></h3>
                         </asp:Panel>
                         <asp:Panel ID="pnlContentImage" Visible='<%# Eval("ContentImage").ToString.Length > 10 %>' runat="server">
                             <dx:ASPxBinaryImage ID="imgbContent" Width='<%# Unit.Percentage(Eval("ImageWidth")) %>' Value='<%# Eval("ContentImage") %>' CssClass="imgborder ml-2 mb-2 float-right " runat="server"></dx:ASPxBinaryImage></asp:Panel>
                         <asp:Panel ID="pnlContentText" Visible='<%# Eval("ContentText").ToString.Length > 0 %>' runat="server">
                            <p class='<%# IIf(Eval("ContentHeading").ToString.Length = 0, "lead", "") %>'><asp:Literal ID="litContent" runat="server" Text='<%# IIf(Eval("ContentHeading").ToString.Length = 0, Eval("ContentText").ToString.Replace("<p>", "<p class=""lead"">"), Eval("ContentText")) %>'></asp:Literal></p>
                         </asp:Panel>
                         <asp:Panel ID="pnlContentQuote" Visible='<%# Eval("ContentQuoteText").ToString.Length > 0 %>' runat="server">
                             <blockquote class="blockquote blockquote-big ">
                        <p><%# Eval("ContentQuoteText") %></p>
                                 <asp:Panel ID="pnlAttr" Visible='<%# Eval("ContentQuoteAttr").ToString.Length > 0 %>' runat="server">
                        <footer><cite title='<%# Eval("ContentQuoteAttr") %>'><%# Eval("ContentQuoteAttr") %></cite></footer></asp:Panel>
                    </blockquote>
                         </asp:Panel></div>
                     </ItemTemplate>
                     <AlternatingItemTemplate>
                          <div class="clearfix">
                         <asp:Panel ID="pnlContentHeading" Visible='<%# Eval("ContentHeading").ToString.Length > 0 %>' runat="server">
                            <h3 class="color-primary "><%# Eval("ContentHeading").ToString %></h3>
                         </asp:Panel>
                         <asp:Panel ID="pnlContentImage" Visible='<%# Eval("ContentImage").ToString.Length > 10 %>' runat="server">
                             <dx:ASPxBinaryImage ID="imgbContent" Width='<%# Unit.Percentage(Eval("ImageWidth")) %>' Value='<%# Eval("ContentImage") %>' CssClass="imgborder ml-2 mb-2 float-left mr-auto pad-right-twenty" runat="server"></dx:ASPxBinaryImage></asp:Panel>
                         <asp:Panel ID="pnlContentText" Visible='<%# Eval("ContentText").ToString.Length > 0 %>' runat="server">
                         <p class='<%# IIf(Eval("ContentHeading").ToString.Length = 0, "lead", "") %>'><asp:Literal ID="litContent" runat="server" Text='<%# IIf(Eval("ContentHeading").ToString.Length = 0, Eval("ContentText").ToString.Replace("<p>", "<p class=""lead"">"), Eval("ContentText")) %>'></asp:Literal></p>
                         </asp:Panel>
                         <asp:Panel ID="pnlContentQuote" Visible='<%# Eval("ContentQuoteText").ToString.Length > 0 %>' runat="server">
                             <blockquote class="blockquote blockquote-big ">
                        <p><%# Eval("ContentQuoteText") %></p>
                                 <asp:Panel ID="pnlAttr" Visible='<%# Eval("ContentQuoteAttr").ToString.Length > 0 %>' runat="server">
                        <footer><cite title='<%# Eval("ContentQuoteAttr") %>'><%# Eval("ContentQuoteAttr") %></cite></footer></asp:Panel>
                    </blockquote>
                         </asp:Panel></div>
                     </AlternatingItemTemplate>
</asp:Repeater>
                   </div>
            </div>
        </div>
    </div>
</div>
