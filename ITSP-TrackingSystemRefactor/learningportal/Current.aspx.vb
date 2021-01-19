Imports DevExpress.Web

Public Class Current
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Not Page.Request.Item("Invalid") Is Nothing Then
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "showInvalidModal", "<script>$('#modalInvalidCourse').modal('show');</script>")
            End If
        End If
    End Sub
    Private Sub lbtConfirmRemove_Click(sender As Object, e As EventArgs) Handles lbtConfirmRemove.Click
        Dim taq As New LearnerPortalTableAdapters.QueriesTableAdapter
        taq.RemoveProgress(hfRemoveProgressID.Value)
        bsgvCurrent.DataBind()
    End Sub

    Private Sub lbtSubmitTBC_Click(sender As Object, e As EventArgs) Handles lbtSubmitTBC.Click
        Dim tbComp As TextBox = tbCompleteBy
        Dim sDate As String = tbCompleteBy.Text
        Dim nProgressID As Integer = hfProgressID.Value
        Dim taQueries As New LearnerPortalTableAdapters.QueriesTableAdapter
        If sDate.Length > 0 Then
            Dim dComp As DateTime
            If DateTime.TryParse(sDate, dComp) Then
                taQueries.SetTBCDate(dComp, nProgressID)
            End If
        Else
            taQueries.ClearTBCDate(nProgressID)
        End If
        bsgvCurrent.DataBind()
    End Sub

    Protected Sub lbtSetUTC_Command(sender As Object, e As CommandEventArgs)
        Dim taq As New LearnerPortalTableAdapters.QueriesTableAdapter
        tbCompleteBy.Text = ""
        hfProgressID.Value = e.CommandArgument
        lblCourseName.Text = taq.GetCourseNameForProgressID(e.CommandArgument)
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "setTBCModal", "<script>$('#modalSetDate').modal('show');</script>")
    End Sub

    Protected Sub lbtEditUTC_Command(sender As Object, e As CommandEventArgs)
        Dim taq As New LearnerPortalTableAdapters.QueriesTableAdapter
        Dim tbcDate As Date = CDate(taq.GetTBCDate(e.CommandArgument))
        lblCourseName.Text = taq.GetCourseNameForProgressID(e.CommandArgument)
        tbCompleteBy.Text = tbcDate.ToShortDateString
        hfProgressID.Value = e.CommandArgument
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "setTBCModal", "<script>$('#modalSetDate').modal('show');</script>")
    End Sub

    Protected Sub lbtLaunch_Command(sender As Object, e As CommandEventArgs)
        Dim nCustomisationID As Integer = CInt(e.CommandArgument)
        If nCustomisationID <= 0 Or Session("learnCandidateNumber") Is Nothing Then
            Exit Sub
        End If
        Dim sURL As String = My.Settings.ITSPTrackingURL & "learn?CustomisationID=" & nCustomisationID.ToString & "&lp=1"
        Response.Redirect(sURL)
    End Sub

    Protected Sub lbtRemove_Command(sender As Object, e As CommandEventArgs)
        hfRemoveProgressID.Value = e.CommandArgument
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "removeModal", "<script>$('#modalConfirm').modal('show');</script>")
    End Sub

    Protected Sub lbtUnlockRequest_Command(sender As Object, e As CommandEventArgs)
        Dim nProgressID As Integer = CInt(e.CommandArgument)
        If nProgressID > 0 Then
            Dim taUR As New LearnerPortalTableAdapters.UnlockRequestTableAdapter
            Dim tUR As New LearnerPortal.UnlockRequestDataTable
            tUR = taUR.GetData(nProgressID)
            If tUR.Count > 0 Then
                Dim sEmailTo As String = tUR.First.ContactEmail
                If sEmailTo <> "" Then
                    Dim sContactName As String = tUR.First.ContactForename
                    If sContactName = "" Then
                        sContactName = "Colleague"
                    End If
                    Dim sCourseName As String = tUR.First.CourseName
                    Dim sCCEmail As String = tUR.First.EmailAddress
                    Dim sDelName As String = tUR.First.DelegateName
                    Dim nCustomisationID As Integer = tUR.First.CustomisationID
                    'ccommon.SendEmail(tUR.First.ContactEmail
                    Dim sUnlockURL As String = My.Settings.ITSPTrackingURL & "centrecandidate.aspx?tab=course&CustomisationID=" & nCustomisationID.ToString
                    Dim SbBody As New StringBuilder
                    Dim sSubject As String = "Digital Learning Solutions Progress Unlock Request"
                    SbBody.Append("<body style=""font-family: Calibri; font-size: small;"">")
                    SbBody.Append("<p>Dear " & sContactName & "</p>")
                    SbBody.Append("<p>Digital Learning Solutions Delegate, " & sDelName & ", has requested that you unlock their progress for the course " & sCourseName & "</p>")
                    SbBody.Append("<p>They have reached the maximum number of assessment attempt allowed without passing.</p>")
                    SbBody.Append("<p>To review and unlock their progress, <a href='" & sUnlockURL & "'>click here</a>.</p>")
                    SbBody.Append("</body>")
                    If ccommon.SendEmail(sEmailTo, sSubject, SbBody.ToString(), True,, sCCEmail) Then
                        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalUpdateDetails", "<script>$('#modalUnlockConfirm').modal('show');</script>")
                    End If
                End If
            End If
        End If
    End Sub

    Private Sub bsgvCurrent_HtmlRowPrepared(sender As Object, e As ASPxGridViewTableRowEventArgs) Handles bsgvCurrent.HtmlRowPrepared
        If e.RowType <> DevExpress.Web.GridViewRowType.Data Then
            Return
        End If
        If e.GetValue("OverDue") = 2 Then
            e.Row.ToolTip = "Complete by date passed"
        ElseIf e.GetValue("OverDue") = 1 Then
            e.Row.ToolTip = "Within 1 month of complete by date"
        End If
    End Sub

    Private Sub dsCurrentCourses_Selected(sender As Object, e As ObjectDataSourceStatusEventArgs) Handles dsCurrentCourses.Selected
        Dim dt As DataTable = e.ReturnValue
        If dt.Rows.Count <= 15 Then
            bsgvCurrent.SettingsSearchPanel.Visible = False
        Else
            bsgvCurrent.SettingsSearchPanel.Visible = True
        End If
    End Sub
End Class