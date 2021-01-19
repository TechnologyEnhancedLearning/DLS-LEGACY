Public Class DelegatesModals
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub lbtMarkComplete_Command(sender As Object, e As CommandEventArgs)

        Dim nProgressID As Integer = Session("dvProgressID")
        If bsdeCompleted.Date > DateAdd(DateInterval.Year, -10, Date.Now()) Then
            Dim taQueries As New centrecandidatesTableAdapters.QueriesTableAdapter
            taQueries.RecordCompletion(bsdeCompleted.Date, nProgressID)
            bsdeCompleted.Text = ""
            Page.DataBind()
        End If
    End Sub

    Protected Sub lbtSetTBC_Command(sender As Object, e As CommandEventArgs)

        Dim dDate As Date? = bsdeCompleteBy.Date
        Dim nProgressID As Integer = Session("dvProgressID")
        If dDate >= Date.Now() Then
            Dim taQueries As New centrecandidatesTableAdapters.QueriesTableAdapter
            taQueries.SetTBCDate(dDate, nProgressID)
            bsdeCompleteBy.Text = ""
            Page.DataBind()

        End If
    End Sub
    Protected Sub lbtSetSV_Command(sender As Object, e As CommandEventArgs)
        If ddSupervisor.SelectedValue > 0 Then
            Dim taq As New SuperviseDataTableAdapters.QueriesTableAdapter
            Dim bUpdated As Boolean = taq.SetSupervisorForProgress(Session("dvProgressID"), ddSupervisor.SelectedValue)
            If bUpdated Then
                Dim taSVE As New SuperviseDataTableAdapters.SetSupervisorEmailTableAdapter
                Dim rSVE As SuperviseData.SetSupervisorEmailRow = taSVE.GetData(Session("dvProgressID")).First
                Dim SbBody As New StringBuilder
                SbBody.Append("<body style=""font-family: Calibri; font-size: small;"">")
                SbBody.Append("<p>Dear " & rSVE.AdminName & "</p>")
                SbBody.Append("<p>This is an automated message from the Digital Learning Solutions (DLS) platform to notify you that you have been identified as supervisor by <b>" + rSVE.DelegateName + "</b> for their course or activity <b>" + rSVE.CourseName + "</b>.</p>")
                SbBody.Append("<p>To access the DLS Supervisor interface to supervise this delegate, please visit the <a href='" & My.Settings.ITSPTrackingURL & "/supervise'>DLS Supervisor Interface</a>.</p>")
                SbBody.Append("<p>To contact the delegate to discuss this supervision request, e-mail them at <a href='mailto:" & Session("UserEmail") & "'>" & Session("UserEmail") & "</a>.</p>")
                SbBody.Append("</body>")
                Dim sSubject As String = "You were nominated as Supervisor by a DLS Delegate"
                CCommon.SendEmail(rSVE.AdminEmail, sSubject, SbBody.ToString(), True,,,, 15, rSVE.AdminID)
            End If
        End If
        ddSupervisor.SelectedIndex = 0
        Page.DataBind()
    End Sub
End Class