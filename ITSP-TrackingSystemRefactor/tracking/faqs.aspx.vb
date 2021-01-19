Public Class faqs
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim sTrackingURL As String = CCommon.GetConfigString("TrackingSystemBaseURL")
        Session("TSURL") = sTrackingURL
        If Not Page.Request.Item("tag") Is Nothing Then
            lbtShowAll.Visible = True
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "expand", "$('.panel-collapse').removeClass( 'collapse' ).addClass( 'collapse-in' );", True)
        Else
            lbtShowAll.Visible = False
        End If
    End Sub

    Private Sub lbtShowAll_Click(sender As Object, e As EventArgs) Handles lbtShowAll.Click
        Dim sUri As Uri = New Uri(Request.Url.AbsoluteUri)
        Dim sURL = sUri.Scheme & Uri.SchemeDelimiter & sUri.Authority & sUri.AbsolutePath
        Response.Redirect(sURL)
    End Sub
End Class