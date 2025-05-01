<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="noncompletesurvey.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.noncompletesurvey" %>

<!DOCTYPE html>

<html  >
<head id="Head1" runat="server">
    <title>NHS England Learning Solutions Feedback</title>
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />

  <!--[if lt IE 7]> <link  runat="server" href="~/css/ie6.css" rel="stylesheet" type="text/css"  /><![endif]-->
  <!--[if IE 7]> <link  href="css/ie7.css" rel="stylesheet" type="text/css"  /><![endif]-->
    <script src="../Scripts/jquery-1.12.4.min.js"></script>
		
  
</head>
<body>
    <form id="form1" runat="server">
								<asp:ObjectDataSource ID="dsNonCompleteFeedback" runat="server" InsertMethod="Insert" 
										OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
										TypeName="ITSP_TrackingSystemRefactor.feedbackTableAdapters.NonCompletedFeedbackTableAdapter">
										
										<InsertParameters>
												<asp:SessionParameter Name="JobGroupID" SessionField="fbJobGroupID" 
														Type="Int32" />
												<asp:SessionParameter Name="CustomisationID" SessionField="fbCustomisationID" 
														Type="Int32" />
												<asp:Parameter Name="WhyNotComplete" Type="Byte" />
												<asp:Parameter Name="R1_Style" Type="Boolean" />
												<asp:Parameter Name="R2_PreferF2F" Type="Boolean" />
												<asp:Parameter Name="R3_NotEnjoy" Type="Boolean" />
												<asp:Parameter Name="R4_KnewItAll" Type="Boolean" />
												<asp:Parameter Name="R5_TooHard" Type="Boolean" />
												<asp:Parameter Name="R6_TechIssue" Type="Boolean" />
												<asp:Parameter Name="R7_DislikeComputers" Type="Boolean" />
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
            <div class="row">
                <div class="col col-xs-12">
                    <div class="well">
                      <p><strong>Hello 
								<asp:Label ID="lblName" runat="server" Text=""></asp:Label>, thank you for 
								agreeing to leave follow up feedback for your incomplete 
								<asp:Label ID="lblCourse" runat="server" Text=""></asp:Label> &nbsp;course.</strong></p>
            <p>Please respond to the following short survey and then click <strong>Submit</strong>.</p>
            <p>Your response will be stored anonymously.  If you do not wish to take part, click <strong>Submit</strong> without responding to any of the questions.</p>
                </div></div>
            </div>
                            <hr />
            <asp:FormView ID="FormView1" RenderOuterTable="false" runat="server" DataKeyNames="NonCompletedFeedbackID" 
										DataSourceID="dsNonCompleteFeedback" DefaultMode="Insert">
										
										<InsertItemTemplate>
            <div class="form">
                <div class="form-group row">
                    <asp:Label ID="Label3" CssClass="control-label" runat="server" AssociatedControlID="rblQ1" Text="Have you been able to put your IT training into practice?"></asp:Label>
                  
                        <asp:RadioButtonList ID="rblQ1" class="rblQ1" runat="server" DataValueField="WhyNotComplete" SelectedValue='<%# Bind("WhyNotComplete") %>'>
								<asp:ListItem Text="I did all the sections that were relevant to me but didn’t feel I needed to do the rest" Value="1"></asp:ListItem>
								<asp:ListItem Text="I wasn’t aware that I needed to complete the learning" Value="2"></asp:ListItem>
								<asp:ListItem Text="My job role changed and the training was no longer relevant" Value="3"></asp:ListItem>
								<asp:ListItem Text="I was not given the time to complete the training by my line manager" Value="4"></asp:ListItem>
								<asp:ListItem Text="Other work pressures got in the way" Value="5"></asp:ListItem>
								<asp:ListItem Text="The learning did not meet my needs" Value="6"></asp:ListItem>
								<asp:ListItem  Style="display:none" Text="No answer" Value="0"></asp:ListItem>
								</asp:RadioButtonList>
                </div>
                <hr />
                 <div class="form-group row">
                     <asp:Label ID="Label4" CssClass="control-label" runat="server" AssociatedControlID="rblQ1" Text="To help us to improve provision in the future,  please tell us why the learning wasn’t right for you.(tick all that apply):"></asp:Label>
                    <div>
                         <asp:CheckBox ID="cbR1_Style" runat="server" Checked='<%# Bind("R1_Style") %>' Text="I didn't like the style of learning" /><br />
					 <asp:CheckBox ID="cbR2_PreferF2F" runat="server" Checked='<%# Bind("R2_PreferF2F") %>' Text="I prefer face to face training"/><br />
							<asp:CheckBox ID="cbR3_NotEnjoy" runat="server" Checked='<%# Bind("R3_NotEnjoy") %>' Text="I didn't enjoy the learning so stopped doing it"/><br />	
								<asp:CheckBox ID="cbR4_KnewItAll" runat="server" Checked='<%# Bind("R4_KnewItAll") %>' Text="I already knew most of the learning content"/><br />	
								<asp:CheckBox ID="cbR5_TooHard" runat="server" Checked='<%# Bind("R5_TooHard") %>' Text="I found the learning too difficult to understand/complete"/><br />	
								<asp:CheckBox ID="cbR6_TechIssue" runat="server" Checked='<%# Bind("R6_TechIssue") %>' Text="Technical issues"/><br />	
								<asp:CheckBox ID="cbR7_DislikeComputers" runat="server" Checked='<%# Bind("R7_DislikeComputers") %>' Text="I don't like using computers; they get in the way of my job"/>
                    </div>
            </div>
                <hr />
            </div>
                                             <div class="form-group row">
                                                 <asp:LinkButton ID="InsertButton" runat="server" CssClass="btn btn-primary btn-block" CausesValidation="True" 
														CommandName="Insert" Text="Submit" />
                                                 </div>
</InsertItemTemplate>
										
								</asp:FormView>

 </asp:View>
    <asp:View ID="vThankYou" runat="server">
				<div class="well">
            <p><strong>Thank you for your feedback. Feel free to close this window or navigate away from this page.</strong></p>
						<p>We're sorry that you weren't able to complete the learning. If you wish to undertake more IT Training in the future then please contact your local IT Training provider to arrange this. If you would like to continue the course, it is still available using the access details originally supplied by your centre.</p>		
						</div>	</asp:View>
						<asp:View ID="vError" runat="server"><div class="alert alert-error" >
          
            <p><strong><asp:Label ID="lblErrorText" runat="server" Text=""></asp:Label></strong></p>	
								</div>
								
						</asp:View>
    </asp:MultiView>

   										
												<div style="text-align: center"></div>

										
    <script>

    		$(function() {
    				$('.rblQ1 input:radio').change(function() {
    						var rv = $(this).val();
    						if (rv == "6") {
    								$('#Q1Comment').slideToggle('300');
    						}
    						else {
    								$('#FormView1_Q1CommentsTextBox').val('');
    								$('#Q1Comment').slideUp();
    						}
    				});
    		});
    	
  </script>
   </div></div>
    </div>
    </form>
</body>
</html>
