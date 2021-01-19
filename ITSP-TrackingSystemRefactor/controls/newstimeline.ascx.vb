Public Class newstimeline
    Inherits System.Web.UI.UserControl
    Public Property BrandID As Integer
    Public Property ProductID As Integer
    Public Property ResultCount As Integer
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim taNews As New prelogindataTableAdapters.pwNewsTableAdapter
        Dim tNews As New prelogindata.pwNewsDataTable
        If BrandID = 0 And ProductID = 0 Then
            lblHeader.Text = "Digital Learning Solutions News"
            tNews = taNews.GetActive(ResultCount)
        ElseIf BrandID > 0 Then
            Dim taB As New prelogindataTableAdapters.BrandsTableAdapter
            Dim tB As New prelogindata.BrandsDataTable
            tB = taB.GetDataByID(BrandID)
            If tB.Count = 1 Then
                lblHeader.Text = tB.First.BrandName & " News"
            End If
            tNews = taNews.GetDataByBrandID(ResultCount, BrandID)
        ElseIf ProductID > 0 Then
            Dim taP As New prelogindataTableAdapters.pl_ProductsTableAdapter
            Dim tP As New prelogindata.pl_ProductsDataTable
            tP = taP.GetByProductID(ProductID)
            If tP.Count = 1 Then
                lblHeader.Text = tP.First.ProductName & " News"
            End If
            tNews = taNews.GetDataByProductID(ResultCount, ProductID)
        End If
        If tNews.Count > 0 Then
            rptNews.DataSource = tNews
            rptNews.DataBind()
        Else
            pnlNews.Visible = False
        End If
    End Sub

End Class