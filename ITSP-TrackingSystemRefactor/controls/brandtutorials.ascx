<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="brandtutorials.ascx.vb" Inherits="ITSP_TrackingSystemRefactor.brandtutorials" %>
<asp:ObjectDataSource ID="dsBrandTutorials" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.TutorialsForBrandTableAdapter">
    <SelectParameters>
        <asp:SessionParameter Name="BrandID" SessionField="plBrandID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
