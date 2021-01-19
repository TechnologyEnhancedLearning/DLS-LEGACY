<%@ Page Title="Approve Delegates" Language="vb" AutoEventWireup="false" MasterPageFile="~/tracking/Site.Master" CodeBehind="approvedelegates.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.approvedelegates" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="breadtray" runat="server">
   <ol class="breadcrumb breadcrumb-slash">
        <li class="breadcrumb-item"><a href="delegates">Delegates </a></li>
        <li class="breadcrumb-item active">Approve Delegate Registrations</li>
    </ol>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ObjectDataSource ID="dsAwaitingApproval" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetAwaitingApproval" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.CandidatesTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <dx:BootstrapGridView ID="bsgvAwaitingApproval" SelectAllCheckboxMode="AllPages" ShowSelectCheckbox="True" Settings-GridLines="None" runat="server" AutoGenerateColumns="False" DataSourceID="dsAwaitingApproval" KeyFieldName="CandidateID">
        <SettingsBootstrap Striped="True" />
                <SettingsPager PageSize="15">
                </SettingsPager>
        
        <Columns>
            <dx:BootstrapGridViewCommandColumn SelectAllCheckboxMode="AllPages" ShowSelectCheckbox="True" VisibleIndex="0">
                            </dx:BootstrapGridViewCommandColumn>
            <dx:BootstrapGridViewTextColumn FieldName="FirstName" VisibleIndex="5">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="LastName" VisibleIndex="4">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewDateColumn FieldName="DateRegistered" VisibleIndex="2">
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewTextColumn Caption="Del ID" FieldName="CandidateNumber" VisibleIndex="3">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Ans 1" FieldName="Answer1" VisibleIndex="6">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Ans 2" FieldName="Answer2" VisibleIndex="7">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Ans 3" FieldName="Answer3" VisibleIndex="8">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Job group" FieldName="JobGroupName" ReadOnly="True" VisibleIndex="12">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Email" FieldName="EmailAddress" VisibleIndex="11">
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Caption="Approve?" Name="Approve" VisibleIndex="13">
                 <DataItemTemplate>
                     <asp:LinkButton EnableViewState="false" ID="lbtAcceptReg" CssClass="btn btn-success btn-sm" ToolTip="Approve registration" OnCommand="ApproveDelegate_Click" CommandArgument='<%# Eval("CandidateID") %>' runat="server"><i aria-hidden="true" class="fas fa-check"></i></asp:LinkButton>
                                
                                      <asp:LinkButton EnableViewState="false" ID="lbtInactivateDelegate" OnClientClick="return confirm('Are you sure that you wish to reject this delegate registration?');" CssClass="btn btn-danger btn-sm" ToolTip="Reject and remove registration" OnCommand="RejectDelegate_Click" CommandArgument='<%# Eval("CandidateID") %>' runat="server"><i aria-hidden="true" class="fas fa-times"></i></asp:LinkButton>
                                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
        </Columns>
    </dx:BootstrapGridView>
    <asp:LinkButton CssClass="btn btn-primary float-right mt-1" ID="lbtApproveSelected" OnCommand="lbtApproveSelected_Command" runat="server"><i aria-hidden="true" class="fas fa-user-check"></i> Approve Selected</asp:LinkButton>
</asp:Content>
