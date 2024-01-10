<%@ Page Title="Manage Content" Language="vb" AutoEventWireup="false" MasterPageFile="~/cms/CMS.Master" MaintainScrollPositionOnPostback="true" CodeBehind="ManageContent.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.ManageContent" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.ASPxHtmlEditor.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxHtmlEditor" TagPrefix="dx" %>


<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .rotate-90 {
    -webkit-transform: rotate(90deg);
    -moz-transform: rotate(90deg);
    -ms-transform: rotate(90deg);
    -o-transform: rotate(90deg);
    transform: rotate(90deg);
}
    </style>
    <link href="../Content/fileup.css" rel="stylesheet" />
    <script src="../Scripts/cms.js"></script>
   <script>
       function BindEvents() {

           $(document).on('change', '.btn-file :file', function () {
               var input = $(this),
                   numFiles = input.get(0).files ? input.get(0).files.length : 1,
                   label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
               input.trigger('fileselect', [numFiles, label]);
           });

           $(document).ready(function () {
               $('.bs-pagination td table').each(function (index, obj) {
                   convertToPagination(obj)
               });
               //$('input, textarea').placeholder({ customClass: 'my-placeholder' });
               $('.btn-file :file').on('fileselect', function (event, numFiles, label) {

                   var input = $(this).parents('.input-group').find(':text'),
                       log = numFiles > 1 ? numFiles + ' files selected' : label;

                   if (input.length) {
                       input.val(log);
                   } else {
                       if (log) alert(log);
                   }

               });
                setEditFormControlVis();
               setDiagnosticControlVisibility();
           });
           $('#ddContentType').change(function () {
               setEditFormControlVis();
               setDiagnosticControlVisibility();
           });
           $('#ddAssessmentTypeID').change(function () {
               setDiagnosticControlVisibility();
           });
       };
      
</script>
    <div class="row">
        <div class="col-md-6">
<h2>Manage Content</h2>
        </div>
        <div class="col-md-6">
            <div id="pnlUsage" runat="server" class="card card-info">
                <div class="card-header">
                <h4 class="mb-2 text-center">Server space used: 
                    <asp:Label ID="lblUsed" runat="server" Text="Used"></asp:Label>
                    /
                    <asp:Label ID="lblAvailable" runat="server" Text="Available"></asp:Label></h4></div>
                <div class="card-body">
                <div class="progress">
                    <div class="progress-bar progress-bar-info" runat="server" id="progbar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
                        <asp:Label ID="lblPercent" runat="server" Text="60%"></asp:Label>
                    </div>
                </div>
                <asp:Panel ID="pnlExceeded" Visible ="false" CssClass="card-text text-center" runat="server">
                   <p>To enable further uploads, please archive content or upgrade.</p>
                </asp:Panel></div>
            </div>
        </div>
    </div>
    
    <hr />
    <asp:MultiView ID="mvManageContent" runat="server">
        <asp:View ID="vChooseCourse" runat="server">
            <asp:ObjectDataSource ID="dsCourses" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetForUser" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.ApplicationsTableAdapter">
                <SelectParameters>
                    <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                    <asp:Parameter DefaultValue="False" Name="ShowArchived" Type="Boolean" />
                    <asp:SessionParameter DefaultValue="False" Name="PublishToAll" SessionField="UserPublishToAll" Type="Boolean" />
                    <asp:ControlParameter ControlID="cbFilterForCentre" DefaultValue="1" Name="ShowOnlyMine" PropertyName="Checked" Type="Boolean" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <div class="card card-primary">
                <div class="card-header">
                    Choose a Course to Manage<div class="float-right">
                    <asp:CheckBox ID="cbFilterForCentre" runat="server" TextAlign="Right" Font-Bold="false" Font-Size="Smaller" Text="Show only my centre's courses?" Checked="true" AutoPostBack="True" /></div>
                </div>
                <div class="card-body">
                    <div class="m-3" id="frmSelectCourse" runat="server">
                        <div class="form-group row">
                            <asp:Label ID="lblSelectCourse" AssociatedControlID="ddCourse" CssClass="control-label col-4" runat="server" Text="Select course:"></asp:Label>
                            <div class="col-8">
                                <asp:DropDownList CssClass="form-control" ID="ddCourse" runat="server" DataSourceID="dsCourses" DataTextField="ApplicationName" DataValueField="ApplicationID" AppendDataBoundItems="True">
                                    <asp:ListItem Text="Please select..." Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer clearfix">
                    <asp:LinkButton ID="lbtOK" CssClass="btn btn-primary float-right" runat="server">OK</asp:LinkButton>
                </div>
            </div>
        </asp:View>
        <asp:View ID="vManageContent" runat="server">
            <asp:ObjectDataSource ID="dsSections" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActive" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.SectionsTableAdapter" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_SectionID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ApplicationID" Type="Int32" />
                    <asp:Parameter Name="SectionNumber" Type="Int32" />
                    <asp:Parameter Name="SectionName" Type="String" />
                    <asp:Parameter Name="ConsolidationPath" Type="String" />
                    <asp:Parameter Name="DiagAssessPath" Type="String" />
                    <asp:Parameter Name="PLAssessPath" Type="String" />
                    <asp:Parameter Name="CreatedByID" Type="Int32" />
                    <asp:Parameter Name="CreatedByCentreID" Type="Int32" />
                    <asp:Parameter Name="CreatedDate" Type="DateTime" />
                </InsertParameters>
                <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="34" Name="ApplicationID" QueryStringField="courseid" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ApplicationID" Type="Int32" />
                    <asp:Parameter Name="SectionNumber" Type="Int32" />
                    <asp:Parameter Name="SectionName" Type="String" />
                    <asp:Parameter Name="ConsolidationPath" Type="String" />
                    <asp:Parameter Name="DiagAssessPath" Type="String" />
                    <asp:Parameter Name="PLAssessPath" Type="String" />
                    <asp:Parameter Name="CreatedByID" Type="Int32" />
                    <asp:Parameter Name="CreatedByCentreID" Type="Int32" />
                    <asp:Parameter Name="CreatedDate" Type="DateTime" />
                    <asp:Parameter Name="Original_SectionID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <div class="card card-primary">
                <div class="card-header">
                    <h4>
                        <asp:Label ID="lblCourseHeading" runat="server" Text=""></asp:Label></h4>
                </div>
                <div class="card-body">
                    
                    <asp:Repeater ID="rptSections" runat="server" DataSourceID="dsSections">
                        <ItemTemplate>
                            <asp:ObjectDataSource ID="dsTutorials" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActive" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.TutorialsTableAdapter">
                                <SelectParameters>
                                    <asp:Parameter Name="SectionID" Type="Int32" DefaultValue="0" />
                                </SelectParameters>
                            </asp:ObjectDataSource>

                            <div class="card card-default mb-2">
                                <div class="card-header">
                                    <div class="row">
                                        <asp:HiddenField ID="hfSectionID" runat="server" Value='<%# Eval("SectionID")%>' />
                                        <div class="col-1">
                                            <div class="dropdown mt-1">
                                                <button class="btn btn-primary btn-lg dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true">
                                                    <i aria-hidden="true" class="fas fa-cog"></i>
                                                   
                                                </button>
                                                <div class="dropdown-menu dropdown-menu-buttons" role="menu">
                                                    
                                                        <asp:LinkButton ID="lbtEdit" CssClass="dropdown-item" runat="server" CausesValidation="False" ToolTip="Edit Section Details" CommandName="EditDetails" CommandArgument='<%#Eval("SectionID")%>' Text=""><i aria-hidden="true" class="fas fa-pencil-alt mr-1"></i> Edit details</asp:LinkButton>
                                                        <asp:LinkButton ID="lbtAssessTemplate" CssClass='<%# IIf(Session("UserImportOnly") = True, "dropdown-item disabled", "dropdown-item")%>' runat="server" CausesValidation="False" ToolTip="Download assessment template for use in Content Creator" CommandName="AssessTemplate" CommandArgument='<%#Eval("SectionID")%>' Text=""><i aria-hidden="true" class="fas fa-file-export mr-1"></i> Download Assessment Template</asp:LinkButton>
                                                    <div class="dropdown-divider"></div>
                                                        <asp:LinkButton ID="lbtMoveFirst" CssClass='<%#IIf(Container.ItemIndex = 0, "dropdown-item disabled", "dropdown-item")%>' runat="server" CausesValidation="False" ToolTip="Move to Top" CommandName="MoveFirst" CommandArgument='<%#Eval("SectionID")%>' Text=""><i aria-hidden="true" class="fas fa-angle-double-up mr-1"></i> Move to Top</asp:LinkButton>
                                                   
                                                        <asp:LinkButton ID="lbtMoveUp"  CssClass='<%#IIf(Container.ItemIndex = 0, "dropdown-item disabled", "dropdown-item")%>' runat="server" CausesValidation="False" ToolTip="Move Up" CommandName="MoveUp" CommandArgument='<%#Eval("SectionID")%>' Text=""><i aria-hidden="true" class="fas fa-angle-up mr-1"></i> Move Up</asp:LinkButton>
                                                
                                                        <asp:LinkButton ID="lbtMoveDown" CssClass="dropdown-item" runat="server" CausesValidation="False" ToolTip="Move Down" CommandName="MoveDown" CommandArgument='<%#Eval("SectionID")%>' Text=""><i aria-hidden="true" class="fas fa-angle-down mr-1"></i> Move Down</asp:LinkButton>
                                                
                                                        <asp:LinkButton ID="lbtMoveLast" CssClass="dropdown-item" runat="server" CausesValidation="False" ToolTip="Move to Bottom" CommandName="MoveLast" CommandArgument='<%#Eval("SectionID")%>' Text=""><i aria-hidden="true" class="fas fa-angle-double-down mr-1"></i> Move to Bottom</asp:LinkButton>
                                                    
                                                    <div class="dropdown-divider"></div>
                                                        <asp:LinkButton ID="lbtArchive" CssClass="dropdown-item text-danger" OnClientClick="return confirm('Are you sure you wish to Archive this section (All content uploaded against it will be deleted permanently))?');" runat="server" CausesValidation="False" ToolTip="Archive Section" CommandName="Archive" CommandArgument='<%#Eval("SectionID")%>' Text=""><i aria-hidden="true" class="fas fa-trash mr-1"></i> Archive</asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-8">
                                            <h5  class="mt-1"><strong>
                                                <asp:Label ID="lblSectionHeading" runat="server" Text='<%# Eval("SectionName")%>'></asp:Label></strong></h5>
                                        </div>
                                        <div class="col-3">
                                            <div class="list-group">
                                                <asp:Panel ID="Panel1" CssClass="list-group-item" Visible='<%#Eval("DiagAssessPath").ToString.Length > 0%>' runat="server">
                                                    <asp:LinkButton ID="LinkButton1"  OnClientClick=' <%#"javascript:playThisTutorial(""" + Eval("DiagAssessPath").ToString() + """,""1024"",""768"",""diag"");return false;"%>' CssClass="btn btn-outline-success btn-block" ToolTip="Preview Diagnostic Assessment" runat="server"><i aria-hidden="true" class="far fa-check-square"></i> Diagnostic</asp:LinkButton>
                                                </asp:Panel>
                                                <asp:Panel ID="Panel2" CssClass="list-group-item" Visible='<%#Eval("PLAssessPath").ToString.Length > 0%>' runat="server">
<asp:LinkButton ID="LinkButton2"  OnClientClick=' <%#"javascript:playThisTutorial(""" + Eval("PLAssessPath").ToString() + """,""1024"",""768"",""assess"");return false;"%>' CssClass="btn btn-outline-success btn-block" ToolTip="Preview Post Learning Assessment" runat="server"><i aria-hidden="true" class="fas fa-graduation-cap"></i> Assessment</asp:LinkButton>
                                                </asp:Panel>
                                                <asp:Panel ID="Panel3" CssClass="list-group-item" Visible='<%#Eval("ConsolidationPath").ToString.Length > 0%>' runat="server">
                                                    <asp:LinkButton ID="lbtSupportMats"  runat="server"  CssClass="btn btn-outline-warning btn-block" OnClientClick='<%#"javascript:openThisPage(""" + Eval("ConsolidationPath").ToString() + """);return false;"%>' CausesValidation="False" ToolTip="Preview Supporting Materials" Text=""><i aria-hidden="true" class="fas fa-info-circle"></i> Support Materials</asp:LinkButton>
                                                </asp:Panel>
                                               
                                            </div>
                                               </div>
                                          </div>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-1">
                                        </div>
                                    </div>
                                    <ul class="list-group mb-2">
                                        <asp:Repeater ID="rptTutorials" runat="server">
                                            <ItemTemplate>

                                                <li class="list-group-item">
                                                    <div class="row">
                                                        <div class="col-1">
                                                            <div class="dropdown">
                                                                <button class="btn btn-secondary btn-sm dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true">
                                                                    <i aria-hidden="true" class="fas fa-cog"></i>
                                                                    
                                                                </button>
                                                                <div class="dropdown-menu dropdown-menu-buttons" role="menu">
                                                                        <asp:LinkButton ID="lbtEdit" CssClass='<%# IIf(Session("UserImportOnly") = True, "dropdown-item disabled", "dropdown-item")%>' runat="server" Enabled='<%# Not (Session("UserImportOnly"))%>' OnClick="TutorialRepeaterCommand" CausesValidation="False" ToolTip="Edit Tutorial Details" CommandName="EditDetails" CommandArgument='<%#Eval("TutorialID")%>' Text=""><i aria-hidden="true" class="fas fa-pencil-alt mr-1"></i> Edit details</asp:LinkButton>
                                                                    
                                                                    <div class="dropdown-divider"></div>
                                                                        <asp:LinkButton ID="lbtMoveTop" CssClass='<%# IIf(Container.ItemIndex = 0, "dropdown-item disabled", "dropdown-item")%>' runat="server" OnClick="TutorialRepeaterCommand" CausesValidation="False" ToolTip="Move to Top" CommandName="MoveFirst" CommandArgument='<%#Eval("TutorialID")%>' Text=""><i aria-hidden="true" class="fas fa-angle-double-up mr-1"></i> Move to Top</asp:LinkButton>
                                                                  
                                                                        <asp:LinkButton ID="lbtMoveUpTut" CssClass='<%# IIf(Container.ItemIndex = 0, "dropdown-item disabled", "dropdown-item")%>' runat="server" OnClick="TutorialRepeaterCommand" CausesValidation="False" ToolTip="Move Up" CommandName="MoveUp" CommandArgument='<%#Eval("TutorialID")%>' Text=""><i aria-hidden="true" class="fas fa-angle-up mr-1"></i> Move Up</asp:LinkButton>
                                                                   
                                                                        <asp:LinkButton ID="lbtMoveDownTut" CssClass="dropdown-item" runat="server" OnClick="TutorialRepeaterCommand" CausesValidation="False" ToolTip="Move Down" CommandName="MoveDown" CommandArgument='<%#Eval("TutorialID")%>' Text=""><i aria-hidden="true" class="fas fa-angle-down mr-1"></i> Move Down</asp:LinkButton>
                                                             
                                                                        <asp:LinkButton ID="lbtMoveLastTut" CssClass="dropdown-item" runat="server" OnClick="TutorialRepeaterCommand" CausesValidation="False" ToolTip="Move to Bottom" CommandName="MoveLast" CommandArgument='<%#Eval("TutorialID")%>' Text=""><i aria-hidden="true" class="fas fa-angle-double-down mr-1"></i> Move to Bottom</asp:LinkButton>
                                                                    
                                                                    <div class="dropdown-divider"></div>
                                                                        <asp:LinkButton ID="lbtArchive" CssClass="dropdown-item text-danger" OnClick="TutorialRepeaterCommand" OnClientClick="return confirm('Are you sure you wish to Archive this tutorial (All content uploaded against it will be deleted permanently)?');" runat="server" CausesValidation="False" ToolTip="Archive Tutorial" CommandName="Archive" CommandArgument='<%#Eval("TutorialID")%>' Text=""><i aria-hidden="true" class="fas fa-trash mr-1"></i> Archive</asp:LinkButton>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-5">
                                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("TutorialName")%>'></asp:Label>
                                                        </div>
                                                        <div class="col-1">
                                                            <%--OBJECTIVES--%>
                                                           <asp:LinkButton ID="lbtObjective" runat="server" CssClass="btn btn-outline-danger" Visible='<%#Eval("Objectives").ToString.Length > 0 And Eval("ContentTypeID") < 4%>'  CausesValidation="False" ToolTip="Preview Objectives" OnClientClick=' <%#"javascript:showThisObjective (""" + Eval("Objectives").ToString.Replace(vbCr, "").Replace(vbLf, "") + """);return false;"%>' Text=""><i aria-hidden="true" class="fas fa-bullseye"></i></asp:LinkButton>
                                                            <asp:LinkButton ID="lbtReview" ToolTip="Preview Competency" CssClass="btn btn-outline-success" CommandArgument='<%# Eval("TutorialID")%>' Visible='<%#Eval("ContentTypeID") = 4%>'  runat="server" OnCommand="lbtReview_Command"><i class="fas fa-search"></i> Preview</asp:LinkButton>
                                                        </div>
                                                        <div class="col-1">
                                                            <%--VIDEO--%>
                                                            <asp:LinkButton ID="lbtVideo" runat="server" CssClass="btn btn-outline-info" Visible='<%#Eval("VideoPath").ToString.Length > 0%>' OnClientClick=' <%#"javascript:playThisVideo (""" + Eval("VideoPath") + """);return false;"%>' CausesValidation="False" ToolTip="Preview Intro Video"  Text=""><i aria-hidden="true" class="fas fa-video"></i></asp:LinkButton>
                                                        </div>
                                                        <div class="col-1">
                                                            <%--TUTORIAL--%>
                                                             <asp:LinkButton ID="lbtTutorial"  runat="server" CssClass="btn btn-outline-success" Visible='<%#Eval("TutorialPath").ToString.Length > 0%>'  OnClientClick=' <%#"javascript:playThisTutorial(""" + CorrectTutorialURL(Eval("TutorialPath").ToString()) + """,""" + Eval("hEmbedRes").ToString() + """,""" + Eval("vEmbedRes").ToString() + """,""learn"");return false;"%>' CausesValidation="False" ToolTip="Preview Tutorial" Text=""><i aria-hidden="true" class="fas fa-play"></i></asp:LinkButton>
                                                        </div>
                                                        <div class="col-1">
                                                            <%--SUPPORTING INFO--%>
                                                            <asp:LinkButton ID="lbtSupportMats"  runat="server" CssClass="btn btn-outline-warning" Visible='<%#Eval("SupportingMatsPath").ToString.Length > 0%>' OnClientClick='<%#"javascript:openThisPage(""" + Eval("SupportingMatsPath").ToString() + """);return false;"%>' CausesValidation="False" ToolTip="Preview Supporting Materials" CommandName="SupportMatsPreview" CommandArgument='<%#Eval("TutorialID")%>' Text=""><i aria-hidden="true" class="fas fa-info-circle"></i></asp:LinkButton>
                                                        </div></div>
                                                </li>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </ul>
                                    <asp:Panel  CssClass="btn-group  float-right" id="pnlAddAndImport" runat="server">
                                    <asp:LinkButton ID="lbtAddTutorial" CommandName="AddTutorial" CommandArgument='<%# Eval("SectionID")%>' min-width="25%" CssClass="btn btn-secondary" runat="server"><i aria-hidden="true" class="fas fa-plus mr-1"></i> Add Tutorial</asp:LinkButton>
 <button type="button" class="btn btn-secondary dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    
    <span class="sr-only">Toggle Dropdown</span>
  </button>
<div class="dropdown-menu">
    
        <asp:LinkButton ID="lbtAddNewTutorial" CssClass="dropdown-item" CommandName="AddTutorial" CommandArgument='<%# Eval("SectionID")%>' runat="server"><i aria-hidden="true" class="fas fa-plus mr-1"></i> Add new tutorial</asp:LinkButton>
   
        <asp:LinkButton ID="lbtImportTutorial" CssClass="dropdown-item" CommandName="ImportTutorial" CommandArgument='<%# Eval("SectionID")%>' runat="server"><i aria-hidden="true" class="fas fa-download mr-1"></i> Import tutorial</asp:LinkButton>
  </div>
                </asp:Panel>
                                    <asp:Panel ID="pnlImportOnly" cssclass="btn-group float-right" runat="server" Visible="false">
                    
                   <asp:LinkButton ID="lbtImportTutorialOnly" CssClass="btn btn-outline-secondary" CommandName="ImportTutorial" CommandArgument='<%# Eval("SectionID")%>' runat="server"><i aria-hidden="true" class="fas fa-download mr-1"></i> Import tutorial</asp:LinkButton>
            </asp:Panel>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    
                    <div class="btn-group  float-right" id ="divAddAndImport" runat="server">
                    <asp:LinkButton ID="lbtAddSection" min-width="25%" CssClass="btn btn-primary" runat="server"><i aria-hidden="true" class="fas fa-plus"></i> Add Section</asp:LinkButton>
                         <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    
    <span class="sr-only">Toggle Dropdown</span>
  </button>
<div class="dropdown-menu">
 
        <asp:LinkButton ID="lbtAddNewSection" CssClass="dropdown-item" runat="server"><i aria-hidden="true" class="fas fa-plus mr-1"></i> Add new section</asp:LinkButton>
   
        <asp:LinkButton ID="lbtImportSection" CssClass="dropdown-item" runat="server"><i aria-hidden="true" class="fas fa-download mr-1"></i> Import section</asp:LinkButton>
  </div>
                </div>
                    <div id="divImportOnly" runat="server">
                        <asp:LinkButton ID="lbtAddNewSection2" cssclass="btn btn-primary float-right" runat="server"><i aria-hidden="true" class="fas fa-plus mr-1"></i> Add new section</asp:LinkButton>
<asp:LinkButton ID="lbtImportSection2" cssclass="btn btn-primary float-right" runat="server"><i aria-hidden="true" class="fas fa-download-alt mr-1"></i> Import section</asp:LinkButton>
</div></div>
             </div>       
        </asp:View>
        <asp:View ID="vSectionDetail" runat="server">
            <asp:ObjectDataSource ID="dsSection" runat="server" DeleteMethod="Delete" InsertMethod="InsertSection" OldValuesParameterFormatString="original_{0}" SelectMethod="GetBySectionID" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.SectionsTableAdapter" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_SectionID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="ApplicationID" Type="Int32" />
                    <asp:Parameter Name="SectionName" Type="String" />
                    <asp:Parameter Name="ConsolidationPath" Type="String" />
                    <asp:Parameter Name="DiagAssessPath" Type="String" />
                    <asp:Parameter Name="PLAssessPath" Type="String" />
                    <asp:Parameter Name="CreatedByID" Type="Int32" />
                    <asp:Parameter Name="CreatedByCentreID" Type="Int32" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="0" Name="SectionID" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ApplicationID" Type="Int32" />
                    <asp:Parameter Name="SectionNumber" Type="Int32" />
                    <asp:Parameter Name="SectionName" Type="String" />
                    <asp:Parameter Name="ConsolidationPath" Type="String" />
                    <asp:Parameter Name="DiagAssessPath" Type="String" />
                    <asp:Parameter Name="PLAssessPath" Type="String" />
                    <asp:Parameter Name="CreatedByID" Type="Int32" />
                    <asp:Parameter Name="CreatedByCentreID" Type="Int32" />
                    <asp:Parameter Name="CreatedDate" Type="DateTime" />
                    <asp:Parameter Name="Original_SectionID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <div class="card card-primary">
                <div class="card-header">
                    <h6>
                    <asp:Label ID="lblSectionDetailFormHeading" runat="server" Text="Edit Section Details"></asp:Label></h6>
                </div>
                <asp:FormView ID="fvSectionDetail" RenderOuterTable="False" runat="server" DataKeyNames="SectionID" DataSourceID="dsSection" DefaultMode="Edit">
                    <EditItemTemplate>

                        <div class="card-body">
                            <div class="m-3">
                                <asp:HiddenField ID="hfSectionID" runat="server" Value='<%# Eval("SectionID")%>' />
                                <asp:HiddenField ID="hfApplicationID" runat="server" Value='<%# Bind("ApplicationID")%>' />
                                <asp:HiddenField ID="hfSectionNumber" runat="server" Value='<%# Bind("SectionNumber")%>' />
                                <div class="form-group row">
                                    <asp:Label ID="lblSectionName" CssClass="control-label col-4" runat="server" AssociatedControlID="SectionNameTextBox">Section Name:</asp:Label>
                                    <div class="col-8">
                                        <asp:TextBox ID="SectionNameTextBox" runat="server" Text='<%# Bind("SectionName") %>' CssClass="form-control" />

                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label2" CssClass="control-label col-4" runat="server" AssociatedControlID="ConsolidationTextBox">Consolidation Path:</asp:Label>
                                    <div class="col-8">
                                        <asp:HiddenField ID="hfConsolidationPath" Value='<%# Eval("ConsolidationPath")%>' runat="server" />
                                            <asp:TextBox ID="ConsolidationTextBox" runat="server" Text='<%# Bind("ConsolidationPath")%>' CssClass="form-control" />

                                        <asp:Panel ID="pnlConsolidationUpload"  cssclass="input-group" runat="server">
                                         
                                            <span class="input-group-prepend">
                                            <span class="btn btn-outline-secondary btn-file">Browse&hellip;
                                                <asp:FileUpload AllowMultiple="false" ID="fupConsolidation"  runat="server" />
                                                
                                            </span>
                                        </span>
                                           <input type="text" placeholder=".zip, .docx, .pdf" class="form-control" readonly="true">
                                            <span class="input-group-append">
                                                <asp:LinkButton ID="lbtUploadConsolidation" CausesValidation="false" CommandName="UploadConsolidation" CommandArgument='<%# Eval("SectionID")%>' CssClass="btn btn-outline-secondary" ToolTip="Upload Consolidation" runat="server"><i aria-hidden="true" class="fas fa-file-upload"></i> Upload</asp:LinkButton>
                                           </span>
                                        </asp:Panel><asp:RegularExpressionValidator ID="rfvUploadConsolidation" runat="server" ControlToValidate="fupConsolidation" CssClass="bg-danger"
 Tooltip=".mp4 format only" ErrorMessage=".docx, .pdf or .zip format only"
 ValidationExpression="(.+\.([Pp][Dd][Ff])|.+\.([Dd][Oo][Cc][Xx])|.+\.([Zz][Ii][Pp]))" ValidationGroup="vgConsolidationUpload"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblDiagnostic" CssClass="col-md-4 control-label" AssociatedControlID="DiagnosticPathTextBox" runat="server" Text="Diagnostic URL:"></asp:Label>
                                    <div class="col-8">
                                        <asp:HiddenField ID="hfDiagnosticPath" Value='<%# Eval("DiagAssessPath")%>' runat="server" />
                                        <asp:TextBox ID="DiagnosticPathTextBox" runat="server" Text='<%# Bind("DiagAssessPath") %>' CssClass="form-control" />
                                        <asp:Panel ID="pnlDiagUpload" cssclass="input-group" runat="server">
                                            <span class="input-group-prepend">
                                            <span class="btn btn-outline-secondary btn-file">Browse&hellip;
                                                <asp:FileUpload AllowMultiple="false" ID="fupDiagnostic" runat="server" />
                                            </span>
                                        </span>
                                            <input type="text" placeholder=".zip Content Creator / valid SCORM package" class="form-control" readonly="true">
                                            <span class="input-group-append">
                                                <asp:LinkButton ID="lbtUploadDiagnostic" CausesValidation="true" ValidationGroup="vgDiagnosticUpload" CommandName="UploadDiagnostic" CommandArgument='<%# Eval("SectionID")%>' CssClass="btn btn-outline-secondary" ToolTip="Upload Diagnostic" runat="server"><i aria-hidden="true" class="fas fa-file-upload"></i> Upload</asp:LinkButton>
                                            </span>
                                        </asp:Panel><asp:RegularExpressionValidator ID="rfvUploadDiagnostic" runat="server" ControlToValidate="fupDiagnostic" CssClass="bg-danger"
 Tooltip=".zip format only" ErrorMessage=".zip format only"
 ValidationExpression="(.+\.([Zz][Ii][Pp]))" ValidationGroup="vgDiagnosticUpload"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblPLAssess" CssClass="col-md-4 control-label" AssociatedControlID="PLAssessPathTextBox" runat="server" Text="PL Assess URL:"></asp:Label>
                                    <div class="col-8">
                                        <asp:HiddenField ID="hfPLAssessPath" Value='<%# Eval("PLAssessPath")%>' runat="server" />
                                        <asp:TextBox ID="PLAssessPathTextBox" runat="server" Text='<%# Bind("PLAssessPath") %>' CssClass="form-control" />
                                        <asp:Panel ID="pnlAssessUpload" cssclass="input-group" runat="server">
                                            <span class="input-group-prepend">
                                            <span class="btn btn-outline-secondary btn-file">Browse&hellip;
                                                <asp:FileUpload AllowMultiple="false" ID="fupPLAssess" runat="server" />
                                            </span>
                                        </span>
                                            <input type="text" placeholder=".zip Content Creator / valid SCORM package" class="form-control" readonly="true">
                                            <span class="input-group-append">
                                                <asp:LinkButton ID="lbtUploadPLAssess" CausesValidation="true" ValidationGroup="vgPLAssessUpload" CommandName="UploadPLAssess" CommandArgument='<%# Eval("SectionID")%>' CssClass="btn btn-outline-secondary" ToolTip="Upload PLAssess" runat="server"><i aria-hidden="true" class="fas fa-file-upload"></i> Upload</asp:LinkButton>
                                            </span>
                                        </asp:Panel><asp:RegularExpressionValidator ID="rfvUploadPLAssess" runat="server" ControlToValidate="fupPLAssess" CssClass="bg-danger"
 Tooltip=".zip format only" ErrorMessage=".zip format only"
 ValidationExpression="(.+\.([Zz][Ii][Pp]))" ValidationGroup="vgPLAssessUpload"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblCreatedBy" CssClass="control-label col-4" runat="server" AssociatedControlID="CreatedByTextBox">Created By:</asp:Label>
                                    <div class="col-8">
                                        <asp:HiddenField ID="hfCreatedByID" runat="server" Value='<%# Bind("CreatedByID") %>' />
                                        <asp:TextBox CssClass="form-control" ID="CreatedByTextBox" Enabled="false" runat="server" Text='<%# Eval("CreatedBy")%>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblCentre" CssClass="control-label col-4" runat="server" AssociatedControlID="CreatedByCentreIDTextBox">Centre:</asp:Label>
                                    <div class="col-8">
                                        <asp:HiddenField ID="hfCreatedByCentreID" runat="server" Value='<%# Bind("CreatedByCentreID") %>' />
                                        <asp:TextBox CssClass="form-control" Enabled="false" ID="CreatedByCentreIDTextBox" runat="server" Text='<%# Eval("CreatedByCentre")%>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblCreatedDate" CssClass="control-label col-4" runat="server" AssociatedControlID="CreatedDateTextBox">Created:</asp:Label>
                                    <div class="col-8">
                                        <asp:TextBox CssClass="form-control" Enabled="false" ID="CreatedDateTextBox" runat="server" Text='<%# Bind("CreatedDate") %>' />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer clearfix">
                            <asp:LinkButton ID="UpdateCancelButton" CssClass="btn btn-outline-secondary float-left mr-auto" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                            <asp:LinkButton ID="UpdateButton" CssClass="btn btn-primary float-right" runat="server" ValidationGroup="UpdateSection" CausesValidation="True" CommandName="Update" Text="Update" />
                            
                        </div>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <div class="card-body">
                            <div class="m-3">
                                <asp:HiddenField ID="hfApplicationID" runat="server" Value='<%# Bind("ApplicationID")%>' />
                                <div class="form-group row">
                                    <asp:Label ID="lblSectionName" CssClass="control-label col-4" runat="server" AssociatedControlID="SectionNameTextBox">Section Name:</asp:Label>
                                    <div class="col-8">
                                        <asp:TextBox ID="SectionNameTextBox" runat="server" Text='<%# Bind("SectionName") %>' CssClass="form-control" />
                                     <asp:RequiredFieldValidator ValidationGroup="InsertSection" CssClass="bg-danger" ID="rfvSectionName" ControlToValidate="SectionNameTextBox" Display="Dynamic" runat="server" ErrorMessage="Required"></asp:RequiredFieldValidator>
                               </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label2" CssClass="control-label col-4" runat="server" AssociatedControlID="ConsolidationTextBox">Consolidation Path:</asp:Label>
                                    <div class="col-8">
                                            <asp:TextBox ID="ConsolidationTextBox" runat="server" Text='<%# Bind("ConsolidationPath")%>' CssClass="form-control" />
                                        <asp:Panel ID="pnlConsolidationUpload"  cssclass="input-group" runat="server">
                                            <span class="input-group-prepend">
                                            <span class="btn btn-outline-secondary btn-file">Browse&hellip;
                                                <asp:FileUpload AllowMultiple="false" ID="fupConsolidation"  runat="server" />
                                            </span>
                                        </span>
                                           <input type="text" placeholder=".zip, .docx, .pdf" class="form-control" readonly="true">
                                            <span class="input-group-append">
                                                <asp:LinkButton ID="lbtUploadConsolidation" CausesValidation="false" CommandName="UploadConsolidation" CommandArgument='<%# Eval("SectionID")%>' CssClass="btn btn-outline-secondary" ToolTip="Upload Consolidation" runat="server"><i aria-hidden="true" class="fas fa-file-upload"></i> Upload</asp:LinkButton>
                                           </span></asp:Panel>
                                        <asp:RegularExpressionValidator ID="rfvUploadConsolidation" runat="server" ControlToValidate="fupConsolidation" CssClass="bg-danger"
 Tooltip=".mp4 format only" ErrorMessage=".docx, .pdf or .zip format only"
 ValidationExpression="(.+\.([Pp][Dd][Ff])|.+\.([Dd][Oo][Cc][Xx])|.+\.([Zz][Ii][Pp]))" ValidationGroup="vgConsolidationUpload"></asp:RegularExpressionValidator>
                                </div></div>
                                
                                <div class="form-group row">
                                    <asp:Label ID="lblDiagnostic" CssClass="col-md-4 control-label" AssociatedControlID="DiagnosticPathTextBox" runat="server" Text="Diagnostic URL:"></asp:Label>
                                    <div class="col-8">
                                        <asp:TextBox ID="DiagnosticPathTextBox" runat="server" Text='<%# Bind("DiagAssessPath") %>' CssClass="form-control" />
                                        <asp:Panel ID="pnlDiagUpload"  cssclass="input-group" runat="server">
                                        
                                            <span class="input-group-prepend">
                                            <span class="btn btn-outline-secondary btn-file">Browse&hellip;
                                                <asp:FileUpload AllowMultiple="false" ID="fupDiagnostic" runat="server" />
                                            </span>
                                        </span>
                                            <input type="text" placeholder=".zip Content Creator CDA / valid SCORM package" class="form-control" readonly="true">
                                            <span class="input-group-append">
                                                <asp:LinkButton ID="lbtUploadDiagnostic" CausesValidation="true" ValidationGroup="vgDiagnosticUpload" CommandName="UploadDiagnostic" CommandArgument='<%# Eval("SectionID")%>' CssClass="btn btn-outline-secondary" ToolTip="Upload Diagnostic" runat="server"><i aria-hidden="true" class="fas fa-file-upload"></i> Upload</asp:LinkButton>
                                            </span></asp:Panel>
                                        <asp:RegularExpressionValidator ID="rfvUploadDiagnostic" runat="server" ControlToValidate="fupDiagnostic" CssClass="bg-danger"
 Tooltip=".zip format only" ErrorMessage=".zip format only"
 ValidationExpression="(.+\.([Zz][Ii][Pp]))" ValidationGroup="vgDiagnosticUpload"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                                
                                <div class="form-group row">
                                    <asp:Label ID="lblPLAssess" CssClass="col-md-4 control-label" AssociatedControlID="PLAssessPathTextBox" runat="server" Text="PLAssess URL:"></asp:Label>
                                    <div class="col-8">
                                        <asp:TextBox ID="PLAssessPathTextBox" runat="server" Text='<%# Bind("PLAssessPath") %>' CssClass="form-control" />
                                        <asp:Panel ID="pnlAssessUpload"  cssclass="input-group" runat="server">
                                        
                                            <span class="input-group-prepend">
                                            <span class="btn btn-outline-secondary btn-file">Browse&hellip;
                                                <asp:FileUpload AllowMultiple="false" ID="fupPLAssess" runat="server" />
                                            </span>
                                        </span>
                                            <input type="text" placeholder=".zip Content Creator CDA / valid SCORM package" class="form-control" readonly="true">
                                            <span class="input-group-append">
                                                <asp:LinkButton ID="lbtUploadPLAssess" CausesValidation="true" ValidationGroup="vgPLAssessUpload" CommandName="UploadPLAssess" CommandArgument='<%# Eval("SectionID")%>' CssClass="btn btn-outline-secondary" ToolTip="Upload PLAssess" runat="server"><i aria-hidden="true" class="fas fa-file-upload"></i> Upload</asp:LinkButton>
                                            </span></asp:Panel>
                                        <asp:RegularExpressionValidator ID="rfvUploadPLAssess" runat="server" ControlToValidate="fupPLAssess" CssClass="bg-danger"
 Tooltip=".zip format only" ErrorMessage=".zip format only"
 ValidationExpression="(.+\.([Zz][Ii][Pp]))" ValidationGroup="vgPLAssessUpload"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblCreatedBy" CssClass="control-label col-4" runat="server" AssociatedControlID="CreatedByTextBox">Created By:</asp:Label>
                                    <div class="col-8">
                                        <asp:HiddenField ID="hfCreatedByID" runat="server" Value='<%# Bind("CreatedByID") %>' />
                                        <asp:TextBox CssClass="form-control" ID="CreatedByTextBox" Enabled="false" runat="server" Text='<%# Eval("CreatedBy")%>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblCentre" CssClass="control-label col-4" runat="server" AssociatedControlID="CreatedByCentreIDTextBox">Centre:</asp:Label>
                                    <div class="col-8">
                                        <asp:HiddenField ID="hfCreatedByCentreID" runat="server" Value='<%# Bind("CreatedByCentreID") %>' />
                                        <asp:TextBox CssClass="form-control" Enabled="false" ID="CreatedByCentreIDTextBox" runat="server" Text='<%# Eval("CreatedByCentre")%>' />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer clearfix">
                            <asp:LinkButton ID="InsertCancelButton" CssClass="btn btn-outline-secondary float-left mr-auto" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                            <asp:LinkButton ID="InsertButton" CssClass="btn btn-primary float-right" runat="server" ValidationGroup="InsertSection" CausesValidation="True" CommandName="Insert" Text="Insert" />
                            
                        </div>
                    </InsertItemTemplate>

                </asp:FormView>
            </div>
        </asp:View>
        <asp:View ID="vImportSection" runat="server">
             <div class="card card-primary">
                <div class="card-header"><h6>
                    <asp:Label ID="Label4" runat="server" Text="Import Course Section"></asp:Label></h6>
                </div>
                 <div class="card-body">
                     <asp:ObjectDataSource ID="dsCoursesForImport" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="Get101Courses" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.ApplicationsTableAdapter">
                         <SelectParameters>
                             <asp:SessionParameter Name="CentreID" SessionField="UserCentreID" Type="Int32" />
                         </SelectParameters>
                     </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="dsSectionsForImport" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActive" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.SectionsTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddCourseForSectionImport" Name="ApplicationID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
                     <div class="m-3">
                     <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                         <ContentTemplate>
 <div class="form-group row">
                                    <asp:Label ID="lblCourseToImportFrom" CssClass="col-md-4 control-label" AssociatedControlID="ddCourseForSectionImport" runat="server" Text="Course to import from:"></asp:Label>
                                    <div class="col-8">
                     <asp:DropDownList ID="ddCourseForSectionImport" CssClass="form-control" runat="server" DataSourceID="dsCoursesForImport" DataTextField="ApplicationName" DataValueField="ApplicationID" AutoPostBack="True"></asp:DropDownList>
                                        </div>
                          </div>
                      <div class="form-group row">
                                    <asp:Label ID="lblSectionToImportFrom" CssClass="col-md-4 control-label" AssociatedControlID="ddSectionToImport" runat="server" Text="Section to import:"></asp:Label>
                                    <div class="col-8">
                     <asp:DropDownList ID="ddSectionToImport" CssClass="form-control" runat="server" DataSourceID="dsSectionsForImport" DataTextField="SectionName" DataValueField="SectionID"></asp:DropDownList>
                                        </div>
                          </div>
                         </ContentTemplate>
                     </asp:UpdatePanel>
                     </div>
                 </div>
                 <div class="card-footer clearfix">
                     <asp:LinkButton ID="lbtImportSectionCancel" CssClass="btn btn-outline-secondary mr-auto" runat="server">Cancel</asp:LinkButton>
                     <asp:LinkButton ID="lbtImportSectionConfirm" CssClass="btn btn-primary float-right" runat="server">Import</asp:LinkButton>
                     
                 </div>
                 </div>
        </asp:View>
        <asp:View ID="vTutorialDetail" runat="server">
            <asp:ObjectDataSource ID="dsTutorial" runat="server" DeleteMethod="Delete" OldValuesParameterFormatString="original_{0}" SelectMethod="GetByTutorialID" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.TutorialsTableAdapter" UpdateMethod="UpdateQuery" InsertMethod="Insert">
                <DeleteParameters>
                    <asp:Parameter Name="Original_TutorialID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="TutorialName" Type="String" />
                    <asp:Parameter Name="VideoPath" Type="String" />
                    <asp:Parameter Name="TutorialPath" Type="String" />
                    <asp:Parameter Name="SupportingMatsPath" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Objectives" Type="String" />
                    <asp:Parameter Name="DiagAssessOutOf" Type="Int32" />
                    <asp:Parameter Name="ObjectiveNum" Type="Int32" />
                    <asp:Parameter Name="Keywords" Type="String" />
                    <asp:Parameter Name="SectionID" Type="Int32" />
                    <asp:Parameter Name="OrderByNumber" Type="Int32" />
                    <asp:Parameter Name="CMIInteractionIDs" Type="String" />
                    <asp:Parameter Name="OverrideTutorialMins" Type="Int32" />
                    <asp:Parameter Name="Description" Type="String" />
                    <asp:Parameter Name="ContentTypeID" Type="Int32" />
                    <asp:Parameter Name="LearnerMarksCompletion" Type="Boolean" />
                    <asp:Parameter Name="DefaultMethodID" Type="Int32" />
                    <asp:Parameter Name="EvidenceText" Type="String" />
                    <asp:Parameter Name="IncludeActionPlan" Type="Boolean" />
                    <asp:Parameter Name="SupervisorVerify" Type="Boolean" />
                    <asp:Parameter Name="SupervisorSuccessText" Type="String" />
                    <asp:Parameter Name="SupervisorFailText" Type="String" />
                    <asp:Parameter Name="RequireVideoPercent" Type="Int32" />
                    <asp:Parameter Name="RequireTutorialCompletion" Type="Boolean" />
                    <asp:Parameter Name="RequireSupportMatsOpen" Type="Boolean" />
                    <asp:Parameter Name="AllowPreview" Type="Boolean" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="0" Name="TutorialID" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="TutorialName" Type="String" />
                    <asp:Parameter Name="VideoPath" Type="String" />
                    <asp:Parameter Name="TutorialPath" Type="String" />
                    <asp:Parameter Name="SupportingMatsPath" Type="String" />
                    <asp:Parameter Name="Active" Type="Boolean" />
                    <asp:Parameter Name="Objectives" Type="String" />
                    <asp:Parameter Name="DiagAssessOutOf" Type="Int32" />
                    <asp:Parameter Name="Keywords" Type="String" />
                    <asp:Parameter Name="CMIInteractionIDs" Type="String" />
                    <asp:Parameter Name="OverrideTutorialMins" Type="Int32" />
                    <asp:Parameter Name="Description" Type="String" />
                    <asp:Parameter Name="ContentTypeID" Type="Int32" />
                    <asp:Parameter Name="LearnerMarksCompletion" Type="Boolean" />
                    <asp:Parameter Name="DefaultMethodID" Type="Int32" />
                    <asp:Parameter Name="EvidenceText" Type="String" />
                    <asp:Parameter Name="IncludeActionPlan" Type="Boolean" />
                    <asp:Parameter Name="SupervisorVerify" Type="Boolean" />
                    <asp:Parameter Name="SupervisorSuccessText" Type="String" />
                    <asp:Parameter Name="SupervisorFailText" Type="String" />
                    <asp:Parameter Name="RequireVideoPercent" Type="Int32" />
                    <asp:Parameter Name="RequireTutorialCompletion" Type="Boolean" />
                    <asp:Parameter Name="RequireSupportMatsOpen" Type="Boolean" />
                    <asp:Parameter Name="AllowPreview" Type="Boolean" />
                    <asp:Parameter Name="Original_TutorialID" Type="Int32" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <asp:ObjectDataSource ID="dsAssessmentTypes" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.AssessmentTypesTableAdapter"></asp:ObjectDataSource>
            <div class="card card-primary">
                <div class="card-header">
                    <asp:Label ID="lblTutorialDetailHeading" runat="server" Text="Edit Tutorial Details"></asp:Label>
                </div>
                <asp:FormView ID="fvTutorialDetail" runat="server" DataKeyNames="TutorialID" DataSourceID="dsTutorial" DefaultMode="Edit" RenderOuterTable="False">
                    <EditItemTemplate>
                        <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("TutorialID") %>' />
                        <asp:HiddenField ID="hfSectionID" runat="server" Value='<%# Eval("SectionID") %>' />
                        <div class="card-body">
                            <div class="m-3">
                                <div class="form-group row">
                                    <asp:Label ID="Label9" CssClass="control-label col-md-4" runat="server" AssociatedControlID="ddContentType">Content Type:</asp:Label>
                                    <div class="col-md-8">
                                        <asp:DropDownList CssClass="form-control" SelectedValue='<%# Bind("ContentTypeID") %>' ClientIDMode="Static" ID="ddContentType" runat="server">
                                            <asp:ListItem Text="Online learning" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Offline learning" Enabled="false" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Classroom learning" Enabled="false" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="Self Assessment" Value="4"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblTutName" CssClass="col-md-4 control-label" AssociatedControlID="TutorialNameTextBox" ClientIDMode="Static" runat="server" Text="Tutorial Name:"></asp:Label>
                                    <div class="col-md-8">
                                        <asp:TextBox ID="TutorialNameTextBox" CssClass="form-control" runat="server" Text='<%# Bind("TutorialName") %>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblDescription" CssClass="col-md-4 control-label" runat="server" AssociatedControlID="htmlDescription" Text="Description:"></asp:Label>
                                    <div class="col-md-8">
                                        <dx:ASPxHtmlEditor Width="100%" Html='<%# Bind("Description") %>' ID="htmlDescription" Height="200px" runat="server" Settings-AllowCustomColorsInColorPickers="False" SettingsHtmlEditing-AllowIdAttributes="False" SettingsHtmlEditing-PasteMode="PlainText" SettingsText-DesignViewTab="Edit"></dx:ASPxHtmlEditor>
                                    </div>
                                </div>
                                <div ID="pnlVideoTutorialCtrls">
                                <div class="form-group row">
                                    <asp:Label ID="lblVideo" AssociatedControlID="VideoPathTextBox" CssClass="col-md-4 control-label" runat="server" Text="Video URL:"></asp:Label>
                                    <div class="col-8">
                                        <asp:HiddenField ID="hfVideoPath" Value='<%# Eval("VideoPath") %>' runat="server" />
                                         <asp:TextBox ID="VideoPathTextBox" runat="server" Text='<%# Bind("VideoPath") %>' CssClass="form-control" /><div class="input-group">
                                            <span class="input-group-prepend">
                                            <span class="btn btn-outline-secondary btn-file">Browse&hellip;
                                                <asp:FileUpload AllowMultiple="false" ID="fupVideo"  runat="server" />
                                                
                                            </span>
                                        </span>
                                           <input type="text" placeholder=".mp4 video file only" class="form-control" readonly="true">
                                            <span class="input-group-append">
                                                <asp:LinkButton ID="lbtUploadTutVideo" CausesValidation="true" ValidationGroup="vgVideoUpload" CommandName="UploadVideo" CommandArgument='<%# Eval("SectionID")%>' CssClass="btn btn-outline-secondary" ToolTip="Upload Video" runat="server"><i aria-hidden="true" class="fas fa-file-upload"></i> Upload</asp:LinkButton>
                                            </span>
                                        </div><asp:RegularExpressionValidator ID="rfvUploadVideo" runat="server" ControlToValidate="fupVideo" CssClass="bg-danger"
 Tooltip=".mp4 format only" ErrorMessage=".mp4 format only"
 ValidationExpression="(.+\.([Mm][Pp][4]))" ValidationGroup="vgVideoUpload"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblTutorial" CssClass="col-md-4 control-label" AssociatedControlID="TutorialPathTextBox" runat="server" Text="Tutorial URL:"></asp:Label>
                                    <div class="col-8">
                                        <asp:HiddenField ID="hfTutorialPath" Value='<%# Eval("TutorialPath") %>' runat="server" />
                                        <asp:TextBox ID="TutorialPathTextBox" runat="server" Text='<%# Bind("TutorialPath") %>' CssClass="form-control" /><div class="input-group">
                                            <span class="input-group-prepend">
                                            <span class="btn btn-outline-secondary btn-file">Browse&hellip;
                                                <asp:FileUpload AllowMultiple="false" ID="fupTutorial" runat="server" />
                                            </span>
                                        </span>
                                            <input type="text" placeholder=".zip Content Creator CDA / valid SCORM package" class="form-control" readonly="true">
                                            <span class="input-group-append">
                                                <asp:LinkButton ID="lbtUploadTutorial" CausesValidation="true" ValidationGroup="vgTutorialUpload" CommandName="UploadTutorial" CommandArgument='<%# Eval("SectionID")%>' CssClass="btn btn-outline-secondary" ToolTip="Upload Tutorial" runat="server"><i aria-hidden="true" class="fas fa-file-upload"></i> Upload</asp:LinkButton>
                                            </span>
                                        </div><asp:RegularExpressionValidator ID="rfvUploadTutorial" runat="server" ControlToValidate="fupTutorial" CssClass="bg-danger"
 Tooltip=".zip format only" ErrorMessage=".zip format only"
 ValidationExpression="(.+\.([Zz][Ii][Pp]))" ValidationGroup="vgTutorialUpload"></asp:RegularExpressionValidator>
                                    </div>
                                    
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label11" CssClass="col-md-4 control-label" AssociatedControlID="bsSpinOverrideTutorialMins" runat="server" Text="Override Tutorial Mins:"></asp:Label>
                                    <div class="col-8">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text">0 = don't override</div>
                                            </div>
                                        <dx:BootstrapSpinEdit ID="bsSpinOverrideTutorialMins" NumberType="Integer" Number='<%# Bind("OverrideTutorialMins") %>' runat="server" MaxValue="60" ToolTip="0 = use calculated average tutorial time"></dx:BootstrapSpinEdit>
                                            </div></div>
                                </div>
                                    <asp:Panel runat="server"  Visible='<%# Session("UserPublishToAll") %>'>
                                    <div class="form-group row">
                                    <asp:Label ID="Label13" CssClass="col-md-4 control-label" AssociatedControlID="cbAllowPreview" runat="server" Text="Allow unauthenticated preview:"></asp:Label>
                                    <div class="col-md-8">
                                        <asp:CheckBox ID="cbAllowPreview" runat="server" Checked='<%# Bind("AllowPreview") %>' />
                                    </div>
                                </div></asp:Panel>
                                    </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblSupportMats" AssociatedControlID="SupportingMatsPathTextBox" CssClass="col-md-4 control-label" runat="server" Text="Support Materials URL:"></asp:Label>
                                    <div class="col-8">
                                        <asp:HiddenField ID="hfSupportingMatsPath" Value='<%# Eval("SupportingMatsPath") %>' runat="server" />
                                        <asp:TextBox ID="SupportingMatsPathTextBox" runat="server" Text='<%# Bind("SupportingMatsPath") %>' CssClass="form-control" />
                                        <div class="input-group">
                                            <span class="input-group-prepend">
                                            <span class="btn btn-outline-secondary btn-file">Browse&hellip;
                                                <asp:FileUpload AllowMultiple="false" ID="fupSupportMats" runat="server" />
                                            </span>
                                        </span>
                                            <input type="text" placeholder="html or zip file" class="form-control" readonly="true">
                                            <span class="input-group-append">
                                                <asp:LinkButton ID="lbtUploadSuppportMats" CausesValidation="true" ValidationGroup="vgSupportUpload" CommandName="UploadSupportMats" CommandArgument='<%# Eval("SectionID")%>' CssClass="btn btn-outline-secondary" ToolTip="Upload Supporting Materials" runat="server"><i aria-hidden="true" class="fas fa-file-upload"></i> Upload</asp:LinkButton>
                                            </span>
                                        </div>
                                        <asp:RegularExpressionValidator ID="rfvSupportMats" runat="server" ControlToValidate="fupSupportMats" CssClass="bg-danger"
 Tooltip=".htm, .html, .zip, .docx or .pdf format" ErrorMessage=".htm, .html, .pdf, .docx or .zip format only"
 ValidationExpression="(.+\.([Hh][Tt][Mm])|.+\.([Hh][Tt][Mm][Ll])|.+\.([Zz][Ii][Pp])|.+\.([Pp][Dd][Ff]))|.+\.([Dd][Oo][Cc][Xx])" ValidationGroup="vgSupportUpload"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                                
                                
                                <div class="form-group row">
                                    <asp:Label ID="lblObjectives" CssClass="col-md-4 control-label" ClientIDMode="Static" runat="server" AssociatedControlID="htmlObjectives" Text="Objectives:"></asp:Label>
                                    <div class="col-md-8">
                                        <dx:ASPxHtmlEditor Width="100%" Html='<%# Bind("Objectives") %>' ID="htmlObjectives" Height="200px" runat="server" Settings-AllowCustomColorsInColorPickers="False" SettingsHtmlEditing-AllowIdAttributes="False" SettingsHtmlEditing-PasteMode="PlainText" SettingsText-DesignViewTab="Edit"></dx:ASPxHtmlEditor>
                                    </div>
                                </div>
                                <asp:Panel ID="pnlEvidenceText" ClientIDMode="Static" CssClass="form-group row" runat="server">
 <asp:Label ID="lblEvidence" CssClass="col-md-4 control-label" runat="server" AssociatedControlID="htmlEvidenceText" ClientIDMode="Static" Text="Evidence text:"></asp:Label>
                                    <div class="col-md-8">
                                        <dx:ASPxHtmlEditor Width="100%" Html='<%# Bind("EvidenceText") %>' ID="htmlEvidenceText" Height="200px" runat="server" Settings-AllowCustomColorsInColorPickers="False" SettingsHtmlEditing-AllowIdAttributes="False" SettingsHtmlEditing-PasteMode="PlainText" SettingsText-DesignViewTab="Edit"></dx:ASPxHtmlEditor>
                                    </div>
                                </asp:Panel>
                             
  
                                
                                <div ID="pnlDiagnosticConfig">
<div class="form-group row">
                                    <asp:Label ID="Label10" CssClass="col-md-4 control-label" AssociatedControlID="tbCMIInteractionIDs" runat="server" Text="Diagnostic interaction ID list:"></asp:Label>
                                    <div class="col-md-8">
                                            <asp:TextBox CssClass="form-control" ID="tbCMIInteractionIDs" placeholder="Comma separated list of diagnostic assessment that test against the objectives for this tutorial." runat="server" Text='<%# Bind("CMIInteractionIDs")%>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblDiagOutOf" CssClass="col-md-4 control-label" AssociatedControlID="bspinDiagAssessOutOf" runat="server" Text="Diagnostic possible score:"></asp:Label>
                                    <div class="col-md-8">
                                        <dx:BootstrapSpinEdit ID="bspinDiagAssessOutOf" runat="server" Number='<%# Bind("DiagAssessOutOf") %>' NumberType="Integer"></dx:BootstrapSpinEdit>
                                    </div>
                                </div>
                                </div>
                                       
                                <div id="pnlOfflineConfig">
                                    <div class="form-group row d-none">
                                    <asp:Label ID="Label14" CssClass="col-md-4 control-label" AssociatedControlID="cbLearnerMarksCompletion" runat="server" Text="Learner Marks Completion:"></asp:Label>
                                    <div class="col-md-8">
                                        <asp:CheckBox ID="cbLearnerMarksCompletion" runat="server" Checked='<%# Bind("LearnerMarksCompletion") %>' />
                                    </div>
                                </div>
                                      <div class="form-group row">
                                    <asp:Label ID="Label15" CssClass="col-md-4 control-label" AssociatedControlID="cbIncludeActionPlan" runat="server" Text="Include Action Plan:"></asp:Label>
                                    <div class="col-md-8">
                                        <asp:CheckBox ID="cbIncludeActionPlan" runat="server" Checked='<%# Bind("IncludeActionPlan") %>' />
                                    </div>
                                </div>
                                    <div class="form-group row">
                                    <asp:Label ID="Label16" CssClass="col-md-4 control-label" AssociatedControlID="cbSupervisorVerify" runat="server" Text="Supervisor Verifies Completion:"></asp:Label>
                                    <div class="col-md-8">
                                        <asp:CheckBox ID="cbSupervisorVerify" runat="server" Checked='<%# Bind("SupervisorVerify") %>' />
                                    </div>
                                </div>
                                    <div class="form-group row">
                                    <asp:Label ID="Label17" CssClass="col-md-4 control-label" AssociatedControlID="tbSupervisorSuccessText" runat="server" Text="Supervisor Success Text:"></asp:Label>
                                    <div class="col-md-8">
                                        <asp:TextBox ID="tbSupervisorSuccessText" CssClass="form-control" runat="server" Text='<%# Bind("SupervisorSuccessText") %>' />
                                    </div>
                                </div>
                                    <div class="form-group row">
                                    <asp:Label ID="Label18" CssClass="col-md-4 control-label" AssociatedControlID="tbSupervisorFailText" runat="server" Text="Supervisor Fail Text:"></asp:Label>
                                    <div class="col-md-8">
                                        <asp:TextBox ID="tbSupervisorFailText" CssClass="form-control" runat="server" Text='<%# Bind("SupervisorFailText") %>' />
                                    </div>
                                </div>
                                </div>
                                        
                                <div id="pnlKeyWords" class="form-group row">
<asp:Label ID="lblKeywords" CssClass="col-md-4 control-label" AssociatedControlID="KeywordsTextBox" runat="server" Text="Keywords:"></asp:Label>
                                    <div class="col-md-8">
                                        <asp:TextBox ID="KeywordsTextBox" CssClass="form-control" placeholder="Search terms for Knowledge Bank separated by spaces" TextMode="MultiLine" runat="server" Text='<%# Bind("Keywords") %>' ToolTip="Additional search terms for Knowledge Bank" />
                                    </div>
                                </div>
                                
                                <div class="form-group row">
                                    <asp:Label ID="lblActive" CssClass="col-md-4 control-label" AssociatedControlID="ActiveCheckBox" runat="server" Text="Active"></asp:Label>
                                    <div class="col-md-8">
                                        <asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Bind("Active") %>' />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer clearfix">
                            <asp:LinkButton ID="UpdateCancelButton" CssClass="btn btn-outline-secondary float-left mr-auto" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                            <asp:LinkButton ID="UpdateButton" CssClass="btn btn-primary float-right" runat="server" CausesValidation="True" CommandName="Update" Text="Update" ValidationGroup="UpdateTutorial" />
                            
                        </div>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <div class="card-body">
                            <div class="m-3">
                                <asp:HiddenField ID="hfSectionID" runat="server" Value='<%# Bind("SectionID") %>' />
                                <div class="form-group row">
                                    <asp:Label ID="Label9" CssClass="control-label col-md-4" runat="server" AssociatedControlID="ddContentType">Content Type:</asp:Label>
                                    <div class="col-md-8">
                                        <asp:DropDownList CssClass="form-control"  SelectedValue='<%# Bind("ContentTypeID") %>' ClientIDMode="Static" ID="ddContentType" runat="server">
                                            <asp:ListItem Text="Online learning" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Offline learning" Enabled="false" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Classroom learning" Enabled="false" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="Self Assessment" Value="4"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblTutName" ClientIDMode="Static" CssClass="col-md-4 control-label" AssociatedControlID="TutorialNameTextBox" runat="server" Text="Tutorial Name:"></asp:Label>
                                    <div class="col-md-8">
                                        <asp:TextBox ID="TutorialNameTextBox" CssClass="form-control" runat="server" Text='<%# Bind("TutorialName") %>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="Label12" CssClass="col-md-4 control-label" runat="server" AssociatedControlID="htmlDescription" Text="Description:"></asp:Label>
                                    <div class="col-md-8">
                                        <dx:ASPxHtmlEditor Width="100%" Html='<%# Bind("Description") %>' ID="htmlDescription" Height="200px" runat="server" Settings-AllowCustomColorsInColorPickers="False" SettingsHtmlEditing-AllowIdAttributes="False" SettingsHtmlEditing-PasteMode="PlainText" SettingsText-DesignViewTab="Edit"></dx:ASPxHtmlEditor>
                                    </div>
                                </div>
                                <div id="pnlVideoTutorialCtrls">
                                <div class="form-group row">
                                    <asp:Label ID="lblVideo" AssociatedControlID="VideoPathTextBox" CssClass="col-md-4 control-label" runat="server" Text="Video URL:"></asp:Label>
                                    <div class="col-8">
                                         <asp:TextBox ID="VideoPathTextBox" runat="server" Text='<%# Bind("VideoPath") %>' CssClass="form-control" /><div class="input-group">
                                            <span class="input-group-prepend">
                                            <span class="btn btn-outline-secondary btn-file">Browse&hellip;
                                                <asp:FileUpload AllowMultiple="false" ID="fupVideo"  runat="server" />
                                                
                                            </span>
                                        </span>
                                           <input type="text" placeholder=".mp4 video file only" class="form-control" readonly="true">
                                            <span class="input-group-append">
                                                <asp:LinkButton ID="lbtUploadTutVideo" CausesValidation="true" ValidationGroup="vgVideoUpload" CommandName="UploadVideo" CommandArgument='<%# Eval("SectionID")%>' CssClass="btn btn-outline-secondary" ToolTip="Upload Video" runat="server"><i aria-hidden="true" class="fas fa-file-upload"></i> Upload</asp:LinkButton>
                                            </span>
                                        </div><asp:RegularExpressionValidator ID="rfvUploadVideo" runat="server" ControlToValidate="fupVideo" CssClass="bg-danger"
 Tooltip=".mp4 format only" ErrorMessage=".mp4 format only"
 ValidationExpression="(.+\.([Mm][Pp][4]))" ValidationGroup="vgVideoUpload"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblTutorial" CssClass="col-md-4 control-label" AssociatedControlID="TutorialPathTextBox" runat="server" Text="Tutorial URL:"></asp:Label>
                                    <div class="col-8">
                                        <asp:TextBox ID="TutorialPathTextBox" runat="server" Text='<%# Bind("TutorialPath") %>' CssClass="form-control" /><div class="input-group">
                                            <span class="input-group-prepend">
                                            <span class="btn btn-outline-secondary btn-file">Browse&hellip;
                                                <asp:FileUpload AllowMultiple="false" ID="fupTutorial" runat="server" />
                                            </span>
                                        </span>
                                            <input type="text" placeholder=".zip Content Creator CDA / valid SCORM package" class="form-control" readonly="true">
                                            <span class="input-group-append">
                                                <asp:LinkButton ID="lbtUploadTutorial" CausesValidation="true" ValidationGroup="vgTutorialUpload" CommandName="UploadTutorial" CommandArgument='<%# Eval("SectionID")%>' CssClass="btn btn-outline-secondary" ToolTip="Upload Tutorial" runat="server"><i aria-hidden="true" class="fas fa-file-upload"></i> Upload</asp:LinkButton>
                                            </span>
                                        </div><asp:RegularExpressionValidator ID="rfvUploadTutorial" runat="server" ControlToValidate="fupTutorial" CssClass="bg-danger"
 Tooltip=".zip format only" ErrorMessage=".zip format only"
 ValidationExpression="(.+\.([Zz][Ii][Pp]))" ValidationGroup="vgTutorialUpload"></asp:RegularExpressionValidator>
                                    </div>
                                    
                                </div>
                                    
                                <div class="form-group row">
                                    <asp:Label ID="Label11" CssClass="col-md-4 control-label" AssociatedControlID="bsSpinOverrideTutorialMins" runat="server" Text="Override Tutorial Mins:"></asp:Label>
                                    <div class="col-8">
                                          <div class="input-group">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text">0 = don't override</div>
                                            </div>
                                        <dx:BootstrapSpinEdit ID="bsSpinOverrideTutorialMins" NumberType="Integer" Number='<%# Bind("OverrideTutorialMins") %>' runat="server" MaxValue="60" ToolTip="0 = use calculated average tutorial time"></dx:BootstrapSpinEdit>
                                            </div>
                                    </div>
                                </div>
                                    <asp:Panel runat="server"  Visible='<%# Session("UserPublishToAll") %>'>
                                    <div class="form-group row">
                                    <asp:Label ID="Label13" CssClass="col-md-4 control-label" AssociatedControlID="cbAllowPreview" runat="server" Text="Allow unauthenticated preview:"></asp:Label>
                                    <div class="col-md-8">
                                        <asp:CheckBox ID="cbAllowPreview" runat="server" Checked='<%# Bind("AllowPreview") %>' />
                                    </div>
                                </div></asp:Panel>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblSupportMats" AssociatedControlID="SupportingMatsPathTextBox" CssClass="col-md-4 control-label" runat="server" Text="Support Materials URL:"></asp:Label>
                                    <div class="col-8">
                                        <asp:TextBox ID="SupportingMatsPathTextBox" runat="server" Text='<%# Bind("SupportingMatsPath") %>' CssClass="form-control" />
                                        <div class="input-group">
                                            <span class="input-group-prepend">
                                            <span class="btn btn-outline-secondary btn-file">Browse&hellip;
                                                <asp:FileUpload AllowMultiple="false" ID="fupSupporMats" runat="server" />
                                            </span>
                                        </span>
                                            <input type="text" placeholder="html or zip file" class="form-control" readonly="true">
                                            <span class="input-group-append">
                                                <asp:LinkButton ID="lbtUploadSuppportMats" CausesValidation="true" ValidationGroup="vgSupportUpload" CommandName="UploadSupport" CommandArgument='<%# Eval("SectionID")%>' CssClass="btn btn-outline-secondary" ToolTip="Upload Supporting Materials" runat="server"><i aria-hidden="true" class="fas fa-file-upload"></i> Upload</asp:LinkButton>
                                            </span>
                                        </div>
                                        <asp:RegularExpressionValidator ID="rfvSupportMats" runat="server" ControlToValidate="fupSupporMats" CssClass="bg-danger"
 Tooltip=".htm, .html, .zip, .docx or .pdf format" ErrorMessage=".htm, .html, .pdf, .docx or .zip format only"
 ValidationExpression="(.+\.([Hh][Tt][Mm])|.+\.([Hh][Tt][Mm][Ll])|.+\.([Zz][Ii][Pp])|.+\.([Pp][Dd][Ff]))|.+\.([Dd][Oo][Cc][Xx])" ValidationGroup="vgSupportUpload"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                                
                                <div class="form-group row">
                                    <asp:Label ID="lblActive" CssClass="col-md-4 control-label" AssociatedControlID="ActiveCheckBox" runat="server" Text="Active"></asp:Label>
                                    <div class="col-md-8">
                                        <asp:CheckBox ID="ActiveCheckBox" runat="server" Checked='<%# Bind("Active") %>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblObjectives" CssClass="col-md-4 control-label" ClientIDMode="Static" runat="server" AssociatedControlID="htmlObjectives" Text="Objectives:"></asp:Label>
                                    <div class="col-md-8">
                                        <dx:ASPxHtmlEditor Width="100%" Html='<%# Bind("Objectives") %>' ID="htmlObjectives" Height="200px" runat="server" Settings-AllowCustomColorsInColorPickers="False" SettingsHtmlEditing-AllowIdAttributes="False" SettingsHtmlEditing-PasteMode="PlainText" SettingsText-DesignViewTab="Edit"></dx:ASPxHtmlEditor>
                                    </div>
                                </div>
                                <div id="pnlEvidenceText" class="form-group row">
 <asp:Label ID="lblEvidence" CssClass="col-md-4 control-label" runat="server" AssociatedControlID="htmlEvidenceText" ClientIDMode="Static" Text="Evidence text:"></asp:Label>
                                    <div class="col-md-8">
                                        <dx:ASPxHtmlEditor Width="100%" Html='<%# Bind("EvidenceText") %>' ID="htmlEvidenceText" Height="200px" runat="server" Settings-AllowCustomColorsInColorPickers="False" SettingsHtmlEditing-AllowIdAttributes="False" SettingsHtmlEditing-PasteMode="PlainText" SettingsText-DesignViewTab="Edit"></dx:ASPxHtmlEditor>
                                    </div>
                                </div>
                                <div id="pnlDiagnosticConfig">
<div class="form-group row">
                                    <asp:Label ID="Label10" CssClass="col-md-4 control-label" AssociatedControlID="tbCMIInteractionIDs" runat="server" Text="Diagnostic interaction ID list:"></asp:Label>
                                    <div class="col-md-8">
                                            <asp:TextBox CssClass="form-control" ID="tbCMIInteractionIDs" placeholder="Comma separated list of diagnostic assessment that test against the objectives for this tutorial." runat="server" Text='<%# Bind("CMIInteractionIDs")%>' />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <asp:Label ID="lblDiagOutOf" CssClass="col-md-4 control-label" AssociatedControlID="bspinDiagAssessOutOf" runat="server" Text="Diagnostic possible score:"></asp:Label>
                                    <div class="col-md-8">
                                        <dx:BootstrapSpinEdit ID="bspinDiagAssessOutOf" runat="server" Number='<%# Bind("DiagAssessOutOf") %>' NumberType="Integer"></dx:BootstrapSpinEdit>
                                    </div>
                                </div>
                                </div>
                                <div id="pnlOfflineConfig">
                                    <div class="form-group row d-none">
                                    <asp:Label ID="Label14" CssClass="col-md-4 control-label" AssociatedControlID="cbLearnerMarksCompletion" runat="server" Text="Learner Marks Completion:"></asp:Label>
                                    <div class="col-md-8">
                                        <asp:CheckBox ID="cbLearnerMarksCompletion" runat="server" Checked='<%# Bind("LearnerMarksCompletion") %>' />
                                    </div>
                                </div>
                                      <div class="form-group row">
                                    <asp:Label ID="Label15" CssClass="col-md-4 control-label" AssociatedControlID="cbIncludeActionPlan" runat="server" Text="Include Action Plan:"></asp:Label>
                                    <div class="col-md-8">
                                        <asp:CheckBox ID="cbIncludeActionPlan" runat="server" Checked='<%# Bind("IncludeActionPlan") %>' />
                                    </div>
                                </div>
                                    <div class="form-group row">
                                    <asp:Label ID="Label16" CssClass="col-md-4 control-label" AssociatedControlID="cbSupervisorVerify" runat="server" Text="Supervisor Verifies Completion:"></asp:Label>
                                    <div class="col-md-8">
                                        <asp:CheckBox ID="cbSupervisorVerify" runat="server" Checked='<%# Bind("SupervisorVerify") %>' />
                                    </div>
                                </div>
                                    <div class="form-group row">
                                    <asp:Label ID="Label17" CssClass="col-md-4 control-label" AssociatedControlID="tbSupervisorSuccessText" runat="server" Text="Supervisor Success Text:"></asp:Label>
                                    <div class="col-md-8">
                                        <asp:TextBox ID="tbSupervisorSuccessText" CssClass="form-control" runat="server" Text='<%# Bind("SupervisorSuccessText") %>' />
                                    </div>
                                </div>
                                    <div class="form-group row">
                                    <asp:Label ID="Label18" CssClass="col-md-4 control-label" AssociatedControlID="tbSupervisorFailText" runat="server" Text="Supervisor Fail Text:"></asp:Label>
                                    <div class="col-md-8">
                                        <asp:TextBox ID="tbSupervisorFailText" CssClass="form-control" runat="server" Text='<%# Bind("SupervisorFailText") %>' />
                                    </div>
                                </div>
                                </div>
                                <div class="form-group row" runat="server">
<asp:Label ID="lblKeywords" CssClass="col-md-4 control-label" AssociatedControlID="KeywordsTextBox" runat="server" Text="Keywords:"></asp:Label>
                                    <div class="col-md-8">
                                        <asp:TextBox ID="KeywordsTextBox" CssClass="form-control" placeholder="Search terms for Knowledge Bank separated by spaces" TextMode="MultiLine" runat="server" Text='<%# Bind("Keywords") %>' ToolTip="Additional search terms for Knowledge Bank" />
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="card-footer clearfix">
                            <asp:LinkButton ID="InsertCancelButton" CssClass="btn btn-outline-secondary float-left mr-auto" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                            <asp:LinkButton ID="InsertButton" CssClass="btn btn-primary float-right" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" ValidationGroup="InsertTutorial" />
                            
                        </div>
                    </InsertItemTemplate>

                </asp:FormView>
            </div>
            <script>
                (function ($) {
                    $('.spinner .btn:first-of-type').on('click', function () {
                        $('.spinner input').val(parseInt($('.spinner input').val(), 10) + 1);
                    });
                    $('.spinner .btn:last-of-type').on('click', function () {
                        $('.spinner input').val(parseInt($('.spinner input').val(), 10) - 1);
                    });
                })(jQuery);
            </script>
        </asp:View>
        <asp:View ID="vImportTutorial" runat="server">
             <div class="card card-primary">
                <div class="card-header">
                    <asp:Label ID="Label3" runat="server" Text="Import Course Tutorial"></asp:Label>
                </div>
                 <div class="card-body">
                    <asp:ObjectDataSource ID="dsSectionsForTutorialImport" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActive" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.SectionsTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddCourseForTutorialImport" Name="ApplicationID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
                     <asp:ObjectDataSource ID="dsTutorialsForImport" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetActive" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.TutorialsTableAdapter">
                        
                         <SelectParameters>
                             <asp:ControlParameter ControlID="ddSectionsForTutorialImport" Name="SectionID" PropertyName="SelectedValue" Type="Int32" />
                         </SelectParameters>
                        
                     </asp:ObjectDataSource>
                     <asp:HiddenField ID="hfSectionIDImport" runat="server" />
                 <div class="m-3">
                     <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                         <ContentTemplate>
 <div class="form-group row">
                                    <asp:Label ID="Label7" CssClass="col-md-4 control-label" AssociatedControlID="ddCourseForTutorialImport" runat="server" Text="Course to import from:"></asp:Label>
                                    <div class="col-8">
                     <asp:DropDownList ID="ddCourseForTutorialImport" CssClass="form-control" runat="server" DataSourceID="dsCoursesForImport" DataTextField="ApplicationName" DataValueField="ApplicationID" AutoPostBack="True"></asp:DropDownList>
                                        </div>
                          </div>
                      <div class="form-group row">
                                    <asp:Label ID="Label8" CssClass="col-md-4 control-label" AssociatedControlID="ddSectionsForTutorialImport" runat="server" Text="Section:"></asp:Label>
                                    <div class="col-8">
                     <asp:DropDownList ID="ddSectionsForTutorialImport" CssClass="form-control" runat="server" DataSourceID="dsSectionsForTutorialImport" DataTextField="SectionName" DataValueField="SectionID" AutoPostBack="True"></asp:DropDownList>
                                        </div>
                          </div>
                             <div class="form-group row">
                                    <asp:Label ID="Label9" CssClass="col-md-4 control-label" AssociatedControlID="ddTutorialToImport" runat="server" Text="Tutorial to import:"></asp:Label>
                                    <div class="col-8">
                     <asp:DropDownList ID="ddTutorialToImport" CssClass="form-control" runat="server" DataSourceID="dsTutorialsForImport" DataTextField="TutorialName" DataValueField="TutorialID"></asp:DropDownList>
                                        </div>
                          </div>
                         </ContentTemplate>
                     </asp:UpdatePanel>
                     </div>
                 </div>
                 <div class="card-footer clearfix">
                     <asp:LinkButton ID="lbtImportTutorialCancel" CssClass="btn btn-outline-secondary mr-auto" runat="server">Cancel</asp:LinkButton>
                     <asp:LinkButton ID="lbtImportTutorialConfirm" CssClass="btn btn-primary float-right" runat="server">Import</asp:LinkButton>
                 </div>
             </div>
        </asp:View>
        <asp:View ID="vCompetencyAssess" runat="server">
            <asp:ObjectDataSource ID="dsCompetency" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetByTutorialID" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.TutorialsTableAdapter">
                <SelectParameters>
                    <asp:Parameter Name="TutorialID" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
            
            <asp:FormView ID="fvCompetency" DataSourceID="dsCompetency" DataKeyNames="TutorialID" RenderOuterTable="false" DefaultMode="ReadOnly" runat="server">
                <ItemTemplate>
                    <div class="card card-primary">
                        <div class="card-header">
                            <h4>Skill: <%# Eval("TutorialName") %><small></small></h4>
                        </div>
                        <div class="card-body">



                            <h6>Definition</h6>
                            <p><%# Eval("Description") %></p>
                            <h6>Required Knowledge and Experience</h6>
                            <p><%# Eval("Objectives") %></p>
                            <div class="card card-default mb-2">
                                <div class="card-header" data-toggle="collapse" data-target='<%# "#selfassess-" & Eval("TutorialID") %>' aria-controls='<%# "selfassess-" & Eval("TutorialID") %>' aria-expanded="false" role="button"  style="cursor:pointer;">
                                    <div  class="d-flex w-100 justify-content-between"><h6 class="mt-1 mb-1">Self Assessment</h6>
                                    <div class="mt-1">Current Status: <b>Not Assessed</b></div></div>
                                </div>
                                <div id='<%# "selfassess-" & Eval("TutorialID") %>' class="card-body collapse">
                                    <asp:HiddenField ID="hfAssessmentTypeID" Value='<%# Eval("AssessmentTypeID") %>' runat="server" />
                                    <asp:ObjectDataSource ID="dsAssessDescriptors" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetByAssessmentTypeID" TypeName="ITSP_TrackingSystemRefactor.itspdbTableAdapters.AssessmentTypeDescriptorsTableAdapter">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="hfAssessmentTypeID" Name="AssessmentTypeID" PropertyName="Value" Type="Int32" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                    <p>Users will be asked to rate their current level against this skill using the following scale:</p>
                                    <asp:Repeater ID="rptAssessDescs" DataSourceID="dsAssessDescriptors" runat="server">
                                        <ItemTemplate>
                                            <div class="list-group">
                                                <div class="list-group-item mb-1">
                                                    <div data-toggle="collapse" data-target='<%# "#desc-" & Eval("AssessmentTypeDescriptorID") %>' role="button" aria-expanded="false" aria-controls='<%# "desc-" & Eval("AssessmentTypeDescriptorID") %>' style="cursor:pointer;" class="d-flex w-100 justify-content-between">
                                                        <b class="mb-1"><%# Eval("DescriptorText") %></b>
                                                        <small>Weight: <%# Eval("WeightingScore") %></small>
                                                    </div>
                                                    <p id='<%# "desc-" & Eval("AssessmentTypeDescriptorID") %>' class="mb-1 collapse"><%# Eval("DescriptorDetail") %></p>
                                                </div>
                                            </div>
                                           
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <p>Users will be able to review each skill whenever they need to (typically when they complete actions or the evidence changes).</p>
                                    <asp:Panel ID="pnlSV" Visible='<%# Eval("SupervisorVerify") %>' runat="server">
<p>Each time a new self assessment is made, it will be subitted for review by their supervisor who will verify it with one of the following outcomes:</p>
                                        <div class="row">
                                            <div class="col"><div class="alert alert-success"><%# Eval("SupervisorSuccessText") %></div></div>
                                            <div class="col"><div class="alert alert-danger"><%# Eval("SupervisorFailText") %></div></div>
                                        </div>
                                    </asp:Panel>
                                    
                                    
                                </div>
                            </div>
                             <div class="card card-default mb-2">
                                <div class="card-header"  data-toggle="collapse" data-target='<%# "#evidence-" & Eval("TutorialID") %>' aria-controls='<%# "evidence-" & Eval("TutorialID") %>' aria-expanded="false" role="button"  style="cursor:pointer;">
                                    <div  class="d-flex w-100 justify-content-between"><h6 class="mt-1 mb-1">Evidence</h6>
                                     <div class="mt-1">Evidence items: <b>0</b></div></div>
                                </div>
                                <div class="card-body collapse" id='<%# "evidence-" & Eval("TutorialID") %>'>
                                    <div class="alert alert-info">Use this section to provide evidence to support your self assessment against this skill.</div>
                                    <div class="card card-default">
                                        <div class="card-body"><%# Eval("EvidenceText") %></div>
                                        </div>
                                    <p>The user will have the opportunity to add evidence that demonstrates this skill. Each piece of evidence will record:</p>
                                    <ul>
                                        <li>Completed date</li>
                                        <li>Duration <small>(optional)</small></li>
                                        <li>Method of completion</li>
                                        <li>Activity</li>
                                        <li>Outcomes / Evidence descriptor</li>
                                        <li>Supporting files <small>(optional)</small></li>
                                    </ul>
                                    <p>A piece of evidence may be linked to more than one skill.</p>
                                    </div>
                                 </div>
                            <div class="card card-default mb-2">
                                <div class="card-header"  data-toggle="collapse" data-target='<%# "#actionplan-" & Eval("TutorialID") %>' aria-controls='<%# "actionplan-" & Eval("TutorialID") %>' aria-expanded="false" role="button"  style="cursor:pointer;">
                                    <div  class="d-flex w-100 justify-content-between">
                                    <h6 class="mt-1 mb-1">Action Plan</h6>
                                    <div class="mt-1">Open actions: <b>0</b></div></div>
                                </div>
                                <div class="card-body collapse" id='<%# "actionplan-" & Eval("TutorialID") %>'>
                                    <div class="alert alert-info">Use this section to record planned development actions to improve this skill. Once completed, actions will become evidence.</div>
                                     <p>The user will have the opportunity to add actions intended to improve. Each action will record:</p>
                                    <ul>
                                        <li>Due date</li>
                                        <li>Intended method of completion</li>
                                        <li>Activity</li>
                                        <li>Intended outcomes</li>
                                    </ul>
                                    <p>An action may be linked to more than one skill.</p>
                                    <p>An action may involve enrolment on a course managed through DLS, if so, the course will appear on the user's Current courses list in the Learning Portal with the due date scheduled. When completed, the action will be automatically closed and added as evidence.</p>
                                    </div>
                                 </div>
                        </div>
                        <div class="card-footer">
                            <asp:LinkButton ID="lbtCloseCompetency" OnCommand="lbtCloseCompetency_Command" CssClass="btn btn-primary float-right" runat="server">Close</asp:LinkButton>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:FormView>
            
        </asp:View>
    </asp:MultiView>
    <!-- Standard Modal Message  -->
    <div id="modalMessage" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="lblModalText" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    
                    <h5 class="modal-title">
                        <asp:Label ID="lblModalHeading" runat="server"></asp:Label></h5><button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <p>
                        <asp:Label ID="lblModalText" runat="server"></asp:Label>
                    </p>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary float-right" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Objectives Modal Message  -->
    <div id="objectivesModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="lblModalText" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    
                    <h5 class="modal-title">
                        <asp:Label ID="Label5" runat="server">Objectives</asp:Label></h5><button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="objective-html">

                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary float-right" data-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div> 
    <!-- Video Modal Message  -->
    <div id="videoModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="lblModalText" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                   
                    <h5 class="modal-title">
                        <asp:Label ID="Label6" runat="server">Video Preview</asp:Label></h5> <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="videodiv embed-responsive embed-responsive-4by3">
</div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary float-right" data-dismiss="modal">OK</button>

                </div>
            </div>
        </div>
    </div>
     <!-- Upload Modal Message  -->
    <div id="selectFileModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="lblModalText" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    
                    <h5 class="modal-title">
                        <asp:Label ID="lblUploadTitle" runat="server">Select File from Zip</asp:Label></h5><button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="table-responsive">
                        <asp:HiddenField ID="hfFileField" runat="server" />
                        <asp:HiddenField ID="hfFilePath" runat="server" />
                    <asp:GridView CssClass="table table-striped" ID="gvSelectFile" GridLines="None" runat="server" AutoGenerateColumns="false">
    <Columns>
        <asp:TemplateField ShowHeader="False">
                                                <ItemTemplate>
                                                    <asp:LinkButton cssclass="btn btn-primary" ID="lbtSelectFile" runat="server" CausesValidation="False" CommandArgument='<%# Eval("FileName")%>' CommandName="Select" Text="Select"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
        <asp:BoundField DataField="FileName" HeaderText="File Name" />
        <asp:BoundField DataField="UncompressedSize" HeaderText="Size (Bytes)" />
    </Columns>
</asp:GridView>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton cssclass="btn btn-outline-secondary float-right"  ID="lbtSearchCancel" data-dismiss="modal" runat="server" Enabled="False">Cancel</asp:LinkButton>
                    

                </div>
                </div>
            </div>
        </div>
    </div>
     <script>
         Sys.Application.add_load(BindEvents);
     </script>          
</asp:Content>
