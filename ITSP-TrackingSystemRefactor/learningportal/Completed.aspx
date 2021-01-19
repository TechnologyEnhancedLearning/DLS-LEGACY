<%@ Page Title="Completed Courses" Language="vb" AutoEventWireup="false" MasterPageFile="~/learningportal/lportal.Master" CodeBehind="Completed.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.Completed" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FeaturedContent" runat="server">
    <h2>My Completed Courses</h2>
    <hr />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ObjectDataSource ID="dsCompletedCourses" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.LearnerPortalTableAdapters.GetCompletedCoursesForCandidateTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CandidateID" SessionField="learnCandidateID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <dx:BootstrapGridView ID="bsgvCompleted" runat="server" AutoGenerateColumns="False"  Settings-GridLines="None" DataSourceID="dsCompletedCourses" KeyFieldName="ProgressID" SettingsBootstrap-Sizing="Large">
           <CssClasses Table="table table-striped" />

                        <Settings ShowHeaderFilterButton="True" />
                        <SettingsCookies Enabled="True" Version="0.1" StoreFiltering="False" StorePaging="False" StoreSearchPanelFiltering="False" />
                        <SettingsPager PageSize="15">
                        </SettingsPager>
        <Columns>
            <dx:BootstrapGridViewTextColumn  VisibleIndex="0">
               <DataItemTemplate>
                    <asp:LinkButton EnableViewState="false" ID="lbtLaunch" CssClass="btn btn-success" tooltip="Launch Course" OnCommand="lbtLaunch_Command" CommandArgument='<%#Eval("CustomisationID")%>' runat="server"><i aria-hidden="true" class="fas fa-play"></i></asp:LinkButton>
                     <asp:LinkButton EnableViewState="false" ID="lbtEval" CssClass="btn btn-info" ToolTip="Evaluate" Visible='<%# Eval("HasLearning") And Eval("Evaluated").ToString.Length = 0 %>' OnCommand="lbtCert_Command" CommandArgument='<%#Eval("ProgressID")%>' runat="server"><i class="fas fa-clipboard-check"></i></asp:LinkButton>
                    <asp:LinkButton EnableViewState="false" ID="lbtCert" CssClass="btn btn-primary" ToolTip="View / Print Certificate" Visible='<%# Eval("IsAssessed") And (Eval("Evaluated").ToString.Length > 0 Or Not Eval("HasLearning")) %>' OnCommand="lbtCert_Command" CommandArgument='<%#Eval("ProgressID")%>' runat="server"><i class="fas fa-award"></i></asp:LinkButton>
                  
               </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="CourseName" Settings-AllowHeaderFilter="False" Caption="Course" ReadOnly="True" VisibleIndex="1">
            </dx:BootstrapGridViewTextColumn>
           <dx:BootstrapGridViewTextColumn Name="Content" Caption="Content" VisibleIndex="2">
               <DataItemTemplate>
                    <span class="text-info small">
                     <asp:Label EnableViewState="false" ID="Label5" Visible='<%# Eval("HasDiagnostic") %>' runat="server" ToolTip="Includes Diagnostic Assessment"><i aria-hidden="true" class="fas fa-bullseye"></i></asp:Label>&nbsp;
                    <asp:Label EnableViewState="false" ID="Label6" Visible='<%# Eval("HasLearning") %>' runat="server" ToolTip="Includes Learning Content"><i aria-hidden="true" class="fas fa-book"></i></asp:Label>&nbsp;
                    <asp:Label EnableViewState="false" ID="Label7" Visible='<%# Eval("IsAssessed") %>' runat="server" ToolTip="Includes Post Learning Assessment and Certification"><i aria-hidden="true" class="fas fa-graduation-cap"></i></asp:Label>&nbsp;
                    </span>
               </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewDateColumn FieldName="LastAccessed" Caption="Last Access" VisibleIndex="3">
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewDateColumn FieldName="StartedDate" Caption="Enrolled" VisibleIndex="4">
            </dx:BootstrapGridViewDateColumn>   
            <dx:BootstrapGridViewDateColumn FieldName="Completed" VisibleIndex="5">
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewDateColumn FieldName="Evaluated" Settings-AllowHeaderFilter="False" VisibleIndex="6">
                <PropertiesDateEdit DisplayFormatString="">
                </PropertiesDateEdit>
                <DataItemTemplate>
                      <asp:Label ID="Label8" EnableViewState="false" Visible='<%# Eval("HasLearning") %>' runat="server" Text='<%# Bind("Evaluated", "{0:d}") %>'></asp:Label>
                     <asp:Label ID="Label9" EnableViewState="false" Visible='<%# Eval("HasLearning") = False %>' runat="server" Text="N/A"></asp:Label>
                </DataItemTemplate>
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewTextColumn FieldName="DiagnosticScore" Caption="Diag" Settings-AllowHeaderFilter="False" VisibleIndex="7">
                <DataItemTemplate>
                    <asp:Label ID="Label1" EnableViewState="false" runat="server" Visible='<%#Eval("HasDiagnostic") And Not Eval("DiagnosticScore").ToString = "" And Not Eval("DiagnosticScore").ToString = "0"%>' Text='<%# Eval("DiagnosticScore") & "%" %>'></asp:Label>
                    <asp:Label ID="Label3" EnableViewState="false" runat="server" Visible='<%#Not Eval("HasDiagnostic") Or Eval("DiagnosticScore").ToString = "" Or Eval("DiagnosticScore").ToString = "0"%>' Text="-"></asp:Label>
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="Passes" Settings-AllowHeaderFilter="False" Caption="Assess" ReadOnly="True" VisibleIndex="12">
                <DataItemTemplate>
                    <asp:Label ID="Label2" EnableViewState="false" runat="server" Visible='<%# Eval("IsAssessed") %>' Text='<%# Eval("Passes") & "/" & Eval("Sections") %>'></asp:Label>
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
         
            
        </Columns>
        <SettingsSearchPanel Visible="True" />
    </dx:BootstrapGridView>
   <%-- <asp:GridView ID="gvCurrentCourses" CssClass="table table-striped" EmptyDataText="You have no current courses. View the <a href='available.aspx'>Avaliable</a> courses tab to start one." AllowSorting="True" HeaderStyle-CssClass="sorted-none" GridLines="None" runat="server" AutoGenerateColumns="False" DataKeyNames="ProgressID" DataSourceID="dsCompletedCourses">
        <Columns>
            <asp:TemplateField HeaderText="" InsertVisible="False" SortExpression="ProgressID">
                <ItemTemplate>
                     <asp:LinkButton ID="lbtLaunch" CssClass="btn btn-success" tooltip="Launch Course" CommandName="Launch" CommandArgument='<%#Eval("CustomisationID")%>' runat="server"><i aria-hidden="true" class="fas fa-play"></i></asp:LinkButton>
                     <asp:LinkButton ID="lbtEval" CssClass="btn btn-info" ToolTip="Evaluate" Visible='<%# Eval("HasLearning") And Eval("Evaluated").ToString.Length = 0 %>' CommandName="Certificate" CommandArgument='<%#Eval("CustomisationID")%>' runat="server"><i aria-hidden="true" class="lpicon-assignment_turned_in"></i></asp:LinkButton>
                    <asp:LinkButton ID="lbtCert" CssClass="btn btn-primary" ToolTip="View / Print Certificate" Visible='<%# Eval("IsAssessed") And (Eval("Evaluated").ToString.Length > 0 Or Not Eval("HasLearning")) %>' CommandName="Certificate" CommandArgument='<%#Eval("CustomisationID")%>' runat="server"><i aria-hidden="true" class="lpicon-award"></i></asp:LinkButton>
                  
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Course" SortExpression="CourseName">
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("CourseName") %>'></asp:Label> <asp:LinkButton ID="lbtUnlockRequest" CssClass="btn btn-outline-secondary" Visible='<%# Eval("PLLocked") %>' ToolTip="Assessment limit reached - request unlock" runat="server"><i aria-hidden="true" class="fas fa-lock"></i></asp:LinkButton>
                   
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Content" SortExpression="CourseName">
                <ItemTemplate>
                     <span class="text-info small">
                     <asp:Label ID="Label5" Visible='<%# Eval("HasDiagnostic") %>' runat="server" ToolTip="Includes Diagnostic Assessment"><i aria-hidden="true" class="glyphicon glyphicon-screenshot"></i></asp:Label>&nbsp;
                    <asp:Label ID="Label6" Visible='<%# Eval("HasLearning") %>' runat="server" ToolTip="Includes Learning Content"><i aria-hidden="true" class="fas fa-book"></i></asp:Label>&nbsp;
                    <asp:Label ID="Label7" Visible='<%# Eval("IsAssessed") %>' runat="server" ToolTip="Includes Post Learning Assessment and Certification"><i aria-hidden="true" class="fas fa-graduation-cap"></i></asp:Label>&nbsp;
                    </span>
                    </ItemTemplate>
            </asp:TemplateField>
            
            <asp:BoundField DataField="StartedDate" HeaderText="Enrolled" SortExpression="StartedDate" DataFormatString="{0:d}" />
            <asp:BoundField DataField="Completed" DataFormatString="{0:d}" HeaderText="Completed" SortExpression="Completed" />
            
            <asp:TemplateField HeaderText="Evaluated" SortExpression="Evaluated">
               
                <ItemTemplate>
                  
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField AccessibleHeaderText="Diagnostic Score" HeaderText="<i aria-hidden='true' title='Diagnostic Score' class='glyphicon-screenshot'></i>" SortExpression="DiagnosticScore">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Visible='<%#Eval("HasDiagnostic") And Not Eval("DiagnosticScore").ToString = "" And Not Eval("DiagnosticScore").ToString = "0"%>' Text='<%# Eval("DiagnosticScore") & "%" %>'></asp:Label>
                    <asp:Label ID="Label3" runat="server" Visible='<%#Not Eval("HasDiagnostic") Or Eval("DiagnosticScore").ToString = "" Or Eval("DiagnosticScore").ToString = "0"%>' Text="-"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField AccessibleHeaderText="Assessments Passed" HeaderText="<i aria-hidden='true' title='Assessment Passes' class='glyphicon-education'></i>" SortExpression="Passes">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Visible='<%# Eval("IsAssessed") %>' Text='<%# Eval("Passes") & "/" & Eval("Sections") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            
        </Columns>

<HeaderStyle CssClass="sorted-none"></HeaderStyle>
    </asp:GridView>--%>
</asp:Content>
