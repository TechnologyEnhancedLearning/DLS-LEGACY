Public Class Completed
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub lbtLaunch_Command(sender As Object, e As CommandEventArgs)
        Dim nCustomisationID As Integer = CInt(e.CommandArgument)
        If nCustomisationID <= 0 Or Session("learnCandidateNumber") Is Nothing Then
            Exit Sub
        End If
        Dim sURL As String = My.Settings.ITSPTrackingURL & "learn.aspx?CustomisationID=" & nCustomisationID.ToString & "&lp=1"
        Response.Redirect(sURL)
    End Sub

    Protected Sub lbtCert_Command(sender As Object, e As CommandEventArgs)
        Dim taq As New LearnerPortalTableAdapters.QueriesTableAdapter
        Dim nProgressID As Integer = CInt(e.CommandArgument)

        If nProgressID <= 0 Or Session("learnCandidateNumber") Is Nothing Then
            Exit Sub
        End If


        Dim sURL As String = My.Settings.ITSPTrackingURL & "finalise?ProgressID=" & nProgressID.ToString & "&lp=1"
        Response.Redirect(sURL)
    End Sub

    Private Sub dsCompletedCourses_Selected(sender As Object, e As ObjectDataSourceStatusEventArgs) Handles dsCompletedCourses.Selected
        Dim dt As DataTable = e.ReturnValue
        If dt.Rows.Count <= 15 Then
            bsgvCompleted.SettingsSearchPanel.Visible = False
        Else
            bsgvCompleted.SettingsSearchPanel.Visible = True
        End If
    End Sub
End Class