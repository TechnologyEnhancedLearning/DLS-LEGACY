<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DelegateProgressView.ascx.vb" Inherits="ITSP_TrackingSystemRefactor.DelegateProgressView" %>
<!-- Modal -->
<div class="modal fade" id="progressModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                
                <h5 class="modal-title" id="myModalLabel">Delegate Progress</h5><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <ul class="nav nav-tabs" role="tablist">
                    <li role="presentation" class="active"><a href="#summary" aria-controls="summary" role="tab" data-toggle="tab">Summary</a></li>
                    <li role="presentation"><a href="#detail" aria-controls="detail" role="tab" data-toggle="tab">Detail</a></li>
                </ul>
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="summary">
                        <asp:ObjectDataSource ID="dsProgressSummary" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.progressTableAdapters.ProgressTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter Name="ProgressID" SessionField="dvProgressID" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:FormView ID="ProgressDetailsFormView" runat="server" DataSourceID="dsProgressSummary">

                            <ItemTemplate>
                                <table style="width: 580px;">
                                    <tr>
                                        <td colspan="2">
                                            <div style="font-weight: bold; text-align: center;">
                                                <asp:Label ID="ApplicationNameLabel" runat="server" Text='<%# Eval("ApplicationName") %>' />
                                                -
																				<asp:Label ID="CustomisationNameLabel" runat="server" Text='<%# Eval("CustomisationName") %>' />
                                            </div>
                                        </td>
                                        <td style="width: 25%">Diagnostic score:
                                        </td>
                                        <td style="width: 25%" class="Gridviewrowsstyle">
                                            <asp:Label ID="DiagnosticScoreLabel" runat="server" Text='<%# Eval("DiagnosticScore", "{0:F0}%") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%">Started:
                                        </td>
                                        <td style="width: 25%" class="Gridviewrowsstyle">
                                            <asp:Label ID="FirstSubmittedTimeLabel" runat="server" Text='<%# Eval("FirstSubmittedTime", "{0:dd/MM/yyyy}") %>' />
                                        </td>
                                        <td style="width: 25%">Last Updated:
                                        </td>
                                        <td style="width: 25%" class="Gridviewrowsstyle">
                                            <asp:Label ID="SubmittedTimeLabel" runat="server" Text='<%# Eval("SubmittedTime", "{0:dd/MM/yyyy}") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Completed:
                                        </td>
                                        <td class="Gridviewrowsstyle">
                                            <asp:Label ID="CompletedLabel" runat="server" Visible='<%# Eval("Completed").ToString.Length > 0 %>'
                                                Text='<%# Databinder.Eval(Container.DataItem, "Completed", "{0:dd/MM/yyyy}") %>' />
                                            <asp:TextBox ID="tbCompleted" Visible='<%# Eval("Completed").ToString.Length = 0 AND Eval("IsAssessed").ToString = "False" %>'
                                                runat="server" Width="60px"></asp:TextBox>
                                            <asp:LinkButton Visible='<%# Eval("Completed").ToString.Length = 0 AND Eval("IsAssessed").ToString = "False" %>'
                                                ID="btnConfirmComplete" runat="server" CssClass="EITSButton" CommandName="ConfirmComplete"
                                                CommandArgument='<%# Eval("ProgressID") %>'>Confirm</asp:LinkButton>
                                        </td>
                                        <td>Evaluated:
                                        </td>
                                        <td class="Gridviewrowsstyle">
                                            <asp:Label ID="EvaluatedLabel" runat="server" Text='<%# Databinder.Eval(Container.DataItem, "Evaluated", "{0:dd/MM/yyyy}") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Logins:
                                        </td>
                                        <td class="Gridviewrowsstyle">
                                            <asp:Label ID="LoginCountLabel" runat="server" Text='<%# Bind("LoginCount") %>' />
                                        </td>
                                        <td>Learning time (mins):
                                        </td>
                                        <td class="Gridviewrowsstyle">
                                            <asp:Label ID="LearningTimeLabel" runat="server" Text='<%# Bind("LearningTime") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Assessments passed:
                                        </td>
                                        <td class="Gridviewrowsstyle">
                                            <asp:Label ID="AssessPassLabel" runat="server" Text='<%# Bind("AssessPass") %>' />
                                        </td>
                                        <td>Assessment attempts:
                                        </td>
                                        <td class="Gridviewrowsstyle">
                                            <asp:Label ID="AssessCountLabel" runat="server" Text='<%# Bind("AssessCount") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Pass ratio:
                                        </td>
                                        <td class="Gridviewrowsstyle">
                                            <asp:Label ID="AssessRatioLabel" runat="server" Text='<%# Databinder.Eval(Container.DataItem, "AssessRatio", "{0:F0}%") %>' />
                                        </td>
                                        <td colspan="2"></td>
                                    </tr>
                                    <tr style="<%# if(not IsDBNull(Container.DataItem("Question1")) AndAlso CStr(Container.DataItem("Question1")).Length > 0, "", "display:none")%>">
                                        <td>
                                            <asp:Label ID="Question1Label" runat="server" Text='<%# Bind("Question1") %>' />
                                        </td>
                                        <td colspan="3" class="Gridviewrowsstyle">
                                            <asp:Label ID="Answer1Label" runat="server" Text='<%# Bind("Answer1") %>' />
                                        </td>
                                    </tr>
                                    <tr style="<%# if(not IsDBNull(Container.DataItem("Question2")) AndAlso CStr(Container.DataItem("Question2")).Length > 0, "", "display:none")%>">
                                        <td>
                                            <asp:Label ID="Question2Label" runat="server" Text='<%# Bind("Question2") %>' />
                                        </td>
                                        <td colspan="3" class="Gridviewrowsstyle">
                                            <asp:Label ID="Answer2Label" runat="server" Text='<%# Bind("Answer2") %>' />
                                        </td>
                                    </tr>
                                    <tr style="<%# if(not IsDBNull(Container.DataItem("Question3")) AndAlso CStr(Container.DataItem("Question3")).Length > 0, "", "display:none")%>">
                                        <td>
                                            <asp:Label ID="Question3Label" runat="server" Text='<%# Bind("Question3") %>' />
                                        </td>
                                        <td colspan="3" class="Gridviewrowsstyle">
                                            <asp:Label ID="Answer3Label" runat="server" Text='<%# Bind("Answer3") %>' />
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:FormView>
                    </div>
                    <div role="tabpanel" class="tab-pane" id="detail">
                    </div>

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary float-right" data-dismiss="modal">Close</button>

            </div>
        </div>
    </div>
</div>
