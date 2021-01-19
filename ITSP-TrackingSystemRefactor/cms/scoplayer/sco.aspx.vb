Partial Public Class scont
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.Request.Item("tutpath") Is Nothing Then
            Dim sScript As String = "<script>"
            sScript = sScript + "$(document).ready(function() {"
            sScript = sScript + "Run.ManifestByURL('" & Page.Request.Item("tutpath")
            sScript = sScript + "', false);});</script>"
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "LoadSco", sScript)
        End If
    End Sub

End Class