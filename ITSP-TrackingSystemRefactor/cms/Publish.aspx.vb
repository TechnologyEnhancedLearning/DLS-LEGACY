Public Class Publish
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        cbFilterForCentre.Visible = Session("UserPublishToAll")

        pnlFilterSearch.Visible = Session("UserPublishToAll")
        lbtAddAll.Visible = Session("UserPublishToAll")
        If Not Page.IsPostBack Then
            If Page.Request.Item("courseid") Is Nothing Then
                mvPublishContent.SetActiveView(vChooseCourse)
            Else
                Dim taq As New itspdbTableAdapters.QueriesTableAdapter
                If Not taq.CheckCourseValidForUser(Page.Request.Item("courseid"), Session("UserCentreID"), Session("UserPublishToAll")) Then
                    mvPublishContent.SetActiveView(vChooseCourse)
                Else
                    Dim nCourseID As Integer = Page.Request.Item("courseid")
                    Dim taApp As New itspdbTableAdapters.ApplicationsTableAdapter
                    Dim tApp As New itspdb.ApplicationsDataTable
                    tApp = taApp.GeByApplicationID(nCourseID)
                    lblCourseHeading.Text = tApp.First.ApplicationName

                    'We need to run some checks for validity of course for publishing:

                    Dim taValidate As New itspdbTableAdapters.ValidateCourseForPublishingTableAdapter
                    Dim tValidate As New itspdb.ValidateCourseForPublishingDataTable
                    tValidate = taValidate.GetData(nCourseID)
                    If tValidate.Count > 0 Then
                        ' check that we have some warnings:
                        Dim sWarning As String = ""
                        If tValidate.First.SecsDiagNoOutOf > 0 Then
                            sWarning = "<div class='alert alert-danger'>" & tValidate.First.SecsDiagNoOutOf.ToString & " sections of your course have no Diagnostic 'out of' score specified. Your diagnostic assessments will not work for these sections.</div>"
                        End If
                        If tValidate.First.SecsNoDiagUploaded > 0 Then
                            sWarning = sWarning & "<div class='alert alert-danger'>Diagnostic assessments are switched on for your course but " & tValidate.First.SecsNoDiagUploaded.ToString & " sections of your course have no Diagnostic uploaded.</div>"
                        End If
                        If tValidate.First.SecsNoPLUploaded > 0 Then
                            sWarning = sWarning & "<div class='alert alert-danger'>Post learning assessments are switched on for your course but " & tValidate.First.SecsNoPLUploaded.ToString & " sections of your course have no Post Learning Assessment uploaded.</div>"
                        End If

                        If tValidate.First.SecsCCPLorDiag > 0 Then
                            sWarning = sWarning & "<div class='alert alert-warning'>Please ensure that diagnostics and assessments have been linked to tutorial objectives in Content Creator by downloading assessment templates for each section and importing to Content Creator and matching.</div>"
                        End If
                        If sWarning.Length > 0 Then
                            lblModalMessage.Text = sWarning
                            lblModalHeading.Text = "Pre-publish Course Validation Checks"
                            Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalValidationChecks", "<script>$('#messageModal').modal('show');</script>")
                        End If
                    End If
                    mvPublishContent.SetActiveView(vPublish)
                End If
            End If
        End If
    End Sub
    Private Sub ddCourse_DataBound(sender As Object, e As EventArgs) Handles ddCourse.DataBound

		ddCourse.SelectedValue = Page.Request.Item("courseid")

	End Sub
	Protected Sub lbtUpdateFilter_Click(sender As Object, e As EventArgs) Handles lbtUpdateFilter.Click
		ddCentresToAdd.DataBind()
	End Sub
	Private Sub lbtOK_Click(sender As Object, e As EventArgs) Handles lbtOK.Click
        Response.Redirect("~/cms/Publish.aspx?courseid=" & ddCourse.SelectedValue.ToString())
    End Sub

	Private Sub lbtAdd_Click(sender As Object, e As EventArgs) Handles lbtAdd.Click
		If ddCentresToAdd.Items.Count > 0 Then
			Dim nCentreID As Integer = ddCentresToAdd.SelectedValue
			Dim nCourseID As Integer = Page.Request.Item("courseid")
			Dim taQ As New itspdbTableAdapters.QueriesTableAdapter
            taQ.AddAppToCentre(nCentreID, nCourseID)
            Dim sCourseName As String = lblCourseHeading.Text
            Dim service As New ts.services.services
            Dim nEmails As Integer = service.SendCoursePublishedNotifications(nCentreID, sCourseName)
            lblPublished.Text = "Published to centre and " & nEmails & " emails sent."
            pnlOutcome.Visible = True
            ddCentresToAdd.DataBind()
            bsgvPublishedToCentres.DataBind()
        End If
	End Sub

	Private Sub lbtAddAll_Click(sender As Object, e As EventArgs) Handles lbtAddAll.Click
		If ddCentresToAdd.Items.Count > 0 Then
			Dim nCourseID As Integer = Page.Request.Item("courseid")
            Dim nCentreID As Integer
            Dim sCourseName As String = lblCourseHeading.Text
            Dim taQ As New itspdbTableAdapters.QueriesTableAdapter
            Dim nEmails As Integer = 0
            For Each li As ListItem In ddCentresToAdd.Items
                nCentreID = li.Value
                taQ.AddAppToCentre(nCentreID, nCourseID)
                Dim service As New ts.services.services
                nEmails += service.SendCoursePublishedNotifications(nCentreID, sCourseName)
            Next
            lblPublished.Text = "Published to all " + ddCentresToAdd.Items.Count + " centres and " & nEmails & " emails sent."
            pnlOutcome.Visible = True
            bsgvPublishedToCentres.DataBind()
            ddCentresToAdd.DataBind()
		End If
	End Sub



    Private Sub cbFilterForCentre_CheckedChanged(sender As Object, e As EventArgs) Handles cbFilterForCentre.CheckedChanged
        ddCourse.Items.Clear()
        ddCourse.DataBind()
    End Sub

    Protected Sub lbtDelete_Command(sender As Object, e As CommandEventArgs)
        Dim nCentreAppID As Integer = e.CommandArgument
        Dim taQ As New itspdbTableAdapters.QueriesTableAdapter
        taQ.DeleteCourseFromCentre(nCentreAppID)
        bsgvPublishedToCentres.DataBind()
        ddCentresToAdd.DataBind()
    End Sub
End Class