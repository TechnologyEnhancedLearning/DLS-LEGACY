<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="summary.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.summary" %>

<!DOCTYPE html>

<html lang="en">
<head runat="server">
    <title>Digital Learning Solutions Progress Summary</title>
  
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
	<style type="text/css">

  	.CertBack
  	{position:relative; background-color:white; padding:20px; margin-top:40px; width:800px; border-style: solid; border-color: #00529E; border-width: 3px;
  	  		}	
  	  		  		
@media print 
{
	 
	.maincontentcontainer
{
	margin: 0 0 0 0;
	min-height: 500px;
	color: #000;
	border: none;
	background-color: #FFFFFF;
}
    #header, 
    #footer         
    {
       visibility: hidden;
    }
    .no-print, .no-print *
    {
        display: none !important;
    }
}

  
  
  </style>
</head>
<body>
    <asp:ObjectDataSource ID="dsSummary" runat="server" 
		OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
		TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.ProgressSummaryTableAdapter">
		<SelectParameters>
			<asp:SessionParameter Name="ProgressID" SessionField="ProgressID" 
				Type="Int32" />
		</SelectParameters>
	</asp:ObjectDataSource>
	<asp:ObjectDataSource ID="dsSections" runat="server" 
		OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByUSP" 
		TypeName="ITSP_TrackingSystemRefactor.LearnMenuTableAdapters.LMSectionsTableAdapter">
		<SelectParameters>
			<asp:SessionParameter Name="ProgressID" 
				SessionField="ProgressID" Type="Int32" />
		</SelectParameters>
	</asp:ObjectDataSource>
    <form id="form1" runat="server">
    
      <div id="CertBack" runat="server" class="CertBack"  title="CertBack">
          
    Progress as at: <asp:Label ID="lblCurrentDate" runat="server" Text="Label"></asp:Label>
    <div style="padding: 22px; float:right">
    
    <asp:Image ID="Logo" runat="server" ImageUrl="~/images/logo.png" AlternateText="Logo" /></div>
    <div style="clear:both"></div>
    <asp:FormView ID="fvProgSummary" runat="server" DataKeyNames="ProgressID" DataSourceID="dsSummary">
                      <ItemTemplate>
                        <h2 style="color: #000066; font-weight: bold">
                          Progress Summary for 
							<asp:Label ID="lblName" runat="server" Text='<%#Eval("CandidateName") + " (" + Eval("CandidateNumber") + ")" %>'></asp:Label>
							
							</h2>
                          <h3><asp:Label ID="lblTitle" runat="server" Text='<%#Eval("Course")%>'></asp:Label></h3>
                           <h4><asp:Label ID="lblCompReq1" Visible='<%# Eval("IsAssessed") %>' runat="server" Text='To complete this course, you must pass all post learning assessments' />
                        <asp:Label ID="lblCompReq2" Visible='<%# Convert.ToInt32(Eval("DiagCompletionThreshold")) > 0 AND Convert.ToInt32(Eval("TutCompletionThreshold")) > 0 AND NOT Eval("IsAssessed") %>' runat="server"
                          Text='<%#Eval("DiagCompletionThreshold", "To complete this course, you must achieve {0}% in the diagnostic assessment and complete ") & Eval("TutCompletionThreshold", "{0}% of the learning materials") %>' />
                        <asp:Label ID="lblCompReq3" Visible='<%# Convert.ToInt32(Eval("DiagCompletionThreshold")) = 0 AND NOT Eval("IsAssessed") %>' runat="server"
                          Text='<%#Eval("TutCompletionThreshold", "To complete this course, you must complete {0}% of the learning materials") %>' />
                        <asp:Label ID="lblCompReq4" Visible='<%# Convert.ToInt32(Eval("TutCompletionThreshold")) = 0 AND NOT Eval("IsAssessed") %>' runat="server"
                          Text='<%#Eval("DiagCompletionThreshold", "To complete this course, you must achieve {0}% in the diagnostic assessment") %>' /></h4>
                        <br />
                        <table>
                        <tr>
                        <td colspan="2">
							</td>
                        </tr>
                          <tr>
                            <td>
                              Course Status:
                            </td>
                            <td>
                              <asp:Label ID="lblCompleted" Visible='<%# Eval("Completed").ToString.Length > 0 %>'
                                runat="server" Text='<%#Eval("Completed", "COMPLETE (Completed:  {0:dd MMMM yyyy})")%>' Font-Bold="True" />
                              <asp:Label ID="lblIncomplete" Visible='<%# Eval("Completed").ToString.Length = 0 %>'
                                runat="server" Text='INCOMPLETE' Font-Bold="True" />
                            </td>
                            
                          </tr>
                          <tr id="trDiagnostic" runat="server" visible='<%# Eval("DiagAttempts") > 0 %>'>
                            <td>
                              Diagnostic Score:
                            </td>
                            <td>
                              <asp:Label ID="lblDiagScore" runat="server" Text='<%# Eval("DiagnosticScore", "{0}%") %>'></asp:Label>
                            </td>
                          </tr>
                          <tr id="trLearning" runat="server" visible='<%# Eval("LearningDone")> 0 %>'>
                            <td>
                              Learning Completed:
                            </td>
                            <td>
                              <asp:Label ID="Label15" runat="server" Text='<%# Eval("LearningDone", "{0}%") %>'></asp:Label>
                            </td>
                          </tr>
                          <tr id="trPostLearning" runat="server" visible='<%# Eval("IsAssessed") %>'>
                            <td>
                              Assessments Passed:
                            </td>
                            <td>
                              <asp:Label ID="Label16" runat="server" Text='<%# Eval("PLPasses") & " out of " & Eval("Sections") %>'></asp:Label>
                            </td>
                          </tr>
                        </table>
                        <br />
                       
                      </ItemTemplate>
                    </asp:FormView>
		<table class="table table-striped small"><tr><th align="left">Section</th><th align="left">Diagnostic Score</th><th align="left">Learning % / Time</th><th align="left">Post Learning Assessment</th></tr>
		
		
		<asp:Repeater ID="rptSections" runat="server" DataSourceID="dsSections">
		<ItemTemplate>
		<tr><td>
			<asp:Label ID="lblSectionName" runat="server" Text='<%#Eval("SectionName")%>'/></td>
			<td><asp:Label ID="lblDiagOutcome" CssClass="secStatus" runat="server" Text='<%# Eval("SecScore").ToString + " / " + Eval("SecOutOf").ToString + " - " + Eval("DiagAttempts").ToString + " attempt(s)" %>'
                                                Visible='<%# Eval("DiagAttempts").ToString <> "0" %>'></asp:Label>
                                              <asp:Label ID="lblDiagNotAttempted" CssClass="secStatus" runat="server" Text="Not attempted"
                                                Visible='<%# Eval("DiagAttempts").ToString = "0" %>'></asp:Label></td>
			<td>
				<asp:Label ID="lblLearning" runat="server" Text=""/> <asp:Label ID="lblSecStatus" runat="server"
                                                  Text='<%#Eval("PCComplete", "{0}% complete")%>' />
                                                &nbsp;
                                                <asp:Label ID="Label12" runat="server" Text='<%#Eval("TimeMins", "{0} mins")%>'
                                                   />
                                               </td>
			<td>
				<asp:Label ID="lblPLAssessOutcome" CssClass="secStatus" runat="server" Visible='<%# Eval("AttemptsPL").ToString <> "0" %>'
                                                Text='<%# Eval("MaxScorePL").ToString + "%  - " + Eval("AttemptsPL").ToString + " attempt(s)" %>'></asp:Label>
                                              <asp:Label ID="lblPLAssessStatus" CssClass="secStatus" runat="server" Text="Not attempted"
                                                Visible='<%# Eval("AttemptsPL").ToString = "0" AND Eval("IsAssessed") %>'></asp:Label>
                                              <asp:Label ID="lblRecommended" CssClass="secStatus" runat="server" Text="FAILED"
                                                ForeColor="#CC0000" Font-Bold="True" Visible='<%# Eval("AttemptsPL") > 0 AND Eval("IsAssessed") AND Eval("PLPassed").ToString = "False" %>' />
                                              <asp:Label ID="lblOptional" CssClass="secStatus" runat="server" Text="PASSED" Font-Bold="False"
                                                ForeColor="#000000" Visible='<%# Eval("AttemptsPL") > 0 AND Eval("IsAssessed") AND Eval("PLPassed") %>' /></td>
			</tr>
		</ItemTemplate>
		
		</asp:Repeater>
			
		</table><div style="clear:both"></div>
		<h2>Achievements</h2>
		<h4>The following post learning assessments have been passed:</h4>
		<table class="table table-striped small"><tr><th align="left">Assessment</th><th align="left">Outcome</th></tr>
			<asp:Repeater ID="rptAchievements" runat="server" DataSourceID="dsSections">
		<ItemTemplate>
			<tr runat="server" Visible='<%# Eval("AttemptsPL") > 0 AND Eval("IsAssessed") AND Eval("PLPassed") %>'  ><td>
			<asp:Label ID="lblSectionName" runat="server" Text='<%#Eval("SectionName")%>'/></td>
			<td>
			<asp:Label ID="lblOptional" CssClass="secStatus" runat="server" Text="PASSED" Font-Bold="False"
                                                ForeColor="#00CC00" /></td>
			</tr>
		</ItemTemplate>
		</asp:Repeater>
		</table>
    </div>
    </form>
</body>
</html>
