Public Class centrelogins
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnToggle_Click(sender As Object, e As CommandEventArgs)
        Dim nAdminUserID As Integer = e.CommandArgument
        If nAdminUserID > 0 Then
            Dim taq As New ITSPTableAdapters.AdminUsersTableAdapter
            taq.ToggleApproved(nAdminUserID)
            bsgvAdminUsers.DataBind()
        End If
    End Sub
    Protected Sub Unlock_Click(sender As Object, e As CommandEventArgs)
        Dim nAdminUserID As Integer = e.CommandArgument
        If nAdminUserID > 0 Then
            Dim taq As New ITSPTableAdapters.AdminUsersTableAdapter
            taq.ResetFailCount(nAdminUserID)
            bsgvAdminUsers.DataBind()
        End If
    End Sub
    Protected Sub InactivateUser_Click(sender As Object, e As CommandEventArgs)
        Dim nAdminID As Integer = CInt(e.CommandArgument)
        Dim taAdminUsers As New ITSPTableAdapters.AdminUsersTableAdapter
        Dim nRes As Integer = taAdminUsers.InactivateUserByID(nAdminID)
        If nRes = 1 Then
            lblModalHeading.Text = "User Inactivated"
            lblModalMessage.Text = "The user's account has been inactivated. They will no longer be able to login."
        ElseIf nRes = 2 Then
            lblModalHeading.Text = "Admin User Account Deleted"
            lblModalMessage.Text = "The user's account has been deleted because they have never logged in."
        End If
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalConfirm", "<script>$('#messageModal').modal('show');</script>")
        bsgvAdminUsers.DataBind()
    End Sub

    Protected Sub lbtEditRoles_Command(sender As Object, e As CommandEventArgs)
        Dim taAdminUser As New ITSPTableAdapters.AdminUsersTableAdapter
        Dim tAdminUser As New ITSP.AdminUsersDataTable
        tAdminUser = taAdminUser.GetByAdminID(e.CommandArgument)
        If tAdminUser.Count = 1 Then
            Dim r As ITSP.AdminUsersRow = tAdminUser.First
            tbAdminUser.Text = r.Forename & " " & r.Surname & "(" & r.Email & ")"
            ddCategory.SelectedValue = r.CategoryID
            If r.ContentManager And r.ImportOnly Then
                ddCMSRole.SelectedValue = 1
            ElseIf r.ContentManager Then
                ddCMSRole.SelectedValue = 2
            Else
                ddCMSRole.SelectedValue = 0
            End If
            hfAdminID.Value = e.CommandArgument
            cbCentreAdmin.Checked = r.CentreAdmin
            cbCCLicence.Checked = r.ContentCreator
            cbSupervisor.Checked = r.Supervisor
            cbTrainer.Checked = r.Trainer
            cbFrameworkDeveloper.Checked = r.IsFrameworkDeveloper
            Dim taContractDash As New ITSPTableAdapters.ContractUsageDashTableAdapter
            Dim tCD As New ITSP.ContractUsageDashDataTable
            tCD = taContractDash.GetData(Session("UserCentreID"))
            If tCD.Count = 1 Then
                Dim cdr As ITSP.ContractUsageDashRow = tCD.First
                'Okay let's check limits and restrict controls accordingly
                'First CC Licences:
                If Not cbCCLicence.Checked Then
                    If cdr.CCLicencesLimit > -1 And cdr.CCLicences >= cdr.CCLicencesLimit Then
                        'lock it!
                        cbCCLicence.Enabled = False
                        If cdr.CustomCoursesLimit > 0 Then
                            cbCCLicence.ToolTip = "All of your " & cdr.CustomCoursesLimit.ToString & " Content Creator licences are assigned"
                        Else
                            cbCCLicence.ToolTip = "No Content Creator licences at centre"
                        End If

                    End If
                End If
                'Now trainers:
                If Not cbTrainer.Checked Then
                    If cdr.TrainersLimit > -1 And cdr.Trainers >= cdr.TrainersLimit Then
                        cbTrainer.Enabled = False
                        If cdr.TrainersLimit > 0 Then
                            cbTrainer.ToolTip = "All of your " & cdr.TrainersLimit.ToString & " Trainer roles are assigned"
                        Else
                            cbTrainer.ToolTip = "No Trainer roles at centre"
                        End If
                    End If
                End If
                'Now CMS admins:
                ddCMSRole.ToolTip = ""
                If Not ddCMSRole.SelectedValue = 1 Then
                    If cdr.CMSAdministratorsLimit > -1 And cdr.CMSAdmins >= cdr.CMSAdministratorsLimit Then
                        For Each i As ListItem In ddCMSRole.Items
                            If i.Value = 1 Then
                                i.Enabled = False
                                ddCMSRole.ToolTip = "No free CMS admin roles at centre. "
                            End If
                        Next
                    End If

                End If
                'Finally CMS managers:
                If Not ddCMSRole.SelectedValue = 2 Then
                    If cdr.CMSManagersLimit > -1 And cdr.CMSManagers >= cdr.CMSManagersLimit Then
                        For Each i As ListItem In ddCMSRole.Items
                            If i.Value = 2 Then
                                i.Enabled = False
                                ddCMSRole.ToolTip = ddCMSRole.ToolTip & "No free CMS manager roles at centre. "
                            End If
                        Next
                    End If

                End If
            End If
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalMessage", "<script>$('#editUserModal').modal('show');</script>")
        End If

    End Sub

    Private Sub lbtAdminEditSubmit_Click(sender As Object, e As EventArgs) Handles lbtAdminEditSubmit.Click
        Dim taq As New ITSPTableAdapters.QueriesTableAdapter
        taq.UpdateAdminUserRoles(hfAdminID.Value, ddCategory.SelectedValue, ddCMSRole.SelectedValue, cbCCLicence.Checked, cbSupervisor.Checked, cbTrainer.Checked, cbCentreAdmin.Checked)
        bsgvAdminUsers.DataBind()
        rptContractDash.DataBind()
    End Sub
End Class