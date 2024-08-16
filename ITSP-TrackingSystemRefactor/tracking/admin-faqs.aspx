<%@ Page Title="Admin - FAQS" Language="vb" AutoEventWireup="false" MasterPageFile="~/tracking/Site.Master" CodeBehind="admin-faqs.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.admin_faqs" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.ASPxHtmlEditor.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxHtmlEditor" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="breadtray" runat="server">
   <h1>FAQs</h1>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <!-- /.row -->
    <asp:ObjectDataSource ID="dsFAQs" runat="server" DeleteMethod="Delete" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.FAQsTableAdapter">
        <DeleteParameters>
            <asp:Parameter Name="Original_FAQID" Type="Int32" />
        </DeleteParameters>
     
    </asp:ObjectDataSource>
    <asp:MultiView ID="mvFAQ" ActiveViewIndex="0" runat="server">
        <asp:View ID="vListFAQs" runat="server">
            <div class="row"><div class="col">
             <div class="float-right">
            <asp:LinkButton ID="lbtAddFAQ" CssClass="btn btn-primary float-right" ToolTip="Add new FAQ" runat="server"><i aria-hidden="true" class="fas fa-plus"></i> Add FAQ</asp:LinkButton>
        </div></div></div>
             <div class="card card-default">
                <div class="card-header clearfix">
                    <div class="btn-group  float-right">
                        <asp:LinkButton ID="lbtClearFilters" runat="server" CssClass="btn btn-outline-secondary"><i aria-hidden="true" class="fas fa-times"></i> Clear filters</asp:LinkButton>
                             <asp:LinkButton ID="lbtDownloadFAQs" CssClass="btn btn-success" runat="server"><i aria-hidden="true" class="fas fa-file-export"></i> Download to Excel</asp:LinkButton>  
                    </div>
                </div>
                <div class="table-responsive">
                    <dx:BootstrapGridView ID="bsgvFAQs" CssClasses-Table="table table-striped small" runat="server" SettingsCustomizationDialog-Enabled="true" AutoGenerateColumns="False" DataSourceID="dsFAQs" KeyFieldName="FAQID">
                        <CssClasses Table="table table-striped small" />
                        <Settings ShowHeaderFilterButton="True" />
                        <SettingsCookies Enabled="True" Version="0.13" />
                        <SettingsPager PageSize="7">
                        </SettingsPager>
                        <Columns>
                            <dx:BootstrapGridViewTextColumn Name="Edit" ReadOnly="True" VisibleIndex="0">
                                <SettingsEditForm Visible="False" />
                                <DataItemTemplate>
                                      <asp:LinkButton ID="lbtEditFAQ" EnableViewState="false" runat="server" CausesValidation="False" CssClass="btn btn-outline-secondary btn-sm" CommandArgument='<%# Eval("FAQID") %>' OnCommand="Select_Click" ToolTip="Edit FAQ"><i aria-hidden="true" class="fas fa-pencil-alt"></i></asp:LinkButton>   
                                </DataItemTemplate>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewDateColumn Caption="Created" FieldName="CreatedDate" Name="Created" VisibleIndex="1">
                            </dx:BootstrapGridViewDateColumn>
                            <dx:BootstrapGridViewTextColumn Caption="Question" FieldName="QText" Name="Question" VisibleIndex="2">
                                <Settings AllowHeaderFilter="False" />
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn Caption="Answer" FieldName="AHTML" Name="Answer" VisibleIndex="3">
                                <Settings AllowHeaderFilter="False" />
                                <DataItemTemplate>  
                                    <asp:Literal EnableViewState="false" ID="litAnswer" runat="server" Text='<%# Bind("AHTML") %>'></asp:Literal>
                                </DataItemTemplate>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn Caption="Short Answer" FieldName="ShortAHTML" Name="Answer" VisibleIndex="3">
                                <Settings AllowHeaderFilter="False" />
                                <DataItemTemplate>  
                                    <asp:Literal EnableViewState="false" ID="litSAnswer" runat="server" Text='<%# Bind("ShortAHTML") %>'></asp:Literal>
                                </DataItemTemplate>
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="QAnchor" VisibleIndex="4" Caption="Anchor" Name="Anchor">
                                <Settings AllowHeaderFilter="False" />
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewCheckColumn FieldName="Published" VisibleIndex="5">
                            </dx:BootstrapGridViewCheckColumn>
                            <dx:BootstrapGridViewTextColumn FieldName="Target" Caption="Target" VisibleIndex="6">
                                <SettingsHeaderFilter Mode="CheckedList">
                                </SettingsHeaderFilter>
                            </dx:BootstrapGridViewTextColumn> 
                            <dx:BootstrapGridViewTextColumn FieldName="Weighting" Visible="False" VisibleIndex="7">
                            </dx:BootstrapGridViewTextColumn>
                            <dx:BootstrapGridViewTextColumn Name="Delete" ReadOnly="True" VisibleIndex="8">
                                <SettingsEditForm Visible="False" />
                                <DataItemTemplate>
                                    <asp:LinkButton ID="lbtDeleteFAQ" EnableViewState="false" CausesValidation="True" CssClass="btn btn-danger btn-sm" OnClientClick="return confirm('Are you sure you want to delete this FAQ?');" runat="server" ToolTip="Delete" CommandArgument='<%# Eval("FAQID") %>' OnCommand="Delete_Click"><i aria-hidden="true" class="fas fa-times"></i></asp:LinkButton>   
                                </DataItemTemplate>
                            </dx:BootstrapGridViewTextColumn>
                        </Columns>
                        <SettingsSearchPanel Visible="True" AllowTextInputTimer="false" />
                    </dx:BootstrapGridView>
                    <dx:ASPxGridViewExporter FileName="ITSP FAQS Export" ID="FAQsGridViewExporter" GridViewID="bsgvDownloads" runat="server"></dx:ASPxGridViewExporter>
                    
                    </div>
          </div>
        </asp:View>
        <asp:View ID="vAddEditFAQ" runat="server">
            <asp:ObjectDataSource ID="dsFAQInsertEdit" runat="server" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetByFAQID" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.FAQsTableAdapter" UpdateMethod="Update">
        <InsertParameters>
            <asp:Parameter Name="CreatedDate" Type="DateTime" />
            <asp:Parameter Name="Weighting" Type="Double" />
            <asp:Parameter Name="QAnchor" Type="String" />
            <asp:Parameter Name="QText" Type="String" />
            <asp:Parameter Name="AHTML" Type="String" />
            <asp:Parameter Name="Published" Type="Boolean" />
            <asp:Parameter Name="TargetGroup" Type="Int32" />
            <asp:Parameter Name="ShortAHTML" Type="String" />
        </InsertParameters>
                <SelectParameters>
                    <asp:Parameter Name="FAQID" Type="Int32" />
                </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="CreatedDate" Type="DateTime" />
            <asp:Parameter Name="Weighting" Type="Double" />
            <asp:Parameter Name="QAnchor" Type="String" />
            <asp:Parameter Name="QText" Type="String" />
            <asp:Parameter Name="AHTML" Type="String" />
            <asp:Parameter Name="Published" Type="Boolean" />
            <asp:Parameter Name="TargetGroup" Type="Int32" />
            <asp:Parameter Name="ShortAHTML" Type="String" />
            <asp:Parameter Name="Original_FAQID" Type="Int32" />
        </UpdateParameters>
    </asp:ObjectDataSource>
            <div class="card card-primary">
                        <div class="card-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4>
                                <asp:Label ID="lblFAQTitle" runat="server" Text="Add FAQ"></asp:Label></h4>
                        </div>
                        <asp:FormView ID="fvFAQ" runat="server" DataKeyNames="FAQID" DataSourceID="dsFAQInsertEdit"
                            DefaultMode="Insert" RenderOuterTable="False">
                            <EditItemTemplate>
                                <div class="card-body">
                                    <div class="m-3">
                                    <div class="form-group hidden">
                                        <asp:Label ID="Label9" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label" Text="CaseStudyID" AssociatedControlID="FAQIDLabel1"></asp:Label>
                                        <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:Label ID="FAQIDLabel1" runat="server" Text='<%# Eval("FAQID") %>' />
                                            </div>
                                    </div>
                                    <div class="form-group row">
                                        <asp:Label ID="Label10" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label" Text="Created date:" AssociatedControlID="CreatedDateTextBox"></asp:Label>
                                        <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:TextBox Enabled="false" CssClass="form-control" ID="CreatedDateTextBox" runat="server" Text='<%# Bind("CreatedDate", "{0:d}") %>' />
                                            </div>
                                    </div>
                                    <div class="form-group row">
                                        <asp:Label ID="Label11" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label" Text="Question:" AssociatedControlID="QTextTextBox"></asp:Label>
                                        <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:TextBox CssClass="form-control" ID="QTextTextBox" runat="server" Text='<%# Bind("QText") %>' />
                                            </div>
                                    </div>
                                    <div class="form-group row">

                                        <asp:Label ID="Label12" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label" Text="Answer:" AssociatedControlID="ASPxHtmlEditor2"></asp:Label>
                                        <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <dx:ASPxHtmlEditor ID="ASPxHtmlEditor2" OnHtmlCorrecting="htmlFAQCorrecting" runat="server" Html='<%# Bind("AHTML") %>' Width="100%" Height="300px"></dx:ASPxHtmlEditor>
                                       </div>
                                    </div>
                                        <div class="form-group row">

                                        <asp:Label ID="Label1" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label" Text="Chatbot Answer:" AssociatedControlID="ASPxHtmlEditor3"></asp:Label>
                                        <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <dx:ASPxHtmlEditor ID="ASPxHtmlEditor3" OnHtmlCorrecting="htmlFAQCorrecting" runat="server" Html='<%# Bind("ShortAHTML") %>' Width="100%" Height="300px"></dx:ASPxHtmlEditor>
                                       </div>
                                    </div>
                                    <div class="form-group row">
                                        <asp:Label ID="Label13" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label" Text="Target group:" AssociatedControlID="ddTargetGroupEdit"></asp:Label>
                                        <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:DropDownList CssClass="form-control" ID="ddTargetGroupEdit" runat="server" SelectedValue='<%# Bind("TargetGroup") %>'>
                                            <asp:ListItem Text="Tracking system" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Prospective centre" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Learners" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Login Notices" Value="3"></asp:ListItem>
                                        </asp:DropDownList>
                                            </div>
                                    </div>
                                    <div class="form-group row">
                                        <asp:Label ID="Label14" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label" Text="Weighting:" AssociatedControlID="ASPxSpinEdit1"></asp:Label>
                                        <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <div class="input-group">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxSpinEdit ID="ASPxSpinEdit1" CssClass="form-control" runat="server" Number='<%# Bind("Weighting") %>' MaxValue="300"  NumberType="Integer">
                                                        </dx:ASPxSpinEdit>
                                                        
                                                    </td>
                                                    
                                                </tr>
                                            </table>
                                        </div>
                                            </div>
                                    </div>
                                    <div class="form-group row">

                                        <asp:Label ID="Label15" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label" Text="Anchor:" AssociatedControlID="QAnchorTextBox"></asp:Label>
                                        <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:TextBox CssClass="form-control" ID="QAnchorTextBox" runat="server" Text='<%# Bind("QAnchor") %>' />
                                            </div>
                                    </div>
                                    <div class="form-group row">

                                        <asp:Label ID="Label16" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label" Text="Published:" AssociatedControlID="PublishedCheckBox"></asp:Label>
                                        <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:CheckBox ID="PublishedCheckBox" runat="server" Checked='<%# Bind("Published") %>' />
                                            </div>
                                    </div>
                                </div>
                                    </div>
                                <div class="card-footer clearfix">

                                   <asp:LinkButton ID="LinkButton1" CommandName="CloseForm" cssclass="btn btn-outline-secondary mr-auto" runat="server">Cancel</asp:LinkButton>
                                    <asp:LinkButton ID="btnUpdateFAQ" CommandName="Update" CausesValidation="True" runat="server"
                                        CssClass="btn btn-primary float-right" Style="font-weight: normal" ToolTip="Update FAQ">
                  <span><span>Update</span></span>
                                    </asp:LinkButton>

                                </div>

                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <div class="card-body">
                                    <div class="m-3">
                                    <div class="form-group row">

                                        <asp:Label ID="Label16" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label" Text="Created date:" AssociatedControlID="CreatedDateTextBox"></asp:Label>
                                        <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:TextBox placeholder="dd/mm/yyyy" CssClass="form-control" ID="CreatedDateTextBox" runat="server" Text='<%# Bind("CreatedDate", "{0:d}") %>' TextMode="Date" />
                                            </div>
                                    </div>
                                    <div class="form-group row">

                                        <asp:Label ID="Label17" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label" Text="Question:" AssociatedControlID="QTextTextBox"></asp:Label>
                                        <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:TextBox CssClass="form-control" ID="QTextTextBox" runat="server" Text='<%# Bind("QText") %>' />
                                            </div>
                                    </div>
                                    <div class="form-group row">
                                        <asp:Label ID="Label12" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label" Text="Answer:" AssociatedControlID="ASPxHtmlEditor1"></asp:Label>
                                        <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <dx:ASPxHtmlEditor ID="ASPxHtmlEditor1" runat="server" OnHtmlCorrecting="htmlFAQCorrecting" Html='<%# Bind("AHTML") %>'  Width="100%" Height="300px"></dx:ASPxHtmlEditor>
                                            </div>
                                    </div>
                                    <div class="form-group row">
                                        <asp:Label ID="Label13" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label" runat="server" Text="Target group:" AssociatedControlID="ddTargetGroupEdit"></asp:Label>
                                        <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:DropDownList CssClass="form-control" ID="ddTargetGroupEdit" runat="server" SelectedValue='<%# Bind("TargetGroup") %>'>
                                            <asp:ListItem Text="Tracking system" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Prospective centre" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Learners" Value="2"></asp:ListItem>
                                        </asp:DropDownList>
                                            </div>
                                    </div>
                                    <div class="form-group row">
                                        <asp:Label ID="Label14" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label" Text="Weighting:" AssociatedControlID="ASPxSpinEdit2"></asp:Label>
                                        <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <div class="input-group">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxSpinEdit ID="ASPxSpinEdit2" CssClass="form-control" runat="server" Number='<%# Bind("Weighting") %>' MaxValue="300" NumberType="Integer">
                                                        </dx:ASPxSpinEdit>
                                                        
                                                    </td>
                                                    
                                                </tr>
                                            </table>
                                        </div>
                                            </div>
                                    </div>
                                    <div class="form-group row">
                                        <asp:Label ID="Label15" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label" Text="Anchor:" AssociatedControlID="QAnchorTextBox"></asp:Label>
                                        <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:TextBox CssClass="form-control" ID="QAnchorTextBox" runat="server" Text='<%# Bind("QAnchor") %>' />
                                            </div>
                                    </div>
                                    <div class="form-group row">
                                        <asp:Label ID="Label18" runat="server" CssClass="col col-sm-4 col-md-3 col-lg-2 control-label" Text="Published:" AssociatedControlID="PublishedCheckBox"></asp:Label>
                                        <div class="col col-sm-8 col-md-9 col-lg-10">
                                        <asp:CheckBox ID="PublishedCheckBox" runat="server" Checked='<%# Bind("Published") %>' />
                                            </div>
                                    </div>
                                </div>
                                    </div>
                                <div class="card-footer clearfix">
                                    <asp:LinkButton ID="LinkButton1" CommandName="CloseForm" cssclass="btn btn-outline-secondary mr-auto" runat="server">Cancel</asp:LinkButton>
                                  
                                    <asp:LinkButton ID="btnInsertFAQ" runat="server" CausesValidation="True" CommandName="Insert"
                                        CssClass="btn btn-primary float-right" Style="font-weight: normal" ToolTip="Add FAQ">
                  <span><span>Add</span></span>
                                    </asp:LinkButton>
                                </div>
                            </InsertItemTemplate>
                        </asp:FormView>
                    </div>
        </asp:View>
    </asp:MultiView>
</asp:Content>
