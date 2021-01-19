Public Class cstoriespreview
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim hf As HiddenField = cstories.FindControl("hfResultCount")
        If Not hf Is Nothing Then
            hf.Value = 1000

        End If
    End Sub

End Class