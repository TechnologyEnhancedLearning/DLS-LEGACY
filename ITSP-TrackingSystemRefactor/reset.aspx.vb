Public Class reset
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            _SetupPassword()
        End If
    End Sub
    Protected Sub _SetupPassword()
        Dim sHash As String = Page.Request.Item("pwdr")
        Dim sEmail As String = Page.Request.Item("email")
        '
        ' Sanity check the hash code
        '
        If sHash Is Nothing OrElse sHash.Length > 64 OrElse sHash.Length < 36 Then
            Response.Redirect("~/Home?action=login&app=ts")
        End If
        '
        ' Let the stored procedure get the information about the password.
        '
        Dim taQueries As New ITSPTableAdapters.QueriesTableAdapter
        If sHash.Length = 64 Then

            Dim nAdminID As Integer = taQueries.uspGetUserFromPasswordHash(sHash, sEmail)

            If nAdminID <= 0 Then

                Me.lblConfirmMessage.Text = "There was a problem resetting your Password. The reset password link is only valid once. Please try again."
                Me.lblConfirmTitle.Text = "Error "
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalPWChangError", "<script>$('#confirmModal').modal('show');</script>")
            Else
                Session("pwType") = "Admin"
                Session("pwRequestUserID") = nAdminID
                bstbEmailReg.Text = sEmail
                bstbEmailReg.Enabled = False
            End If
        End If
        If sHash.Length = 36 Then
            Dim nCandidateID As Integer = taQueries.uspGetDelegateFromPasswordHash(sHash, sEmail)
            If nCandidateID <= 0 Then
                Me.lblConfirmMessage.Text = "There was a problem resetting your Password. The reset password link is only valid once. Please try again."
                Me.lblConfirmTitle.Text = "Error "
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalPWChangError", "<script>$('#confirmModal').modal('show');</script>")
            Else
                Session("pwType") = "Delegate"
                Session("pwRequestUserID") = nCandidateID
                bstbEmailReg.Text = sEmail
                bstbEmailReg.Enabled = False
            End If


        End If
    End Sub

    Private Sub bsbtnReset_Click(sender As Object, e As EventArgs) Handles bsbtnReset.Click
        hfTemp.Value = Crypto.HashPassword(bstbPasswordReg.Text.Trim)
        If Session("pwType") = "Admin" Then
            Dim nUserID As Integer = CInt(Session("pwRequestUserID"))
            If nUserID = 0 Then
                nUserID = Session("UserAdminID")
            End If
            Dim taAdminUsers As New ITSPTableAdapters.AdminUsersTableAdapter
            taAdminUsers.UpdatePasswordHash(hfTemp.Value, nUserID)



        ElseIf Session("pwType") = "Delegate" Then
            Dim taCandidates As New LearnerPortalTableAdapters.CandidatesTableAdapter
            taCandidates.SetPassword(hfTemp.Value, Session("pwRequestUserID"))

        End If
        Dim taCand As New AuthenticateTableAdapters.CandidatesTableAdapter
        Dim tCand As New Authenticate.CandidatesDataTable
        tCand = taCand.GetMatchesForReset(bstbEmailReg.Text)
        If tCand.Count > 0 And Session("pwType") = "Admin" Or tCand.Count > 1 And Session("pwType") = "Delegate" Then
            'give user the option to reset all of their related delegate accounts
            Dim sMsg As String = "<p>Would you like to update all " & tCand.Count.ToString & " of the delegate accounts that are associated with your e-mail address to use this new password (recommended)?</p>"
            lblUpdateAll.Text = sMsg
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "updateAllModal", "<script>$('#updateAllModal').modal('show');</script>")
        Else
            lblConfirmTitle.Text = "Password Reset Successful"
            lblConfirmMessage.Text = "Your password has been changed. You will be able to use your new password to login to all of your Digital Learning Solutions services." ' everything matches!
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalPWChanged", "<script>$('#confirmModal').modal('show');</script>")
        End If
    End Sub

    Private Sub lbtUpdateAll_Click(sender As Object, e As EventArgs) Handles lbtUpdateAll.Click
        Dim taCand As New AuthenticateTableAdapters.CandidatesTableAdapter
        Dim tCand As New Authenticate.CandidatesDataTable
        tCand = taCand.GetMatchesForReset(bstbEmailReg.Text)
        Dim taCandidates As New LearnerPortalTableAdapters.CandidatesTableAdapter
        For Each r As DataRow In tCand.Rows
            taCandidates.SetPassword(hfTemp.Value, r.Item("CandidateID"))
        Next
        lblConfirmTitle.Text = "Password Reset Successful"
        lblConfirmMessage.Text = "Your password has been changed. You will be able to use your new password to login to all of your Digital Learning Solutions services." ' everything matches!
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalPWChanged", "<script>$('#confirmModal').modal('show');</script>")

    End Sub
End Class