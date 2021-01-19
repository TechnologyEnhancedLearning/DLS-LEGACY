<%@ Page Title="Available Courses" Language="vb" AutoEventWireup="false" MasterPageFile="~/learningportal/lportal.Master" CodeBehind="Available.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.Available" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FeaturedContent" runat="server">
    <h2>Available Courses</h2>
    
    <hr />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ObjectDataSource ID="dsAvailable" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.LearnerPortalTableAdapters.GetActiveAvailableCustomisationsForCentreFiltered_V3TableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
            <asp:SessionParameter SessionField="learnCandidateID" Name="CandidateID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <dx:BootstrapGridView ID="bsgvAvailable" runat="server" DataSourceID="dsAvailable" Settings-GridLines="None" AutoGenerateColumns="False" KeyFieldName="CustomisationID" SettingsBootstrap-Sizing="Large">
        <CssClasses Table="table table-striped" />

<SettingsBootstrap Sizing="Large"></SettingsBootstrap>

                        <Settings ShowHeaderFilterButton="True" />
                        <SettingsCookies Enabled="True" Version="0.1" StoreFiltering="False" StorePaging="False" StoreSearchPanelFiltering="False" />
                        <SettingsPager PageSize="15">
                        </SettingsPager>
        <Columns>
            
         <dx:BootstrapGridViewTextColumn VisibleIndex="0">
             <DataItemTemplate>
                  <asp:LinkButton EnableViewState="false" ID="lbtEnroll" Visible='<%# Eval("DelegateStatus") = 0 Or Eval("DelegateStatus") = 4 %>' CssClass="btn btn-primary" ToolTip="Enrol on Course" OnCommand="lbtEnroll_Command" CommandArgument='<%#Eval("CustomisationID")%>' runat="server"><i aria-hidden="true" class="fas fa-plus"></i></asp:LinkButton>
                    <asp:LinkButton EnableViewState="false" ID="lbtReEnroll" Visible='<%# Eval("DelegateStatus") = 1 %>' CssClass="btn btn-info" ToolTip="You started this Course previously. Click to re-enrol" OnCommand="lbtEnroll_Command" CommandArgument='<%#Eval("CustomisationID")%>' runat="server"><i aria-hidden="true" class="fas fa-sync-alt"></i></asp:LinkButton>
              </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="CourseName" Settings-AllowHeaderFilter="False" Caption="Course" ReadOnly="True" VisibleIndex="1">
<Settings AllowHeaderFilter="False"></Settings>
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
            <dx:BootstrapGridViewTextColumn FieldName="Brand" ReadOnly="True" VisibleIndex="4">
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="Category" ReadOnly="True" VisibleIndex="5">
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:BootstrapGridViewTextColumn>
            
            
            <dx:BootstrapGridViewTextColumn FieldName="Topic" VisibleIndex="6">
                <SettingsHeaderFilter Mode="CheckedList">
                </SettingsHeaderFilter>
            </dx:BootstrapGridViewTextColumn>
            
            
        </Columns>
        <SettingsSearchPanel Visible="True" />
    </dx:BootstrapGridView>
    

    <script>
    $(document).ready(function() {
        $('.bs-multi').multiselect({
            buttonText: function (options, select) {
                if (options.length === 0) {
                    return 'Any';
                }
                else if (options.length > 3) {
                    return options.length + ' options selected';
                }
                else {
                    var labels = [];
                    options.each(function () {
                        if ($(this).attr('label') !== undefined) {
                            labels.push($(this).attr('label'));
                        }
                        else {
                            labels.push($(this).html());
                        }
                    });
                    return labels.join(', ') + '';
                }
            }
        });
    });
</script>
</asp:Content>
