Public Class cstory
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub rptStoryContent_DataBinding(sender As Object, e As EventArgs) Handles rptStoryContent.DataBinding
        Dim taCS As New prelogindataTableAdapters.pl_CaseStudiesTableAdapter
        Dim tCS As New prelogindata.pl_CaseStudiesDataTable
        tCS = taCS.GetByCSID(Session("plCaseStudyID"))
        If tCS.Count > 0 Then
            If Not tCS.First.CaseImage Is Nothing Then
                bimgMain.Value = tCS.First.CaseImage
            Else
                bimgMain.Visible = False
            End If
            lblHeading.Text = tCS.First.CaseHeading
            lblSubheading.Text = tCS.First.CaseSubHeading
            lblDate.Text = tCS.First.CaseDate.ToShortDateString()
            lbtCategory.Text = tCS.First.CaseStudyGroup
        End If
    End Sub
End Class