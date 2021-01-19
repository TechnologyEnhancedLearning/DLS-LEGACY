<%@ Page Title="Support FAQs" Language="vb" AutoEventWireup="false" MasterPageFile="~/tracking/Site.Master" CodeBehind="faqs.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.faqs" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="breadtray" runat="server">
    <link href="../Content/dashboard.css" rel="stylesheet" />
    <link href="../Content/faq.css" rel="stylesheet" />
   <ol class="breadcrumb breadcrumb-slash">
        <li class="breadcrumb-item">Support </li>
        <li class="breadcrumb-item active">FAQs</li>
    </ol>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ObjectDataSource ID="dsFAQs" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetByAnchor" TypeName="ITSP_TrackingSystemRefactor.supportdataTableAdapters.FAQDisplayTableAdapter">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="" Name="QAnchor" QueryStringField="tag" Type="String" ConvertEmptyStringToNull="False" />
        </SelectParameters>
    </asp:ObjectDataSource>
     <div id="accordion_search_bar_container">
      <input type="search" 
         id="accordion_search_bar" 
         placeholder="Search"/>
  </div>
    <div class="container" 
       id="accordion" 
       role="tablist" 
       aria-multiselectable="true">
           <asp:Repeater ID="rptFAQs" runat="server" DataSourceID="dsFAQs">
         <ItemTemplate>
		 <div class="row faq mb-1" id='<%# Eval("QAnchor") %>'>
             <div class="col-12">
             <div class="card">
                 <div class="card-header nodecs"> <h6><a class="nodecs" data-toggle="collapse" data-parent="#accordion" href='<%# "#faq" + DataBinder.Eval(Container.DataItem, "FAQID").ToString()%>'>
                                    <i class="fas fa-plus mr-2 ml-2"></i>
                                            <asp:Label ID="lblQuestionRpt" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "QText")%>' />
                     <button class="btn btn-circle btn-outline-secondary btn-sm" runat="server" id="btnCopy" visible='<%# Session("UserUserAdmin") %>' onclick='<%# "copyToClipboardMsg(""lblURL" & Eval("QAnchor") & """); return false;" %>'>
    <i class="far fa-copy"></i>
</button>

                    
                            <%--   <asp:LinkButton EnableViewState="false" CausesValidation="false" OnClientClick='<%# "copyToClipboardMsg(""lblURL" & Eval("QAnchor") & """); return false;" %>' CssClass="btn btn-circle btn-outline-secondary btn-sm" ID="lbtCopy" runat="server"><i aria-hidden="false" class="fa fa-copy"></i></asp:LinkButton>--%></a>
                                </h6><span style="display: none;" id='<%# "lblURL" & Eval("QAnchor")%>'><%# Session("TSURL") & "faqs?tag=" & Eval("QAnchor") %></span></div>
                                <div id='<%# "faq" + DataBinder.Eval(Container.DataItem, "FAQID").ToString()%>' class="card-collapse collapse">
                                    <div class="card-body">
                                        <asp:Literal ID="Literal1" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "AHTML")%>'></asp:Literal>
                                    </div>
                                </div>
                            </div></div></div>
             </ItemTemplate></asp:Repeater>
       
          <script>$('.collapse').on('shown.bs.collapse', function () {
                  $(this).parent().find(".fa-plus").removeClass("fa-plus").addClass("fa-minus");
              }).on('hidden.bs.collapse', function () {
                  $(this).parent().find(".fa-minus").removeClass("fa-minus").addClass("fa-plus");
              });</script>
    </div>
     <asp:LinkButton ID="lbtShowAll" CssClass="btn btn-outline-secondary float-right" runat="server">Show all</asp:LinkButton>
    <script src="../Scripts/faqs.js"></script>
    <script src="../Scripts/clipcopy.js"></script>
</asp:Content>
