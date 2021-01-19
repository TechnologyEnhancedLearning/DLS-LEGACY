Public Class brand
    Inherits System.Web.UI.UserControl
    Protected Property nBrandPopularity As Integer = 100
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim taB As New prelogindataTableAdapters.BrandsTableAdapter
        Dim tB As New prelogindata.BrandsDataTable

        tB = taB.GetDataByID(Session("plBrandID"))
        If tB.Count = 1 Then
            nBrandPopularity = tB.First.PopularityHigh
            If Not tB.First.BrandImage Is Nothing Then
                bimgBrand.Value = tB.First.BrandImage
            Else
                bimgBrand.Visible = False
            End If
            lblBrandName.Text = tB.First.BrandName
            lblBrandDescription.Text = tB.First.BrandDescription
        End If
        If Session("plBrandID") > 1 Then
            pnlTabs.Visible = False
        End If
    End Sub

    Private Sub dsBrandTutorials_Selected(sender As Object, e As ObjectDataSourceStatusEventArgs) Handles dsBrandTutorials.Selected
        If e.ReturnValue.Count = 0 Then
            pnlBrandTutorials.Visible = False
        Else
            pnlBrandTutorials.Visible = True
        End If
    End Sub

    Protected Function GetTimeString(ByVal nMins As Integer) As String
        Dim sReturn As String = ""
        Dim ts As TimeSpan = TimeSpan.FromMinutes(nMins)
        sReturn = String.Format("{0}h {1}m", ts.Hours, ts.Minutes)
        Return sReturn
    End Function
    Protected Function GetPopularity(ByVal nPop As Integer) As Decimal
        Dim dReturn As Decimal = nPop / nBrandPopularity
        Return dReturn
    End Function
End Class