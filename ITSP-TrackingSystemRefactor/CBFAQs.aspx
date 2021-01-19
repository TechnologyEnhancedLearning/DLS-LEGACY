<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CBFAQs.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.CBFAQs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <style>
        h1, .h1 {
  font-size: 1.5rem;
}
    </style>
    <title>FAQ Knowledge Base</title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <asp:ObjectDataSource ID="dsFAQs" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.supportdataTableAdapters.FAQListTableAdapter">
                <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="2" Name="TargetID" QueryStringField="target" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:Repeater ID="rptFAQS" runat="server" DataSourceID="dsFAQs">
                <ItemTemplate>
                <section class="mt-2 mb-4">
                <h1><%# Eval("QText") %></h1>
                    <div>
                        <%# IIF(Eval("ShortAHTML").ToString.Length > 0, Eval("ShortAHTML"), Eval("AHTML")) %>
                    </div>
</section></ItemTemplate>
            </asp:Repeater>
        </div>
    </form>
</body>
</html>
