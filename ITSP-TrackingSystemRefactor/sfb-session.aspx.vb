Public Class sfb_session
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Dim taSession As New SuperviseDataTableAdapters.SchedulerTableAdapter
            Dim tSession As New SuperviseData.SchedulerDataTable
            If Not Page.Request.Item("uri") Is Nothing Then
                tSession = taSession.GetDataByIDs(0, Nothing, Page.Request.Item("uri"))
            ElseIf Not Page.Request.Item("GUID") Is Nothing Then
                tSession = taSession.GetDataByIDs(0, Guid.Parse(Page.Request.Item("GUID")), "")
            End If
            If tSession.Count = 1 Then
                Dim rSess As SuperviseData.SchedulerRow = tSession.First
                Dim sEmail As String
                If Not Page.Request.Item("attemail") Is Nothing Then
                    sEmail = Page.Request.Item("attemail")
                Else
                    Dim suri As String = Page.Request.Item("uri")
                    Dim nLength As Integer = suri.IndexOf(";")
                    sEmail = suri.ToString.Substring(4, nLength - 4)
                End If
                Dim taq As New SuperviseDataTableAdapters.QueriesTableAdapter
                hfAttendees.Value = taq.GetSIPsCSVForLogItem(rSess.UniqueID, sEmail)
                If Session("UserEmail") Is Nothing Then
                    Session("UserEmail") = sEmail
                End If

                Session("SkypeMeetingID") = rSess.UniqueID
                attendLink.Attributes.Add("href", My.Settings.ITSPTrackingURL & "sv-schedule?id=" & Session("SkypeMeetingID").ToString)
                Session("learnCurrentLogItemID") = Session("SkypeMeetingID")
                rptFiles.DataBind()
                lblSession.Text = rSess.Subject
                    lblUISessionTitle.Text = rSess.Subject
                    lblUISessionStart.Text = FormatDateTime(rSess.StartDate, vbLongDate) & " - " & FormatDateTime(rSess.StartDate, vbShortTime)
                Else
                    ShowError("Invalid Session", "Invalid supervision session requested, please close this window and request a new link from your supervisor.")
            End If
        End If
    End Sub
    Protected Sub ShowError(ByVal sError As String, ByVal sMsg As String)
        lblErrorTitle.Text = sError
        lblErrorText.Text = sMsg
        joinskype.Attributes.Add("class", "d-none")
        skypeerror.Attributes.Remove("class")
        skypeerror.Attributes.Add("class", "bg-danger pt-6 pb-6")
    End Sub

    Private Sub dsFiles_Selected(sender As Object, e As ObjectDataSourceStatusEventArgs) Handles dsFiles.Selected
        If e.ReturnValue.Count = 0 Then
            pnlFiles.Visible = False
        Else
            pnlFiles.Visible = True
        End If
    End Sub

    Protected Function GetIconClass(ByVal sFileName As String) As String
        Return CCommon.GetIconClass(sFileName)
    End Function
    Protected Function NiceBytes(ByVal lBytes As Long)
        Return CCommon.BytesToString(lBytes)
    End Function
End Class