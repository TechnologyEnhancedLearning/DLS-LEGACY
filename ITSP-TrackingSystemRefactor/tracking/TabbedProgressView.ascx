<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TabbedProgressView.ascx.vb" Inherits="ITSP_TrackingSystemRefactor.TabbedProgressView" %>
<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<link href="../Content/LearnMenu.css" rel="stylesheet" />
<asp:ObjectDataSource ID="dsProgressDetail" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetByProgressIDsp" TypeName="ITSP_TrackingSystemRefactor.centrecandidatesTableAdapters.ProgressTableAdapter">
    <SelectParameters>
        <asp:SessionParameter Name="ProgressID" SessionField="dvProgressID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="dsEvents" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.centrecandidatesTableAdapters.LearningEventsTableAdapter">
    <SelectParameters>
        <asp:SessionParameter Name="ProgressID" SessionField="dvProgressID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<div style="overflow-x: auto">
    <dx:BootstrapPageControl TabAlign="Justify" ID="bspcDetailRow" runat="server" EnableCallBacks="true" EnableCallbackAnimation="true">
        <CssClasses Content="bstc-content" />
        <TabPages>
            <dx:BootstrapTabPage Text="Current Progress">
                <ContentCollection>
                    <dx:ContentControl runat="server" SupportsDisabledAttribute="True">

                        <%--<div class="card card-default clearfix">
                        <div class="card-body clearfix">--%>
                        <asp:FormView ID="fvProgressDetail" OnDataBinding="fvProgressDetail_DataBinding" DataSourceID="dsProgressDetail" DefaultMode="ReadOnly" RenderOuterTable="false" runat="server" DataKeyNames="ProgressID">
                            <ItemTemplate>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="list-group">
                                            <div class="list-group-item">
                                                Enrolled:
                                                    <asp:Label CssClass="float-right text-muted" ID="FirstSubmittedTimeLabel" runat="server" Text='<%# Bind("FirstSubmittedTime", "{0:dd/MM/yyyy}") %>' />
                                            </div>
                                            <div class="list-group-item">
                                                <div class="form-group row">
                                                    
                                                        <asp:Label ID="Label26" AssociatedControlID="tbSupervisor" CssClass="control-label col-sm-3" runat="server" Text="Supervisor: "></asp:Label>
                                                    <div class="input-group  col-sm-9">
                                                        <asp:TextBox Enabled="false" ID="tbSupervisor" CssClass="form-control" runat="server" Text='<%# Bind("Supervisor") %>'></asp:TextBox>
                                                        <span class="input-group-append">
                                                            <button type="button" class="btn btn-outline-success" title="Set / Change Supervisor" data-toggle="modal" data-target="#modalSetSupervisor"><i class="fas fa-pen"></i></button>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="list-group-item">

                                                <div class="form-group row">

                                                    <asp:Label ID="Label21" AssociatedControlID="lblTBCDate" CssClass="control-label col-sm-3" runat="server" Text="Complete by: "></asp:Label>
                                                    <div class="input-group  col-sm-9">
                                                        <asp:TextBox Enabled="false" ID="lblTBCDate" CssClass="form-control" runat="server" Text='<%# Bind("CompleteByDate", "{0:dd/MM/yyyy}") %>'></asp:TextBox>
                                                        <span class="input-group-append">
                                                            <button type="button" class="btn btn-outline-success" title="Edit Complete By" data-toggle="modal" data-target="#modalSetTBC">
                                                                <i aria-hidden="true" class="fas fa-pen"></i>
                                                            </button>

                                                        </span>
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="list-group-item">
                                                Last Updated:
            <asp:Label CssClass="float-right text-muted" ID="SubmittedTimeLabel" runat="server" Text='<%# Bind("SubmittedTime", "{0:dd/MM/yyyy}") %>' />
                                            </div>
                                            <div class="list-group-item">
                                                <asp:Panel ID="pnlMarkComplete" runat="server" Visible='<%# Eval("Completed").ToString.Length = 0 And Eval("IsAssessed").ToString = "False" %>'>
                                                    Completed:
                                                    <button type="button" class="btn btn-outline-success float-right" data-toggle="modal" data-target="#modalConfirmComplete">
                                                        <i aria-hidden="true" class="fas fa-pen"></i>Confirm Completed Date
                                                    </button>
                                                </asp:Panel>
                                                <asp:Panel ID="pnlReadOnlyComp" Visible='<%# Eval("Completed").ToString.Length > 0 Or Eval("IsAssessed").ToString = "True" %>' runat="server">
                                                    Completed:    
            <asp:Label CssClass="float-right text-muted" ID="CompletedLabel" runat="server" Text='<%# Bind("Completed", "{0:dd/MM/yyyy}") %>' />
                                                </asp:Panel>
                                            </div>
                                            <div class="list-group-item">
                                                Evaluated:
            <asp:Label CssClass="float-right text-muted" ID="EvaluatedLabel" runat="server" Text='<%# Bind("Evaluated", "{0:dd/MM/yyyy}") %>' />
                                            </div>
                                            <div class="list-group-item">
                                                Remove:
                                                <asp:Label CssClass="float-right text-muted" ID="Label23" runat="server" Text='<%# Bind("RemovedDate", "{0:dd/MM/yyyy}") %>' />
                                                <asp:LinkButton ID="lbtArchive" OnCommand="lbtArchive_Command" CssClass="float-right btn btn-sm btn-outline-danger" ToolTip="Remove enrolment" OnClientClick="return confirm('Are you sure you wish to remove this enrolment (the course will no longer appear on the delegate's current/complete courses list and their progress will be marked as removed)?');" CommandArgument='<%# Eval("ProgressID") %>' Visible='<%# Eval("RemovedDate").ToString.Length = 0 %>' runat="server"><i class="fas fa-trash"></i></asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="list-group-item">Enrolment method:
                                            <asp:Label CssClass="float-right text-muted" ID="Label22" runat="server" ToolTip='<%#IIf(Eval("EnrollmentMethodID") = 2, "Enrolled by " & Eval("EnrolledBy"), "") %>' Text='<%# IIf(Eval("EnrollmentMethodID") = 1, "Self", IIf(Eval("EnrollmentMethodID") = 2, "Administrator", IIf(Eval("EnrollmentMethodID") = 3, "Group", "System"))) %>' /></div>

                                        <div class="list-group-item">
                                            Logins:
            <asp:Label CssClass="float-right text-muted" ID="LoginCountLabel" runat="server" Text='<%# Bind("LoginCount") %>' />
                                        </div>
                                        <div class="list-group-item">
                                            Learning time (mins):
            <asp:Label CssClass="float-right text-muted" ID="LearningTimeLabel" runat="server" Text='<%# Bind("LearningTime") %>' />
                                        </div>
                                        <div class="list-group-item">
                                            Diagnostic Score:
            <asp:Label CssClass="float-right text-muted" ID="DiagnosticScoreLabel" runat="server" Text='<%# Bind("DiagnosticScore") %>' />
                                        </div>
                                        <asp:Panel ID="pnlAssessOnly" Visible='<%# Bind("IsAssessed") %>' runat="server">

                                            <div class="list-group-item">
                                                Assessments passed:
            <asp:Label CssClass="float-right text-muted" ID="AssessPassLabel" runat="server" Text='<%# Bind("AssessPass") %>' />
                                            </div>
                                            <div class="list-group-item">
                                                Assessment attempts:
            <asp:Label CssClass="float-right text-muted" ID="AssessCountLabel" runat="server" Text='<%# Bind("AssessCount") %>' />
                                            </div>
                                            <div class="list-group-item">
                                                Pass Ratio
            <asp:Label CssClass="float-right text-muted" ID="AssessRatioLabel" runat="server" Text='<%# Bind("AssessRatio", "{0:F0}%") %>' />
                                            </div>
                                        </asp:Panel>
                                        <asp:Panel ID="pnlAdminQs" Visible='<%# Eval("Question1").ToString.Length > 0 Or Eval("Question2").ToString.Length > 0 Or Eval("Question3").ToString.Length > 0 %>' CssClass="card card-secondary mt-1" runat="server">
                                            <div class="card-header p-1"><strong>Course Admin Fields</strong><asp:LinkButton ID="EditCustFields" Visible="False" EnableViewState="false" ToolTip="Edit custom admin field values"  CssClass="btn btn-outline-success btn-sm float-right" runat="server"><i aria-hidden="true" class="fas fa-pencil-alt"></i></asp:LinkButton></div>
                                            <div class="card-body">
                                        <asp:Panel ID="pnlQ1" Visible='<%# Eval("Question1").ToString.Length > 0 %>' CssClass="list-group-item" runat="server">
                                            <%# Eval("Question1") %>
                                            <asp:Label CssClass="float-right text-muted" ID="Label24" runat="server" Text='<%# Bind("Answer1") %>' />
                                        </asp:Panel>
                                        <asp:Panel ID="pnlQ2" Visible='<%# Eval("Question2").ToString.Length > 0 %>' CssClass="list-group-item" runat="server">
                                            <%# Eval("Question2") %>
                                            <asp:Label CssClass="float-right text-muted" ID="Label25" runat="server" Text='<%# Bind("Answer2") %>' />
                                        </asp:Panel>
                                        <asp:Panel ID="pnlQ3" Visible='<%# Eval("Question3").ToString.Length > 0 %>' CssClass="list-group-item" runat="server">
                                            <%# Eval("Question3") %>
                                            <asp:Label CssClass="float-right text-muted" ID="Label27" runat="server" Text='<%# Bind("Answer3") %>' />
                                        </asp:Panel></div></asp:Panel>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:FormView>

                        <%--</div>
                    </div>--%>
                        <div class="modal fade" tabindex="-1" id="modalConfirm" role="dialog">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">

                                        <h5 class="modal-title">Remove Enrolment?</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    </div>
                                    <div class="modal-body">
                                        <asp:HiddenField ID="hfRemoveProgressID" runat="server" />
                                        <p>Are you sure that you wish to remove this course from the delegate's Current/Completed Courses list and archive their progress?</p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-outline-secondary mr-auto float-left" data-dismiss="modal">Cancel</button>
                                        <asp:LinkButton ID="lbtConfirmRemove" OnCommand="lbtConfirmRemove_Command" ToolTip="Confirm remove" class="btn btn-danger float-right" runat="server">Remove</asp:LinkButton>
                                    </div>
                                </div>
                                <!-- /.modal-content -->
                            </div>
                            <!-- /.modal-dialog -->
                        </div>
                        <!-- /.modal -->
                    </dx:ContentControl>
                </ContentCollection>
            </dx:BootstrapTabPage>
            <dx:BootstrapTabPage Text="Learning Log">
                <ContentCollection>
                    <dx:ContentControl runat="server" SupportsDisabledAttribute="True">
                        <%--<div class="card card-default clearfix">--%>
                        <dx:BootstrapGridView ID="bsgvEvents" runat="server" OnBeforePerformDataSelect="subDetailGrid_DataSelect" AutoGenerateColumns="False" DataSourceID="dsEvents">
                            <SettingsBootstrap Striped="True" />
                            <Columns>
                                <dx:BootstrapGridViewDateColumn Caption="When" FieldName="EventTime" PropertiesDateEdit-DisplayFormatString="{0:dd/MM/yyyy HH:mm}" ReadOnly="True" VisibleIndex="2">
                                    <PropertiesDateEdit DisplayFormatString="{0:dd/MM/yyyy HH:mm}"></PropertiesDateEdit>
                                </dx:BootstrapGridViewDateColumn>
                                <dx:BootstrapGridViewTextColumn Caption="Assessment Taken" FieldName="SectionName" ReadOnly="True" VisibleIndex="4">
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn Caption="Assessment Score" FieldName="Score" ReadOnly="True" VisibleIndex="5">
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn Caption="Assessment Status" FieldName="Status" ReadOnly="True" VisibleIndex="6">
                                </dx:BootstrapGridViewTextColumn>
                                <dx:BootstrapGridViewTextColumn Caption="Learning time (mins)" FieldName="Duration" ReadOnly="True" VisibleIndex="3">
                                </dx:BootstrapGridViewTextColumn>
                            </Columns>
                        </dx:BootstrapGridView>
                        <%--</div>--%>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:BootstrapTabPage>
        </TabPages>
    </dx:BootstrapPageControl>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="False">
        <ContentTemplate>
            <div class="card-eighty card-default">
                <div class="card-footer clearfix">
                    <asp:LinkButton ID="lbtViewDetailedProgress" CssClass="btn btn-info btn-sm float-right" runat="server">View detailed progress</asp:LinkButton>
                </div>
            </div>




            <!-- Modal message-->
            <div class="modal fade" id="detailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog modal-xl" role="document">
                    <div class="modal-content">
                        <div class="modal-header">

                            <h5 class="modal-title" id="myModalLabel">Detailed Progress</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        </div>
                        <div class="modal-body">
                            <asp:ObjectDataSource ID="dsProgHead" runat="server" OldValuesParameterFormatString="original_{0}"
                                SelectMethod="GetDataByProgressID" TypeName="ITSP_TrackingSystemRefactor.centrecandidatesTableAdapters.ProgressHeaderTableAdapter">
                                <SelectParameters>
                                    <asp:SessionParameter Name="ProgressID" SessionField="dvProgressID" Type="Int32" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                            <asp:FormView ID="fvProgHead" RenderOuterTable="False" runat="server" DataSourceID="dsProgHead">
                                <ItemTemplate>
                                    <div class="clearfix" style="margin-bottom: 12px;">
                                        <div class="row">
                                            <div class="col-8 col-sm-8">
                                                <asp:Label ID="Label2" runat="server" Text="Name:" Font-Bold="True"></asp:Label>&nbsp;
										<asp:Label ID="Label1" runat="server" Text='<%# Eval("Delegate") %>'></asp:Label>
                                                &nbsp;<asp:Label ID="Label3" runat="server" Text="ID:" Font-Bold="True"></asp:Label>&nbsp;
										<asp:Label ID="Label4" runat="server" Text='<%# Eval("CandidateNumber") %>'></asp:Label>
                                                &nbsp;<asp:Label ID="Label5" runat="server" Text="Course:" Font-Bold="True"></asp:Label>&nbsp;
										<asp:Label ID="Label6" runat="server" Text='<%# Eval("Course") %>'></asp:Label>
                                                <br />
                                                <asp:Label ID="Label7" runat="server" Text="First access:" Font-Bold="True"></asp:Label>&nbsp;<asp:Label
                                                    ID="Label8" runat="server" Text='<%# Eval("First accessed", "{0:d}") %>' Width="80px"></asp:Label>&nbsp;
                                                <asp:Label ID="Label19" runat="server" Text="To complete by:" Font-Bold="True"></asp:Label>&nbsp;<asp:Label
                                                    ID="Label20" runat="server" Text='<%# Eval("CompleteByDate", "{0:d}") %>' Width="80px"></asp:Label>&nbsp;
										<asp:Label ID="Label9" runat="server" Text="Last access:" Font-Bold="True"></asp:Label>&nbsp;<asp:Label
                                            ID="Label10" runat="server" Text='<%# Eval("Last accessed", "{0:d}") %>' Width="80px"></asp:Label>&nbsp;
										<asp:Label ID="Label11" runat="server" Text="Completed:" Font-Bold="True"></asp:Label>&nbsp;<asp:Label
                                            ID="Label14" runat="server" Text='<%# Eval("Completed", "{0:d}") %>' Width="80px"></asp:Label>&nbsp;
										<asp:Label ID="Label15" runat="server" Text="Evaluated:" Font-Bold="True"></asp:Label>&nbsp;<asp:Label
                                            ID="Label16" runat="server" Text='<%# Eval("Evaluated", "{0:d}") %>' Width="80px"></asp:Label>
                                                <br />
                                                <asp:Label ID="Label17" runat="server" Text="Overall diagnostic score:" Font-Bold="True"></asp:Label>&nbsp;<asp:Label
                                                    ID="Label18" runat="server" Text='<%# Eval("DiagnosticScore").ToString + "%" %>'
                                                    Width="60px"></asp:Label>
                                            </div>
                                            <div class="col-4 col-sm-4">
                                                <div class="btn-group btn-group-sm float-right" role="group" aria-label="...">
                                                    <asp:LinkButton ID="lbtSummary" CssClass="btn btn-info" CommandArgument='<%# Eval("ProgressID") %>' CommandName="summary" ToolTip="Generate PDF progress summary for printing / saving / sending"
                                                        runat="server"><i aria-hidden="true" class="far fa-file-pdf"></i> PDF Summary</asp:LinkButton>
                                                    <%--<asp:LinkButton
                                                            Visible='<%# Eval("IsAssessed") And Eval("Completed").ToString.Length > 0 And Eval("Evaluated").ToString.Length > 0 %>'
                                                            ID="lbtCert" runat="server" ToolTip="Click to access certificate of completion"
                                                            CssClass="btn btn-success" CommandName="finalise" CommandArgument='<%# Eval("ProgressID") %>'><i aria-hidden="true" class="fas fa-trophy"></i> Certificate</asp:LinkButton>--%>
                                                    <asp:HyperLink ID="HyperLink1"
                                                        ToolTip="Click to access certificate of completion" NavigateUrl='<%# "./finalise?ProgressID=" & Eval("ProgressID") %>' 
                                                            CssClass="btn btn-success" Visible='<%# Eval("IsAssessed") And Eval("Completed").ToString.Length > 0 And Eval("Evaluated").ToString.Length > 0 %>' runat="server"><i aria-hidden="true" class="fas fa-trophy"></i> Certificate</asp:HyperLink>  <asp:LinkButton
                                                        Visible='<%# Eval("IsAssessed") And Eval("Completed").ToString.Length > 0 And Not Eval("Evaluated").ToString.Length > 0 %>'
                                                        ID="LinkButton1" runat="server" ToolTip="Certificate unavailable evaluation incomplete" Enabled="false"
                                                        CssClass="btn btn-outline-secondary text-muted"><i aria-hidden="true" class="fas fa-trophy"></i> Certificate</asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                    </div>


                                </ItemTemplate>
                            </asp:FormView>
                            <asp:ObjectDataSource ID="dsSections" runat="server" OldValuesParameterFormatString="original_{0}"
                                SelectMethod="GetDataByUSP" TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.LMSectionsTableAdapter">
                                <SelectParameters>
                                    <asp:SessionParameter Name="ProgressID" SessionField="dvProgressID" Type="Int32" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                            <asp:GridView ID="gvSections" runat="server" AutoGenerateColumns="False" DataKeyNames="SectionID"
                                DataSourceID="dsSections" ShowHeader="False" Width="100%" GridLines="None">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:ObjectDataSource ID="dsProgressDetail" runat="server" OldValuesParameterFormatString="original_{0}"
                                                SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.uspReturnProgressDetailTableAdapter">
                                                <SelectParameters>
                                                    <asp:Parameter Name="SectionID" Type="Int32" />
                                                    <asp:SessionParameter Name="ProgressID" SessionField="dvProgressID" Type="Int32" />
                                                </SelectParameters>
                                            </asp:ObjectDataSource>

                                            <asp:Panel ID="pnlSectionHeader" CssClass='<%# GetSectionClass(Eval("PCComplete")) %>' runat="server">

                                                <div class="card-header clickable clearfix">
                                                    <asp:Label Font-Bold="true" ID="lblSectionHeader" runat="server" Text='<%#Eval("SectionName")%>'></asp:Label>
                                                    <div class="float-right">
                                                        <asp:Label ID="lblSecStatus" runat="server" Style="font-size: 10px; color: #666666;"
                                                            Text='<%#Eval("PCComplete", "{0}% complete")%>' />
                                                        &nbsp;
																								<asp:Label ID="Label12" Visible='<%#Eval("HasLearning")%>' runat="server" Style="font-size: 10px; color: #666666;" Text='<%#Eval("TimeMins", "{0} mins")%>'
                                                                                                    ToolTip='<%#Eval("TimeMins", "Learner has spent {0} mins on the tutorials in this section")%>' />&nbsp;
																								<asp:Label ID="Label13" Visible='<%#Eval("HasLearning")%>' runat="server" Style="font-size: 10px; color: #666666;" Text='<%#Eval("AvgSecTime", "(average time {0} mins)")%>'
                                                                                                    ToolTip='<%#Eval("AvgSecTime", "Average completion time for the tutorials in this section is {0} mins")%>' />
                                                    </div>
                                                </div>

                                                <asp:Panel ID="TutsPanel" runat="server" CssClass="section-panel">
                                                    <div style="width: 100%">
                                                        <asp:GridView ID="gvTutorials" CssClass="table table-striped" DataSourceID="dsProgressDetail" runat="server" AutoGenerateColumns="False"
                                                            DataKeyNames="TutorialID" GridLines="None" SelectedIndex="0" EmptyDataText="No tutorials are active in this section."
                                                            Width="100%">
                                                            <Columns>

                                                                <asp:BoundField DataField="TutorialName" HeaderText="Tutorial" SortExpression="TutorialName"
                                                                    ItemStyle-Width="50%" HeaderStyle-HorizontalAlign="Left" />
                                                                <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" ItemStyle-HorizontalAlign="Center"
                                                                    HeaderStyle-HorizontalAlign="Center" />
                                                                <asp:BoundField DataField="TutTime" HeaderText="Time Taken (mins)" SortExpression="TutTime"
                                                                    ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                                                                <asp:BoundField DataField="AvgTime" HeaderText="Avg Time (mins)" SortExpression="AvgTime"
                                                                    ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                                                                <asp:TemplateField HeaderText="Diagnostic score" SortExpression="TutScore">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblDiagOutcome" runat="server" Text='<%#Eval("TutScore").ToString + "/" + Eval("PossScore").ToString %>'
                                                                            Visible='<%# Eval("DiagAttempts") > 0 AND Eval("DiagStatus") %>' />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </div>
                                                </asp:Panel>
                                                <div class="card-footer list-group-item-assess" runat="server" visible='<%# Eval("PLAssessPath").ToString.Length > 0 And Eval("IsAssessed")%>'>
                                                    <div class="row">
                                                        <div class="col col-sm-12">
                                                            Post Learning Assessment:&nbsp;&nbsp;&nbsp;
                                                                        <asp:Label ID="lblPLAssessOutcome" CssClass="text-muted" runat="server" Visible='<%# Eval("AttemptsPL").ToString <> "0" %>'
                                                                            Text='<%# Eval("MaxScorePL").ToString + "%  - " + Eval("AttemptsPL").ToString + " attempt(s)" %>'></asp:Label>
                                                            <asp:Label ID="lblPLAssessStatus" CssClass="label label-default" runat="server" Text="Not attempted"
                                                                Visible='<%# Eval("AttemptsPL").ToString = "0" %>'></asp:Label>
                                                            <asp:Label ID="lblRecommended" CssClass="label label-danger" runat="server" Text="FAILED"
                                                                Font-Bold="True" Visible='<%# Eval("AttemptsPL") > 0 And Eval("IsAssessed") And Eval("PLPassed").ToString = "False" %>' />
                                                            <asp:Label ID="lblOptional" CssClass="label label-success" runat="server" Text="PASSED" Font-Bold="False"
                                                                Visible='<%# Eval("AttemptsPL") > 0 And Eval("IsAssessed") And Eval("PLPassed") %>' />
                                                        </div>
                                                    </div>
                                                </div>
                                            </asp:Panel>

                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <script>$('.collapse').on('shown.bs.collapse', function () {
                                    $(this).parent().find(".fas fa-plus").removeClass("fas fa-plus").addClass("fas fa-minus");
                                }).on('hidden.bs.collapse', function () {
                                    $(this).parent().find(".fas fa-minus").removeClass("fas fa-minus").addClass("fas fa-plus");
                                });



                            </script>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary float-right" data-dismiss="modal">OK</button>
                        </div>
                    </div>
                </div>
            </div>

        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="lbtViewDetailedProgress" />
        </Triggers>
    </asp:UpdatePanel>
</div>
