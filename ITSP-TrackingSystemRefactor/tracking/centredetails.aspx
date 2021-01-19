<%@ Page Title="Centre Configuration" Language="vb" AutoEventWireup="false" MasterPageFile="~/tracking/Site.Master" CodeBehind="centredetails.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.centredetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="breadtray" runat="server">
    <link  href="../Content/fileup.css" rel="stylesheet" />
    <script src="../Scripts/gmap.js"></script>
    <ol class="breadcrumb breadcrumb-slash">
        <li class="breadcrumb-item"><a href="dashboard">Centre </a></li>
        <li class="breadcrumb-item active">Configuration</li>
    </ol>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HiddenField ID="hfLattitude" ClientIDMode="Static" Value="0" runat="server" />
    <asp:HiddenField ID="hfLongitude" ClientIDMode="Static" Value="0" runat="server" />
     <asp:ObjectDataSource ID="CentreDataSource" runat="server"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.CentreDashboardTableAdapter"
        UpdateMethod="Update" DeleteMethod="Delete" InsertMethod="Insert">
        <UpdateParameters>
            <asp:Parameter Name="RegionID" Type="Int32" />
            <asp:Parameter Name="Active" Type="Boolean" />
            <asp:Parameter Name="CentreName" Type="String" />
            <asp:Parameter Name="ContactForename" Type="String" />
            <asp:Parameter Name="ContactSurname" Type="String" />
            <asp:Parameter Name="ContactEmail" Type="String" />
            <asp:Parameter Name="ContactTelephone" Type="String" />
            <asp:Parameter Name="BannerText" Type="String" />
            <asp:Parameter Name="F1Mandatory" Type="Boolean" />
            <asp:Parameter Name="F1Options" Type="String" />
            <asp:Parameter Name="F2Mandatory" Type="Boolean" />
            <asp:Parameter Name="F2Options" Type="String" />
            <asp:Parameter Name="F3Mandatory" Type="Boolean" />
            <asp:Parameter Name="F3Options" Type="String" />
            <asp:Parameter Name="LastChecked" Type="DateTime" />
            <asp:Parameter Name="pwTelephone" Type="String" />
            <asp:Parameter Name="pwEmail" Type="String" />
            <asp:Parameter Name="pwPostCode" Type="String" />
            <asp:Parameter Name="pwHours" Type="String" />
            <asp:Parameter Name="pwWebURL" Type="String" />
            <asp:Parameter Name="pwTrustsCovered" Type="String" />
            <asp:Parameter Name="pwTrainingLocations" Type="String" />
            <asp:Parameter Name="pwGeneralInfo" Type="String" />
            <asp:Parameter Name="Longitude" Type="Double" />
            <asp:Parameter Name="Lat" Type="Double" />
            <asp:Parameter Name="NotifyEmail" Type="String" />
            <asp:Parameter Name="IPPrefix" Type="String" />
            <asp:Parameter Name="CustomField1PromptID" Type="Int32" />
            <asp:Parameter Name="CustomField2PromptID" Type="Int32" />
            <asp:Parameter Name="CustomField3PromptID" Type="Int32" />
            <asp:Parameter Name="CustomField4PromptID" Type="Int32" />
            <asp:Parameter Name="F4Options" Type="String" />
            <asp:Parameter Name="F4Mandatory" Type="Boolean" />
            <asp:Parameter Name="CustomField5PromptID" Type="Int32" />
            <asp:Parameter Name="F5Options" Type="String" />
            <asp:Parameter Name="F5Mandatory" Type="Boolean" />
            <asp:Parameter Name="CustomField6PromptID" Type="Int32" />
            <asp:Parameter Name="F6Options" Type="String" />
            <asp:Parameter Name="F6Mandatory" Type="Boolean" />
            <asp:Parameter Name="Original_CentreID" Type="Int32" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_CentreID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="RegionID" Type="Int32" />
            <asp:Parameter Name="Active" Type="Boolean" />
            <asp:Parameter Name="CentreName" Type="String" />
            <asp:Parameter Name="ContactForename" Type="String" />
            <asp:Parameter Name="ContactSurname" Type="String" />
            <asp:Parameter Name="ContactEmail" Type="String" />
            <asp:Parameter Name="ContactTelephone" Type="String" />
            <asp:Parameter Name="BannerText" Type="String" />
            <asp:Parameter Name="F1Mandatory" Type="Boolean" />
            <asp:Parameter Name="F1Options" Type="String" />
            <asp:Parameter Name="F2Mandatory" Type="Boolean" />
            <asp:Parameter Name="F2Options" Type="String" />
            <asp:Parameter Name="F3Mandatory" Type="Boolean" />
            <asp:Parameter Name="F3Options" Type="String" />
            <asp:Parameter Name="LastChecked" Type="DateTime" />
            <asp:Parameter Name="pwTelephone" Type="String" />
            <asp:Parameter Name="pwEmail" Type="String" />
            <asp:Parameter Name="pwPostCode" Type="String" />
            <asp:Parameter Name="pwHours" Type="String" />
            <asp:Parameter Name="pwWebURL" Type="String" />
            <asp:Parameter Name="pwTrustsCovered" Type="String" />
            <asp:Parameter Name="pwTrainingLocations" Type="String" />
            <asp:Parameter Name="pwGeneralInfo" Type="String" />
            <asp:Parameter Name="Longitude" Type="Double" />
            <asp:Parameter Name="Lat" Type="Double" />
            <asp:Parameter Name="NotifyEmail" Type="String" />
            <asp:Parameter Name="IPPrefix" Type="String" />
            <asp:Parameter Name="CustomField1PromptID" Type="Int32" />
            <asp:Parameter Name="CustomField2PromptID" Type="Int32" />
            <asp:Parameter Name="CustomField3PromptID" Type="Int32" />
            <asp:Parameter Name="CustomField4PromptID" Type="Int32" />
            <asp:Parameter Name="F4Options" Type="String" />
            <asp:Parameter Name="F4Mandatory" Type="Boolean" />
            <asp:Parameter Name="CustomField5PromptID" Type="Int32" />
            <asp:Parameter Name="F5Options" Type="String" />
            <asp:Parameter Name="F5Mandatory" Type="Boolean" />
            <asp:Parameter Name="CustomField6PromptID" Type="Int32" />
            <asp:Parameter Name="F6Options" Type="String" />
            <asp:Parameter Name="F6Mandatory" Type="Boolean" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="UserCentreID" Name="CentreID" SessionField="UserCentreID"
                Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="AdminCategoryID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
     <asp:ObjectDataSource ID="dsCustomPrompts" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActive" TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.CustomPromptsTableAdapter"></asp:ObjectDataSource>
   
    <asp:FormView ID="fvEditcentreDetails" RenderOuterTable="False" runat="server" DataKeyNames="CentreID"
                    DataSourceID="CentreDataSource">
        <ItemTemplate>
            
            <div class="row">
                                <div class="col col-sm-12">
                                    <div class="card mb-2 card-default">
                                        <div class="card-header"><h5 class="card-title">Centre DLS Details<asp:LinkButton ID="EditButton" runat="server" CausesValidation="False"
                                CommandName="Edit" CssClass="btn btn-primary float-right"><i aria-hidden="true" class="fas fa-edit"></i> Edit</asp:LinkButton></h5></div>
                                        <div class="card-body">
                                            <div class="m-3">
                                                <div class="form-group row">
                                                    <asp:Label ID="RegionNameLabel" AssociatedControlID="tbRegionName" runat="server" CssClass="col col-sm-4 control-label">Region:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbRegionName" Enabled="false" CssClass="form-control input-sm" runat="server" Text='<%# Eval("RegionName") %>' />
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label4" AssociatedControlID="tbCentreName" runat="server" CssClass="col col-sm-4 control-label">Centre Name:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbCentreName" Enabled="false" CssClass="form-control input-sm" runat="server" Text='<%# Bind("CentreName") %>' />
                                                    </div>
                                                </div>

                                                <hr />
                                                <h4>Centre Manager</h4>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label6" AssociatedControlID="ContactForenameTextBox" runat="server" CssClass="col col-sm-4 control-label">Forename:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="ContactForenameTextBox" Enabled="false" runat="server" MaxLength="250"
                                                            Text='<%# Bind("ContactForename") %>' CssClass="form-control input-sm" />
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label7" AssociatedControlID="ContactSurnameTextBox" runat="server" CssClass="col col-sm-4 control-label">Surname:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="ContactSurnameTextBox" Enabled="false" runat="server" MaxLength="250"
                                                            Text='<%# Bind("ContactSurname") %>' CssClass="form-control input-sm" />
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label5" runat="server" AssociatedControlID="tbEmail" CssClass="col col-sm-4 control-label">Email:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbEmail" Enabled="false" runat="server" MaxLength="250" Text='<%# Bind("ContactEmail") %>' CssClass="form-control input-sm" />
                                                      
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label8" AssociatedControlID="ContactTelephoneTextBox" runat="server" CssClass="col col-sm-4 control-label">Telephone:</asp:Label>

                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="ContactTelephoneTextBox" Enabled="false" runat="server" MaxLength="250" CssClass="form-control input-sm"
                                                            Text='<%# Bind("ContactTelephone") %>' />
                                                    </div>
                                                </div>
                                                <hr />
                                                <div class="form-group row">
                                                    <asp:Label ID="Label9" AssociatedControlID="tbNotifyEmail" runat="server" CssClass="col col-sm-4 control-label">Notify Email:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbNotifyEmail" Enabled="false" runat="server" MaxLength="100" Text='<%# Bind("NotifyEmail") %>' CssClass="form-control input-sm" />

                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label10" AssociatedControlID="BannerTextTextBox" runat="server" CssClass="col col-sm-4 control-label">Banner text:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="BannerTextTextBox" Enabled="false" runat="server" Width="245px" MaxLength="100" Text='<%# Bind("BannerText") %>' CssClass="form-control input-sm" />

                                                    </div>
                                                </div>
                                                </div>
                                            </div
                                            </div></div>
                                    <div class="card mb-2 card-default">
                                        <div class="card-header"><h5 class="card-title">Registration Prompts for Delegates<asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False"
                                CommandName="Edit" CssClass="btn btn-primary float-right"><i aria-hidden="true" class="fas fa-edit"></i> Edit</asp:LinkButton></h5></div>
                                        <div class="card-body">
                                                <div class="form-group row">
                                                    <asp:Label ID="Label11" AssociatedControlID="ddCustomPrompt1" runat="server" CssClass="col col-sm-4 control-label">Prompt 1:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <div class="input-group">
                                                             <div class="input-group-prepend">
    <div class="input-group-text">
                                                                <asp:CheckBox ID="Field1Mandatory" Enabled="false" runat="server" Checked='<%#Bind("F1Mandatory")%>'
                                                                    ToolTip="Mandatory?" />

                                                           </div></div>
                                                            
                                                            <asp:DropDownList CssClass="form-control input-sm" AppendDataBoundItems="True" Enabled="false" ID="ddCustomPrompt1" DataSourceID="dsCustomPrompts" SelectedValue='<%# Bind("CustomField1PromptID") %>' DataValueField="CustomPromptID" DataTextField="CustomPrompt" runat="server">
                                                                <asp:ListItem Value="0" Text="Unused"></asp:ListItem>
                                                            </asp:DropDownList>
                                                            
                                                        </div>
                                                        <asp:TextBox ID="F1OptionsText" runat="server" CssClass="form-control input-sm" Enabled="false" Rows="3" TextMode="MultiLine" placeholder="Optional. Enter response options on separate lines (max 4000 characters)."
                                                            Text='<%# Bind("F1Options") %>' />
                                                        
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label12" AssociatedControlID="ddCustomPrompt2" runat="server" CssClass="col col-sm-4 control-label">Prompt 2:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <div class="input-group">
                                                             <div class="input-group-prepend">
    <div class="input-group-text">
                                                                <asp:CheckBox ID="Field2Mandatory" Enabled="false" CssClass="centresInfo" runat="server" Checked='<%#Bind("F2Mandatory")%>'
                                                                    ToolTip="Mandatory" />
                                                            </div></div>
                                                            <asp:DropDownList AppendDataBoundItems="True" Enabled="false" CssClass="form-control input-sm"  ID="ddCustomPrompt2" DataSourceID="dsCustomPrompts" SelectedValue='<%# Bind("CustomField2PromptID") %>' DataValueField="CustomPromptID" DataTextField="CustomPrompt" runat="server">
                                                                <asp:ListItem Value="0" Text="Unused"></asp:ListItem>
                                                            </asp:DropDownList>
                                                            
                                                        </div>
                                                        <asp:TextBox ID="F2OptionsText" runat="server" Enabled="false" CssClass="form-control input-sm" placeholder="Optional. Enter response options on separate lines (max 4000 characters)." Rows="3" TextMode="MultiLine"
                                                            Text='<%# Bind("F2Options") %>' />
                                                        
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label13" AssociatedControlID="ddCustomPrompt3" runat="server" CssClass="col col-sm-4 control-label">Prompt 3:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <div class="input-group">
                                                             <div class="input-group-prepend">
    <div class="input-group-text">
                                                                <asp:CheckBox ID="Field3Mandatory" Enabled="false" CssClass="centresInfo" runat="server" Checked='<%#Bind("F3Mandatory")%>'
                                                                    ToolTip="Mandatory" />
                                                           </div></div>
                                                            <asp:DropDownList Enabled="false" CssClass="form-control input-sm" AppendDataBoundItems="true"  ID="ddCustomPrompt3" DataSourceID="dsCustomPrompts" SelectedValue='<%# Bind("CustomField3PromptID") %>' DataValueField="CustomPromptID" DataTextField="CustomPrompt" runat="server">
                                                                <asp:ListItem Value="0" Text="Unused"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                        <asp:TextBox ID="F3OptionsText" Enabled="false" runat="server" Rows="3" TextMode="MultiLine"
                                                            Text='<%# Bind("F3Options") %>' CssClass="form-control input-sm" placeholder="Optional. Enter response options on separate lines (max 4000 characters)." />
                                                        
                                                    </div>
                                                </div>
                                            <div class="form-group row">
                                                    <asp:Label ID="Label1" AssociatedControlID="ddCustomPrompt4" runat="server" CssClass="col col-sm-4 control-label">Prompt 4:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <div class="input-group">
                                                             <div class="input-group-prepend">
    <div class="input-group-text">
                                                                <asp:CheckBox ID="Field4Mandatory" Enabled="false" CssClass="centresInfo" runat="server" Checked='<%#Bind("F4Mandatory")%>'
                                                                    ToolTip="Mandatory" />
                                                           </div></div>
                                                            <asp:DropDownList CssClass="form-control input-sm" Enabled="false" AppendDataBoundItems="true"  ID="ddCustomPrompt4" DataSourceID="dsCustomPrompts" SelectedValue='<%# Bind("CustomField4PromptID") %>' DataValueField="CustomPromptID" DataTextField="CustomPrompt" runat="server">
                                                                <asp:ListItem Value="0" Text="Unused"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                        <asp:TextBox ID="F4OptionsText" Enabled="false" runat="server" Rows="3" TextMode="MultiLine"
                                                            Text='<%# Bind("F4Options") %>' CssClass="form-control input-sm" placeholder="Optional. Enter response options on separate lines." />
                                                        
                                                    </div>
                                                </div>
												<div class="form-group row">
                                                    <asp:Label ID="Label2" AssociatedControlID="ddCustomPrompt5" runat="server" CssClass="col col-sm-4 control-label">Prompt 5:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <div class="input-group">
                                                             <div class="input-group-prepend">
    <div class="input-group-text">
                                                                <asp:CheckBox ID="Field5Mandatory" Enabled="false" CssClass="centresInfo" runat="server" Checked='<%#Bind("F5Mandatory")%>'
                                                                    ToolTip="Mandatory" />
                                                           </div></div>
                                                            <asp:DropDownList Enabled="false" CssClass="form-control input-sm" AppendDataBoundItems="true"  ID="ddCustomPrompt5" DataSourceID="dsCustomPrompts" SelectedValue='<%# Bind("CustomField5PromptID") %>' DataValueField="CustomPromptID" DataTextField="CustomPrompt" runat="server">
                                                                <asp:ListItem Value="0" Text="Unused"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                        <asp:TextBox ID="F5OptionsText" Enabled="false" runat="server" Rows="3" TextMode="MultiLine"
                                                            Text='<%# Bind("F5Options") %>' CssClass="form-control input-sm" placeholder="Optional. Enter response options on separate lines." />
                                                        
                                                    </div>
                                                </div>
												<div class="form-group row">
                                                    <asp:Label ID="Label3" AssociatedControlID="ddCustomPrompt6" runat="server" CssClass="col col-sm-4 control-label">Prompt 6:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <div class="input-group">
                                                             <div class="input-group-prepend">
    <div class="input-group-text">
                                                                <asp:CheckBox ID="Field6Mandatory" Enabled="false" CssClass="centresInfo" runat="server" Checked='<%#Bind("F6Mandatory")%>'
                                                                    ToolTip="Mandatory" />
                                                           </div></div>
                                                            <asp:DropDownList Enabled="false" CssClass="form-control input-sm" AppendDataBoundItems="true"  ID="ddCustomPrompt6" DataSourceID="dsCustomPrompts" SelectedValue='<%# Bind("CustomField6PromptID") %>' DataValueField="CustomPromptID" DataTextField="CustomPrompt" runat="server">
                                                                <asp:ListItem Value="0" Text="Unused"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                        <asp:TextBox Enabled="false" ID="F6OptionsText" runat="server" Rows="3" TextMode="MultiLine"
                                                            Text='<%# Bind("F6Options") %>' CssClass="form-control input-sm" placeholder="Optional. Enter response options on separate lines." />
                                                        
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                
                                    <div class="card card-default">
                                        <div class="card-header"><h5 class="card-title">DLS Website Centre Information<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False"
                                CommandName="Edit" CssClass="btn btn-primary float-right"><i aria-hidden="true" class="fas fa-edit"></i> Edit</asp:LinkButton></h5></div>
                                        <div class="card-body">
                                            <div class="m-3">
                                                <div class="alert alert-warning" role="alert"><b>Note:</b> The details entered below will be published on the <a href='https://www.dls.nhs.uk/landing-preview/findyourcentre' target='_blank'>Digital Learning Solutions website</a>.</div>

                                                <div class="form-group row">
                                                    <asp:Label ID="Label17" AssociatedControlID="tbPwTelephone" runat="server" CssClass="col col-sm-4 control-label">Centre telephone:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbPwTelephone" Enabled="false" runat="server" MaxLength="100" Text='<%# Bind("pwTelephone") %>'
                                                            CausesValidation="True" CssClass="form-control input-sm" />

                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label18" AssociatedControlID="tbPwEmail" runat="server" CssClass="col col-sm-4 control-label">Centre email:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbPwEmail" Enabled="false" runat="server" MaxLength="100" CssClass="form-control input-sm" Text='<%# Bind("pwEmail") %>' />
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label19" AssociatedControlID="tbPwPostCode" runat="server" CssClass="col col-sm-4 control-label">Centre postcode:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        
                                                        <asp:TextBox ID="tbPwPostCode" Enabled="false" ClientIDMode="Static" runat="server" MaxLength="100" CssClass="form-control input-sm" Text='<%# Bind("pwPostCode") %>'
                                                            CausesValidation="True" />
                                                            
                                                        <div class="row">
                                                            <div class="col col-sm-6">
                                                                <div class="input-group">
  <div class="input-group-prepend">
    <span class="input-group-text">Longitude:</span>
  </div>
                                                                <asp:TextBox ID="tbLongitude" placeholder="long" ClientIDMode="Static" CssClass="form-control input-sm" runat="server" Text='<%# Bind("Longitude") %>' Enabled="false"></asp:TextBox>
                                                                    </div>
                                                            </div>
                                                            <div class="col col-sm-6">
                                                                 <div class="input-group">
  <div class="input-group-prepend">
    <span class="input-group-text">Latitude:</span>
  </div>
                                                                <asp:TextBox ID="tbLattitude" placeholder="lat" ClientIDMode="Static" runat="server" Text='<%# Bind("Lat") %>' CssClass="form-control input-sm" Enabled="False"></asp:TextBox>
                                                                     </div>
                                                            </div></div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label20" AssociatedControlID="tbPwHours" runat="server" CssClass="col col-sm-4 control-label">Opening hours:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbPwHours" Enabled="false" runat="server" MaxLength="100" Text='<%# Bind("pwHours") %>' CssClass="form-control input-sm" />
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label21" AssociatedControlID="tbPwWebURL" runat="server" CssClass="col col-sm-4 control-label">Centre web address:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbPwWebURL" Enabled="false" runat="server" MaxLength="100" Text='<%# Bind("pwWebURL") %>' CssClass="form-control input-sm" />
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label22" AssociatedControlID="tbPwTrustsCovered" runat="server" CssClass="col col-sm-4 control-label">Organisations covered:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox runat="server" Enabled="false" ID="tbPwTrustsCovered" TextMode="MultiLine"
                                                            Rows="3" Text='<%# Bind("pwTrustsCovered") %>' CssClass="form-control input-sm" />
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label23" AssociatedControlID="tbPwTrainingLocations" runat="server" CssClass="col col-sm-4 control-label">Training venues:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbPwTrainingLocations" Enabled="false" CssClass="form-control input-sm" runat="server" Text='<%# Bind("pwTrainingLocations") %>'
                                                            TextMode="MultiLine" Rows="3" />
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label24" AssociatedControlID="tbPwGeneralInfo" runat="server" CssClass="col col-sm-4 control-label">Other information:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbPwGeneralInfo" Enabled="false" runat="server" Text='<%# Bind("pwGeneralInfo") %>'
                                                            TextMode="MultiLine" Rows="3" CssClass="form-control input-sm" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
        </ItemTemplate>
                    <EditItemTemplate>
                        <asp:HiddenField ID="HiddenField2" Value='<%# Bind("Active") %>' runat="server" />
                        <asp:HiddenField ID="HiddenField1" Value='<%# Bind("IPPrefix") %>' runat="server" />
                            <div class="row">
                                <div class="col col-sm-12">
                                    <div class="card mb-2 card-primary">
                                        <div class="card-header"><h5 class="card-title">Edit Centre DLS Details</h5></div>
                                        <div class="card-body">
                                            <div class="m-3">
                                                <div class="form-group row">
                                                    <asp:Label ID="RegionNameLabel" AssociatedControlID="tbRegionName" runat="server" CssClass="col col-sm-4 control-label">Region:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbRegionName" Enabled="false" CssClass="form-control input-sm" runat="server" Text='<%# Eval("RegionName") %>' />
                                                        <asp:HiddenField ID="hfRegionID" Value='<%# Bind("RegionID") %>' runat="server" />
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label4" AssociatedControlID="tbCentreName" runat="server" CssClass="col col-sm-4 control-label">Centre Name:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbCentreName" Enabled="false" CssClass="form-control input-sm" runat="server" Text='<%# Bind("CentreName") %>' />
                                                    </div>
                                                </div>

                                                <hr />
                                                <h4>Centre Manager</h4>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label6" AssociatedControlID="ContactForenameTextBox" runat="server" CssClass="col col-sm-4 control-label">Forename:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="ContactForenameTextBox" runat="server" MaxLength="250"
                                                            Text='<%# Bind("ContactForename") %>' CssClass="form-control input-sm" />
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label7" AssociatedControlID="ContactSurnameTextBox" runat="server" CssClass="col col-sm-4 control-label">Surname:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="ContactSurnameTextBox" runat="server" MaxLength="250"
                                                            Text='<%# Bind("ContactSurname") %>' CssClass="form-control input-sm" />
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label5" runat="server" AssociatedControlID="tbEmail" CssClass="col col-sm-4 control-label">Email:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbEmail" runat="server" MaxLength="250" Text='<%# Bind("ContactEmail") %>' CssClass="form-control input-sm" />
                                                        <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator1" Display="Dynamic"
                                                            ValidationGroup="vgEditCentre" ControlToValidate="tbEmail" ValidationExpression="[a-za-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-za-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-za-zA-Z0-9](?:[a-za-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-za-zA-Z0-9](?:[a-za-zA-Z0-9-]*[a-za-zA-Z0-9])?"
                                                            ErrorMessage="A valid email address must be provided" SetFocusOnError="true" />
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label8" AssociatedControlID="ContactTelephoneTextBox" runat="server" CssClass="col col-sm-4 control-label">Telephone:</asp:Label>

                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="ContactTelephoneTextBox" runat="server" MaxLength="250" CssClass="form-control input-sm"
                                                            Text='<%# Bind("ContactTelephone") %>' />
                                                        <asp:RequiredFieldValidator runat="server" ID="rfvContactTelephone" Display="Dynamic" ValidationGroup="vgEditCentre" ErrorMessage="Required" ControlToValidate="ContactTelephoneTextBox"></asp:RequiredFieldValidator>
                                                    </div>
                                                </div>
                                                <hr />
                                                <div class="form-group row">
                                                    <asp:Label ID="Label9" AssociatedControlID="tbNotifyEmail" runat="server" CssClass="col col-sm-4 control-label">Notify Email:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbNotifyEmail" runat="server" MaxLength="100" Text='<%# Bind("NotifyEmail") %>' CssClass="form-control input-sm" />
                                                        <asp:RegularExpressionValidator runat="server" ID="revNotifyEmail" Display="Dynamic"
                                                            ValidationGroup="vgEditCentre" ControlToValidate="tbNotifyEmail" ValidationExpression="[a-za-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-za-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-za-zA-Z0-9](?:[a-za-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?"
                                                            ErrorMessage="A valid email address must be provided" SetFocusOnError="true" />
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label10" AssociatedControlID="BannerTextTextBox" runat="server" CssClass="col col-sm-4 control-label">Banner text:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="BannerTextTextBox" runat="server" Width="245px" MaxLength="100" Text='<%# Bind("BannerText") %>' CssClass="form-control input-sm" />
                                                        <asp:RegularExpressionValidator runat="server" ID="valBannerText" Display="Dynamic"
                                                            ValidationGroup="vgEditCentre" ControlToValidate="BannerTextTextBox" ValidationExpression=".{0,100}"
                                                            ErrorMessage="Banner text must be up to 100 characters long" SetFocusOnError="true" />
                                                    </div>
                                                </div>
                                                </div>
                                            </div
                                            </div></div>
                                    <div class="card mb-2 card-primary">
                                        <div class="card-header"><h5 class="card-title">Edit Registration Prompts for Delegates</h5></div>
                                        <div class="card-body">
                                                <div class="alert alert-warning" role="alert"><b>Note:</b> Existing answers may be invalid if you change the prompts.</div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label11" AssociatedControlID="ddCustomPrompt1" runat="server" CssClass="col col-sm-4 control-label">Prompt 1:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <div class="input-group">
                                                             <div class="input-group-prepend">
    <div class="input-group-text">
                                                                <asp:CheckBox ID="Field1Mandatory" runat="server" Checked='<%#Bind("F1Mandatory")%>'
                                                                    ToolTip="Mandatory?" />

                                                           </div></div>
                                                            
                                                            <asp:DropDownList CssClass="form-control input-sm" AppendDataBoundItems="True"  ID="ddCustomPrompt1" DataSourceID="dsCustomPrompts" SelectedValue='<%# Bind("CustomField1PromptID") %>' DataValueField="CustomPromptID" DataTextField="CustomPrompt" runat="server">
                                                                <asp:ListItem Value="0" Text="Unused"></asp:ListItem>
                                                            </asp:DropDownList>
                                                            
                                                        </div>
                                                        <asp:TextBox ID="F1OptionsText" runat="server" CssClass="form-control input-sm" Rows="3" TextMode="MultiLine" placeholder="Optional. Enter response options on separate lines (max 4000 characters)."
                                                            Text='<%# Bind("F1Options") %>' />
                                                        
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label12" AssociatedControlID="ddCustomPrompt2" runat="server" CssClass="col col-sm-4 control-label">Prompt 2:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <div class="input-group">
                                                             <div class="input-group-prepend">
    <div class="input-group-text">
                                                                <asp:CheckBox ID="Field2Mandatory" CssClass="centresInfo" runat="server" Checked='<%#Bind("F2Mandatory")%>'
                                                                    ToolTip="Mandatory" />
                                                            </div></div>
                                                            <asp:DropDownList AppendDataBoundItems="True" CssClass="form-control input-sm"  ID="ddCustomPrompt2" DataSourceID="dsCustomPrompts" SelectedValue='<%# Bind("CustomField2PromptID") %>' DataValueField="CustomPromptID" DataTextField="CustomPrompt" runat="server">
                                                                <asp:ListItem Value="0" Text="Unused"></asp:ListItem>
                                                            </asp:DropDownList>
                                                            
                                                        </div>
                                                        <asp:TextBox ID="F2OptionsText" runat="server" CssClass="form-control input-sm" placeholder="Optional. Enter response options on separate lines (max 4000 characters)." Rows="3" TextMode="MultiLine"
                                                            Text='<%# Bind("F2Options") %>' />
                                                        
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label13" AssociatedControlID="ddCustomPrompt3" runat="server" CssClass="col col-sm-4 control-label">Prompt 3:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <div class="input-group">
                                                             <div class="input-group-prepend">
    <div class="input-group-text">
                                                                <asp:CheckBox ID="Field3Mandatory" CssClass="centresInfo" runat="server" Checked='<%#Bind("F3Mandatory")%>'
                                                                    ToolTip="Mandatory" />
                                                           </div></div>
                                                            <asp:DropDownList CssClass="form-control input-sm" AppendDataBoundItems="true"  ID="ddCustomPrompt3" DataSourceID="dsCustomPrompts" SelectedValue='<%# Bind("CustomField3PromptID") %>' DataValueField="CustomPromptID" DataTextField="CustomPrompt" runat="server">
                                                                <asp:ListItem Value="0" Text="Unused"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                        <asp:TextBox ID="F3OptionsText" runat="server" Rows="3" TextMode="MultiLine"
                                                            Text='<%# Bind("F3Options") %>' CssClass="form-control input-sm" placeholder="Optional. Enter response options on separate lines (max 4000 characters)." />
                                                        
                                                    </div>
                                                </div>
                                            <div class="form-group row">
                                                    <asp:Label ID="Label1" AssociatedControlID="ddCustomPrompt4" runat="server" CssClass="col col-sm-4 control-label">Prompt 4:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <div class="input-group">
                                                             <div class="input-group-prepend">
    <div class="input-group-text">
                                                                <asp:CheckBox ID="Field4Mandatory" CssClass="centresInfo" runat="server" Checked='<%#Bind("F4Mandatory")%>'
                                                                    ToolTip="Mandatory" />
                                                           </div></div>
                                                            <asp:DropDownList CssClass="form-control input-sm" AppendDataBoundItems="true"  ID="ddCustomPrompt4" DataSourceID="dsCustomPrompts" SelectedValue='<%# Bind("CustomField4PromptID") %>' DataValueField="CustomPromptID" DataTextField="CustomPrompt" runat="server">
                                                                <asp:ListItem Value="0" Text="Unused"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                        <asp:TextBox ID="F4OptionsText" runat="server" Rows="3" TextMode="MultiLine"
                                                            Text='<%# Bind("F4Options") %>' CssClass="form-control input-sm" placeholder="Optional. Enter response options on separate lines." />
                                                        
                                                    </div>
                                                </div>
												<div class="form-group row">
                                                    <asp:Label ID="Label2" AssociatedControlID="ddCustomPrompt5" runat="server" CssClass="col col-sm-4 control-label">Prompt 5:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <div class="input-group">
                                                             <div class="input-group-prepend">
    <div class="input-group-text">
                                                                <asp:CheckBox ID="Field5Mandatory" CssClass="centresInfo" runat="server" Checked='<%#Bind("F5Mandatory")%>'
                                                                    ToolTip="Mandatory" />
                                                           </div></div>
                                                            <asp:DropDownList CssClass="form-control input-sm" AppendDataBoundItems="true"  ID="ddCustomPrompt5" DataSourceID="dsCustomPrompts" SelectedValue='<%# Bind("CustomField5PromptID") %>' DataValueField="CustomPromptID" DataTextField="CustomPrompt" runat="server">
                                                                <asp:ListItem Value="0" Text="Unused"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                        <asp:TextBox ID="F5OptionsText" runat="server" Rows="3" TextMode="MultiLine"
                                                            Text='<%# Bind("F5Options") %>' CssClass="form-control input-sm" placeholder="Optional. Enter response options on separate lines." />
                                                        
                                                    </div>
                                                </div>
												<div class="form-group row">
                                                    <asp:Label ID="Label3" AssociatedControlID="ddCustomPrompt6" runat="server" CssClass="col col-sm-4 control-label">Prompt 6:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <div class="input-group">
                                                             <div class="input-group-prepend">
    <div class="input-group-text">
                                                                <asp:CheckBox ID="Field6Mandatory" CssClass="centresInfo" runat="server" Checked='<%#Bind("F6Mandatory")%>'
                                                                    ToolTip="Mandatory" />
                                                           </div></div>
                                                            <asp:DropDownList CssClass="form-control input-sm" AppendDataBoundItems="true"  ID="ddCustomPrompt6" DataSourceID="dsCustomPrompts" SelectedValue='<%# Bind("CustomField6PromptID") %>' DataValueField="CustomPromptID" DataTextField="CustomPrompt" runat="server">
                                                                <asp:ListItem Value="0" Text="Unused"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                        <asp:TextBox ID="F6OptionsText" runat="server" Rows="3" TextMode="MultiLine"
                                                            Text='<%# Bind("F6Options") %>' CssClass="form-control input-sm" placeholder="Optional. Enter response options on separate lines." />
                                                        
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                
                                    <div class="card card-primary">
                                        <div class="card-header"><h5 class="card-title">Edit DLS Website Centre Information</h5></div>
                                        <div class="card-body">
                                            <div class="m-3">
                                                <div class="alert alert-warning" role="alert"><b>Note:</b> The details entered below will be published on the <a href='https://www.dls.nhs.uk/landing-preview/findyourcentre' target='_blank'>Digital Learning Solutions website</a>.</div>

                                                <div class="form-group row">
                                                    <asp:Label ID="Label17" AssociatedControlID="tbPwTelephone" runat="server" CssClass="col col-sm-4 control-label">Centre telephone:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbPwTelephone" runat="server" MaxLength="100" Text='<%# Bind("pwTelephone") %>'
                                                            CausesValidation="True" CssClass="form-control input-sm" />

                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label18" AssociatedControlID="tbPwEmail" runat="server" CssClass="col col-sm-4 control-label">Centre email:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbPwEmail" runat="server" MaxLength="100" CssClass="form-control input-sm" Text='<%# Bind("pwEmail") %>' />
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label19" AssociatedControlID="tbPwPostCode" runat="server" CssClass="col col-sm-4 control-label">Centre postcode:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <div class="input-group">
                                                        <asp:TextBox ID="tbPwPostCode" ClientIDMode="Static" runat="server" MaxLength="100" CssClass="form-control input-sm" Text='<%# Bind("pwPostCode") %>'
                                                            CausesValidation="True" /><%--<asp:RequiredFieldValidator
                                                                ID="rfvPostCode" runat="server" ControlToValidate="tbPwPostCode"
                                                                ValidationGroup="vgEditCentre" ToolTip="Centre postcode required (for map position)"
                                                                Text=" " ErrorMessage="Centre postcode required (for map position)" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                                                            <span class="input-group-append">
        <button class="btn btn-success" type="button" id="btnFind"><i aria-hidden="false" class="fas fa-map-marker"></i> Find</button>
      </span></div>
                                                        <div class="row">
                                                            <div class="col col-sm-6">
                                                                 <div class="input-group">
  <div class="input-group-prepend">
    <span class="input-group-text">Longitude:</span>
  </div>
                                                                <asp:TextBox ID="tbLongitude" placeholder="long" ClientIDMode="Static" CssClass="form-control input-sm" runat="server" Text='<%# Bind("Longitude") %>' Enabled="false"></asp:TextBox>
                                                                     </div>
                                                            </div>
                                                            <div class="col col-sm-6">
                                                                 <div class="input-group">
  <div class="input-group-prepend">
    <span class="input-group-text" >Latitude:</span>
  </div>
                                                                <asp:TextBox ID="tbLattitude" placeholder="lat" ClientIDMode="Static" runat="server" Text='<%# Bind("Lat") %>' CssClass="form-control input-sm" Enabled="False"></asp:TextBox>
                                                                     </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label20" AssociatedControlID="tbPwHours" runat="server" CssClass="col col-sm-4 control-label">Opening hours:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbPwHours" runat="server" MaxLength="100" Text='<%# Bind("pwHours") %>' CssClass="form-control input-sm" />
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label21" AssociatedControlID="tbPwWebURL" runat="server" CssClass="col col-sm-4 control-label">Centre web address:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbPwWebURL" runat="server" MaxLength="100" Text='<%# Bind("pwWebURL") %>' CssClass="form-control input-sm" />
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label22" AssociatedControlID="tbPwTrustsCovered" runat="server" CssClass="col col-sm-4 control-label">Organisations covered:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox runat="server" ID="tbPwTrustsCovered" TextMode="MultiLine"
                                                            Rows="3" Text='<%# Bind("pwTrustsCovered") %>' CssClass="form-control input-sm" />
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label23" AssociatedControlID="tbPwTrainingLocations" runat="server" CssClass="col col-sm-4 control-label">Training venues:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbPwTrainingLocations" CssClass="form-control input-sm" runat="server" Text='<%# Bind("pwTrainingLocations") %>'
                                                            TextMode="MultiLine" Rows="3" />
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <asp:Label ID="Label24" AssociatedControlID="tbPwGeneralInfo" runat="server" CssClass="col col-sm-4 control-label">Other information:</asp:Label>
                                                    <div class="col col-sm-8">
                                                        <asp:TextBox ID="tbPwGeneralInfo" runat="server" Text='<%# Bind("pwGeneralInfo") %>'
                                                            TextMode="MultiLine" Rows="3" CssClass="form-control input-sm" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        <div class="row mt-3">
                            <div class="col">
 <asp:LinkButton ID="lbtUpdateCancel" runat="server" CausesValidation="False" 
                                CommandName="Cancel" CssClass="btn btn-secondary float-left mr-auto">Cancel</asp:LinkButton>
                            
                            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" ValidationGroup="vgEditCentre"
                                CommandName="Update" CssClass="btn btn-primary float-right"><i aria-hidden="true" class="fas fa-check"></i> Submit</asp:LinkButton>
                            </div>
                        </div>
                       
                    </EditItemTemplate>

                </asp:FormView>
    <div class="row mt-3 mb-3">
        <div class="col col-md-6">
            <div class="card card-default">
                <div class="card-header clearfix">
                    Centre Logo
                    <asp:LinkButton ID="logoClear" ToolTip="Clear logo image" CssClass="btn btn-outline-secondary float-right"
                        runat="server" Text="Clear" />
                </div>
                <div class="card-body">
                    <asp:Panel ID="logoImagePanel" runat="server">
                        <br />
                        <asp:Image ID="logoImage" AlternateText="Organisation Logo" runat="server" ImageUrl="~/centrelogo" Height="100px"
                            Width="100%" />
                    </asp:Panel>
                    <asp:Panel ID="logoNotLoaded" runat="server">
                        <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-prepend">
                                <span class="btn btn-outline-secondary btn-file">Browse&hellip;
                                                <asp:FileUpload AllowMultiple="false" ID="fupCentreLogo" runat="server" />

                                </span>
                            </span>

                            <input type="text" class="form-control" readonly="true">
                            <span class="input-group-append">
                                <asp:LinkButton ID="lbtLogoUpload" CausesValidation="false" CssClass="btn btn-secondary" ToolTip="Upload Image as Logo" runat="server"><i aria-hidden="true" class="fas fa-file-upload"></i> Upload</asp:LinkButton>
                            </span>
                        </div></div>
                    </asp:Panel>
                    <asp:Label ID="logMessage" runat="server" Text=""></asp:Label>
                </div>
                <div class="card-footer clearfix">
                    <asp:Label ID="logDimensions" CssClass="float-left" runat="server" Text=""></asp:Label>
                </div>

            </div>
        </div>
        <div class="col col-md-6">
            <div class="card card-default">
                <div class="card-header clearfix">
                    Certificate Signature
                    <asp:LinkButton ID="lbtSignatureClear" ToolTip="Clear signature image"
                        CssClass="btn btn-outline-secondary float-right" runat="server" Text="Clear" />
                </div>
                <div class="card-body">
                    <asp:Panel ID="SignatureImagePanel" runat="server">
                        <asp:Image ID="SignatureImage" AlternateText="Centre Signature Image" runat="server" ImageUrl="~/centresignature" Height="100px"
                            Width="100%" />

                    </asp:Panel>
                    <asp:Panel ID="pnlSignatureNotLoaded" runat="server">
                        <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-prepend">
                                <span class="btn btn-outline-secondary btn-file">Browse&hellip;
                                                <asp:FileUpload AllowMultiple="false" ID="fupSigFile" runat="server" />

                                </span>
                            </span>

                            <input type="text" class="form-control" readonly="true">
                            <span class="input-group-append">
                                <asp:LinkButton ID="lbtSignatureUpload" CausesValidation="false" CssClass="btn btn-secondary" ToolTip="Upload Image as Signature" runat="server"><i aria-hidden="true" class="fas fa-file-upload"></i> Upload</asp:LinkButton>
                            </span>
                        </div></div>
                    </asp:Panel>
                    <asp:Label ID="sigMessage" runat="server" Text=""></asp:Label>
                </div>
                <div class="card-footer clearfix">
                    <asp:Label ID="SigDimensions" runat="server" CssClass="float-left" Text=""></asp:Label><asp:LinkButton ID="lbtPreview" ToolTip="Preview certificate with centre logo and signature settings"
                        CssClass="btn btn-outline-secondary float-right" runat="server" CausesValidation="False" OnClientClick="window.open('finalise?Preview=1');return false;"><i aria-hidden="true" class="fas fa-search"></i> Preview</asp:LinkButton>
                </div>


            </div>
        </div>
        
        
        </div>
</asp:Content>
