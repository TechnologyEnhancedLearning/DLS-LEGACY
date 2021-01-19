Imports DevExpress.Web
Imports DevExpress.Web.Bootstrap
Public Class supervise
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Protected Sub GridViewCustomToolbar_ToolbarItemClick(sender As Object, e As BootstrapGridViewToolbarItemClickEventArgs)
        If e.Item.Name = "ExcelExport" Then
            DelegateGridViewExporter.WriteXlsxToResponse()
        End If
    End Sub

    Protected Sub lbtReview_Command(sender As Object, e As CommandEventArgs)
        Dim nProgID As Integer = e.CommandArgument
        Session("TempProgressID") = nProgID
        dsSections.SelectParameters(0).DefaultValue = nProgID
        Dim taSI As New SuperviseDataTableAdapters.SummaryInfoTableAdapter
        Dim r As SuperviseData.SummaryInfoRow = taSI.GetData(nProgID).First
        lblDelegate.Text = r.FirstName & " " & r.LastName & " (" & r.CandidateNumber & ")"
        lblCourse.Text = r.ApplicationName & " - " & r.CustomisationName
        tbEnrolled.Text = r.FirstSubmittedTime.ToShortDateString()
        tbLastAccessed.Text = r.SubmittedTime.ToShortDateString()
        tbEmailAddress.Text = r.EmailAddress
        tbLogins.Text = r.LoginCount.ToString()
        If Not r.IsCompleteByDateNull Then
            tbCompleteBy.Text = r.CompleteByDate.ToShortDateString()
        End If
        If Not r.IsCompletedNull Then
            tbCompleted.Text = r.Completed.ToShortDateString()
        End If
        If r.Prompt1.Length > 0 Then
            pnlAnswer1.Visible = True
            lblAnswer1TextInsert.Text = r.Prompt1 & ":"
            txtAnswer1.Text = r.Answer1
        Else
            pnlAnswer1.Visible = False
        End If
        If r.Prompt2.Length > 0 Then
            pnlAnswer2.Visible = True
            lblAnswer2TextInsert.Text = r.Prompt2 & ":"
            txtAnswer2.Text = r.Answer2
        Else
            pnlAnswer2.Visible = False
        End If
        If r.Prompt3.Length > 0 Then
            pnlAnswer3.Visible = True
            lblAnswer3TextInsert.Text = r.Prompt3 & ":"
            txtAnswer3.Text = r.Answer3
        Else
            pnlAnswer3.Visible = False
        End If
        If r.Prompt4.Length > 0 Then
            pnlAnswer4.Visible = True
            lblAnswer4TextInsert.Text = r.Prompt4 & ":"
            txtAnswer4.Text = r.Answer4
        Else
            pnlAnswer4.Visible = False
        End If
        If r.Prompt5.Length > 0 Then
            pnlAnswer5.Visible = True
            lblAnswer5TextInsert.Text = r.Prompt5 & ":"
            txtAnswer5.Text = r.Answer5
        Else
            pnlAnswer5.Visible = False
        End If
        If r.Prompt6.Length > 0 Then
            pnlAnswer6.Visible = True
            lblAnswer6TextInsert.Text = r.Prompt6 & ":"
            txtAnswer6.Text = r.Answer6
        Else
            pnlAnswer6.Visible = False
        End If
        rptSections.DataBind()
        mvSupervise.SetActiveView(vSuperviseDetail)
    End Sub

    Protected Sub lbtCloseDetail_Command(sender As Object, e As CommandEventArgs)
        bsgvSuperviseDelegates.DataBind()
        Session.Remove("TempProgressID")
        mvSupervise.SetActiveView(vSupervisionGrid)
    End Sub
    Protected Function GetNiceMins(nMins As Integer) As String
        Dim sReturn As String
        Dim hrs As Integer = 0
        Dim mins As Integer = nMins
        sReturn = mins.ToString & " mins"
        If nMins >= 60 Then
            hrs = nMins / 60
            mins = nMins Mod 60
            sReturn = hrs.ToString & " hrs " & mins.ToString & " mins"
        End If
        Return sReturn
    End Function


    Protected Sub fvSelfAssess_DataBound(sender As Object, e As EventArgs)
        Dim fv As FormView = TryCast(sender, FormView)
        Dim bsgv As BootstrapGridView = fv.FindControl("bsgvSkillEvidence")
        If Not bsgv Is Nothing Then
            bsgv.DataBind()
        End If
        bsgv = fv.FindControl("bsgvSkillActions")
        If Not bsgv Is Nothing Then
            bsgv.DataBind()
        End If
    End Sub
    Protected Function GetIconClass(ByVal sFileName As String) As String
        Return CCommon.GetIconClass(sFileName)
    End Function
    Protected Function NiceBytes(ByVal lBytes As Long)
        Return CCommon.BytesToString(lBytes)
    End Function

    Protected Sub lbtSVSubmit_Command(sender As Object, e As CommandEventArgs)
        Dim fv As FormView = TryCast(sender.NamingContainer, FormView)
        If Not fv Is Nothing Then
            Dim rbtSuccess As BootstrapRadioButton = fv.FindControl("bsrbtSuccess")
            Dim rbtFail As BootstrapRadioButton = fv.FindControl("bsrbtFail")
            If Not rbtFail Is Nothing And Not rbtSuccess Is Nothing Then
                If Not rbtFail.Checked And Not rbtSuccess.Checked Then
                    'display validation error message
                Else
                    Dim bOutcome As Boolean = False
                    If rbtSuccess.Checked Then
                        bOutcome = True
                    End If
                    Dim tbSV As TextBox = fv.FindControl("tbSVComments")
                    Dim taq As New SuperviseDataTableAdapters.QueriesTableAdapter
                    Dim nVRs As Integer = taq.GetCountVerRequests(Session("TempProgressID"))
                    taq.SubmitSVVerification(tbSV.Text, bOutcome, Session("UserAdminID"), fv.DataKey.Value)
                    If nVRs > 0 And taq.GetCountVerRequests(Session("TempProgressID")) = 0 Then
                        SendSVVerifiedNotification()
                    End If
                    rptSections.DataBind()
                    End If

                End If
        End If
    End Sub
    Protected Sub SendSVVerifiedNotification()
        Dim taSum As New SuperviseDataTableAdapters.SummaryInfoTableAdapter
        Dim rSum As SuperviseData.SummaryInfoRow = taSum.GetData(Session("TempProgressID")).First
        Dim SbBody As New StringBuilder
        SbBody.Append("<body style=""font-family: Calibri; font-size: small;"">")
        SbBody.Append("<p>Dear " & rSum.FirstName & " " & rSum.LastName & "</p>")
        SbBody.Append("<p>Your supervisor " & Session("UserForename") & " " & Session("UserSurname") & ", has verified the skills and/or objectives that you submitted for verification against the Digital Learning Solutions activity <b>" & rSum.ApplicationName & "</b>.</p>")

        SbBody.Append("<p>To see your supervisor's verification outcomes and comments against these skills or objectives, please login to the <a href='" & My.Settings.ITSPTrackingURL & "/learn?customisationid=" & rSum.CustomisationID.ToString & "'>DLS activity</a>.</p>")

        SbBody.Append("</body>")
        Dim sSubject As String = "DLS Supervisor Verification Complete"
        CCommon.SendEmail(rSum.EmailAddress, sSubject, SbBody.ToString(), True,,,, 17, rSum.CandidateID)
    End Sub
    Protected Sub lbtReviseVerification_Command(sender As Object, e As CommandEventArgs)
        Dim fv As FormView = TryCast(sender.NamingContainer, FormView)
        Dim mv As MultiView = fv.FindControl("mvSupervisorVerify")
        If Not mv Is Nothing Then
            mv.ActiveViewIndex = 1
        End If
    End Sub
End Class