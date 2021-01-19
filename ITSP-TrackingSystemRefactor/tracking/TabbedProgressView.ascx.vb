Imports DevExpress.Web.Bootstrap

Public Class TabbedProgressView
    Inherits System.Web.UI.UserControl

    Dim fvProgDetail As FormView
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Protected Sub subDetailGrid_DataSelect(sender As Object, e As EventArgs)
        Dim sPageName = Request.Url.AbsolutePath.Substring(Request.Url.AbsolutePath.LastIndexOf("/") + 1).ToLower().Replace(".aspx", "")
        Dim grid As BootstrapGridView = TryCast(sender, BootstrapGridView)
        If Not grid Is Nothing Then
            Session("dvProgressID") = grid.GetMasterRowKeyValue()
        Else
            Session("dvProgressID") = 0
        End If

        fvProgDetail.DataBind()
    End Sub
    Protected Sub fvProgressDetail_DataBinding(ByVal sender As Object, ByVal e As EventArgs)
        Dim fv As FormView = CType(sender, FormView)
        fvProgDetail = fv

    End Sub

    Private Sub fvProgressDetail_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles fvProgressDetail.ItemCommand
        If e.CommandName = "ConfirmComplete" Then
            Dim bsdeComp As BootstrapDateEdit = DirectCast(fvProgressDetail.FindControl("bsdeCompleted"), BootstrapDateEdit)
            Dim nProgressID As Integer = CInt(e.CommandArgument)
            If bsdeComp.Date > DateAdd(DateInterval.Year, -10, Date.Now()) Then
                Dim taQueries As New centrecandidatesTableAdapters.QueriesTableAdapter
                taQueries.RecordCompletion(bsdeComp.Date, nProgressID)
                fvProgressDetail.DataBind()
            End If
        ElseIf e.CommandName = "SetTBC" Then
            Dim bsdeComp As BootstrapDateEdit = DirectCast(fvProgressDetail.FindControl("bsdeCompleteBy"), BootstrapDateEdit)
            Dim dDate As Date? = bsdeComp.Date
            Dim nProgressID As Integer = CInt(e.CommandArgument)
            If dDate >= Date.Now() Then
                Dim taQueries As New centrecandidatesTableAdapters.QueriesTableAdapter
                taQueries.SetTBCDate(dDate, nProgressID)
                fvProgressDetail.DataBind()
            End If
        End If
    End Sub
    Protected Function GetBG(ByVal pcComp As Integer) As String
        Dim sColor As String = ""
        Select Case pcComp

            Case 0 To 10
                sColor = "#E39CB7"
            Case 11 To 20
                sColor = "#E9AEAE"
            Case 21 To 30
                sColor = "#F0BFA5"
            Case 31 To 40
                sColor = "#F6D09C"
            Case 41 To 50
                sColor = "#FCE193"
            Case 51 To 60
                sColor = "#F2E793"
            Case 61 To 70
                sColor = "#DBE49B"
            Case 71 To 80
                sColor = "#C4E2A3"
            Case 81 To 90
                sColor = "#ADDEAB"
            Case Is > 90
                sColor = "#96DCB3"
        End Select

        Return sColor
    End Function
    Public Function GetSectionClass(ByVal pcComp As Integer) As String
        Dim sClass As String = ""
        Select Case pcComp
            Case 0 To 10
                sClass = "card card-ten"
            Case 11 To 20
                sClass = "card card-twenty"
            Case 21 To 30
                sClass = "card card-thirty"
            Case 31 To 40
                sClass = "card card-forty"
            Case 41 To 50
                sClass = "card card-fifty"
            Case 51 To 60
                sClass = "card card-sixty"
            Case 61 To 70
                sClass = "card card-seventy"
            Case 71 To 80
                sClass = "card card-eighty"
            Case 81 To 90
                sClass = "card card-ninety"
            Case Is > 90
                sClass = "card card-hundred"
        End Select

        Return sClass
    End Function
    Private Sub gvSections_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvSections.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim nSecID As Integer = gvSections.DataKeys(e.Row.RowIndex).Value
            Dim odsProg As ObjectDataSource = CType(e.Row.FindControl("dsProgressDetail"), ObjectDataSource)
            odsProg.SelectParameters(0).DefaultValue = nSecID
        End If
    End Sub

    Private Sub lbtViewDetailedProgress_Click(sender As Object, e As EventArgs) Handles lbtViewDetailedProgress.Click
        fvProgHead.DataBind()
        gvSections.DataBind()
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalDetail", "<script>$('#detailModal').modal('show');</script>")
    End Sub

    Private Sub fvProgHead_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles fvProgHead.ItemCommand
        Dim sPath As String = Request.Url.AbsoluteUri
        Dim nPos As Integer = Request.Url.AbsoluteUri.LastIndexOf("/") + 1
        Dim SUrl As String

        If e.CommandName = "finalise" Then
            'Dim sURL As String = CCommon.GetServerURL("http", 80) & "finalise" & _

            SUrl = sPath.Substring(0, nPos) & "finalise" &
          "?ProgressID=" & e.CommandArgument
            Response.Redirect(SUrl)
        ElseIf e.CommandName = "summary" Then
            SUrl = sPath.Substring(0, nPos) & "summary" &
             "?ProgressID=" & e.CommandArgument
            'Response.Redirect(SUrl)
            Dim pdfName As String = "ITSPSummary_" & e.CommandArgument.ToString & ".pdf"
            CCommon.GeneratePDFFromURL(SUrl, pdfName)
        End If
    End Sub

    Protected Sub lbtArchive_Command(sender As Object, e As CommandEventArgs)
        Session("tempProgIDForArchive") = e.CommandArgument
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "removeModal", "<script>$('#modalConfirm').modal('show');</script>")
    End Sub

    Protected Sub lbtConfirmRemove_Command(sender As Object, e As CommandEventArgs)
        Dim taq As New LearnerPortalTableAdapters.QueriesTableAdapter
        taq.RemoveProgress(Session("tempProgIDForArchive"))
        fvProgressDetail.DataBind()
        Session.Remove("tempProgIDForArchive")
    End Sub
    Protected Sub lbtSetSV_Command(sender As Object, e As CommandEventArgs)
        Dim ddSupervisor As DropDownList = fvProgressDetail.FindControl("ddSupervisor")
        If Not ddSupervisor Is Nothing Then
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
            fvProgressDetail.DataBind()
        End If
    End Sub

    Protected Sub lbtChangeSupervisor_Command(sender As Object, e As CommandEventArgs)
        Dim pnlChooseSV As Panel = fvProgressDetail.FindControl("pnlChooseSV")
        Dim pnlViewSupervisor As Panel = fvProgressDetail.FindControl("pnlViewSupervisor")
        pnlChooseSV.Visible = True

        pnlViewSupervisor.Visible = False
    End Sub

    Protected Sub lbtCancelSetSV_Command(sender As Object, e As CommandEventArgs)
        Dim pnlChooseSV As Panel = fvProgressDetail.FindControl("pnlChooseSV")
        Dim pnlViewSupervisor As Panel = fvProgressDetail.FindControl("pnlViewSupervisor")
        pnlViewSupervisor.Visible = True
        pnlChooseSV.Visible = False
    End Sub

    Protected Sub bsbtnSetComplete_Command(sender As Object, e As CommandEventArgs)
        Dim bsdeComp As BootstrapDateEdit = DirectCast(fvProgressDetail.FindControl("bsdeCompleted"), BootstrapDateEdit)
        Dim nProgressID As Integer = CInt(e.CommandArgument)
        If bsdeComp.Date > DateAdd(DateInterval.Year, -10, Date.Now()) Then
            Dim taQueries As New centrecandidatesTableAdapters.QueriesTableAdapter
            taQueries.RecordCompletion(bsdeComp.Date, nProgressID)
            fvProgressDetail.DataBind()
        End If
    End Sub
End Class