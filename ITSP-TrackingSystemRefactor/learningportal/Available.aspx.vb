Public Class Available
    Inherits System.Web.UI.Page

    Protected Sub lbtEnroll_Command(sender As Object, e As CommandEventArgs)
        Dim nCustomisationID As Integer = CInt(e.CommandArgument)
        If nCustomisationID <= 0 Or Session("learnCandidateNumber") Is Nothing Then
            Exit Sub
        End If
        Dim sURL As String = ""
        sURL = My.Settings.ITSPTrackingURL & "learn.aspx?CustomisationID=" & nCustomisationID.ToString & "&lp=1"
        Response.Redirect(sURL)
    End Sub

    Private Sub dsAvailable_Selected(sender As Object, e As ObjectDataSourceStatusEventArgs) Handles dsAvailable.Selected
        Dim dt As DataTable = e.ReturnValue
        If dt.Rows.Count <= 15 Then
            bsgvAvailable.SettingsSearchPanel.Visible = False
        Else
            bsgvAvailable.SettingsSearchPanel.Visible = True
        End If
    End Sub
End Class