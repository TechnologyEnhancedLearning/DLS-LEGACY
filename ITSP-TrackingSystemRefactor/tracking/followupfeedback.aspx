<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="followupfeedback.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.followupfeedback" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Digital Learning Solutions Feedback</title>
    <link id="Link1" runat="server" href="~/css/screen.css" rel="stylesheet" type="text/css" />
    <!--[if lt IE 7]> <link  runat="server" href="~/css/ie6.css" rel="stylesheet" type="text/css"  /><![endif]-->
    <!--[if IE 7]> <link  href="css/ie7.css" rel="stylesheet" type="text/css"  /><![endif]-->
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.12.4.min.js"></script>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ObjectDataSource ID="dsFUFeedback" runat="server" DeleteMethod="Delete"
            InsertMethod="Insert" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetData"
            TypeName="ITSP_TrackingSystemRefactor.feedbackTableAdapters.FollowUpFeedbackTableAdapter"
            UpdateMethod="Update">

            <InsertParameters>
                <asp:SessionParameter Name="JobGroupID" SessionField="fbJobGroupID"
                    Type="Int32" />
                <asp:SessionParameter Name="CustomisationID" SessionField="fbCustomisationID"
                    Type="Int32" />
                <asp:Parameter Name="Q1" Type="Byte" />
                <asp:Parameter Name="Q1Comments" Type="String" />
                <asp:Parameter Name="Q2" Type="Byte" />
                <asp:Parameter Name="Q2Comments" Type="String" />
                <asp:Parameter Name="Q3" Type="Byte" />
                <asp:Parameter Name="Q3Comments" Type="String" />
                <asp:Parameter Name="Q4" Type="Byte" />
                <asp:Parameter Name="Q4Comments" Type="String" />
                <asp:Parameter Name="Q5" Type="Byte" />
                <asp:Parameter Name="Q5Comments" Type="String" />
                <asp:Parameter Name="Q6" Type="Byte" />
                <asp:Parameter Name="Q6Comments" Type="String" />
            </InsertParameters>
        </asp:ObjectDataSource>
        <div class="container">
            <div class="row">
            <div class="col col-xs-12">
                <div class="float-right">
                    <img src="../images/logo.png" />
                </div>
            </div>
        </div>
            <asp:MultiView ID="mvFollowUpFeedback" runat="server">
                <asp:View ID="vLeaveFeedback" runat="server">
                    <div class="well">
                        <p>
                            <strong>Hello 
								<asp:Label ID="lblName" runat="server" Text=""></asp:Label>, Thank you for agreeing to leave follow up feedback for your 
								<asp:Label ID="lblCourse" runat="server" Text=""></asp:Label>
                                course.</strong>
                        </p>
                        <p>Please answer the following six questions and then click <strong>Submit</strong>.</p>
                        <p>Your feedback will be used to help us to evaluate the usefulness of these learning resources and continue to improve them.</p>
                        <p>Your response will be stored anonymously.  If you do not wish to take part, click <strong>Submit</strong> without responding to any of the questions.</p>
                    </div>
                    <asp:FormView ID="FormView1" RenderOuterTable="false" runat="server" DataKeyNames="FUEvaluationID"
                        DataSourceID="dsFUFeedback" DefaultMode="Insert">
                        <InsertItemTemplate>
                            <div class="form">
                                <div class="form-group row">
                                    <asp:Label ID="Label1" CssClass="control-label" AssociatedControlID="rblQ1" runat="server" Text="Have you been able to put your IT training into practice?"></asp:Label>
                                    <asp:RadioButtonList ID="rblQ1" class="rblQ1" CssClass="rblQ1" runat="server" DataValueField="Q1" SelectedValue='<%# Bind("Q1") %>'>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Not sure" Value="0"></asp:ListItem>
                                        <asp:ListItem Style="display: none" Text="No answer" Value="0"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <div id="Q1Comment" style="display:none;">
                                        Please tell us how:
                                        <br />
                                        <asp:TextBox ID="Q1CommentsTextBox" CssClass="form-control" runat="server"
                                            Text='<%# Bind("Q1Comments") %>' TextMode="MultiLine" Rows="2" />
                                    </div>
                                </div>
                                <hr />
                                <div class="form-group row">
                                    <asp:Label ID="Label2" CssClass="control-label" AssociatedControlID="rblQ2" runat="server" Text="Have you noticed an improvement in your efficiency/productivity as a result of the training?"></asp:Label>
                                    <asp:RadioButtonList ID="rblQ2" class="rblQ2" CssClass="rblQ2" runat="server" DataValueField="Q2" SelectedValue='<%# Bind("Q2") %>'>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Not sure" Value="0"></asp:ListItem>
                                        <asp:ListItem Style="display: none" Text="No answer" Value="0"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <div id="Q2Comment" style="display:none;">
                                        Please tell us how:
                                        <br />
                                        <asp:TextBox ID="Q2CommentsTextBox" CssClass="form-control" runat="server"
                                            Text='<%# Bind("Q2Comments") %>' TextMode="MultiLine" Rows="2" />
                                    </div>
                                </div>
                                <hr />
                                <div class="form-group row">
                                    <asp:Label ID="Label3" CssClass="control-label" AssociatedControlID="rblQ3" runat="server" Text="Given the opportunity, do you feel confident you could transfer your learning to other people?"></asp:Label>
                                    <asp:RadioButtonList ID="rblQ3" class="rblQ3" CssClass="rblQ3" runat="server" DataValueField="Q3" SelectedValue='<%# Bind("Q3") %>'>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Not sure / not applicable" Value="0"></asp:ListItem>
                                        <asp:ListItem Style="display: none" Text="No answer" Value="0"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <div id="Q3Comment"  style="display:none;">
                                        Please tell us how:
                                        <br />
                                        <asp:TextBox ID="Q3CommentsTextBox" CssClass="form-control" runat="server"
                                            Text='<%# Bind("Q3Comments") %>' TextMode="MultiLine" Rows="2" />
                                    </div>
                                </div>
                                <hr />
                                <div class="form-group row">
                                    <asp:Label ID="Label4" CssClass="control-label" AssociatedControlID="rblQ4" runat="server" Text="Have your IT skills improved?"></asp:Label>
                                    <asp:RadioButtonList ID="rblQ4" class="rblQ4" CssClass="rblQ4" runat="server" DataValueField="Q4" SelectedValue='<%# Bind("Q4") %>'>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Not sure" Value="0"></asp:ListItem>
                                        <asp:ListItem Style="display: none" Text="No answer" Value="0"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <div id="Q4Comment"  style="display:none;">
                                        Please tell us how:
                                        <br />
                                        <asp:TextBox ID="Q4CommentsTextBox" CssClass="form-control" runat="server"
                                            Text='<%# Bind("Q4Comments") %>' TextMode="MultiLine" Rows="2" />
                                    </div>
                                </div>
                                <hr />
                                <div class="form-group row">
                                    <asp:Label ID="Label5" CssClass="control-label" AssociatedControlID="rblQ5" runat="server" Text="Did the demonstration videos assist you with learning?"></asp:Label>
                                    <asp:RadioButtonList ID="rblQ5" class="rblQ5" CssClass="rblQ5" runat="server" DataValueField="Q5" SelectedValue='<%# Bind("Q5") %>'>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Not sure" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Didn't use them" Value="3"></asp:ListItem>
                                        <asp:ListItem Style="display: none" Text="No answer" Value="0"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <div id="Q5Comment"  style="display:none;">
                                        Please tell us how:
                                        <br />
                                        <asp:TextBox ID="Q5CommentsTextBox" runat="server"
                                            Text='<%# Bind("Q5Comments") %>' CssClass="form-control" TextMode="MultiLine" Rows="2" />
                                    </div>
                                </div>
                                <hr />
                                <div class="form-group row">
                                    <asp:Label ID="Label6" CssClass="control-label" AssociatedControlID="rblQ6" runat="server" Text="Did the consolidation exercises assist you with learning?"></asp:Label>
                                    <asp:RadioButtonList ID="rblQ6" class="rblQ6" CssClass="rblQ6" runat="server" DataValueField="Q6" SelectedValue='<%# Bind("Q6") %>'>
                                        <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Not sure" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Didn't use them" Value="3"></asp:ListItem>
                                        <asp:ListItem Style="display: none" Text="No answer" Value="0"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    <div id="Q6Comment"  style="display:none;">
                                        Please tell us how:
                                        <br />
                                        <asp:TextBox ID="Q6CommentsTextBox" CssClass="form-control" runat="server"
                                            Text='<%# Bind("Q6Comments") %>' TextMode="MultiLine" Rows="2" />
                                    </div>
                                </div>
                                <hr />
                                <div class="form-group row">
                                    <asp:LinkButton ID="InsertButton" CssClass="btn btn-primary btn-block" runat="server" CausesValidation="True"
                                        CommandName="Insert" Text="Submit" />
                                </div>
                            </div>
                        </InsertItemTemplate>
                    </asp:FormView>
                </asp:View>
                <asp:View ID="vThankYou" runat="server">
                    <div class="well">
                        <p><strong>Thank you for your feedback. Feel free to close this window or navigate away from this page.</strong></p>
                    </div>
                </asp:View>
                <asp:View ID="vError" runat="server">
                    <div class="alert alert-danger">
                        <strong>
                            <asp:Label ID="lblErrorText" runat="server" Text=""></asp:Label></strong>
                    </div>
                </asp:View>
            </asp:MultiView>
        </div>
        <script>

            $(function () {
                $('.rblQ1 input:radio').change(function () {
                    var rv = $(this).val();
                    if (rv == "1") {
                        $('#Q1Comment').slideToggle('300');
                    }
                    else {
                        $('#FormView1_Q1CommentsTextBox').val('');
                        $('#Q1Comment').slideUp();
                    }
                });
            });
            $(function () {
                $('.rblQ2 input:radio').change(function () {
                    var rv = $(this).val();
                    if (rv == "1") {
                        $('#Q2Comment').slideToggle('300');
                    }
                    else {
                        $('#FormView1_Q2CommentsTextBox').val('');
                        $('#Q2Comment').slideUp();
                    }
                });
            });
            $(function () {
                $('.rblQ3 input:radio').change(function () {
                    var rv = $(this).val();
                    if (rv == "1") {
                        $('#Q3Comment').slideToggle('300');
                    }
                    else {
                        $('#FormView1_Q3CommentsTextBox').val('');
                        $('#Q3Comment').slideUp();
                    }
                });
            });
            $(function () {
                $('.rblQ4 input:radio').change(function () {
                    var rv = $(this).val();
                    if (rv == "1") {
                        $('#Q4Comment').slideToggle('300');
                    }
                    else {
                        $('#FormView1_Q4CommentsTextBox').val('');
                        $('#Q4Comment').slideUp();
                    }
                });
            });
            $(function () {
                $('.rblQ5 input:radio').change(function () {
                    var rv = $(this).val();
                    if (rv == "1") {
                        $('#Q5Comment').slideToggle('300');
                    }
                    else {
                        $('#FormView1_Q5CommentsTextBox').val('');
                        $('#Q5Comment').slideUp();
                    }
                });
            });
            $(function () {
                $('.rblQ6 input:radio').change(function () {
                    var rv = $(this).val();
                    if (rv == "1") {
                        $('#Q6Comment').slideToggle('300');
                    }
                    else {
                        $('#FormView1_Q6CommentsTextBox').val('');
                        $('#Q6Comment').slideUp();
                    }
                });
            });
        </script>
    </form>

</body>
</html>
