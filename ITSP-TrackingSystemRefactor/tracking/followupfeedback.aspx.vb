Public Partial Class followupfeedback
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
		If Not Page.IsPostBack Then
			Dim sFID As New Guid(Page.Request.Item("fid"))
            Dim sCID As String = Page.Request.Item("cid").Replace("'", "")
            Dim taPM As New feedbackTableAdapters.ProgressMatchTableAdapter
            Dim tPM As New feedback.ProgressMatchDataTable
            tPM = taPM.GetByCandidateNumAndGUID(sFID, sCID)
			If tPM.Count > 0 Then
				Session("fbProgressID") = tPM.First.ProgressID
				Session("fbCustomisationID") = tPM.First.CustomisationID
				Session("fbJobGroupID") = tPM.First.JobGroupID
				Me.lblName.Text = tPM.First.FirstName
				Me.lblCourse.Text = tPM.First.ApplicationName & " - " & tPM.First.CustomisationName
				Me.mvFollowUpFeedback.SetActiveView(Me.vLeaveFeedback)
			Else
				lblErrorText.Text = "No matching progress exists in the tracking system that hasn't had a 3 month follow up already submitted. You may already have submitted feedback or come to this page by mistake."
				Me.mvFollowUpFeedback.SetActiveView(Me.vError)
			End If

		End If
	End Sub

	Private Sub FormView1_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewInsertedEventArgs) Handles FormView1.ItemInserted
		Response.Expires = 0
		Response.Cache.SetNoStore()
		Response.AppendHeader("Pragma", "no-cache")
        Dim taq As New feedbackTableAdapters.QueriesTableAdapter
        taq.MarkFollowUpFeedbackSubmitted(CInt(Session("fbProgressID")))
		Me.mvFollowUpFeedback.SetActiveView(Me.vThankYou)
	End Sub
End Class