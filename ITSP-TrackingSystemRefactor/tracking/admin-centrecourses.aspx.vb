Public Class admin_centrecourses
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Protected Sub lbtUpdateFilter_Click(sender As Object, e As EventArgs) Handles lbtUpdateFilter.Click
        ddCentresToAdd.DataBind()
    End Sub
    Private Sub lbtOK_Click(sender As Object, e As EventArgs) Handles lbtOK.Click
        Dim nCourseID As Integer = ddCourse.SelectedValue
        Session("publishcourseid") = nCourseID
        Dim taApp As New ITSPTableAdapters.ApplicationsTableAdapter
        Dim tApp As New ITSP.ApplicationsDataTable
        tApp = taApp.GetByApplicationID(nCourseID)
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
        dsCentresForApp.SelectParameters("CourseID").DefaultValue = nCourseID
        dsNewsCentresForPub.SelectParameters("CourseID").DefaultValue = nCourseID
        lblCourseHeading.Text = tApp.First.ApplicationName
        mvPublishContent.SetActiveView(vPublish)
    End Sub

    Private Sub lbtAdd_Click(sender As Object, e As EventArgs) Handles lbtAdd.Click
        If ddCentresToAdd.Items.Count > 0 Then
            Dim nCentreID As Integer = ddCentresToAdd.SelectedValue
            Dim nCourseID As Integer = Session("publishcourseid")
            Dim taQ As New ITSPTableAdapters.QueriesTableAdapter
            taQ.AddAppToCentre(nCentreID, nCourseID)
            SendPublishedNotifications(nCentreID)
            ddCentresToAdd.DataBind()
            gvPublishedToCentres.DataBind()
        End If
    End Sub
    Protected Sub SendPublishedNotifications(ByVal nCentreID As Integer)
        Dim sCName As String = lblCourseHeading.Text
        Dim service As New ts.services.services()
        Dim nEmails As Integer = service.SendCoursePublishedNotifications(nCentreID, sCName)
    End Sub
    Private Sub lbtAddAll_Click(sender As Object, e As EventArgs) Handles lbtAddAll.Click
        If ddCentresToAdd.Items.Count > 0 Then
            Dim nCourseID As Integer = Session("publishcourseid")
            Dim nCentreID As Integer
            Dim taQ As New ITSPTableAdapters.QueriesTableAdapter
            Dim taUFN As New NotificationsTableAdapters.UsersForNotificationTableAdapter
            Dim tUFN As New Notifications.UsersForNotificationDataTable
            Dim sCName As String = lblCourseHeading.Text
            Dim sFrom As String = "Digital Learning Solutions Notifications <noreply@dls.nhs.uk>"
            Dim sBodyHTML As String
            sBodyHTML = "<p>Dear colleague</p>" + "<p>This is to notify you that the course <b>" + sCName + "</b> has been made available to your centre in the Digital Learning Solutions Tracking System.</p><p>You are receiving this message because you are subscribed to notifications about new courses that are published to your centre.</p><p>To manage your notification subscriptions, login to the <a href='https://www.dls.nhs.uk/tracking'>Digital Learning Solutions Tracking System</a> and click the <b>My Details</b> link."
            Dim sSubjectLine As String = "New Digital Learning Solutions Course Available - " + sCName

            For Each li As ListItem In ddCentresToAdd.Items
                nCentreID = li.Value
                taQ.AddAppToCentre(nCentreID, nCourseID)
                SendPublishedNotifications(nCentreID)

            Next
            gvPublishedToCentres.DataBind()
            ddCentresToAdd.DataBind()
        End If
    End Sub

    Private Sub gvPublishedToCentres_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvPublishedToCentres.RowCommand
        If e.CommandName = "DeleteCentreApp" Then
            Dim nCentreAppID As Integer = e.CommandArgument
            Dim taQ As New ITSPTableAdapters.QueriesTableAdapter
            taQ.DeleteCourseFromCentre(nCentreAppID)
            gvPublishedToCentres.DataBind()
            ddCentresToAdd.DataBind()
        End If
    End Sub

    Private Sub cbFilterForCentre_CheckedChanged(sender As Object, e As EventArgs) Handles cbFilterForCentre.CheckedChanged
        ddCourse.Items.Clear()
        ddCourse.DataBind()
    End Sub

    Private Sub lbtBack_Click(sender As Object, e As EventArgs) Handles lbtBack.Click
        mvPublishContent.SetActiveView(vChooseCourse)
    End Sub
End Class