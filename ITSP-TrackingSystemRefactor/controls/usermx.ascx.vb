﻿Public Class usermx
    Inherits System.Web.UI.UserControl
    Protected Property bUserAuth As Boolean = False
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        hlAccount.NavigateUrl = My.Settings.RefactoredAppBaseURL + "Login"
        hlAppSelect.NavigateUrl = My.Settings.RefactoredAppBaseURL + "ApplicationSelector"
    End Sub

    Private Sub usermx_Init(sender As Object, e As EventArgs) Handles Me.Init

    End Sub

    Private Sub usermx_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender
        If Not Session("UserAdminID") Is Nothing Then
            If Session("UserAdminID") > 0 Then
                hlAccount.Visible = False
                hlAppSelect.Visible = True
            End If
        End If

        If Not Session("learnUserAuthenticated") Is Nothing Then
            If Session("learnUserAuthenticated") Then
                hlAccount.Visible = False
                hlAppSelect.Visible = True
            End If
        End If
    End Sub
End Class