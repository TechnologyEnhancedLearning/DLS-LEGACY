Public Class quotes
    Inherits System.Web.UI.UserControl
    Public Property BrandID As Integer
    Public Property ProductID As Integer
    Public Property ResultCount As Integer
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim taQuotes As New prelogindataTableAdapters.pl_QuotesTableAdapter
        Dim tQuotes As New prelogindata.pl_QuotesDataTable
        If BrandID = 0 And ProductID = 0 Then
            lblHeader.Text = "What our Customers say about Digital Learning Solutions"
            tQuotes = taQuotes.GetActive(ResultCount)
        ElseIf BrandID > 0 Then
            Dim taB As New prelogindataTableAdapters.BrandsTableAdapter
            Dim tB As New prelogindata.BrandsDataTable
            tB = taB.GetDataByID(BrandID)
            If tB.Count = 1 Then
                lblHeader.Text = "What our Customers say about " & tB.First.BrandName
            End If
            tQuotes = taQuotes.GetActiveByBrandID(ResultCount, BrandID)
        ElseIf ProductID > 0 Then
            Dim taP As New prelogindataTableAdapters.pl_ProductsTableAdapter
            Dim tP As New prelogindata.pl_ProductsDataTable
            tP = taP.GetByProductID(ProductID)
            If tP.Count = 1 Then
                lblHeader.Text = "What our Customers say about " & tP.First.ProductName
            End If
            tQuotes = taQuotes.GetActiveByProductID(ResultCount, ProductID)
        End If
        If tQuotes.Count > 0 Then
            rptQuotes.DataSource = tQuotes
            rptQuotes.DataBind()
        Else
            pnlQuotes.Visible = False
        End If
    End Sub

End Class