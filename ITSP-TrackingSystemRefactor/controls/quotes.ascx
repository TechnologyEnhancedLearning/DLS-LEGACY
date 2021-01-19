<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="quotes.ascx.vb" Inherits="ITSP_TrackingSystemRefactor.quotes" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%--<asp:ObjectDataSource ID="dsQuotes" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActive" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.pl_QuotesTableAdapter">

    <SelectParameters>
        <asp:SessionParameter DefaultValue="10" Name="ResultCount" SessionField="QuoteResultCount" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>--%>
<asp:Panel ID="pnlQuotes" runat="server">
<div class="wrap mt-6">
    <div class="container">
    <h2 class="text-center  mb-4">
        <asp:Label ID="lblHeader" runat="server" Text="What our customers say"></asp:Label></h2>
    
    <div class="row">
        <div class="container">
            <asp:Repeater ID="rptQuotes" runat="server">
                <ItemTemplate>
                    
                    <blockquote class='<%# "quote-card info-card wow fadeInRight animation-delay-" & (Container.ItemIndex + 2).ToString() %>'>
                        
                        <p>
                            <%# Eval("QuoteText")%>
                        </p>
                        <cite>
                            <%# Eval("AttrIndividual")%>, <%# Eval("AttrOrganisation")%>, <%# Eval("QuoteDate", "{0:dd MMMM yyy}")%>
              </cite>
                    </blockquote>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <blockquote class='<%# "quote-card primary-card wow fadeInLeft animation-delay-" & (Container.ItemIndex + 2).ToString() %>'>
                       
                        <p>
                            <%# Eval("QuoteText")%>
                        </p>
                        <cite>
                            <%# Eval("AttrIndividual")%>, <%# Eval("AttrOrganisation")%>, <%# Eval("QuoteDate", "{0:dd MMMM yyy}")%>
            </cite>
                    </blockquote>
                </AlternatingItemTemplate>
            </asp:Repeater>
        </div>
    </div>
        </div>
</div>
    </asp:Panel>



