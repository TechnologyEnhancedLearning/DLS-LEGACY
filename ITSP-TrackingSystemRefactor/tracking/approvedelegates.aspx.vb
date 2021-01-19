Imports DevExpress.Web.Bootstrap

Public Class approvedelegates
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Protected Sub RejectDelegate_Click(sender As Object, e As CommandEventArgs)
        Dim taq As New ITSPTableAdapters.QueriesTableAdapter
        Dim nCandidateID As Integer = CInt(e.CommandArgument)
        Dim nProgCount As Integer = CInt(taq.GetProgressCountForCandidate(nCandidateID))
        If nProgCount = 0 Then
            taq.DeleteCandidate(nCandidateID, CInt(Session("UserCentreID")))
        Else
            taq.InactivateCandidate(nCandidateID, CInt(Session("UserCentreID")))
        End If
        bsgvAwaitingApproval.DataBind()
    End Sub
    Protected Sub ApproveDelegate_Click(sender As Object, e As CommandEventArgs)
        ApproveDelegate(e.CommandArgument)
        bsgvAwaitingApproval.DataBind()
    End Sub

    Protected Sub lbtApproveSelected_Command(sender As Object, e As CommandEventArgs)
        Dim bsgv As BootstrapGridView = bsgvAwaitingApproval
        For Each i As Object In bsgv.GetSelectedFieldValues("CandidateID")
            ApproveDelegate(i)
        Next
        bsgvAwaitingApproval.DataBind()
    End Sub
    Protected Sub ApproveDelegate(ByVal nCandidateID As Integer)
        Dim taq As New ITSPTableAdapters.QueriesTableAdapter
        Dim sEmail As String = taq.GetEmailByCandidateID(nCandidateID)
        Dim sCNum As String = taq.GetCandidateNumberByID(nCandidateID)
        taq.ApproveCandidate(nCandidateID, CInt(Session("UserCentreID")))
        CCommon.SendEmail(sEmail, "Digital Learning Solutions Registration Approved", "<p>Your Digital Learning Solutions registration has been approved by your centre administrator.</p><p>You can now login to the Digital Learning Solutions learning materials using your e-mail address or your Delegate ID number <b>" & sCNum & "</b> and the password you chose during registration.</p><p>For more assistance in accessing the materials, please contact your Digital Learning Solutions centre.</p>", True)
    End Sub
End Class