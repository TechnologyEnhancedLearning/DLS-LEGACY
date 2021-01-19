Public Class dlconsolidation
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.QueryString("client") Is Nothing Then
            lblOutcome.Text = "Error downloading consolidation materials. Please close this tab."
        Else
            'Do my ticker counter into a database based on my url   
            Dim client As String = Request.QueryString("client").ToString()
            '* insert etc   
            Dim taq As New LearnMenuTableAdapters.QueriesTableAdapter
            Dim nSectionID As Integer = taq.GetSectionIDByConsolidationPath(client)
            taq.uspIncrementConsolidationCount(nSectionID)
            Response.Redirect(client, True)
        End If
    End Sub

End Class