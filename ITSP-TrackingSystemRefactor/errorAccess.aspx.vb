Public Class errorAccess
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.Request.Item("code") Is Nothing Then
            If Page.Request.Item("code") = 3 Then
                lblError.Text = "An unexpected error occurred trying to load the course menu."
                pnlSessionDetail.Visible = True
                If Not Page.Request.Item("lmApplicationID") Is Nothing Then lblAppID = Session("lmApplicationID")
                If Not Page.Request.Item("UserCentreID") Is Nothing Then lblCentreID = Session("UserCentreID")
                If Not Page.Request.Item("lmCustomisationID") Is Nothing Then lblCustomisationID = Session("lmCustomisationID")
            End If
        End If
    End Sub

End Class