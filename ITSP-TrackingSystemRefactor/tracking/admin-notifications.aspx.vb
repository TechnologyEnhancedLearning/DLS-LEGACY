Imports DevExpress.Web.Bootstrap
Imports DevExpress.Web.Data

Public Class admin_notifications
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Private Sub lbtSendEmail_Click(sender As Object, e As EventArgs) Handles lbtSendEmail.Click
        If CCommon.SendEmail(tbTo.Text, tbSubject.Text, tbBody.Text, False, , tbCC.Text) Then
            Dim sMessage As String = "Message sent to <b>" & tbTo.Text
            If tbCC.Text.Trim.Length > 0 Then
                sMessage += "</b> and CCd to <b>" + tbCC.Text
            End If
            sMessage += "</b>. The message was sent from the address <b>noreply@dls.nhs.uk</b>."
            _DoModal(sMessage, "Message Sent")
            tbTo.Text = ""
            tbCC.Text = ""
        Else
            Dim sMessage As String = "There was a problem sending a message to <b>" & tbTo.Text
            If tbCC.Text.Trim.Length > 0 Then
                sMessage += "</b>, CCd to <b>" + tbCC.Text
            End If
            sMessage += "</b> from the address <b>noreply@dls.nhs.uk</b>."
            _DoModal(sMessage, "Failed to Send Message")
        End If
    End Sub
    Protected Sub _DoModal(ByVal sMessage As String, ByVal sTitle As String)
        lblModalHeading.Text = sTitle
        lblModalMessage.Text = sMessage
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalMessage", "<script>$('#messageModal').modal('show');</script>")
    End Sub

    Private Sub bsgvSANotifications_CellEditorInitialize(sender As Object, e As BootstrapGridViewEditorEventArgs) Handles bsgvSANotifications.CellEditorInitialize
        If bsgvSANotifications.IsEditing And Not bsgvSANotifications.IsNewRowEditing Then
            If e.Column.FieldName = "TargetUserRoleID" Then
                e.Editor.ReadOnly = True
            End If
        ElseIf bsgvSANotifications.IsNewRowEditing Then
            If e.Column.FieldName = "TargetUserRoleID" Then
                e.Editor.ReadOnly = False
            End If
        End If
    End Sub

    Private Sub dsSANotifications_Inserted(sender As Object, e As ObjectDataSourceStatusEventArgs) Handles dsSANotifications.Inserted
        Dim nSANotificationID As Integer = e.ReturnValue
        Dim taSAN As New NotificationsTableAdapters.SANotificationsTableAdapter
        Dim tSAN As New Notifications.SANotificationsDataTable
        tSAN = taSAN.GetByID(nSANotificationID)
        If tSAN.Count = 1 Then
            Dim sSubjectLine As String = "Digital Learning Solutions Notification - " + tSAN.First.SubjectLine
            Dim sBody As String = tSAN.First.BodyHTML
            Dim nTargetRoleID As Integer = tSAN.First.TargetUserRoleID
            Dim taSANAU As New NotificationsTableAdapters.AdminUsersForSANTableAdapter
            Dim tSANAU As New Notifications.AdminUsersForSANDataTable
            tSANAU = taSANAU.GetData(nTargetRoleID)
            Dim nCount As Integer = tSANAU.Count

            If tSANAU.Count > 0 Then
                Dim sFrom As String = "Digital Learning Solutions Notifications <noreply@dls.nhs.uk>"
                Dim sBodyHTML As String
                Dim taq As New NotificationsTableAdapters.QueriesTableAdapter
                Dim sRole As String = taq.GetUserRoleByID(tSAN.First.TargetUserRoleID)
                For Each r As DataRow In tSANAU.Rows
                    sBodyHTML = "<p>Dear " + r.Item("Forename") + "</p>" + "<p>This is a notification published to the Digital Learning Solutions Tracking System for the attention of all users with the role " + sRole + ":</p><hr/>" + sBody
                    CCommon.SendEmail(r.Item("Email"), sSubjectLine, sBodyHTML, True, sFrom)
                Next
            End If

            _DoModal("Notification added and e-mail sent to " + nCount.ToString() + " subscribed users", "Notification Added")
        End If
    End Sub
End Class