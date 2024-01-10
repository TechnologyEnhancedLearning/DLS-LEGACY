Public Class home
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Redirect to V2 login page:
        Dim supportEmail As String = CCommon.GetConfigString("SupportEmail")

        If Not Request.IsAuthenticated Then
            Dim LoginURL As String = My.Settings.RefactoredAppBaseURL + "Home/Welcome"
            Response.Redirect(LoginURL)
        End If

        If Not Page.IsPostBack Then
            Dim taHL As New prelogindataTableAdapters.HeadlineFiguresTableAdapter
            Dim tHL As New prelogindata.HeadlineFiguresDataTable
            tHL = taHL.GetData

        End If

        If Not Session("UserCentreID") Is Nothing Then
            If Session("UserCentreID") > 0 Then

                Dim appSelectorURL As String = My.Settings.RefactoredAppBaseURL + "ApplicationSelector"
                Response.Redirect(appSelectorURL)
            End If
        End If
    End Sub


End Class