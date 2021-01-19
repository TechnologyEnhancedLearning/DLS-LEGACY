Public Class itspbenefits
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Private Sub btnCalculate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCalculate.Click
        If tbOrgSize.Text <> "" Then
            Dim nStaff As Double = CDbl(tbOrgSize.Text)
            Dim nEntry As Double = CDbl(tbPercentEntry.Text)
            Dim nLevel1 As Double = CDbl(tbPercentL1.Text)
            Dim fHourRate As Double = CDbl(ddAvgPayband.SelectedValue)
            Dim fSaveEntry As Double = CDbl((((nEntry / 100) * nStaff) * fHourRate) * 58.5)
            Dim fSaveLevel1 As Double = CDbl((((nLevel1 / 100) * nStaff) * fHourRate) * 65.025)
            Dim fTotSave As Double = fSaveEntry + fSaveLevel1
            Threading.Thread.CurrentThread.CurrentCulture = New Globalization.CultureInfo("en-GB", False)
            lblCalcOutput.Text = Decimal.Parse(fTotSave).ToString("c")
        End If
    End Sub
End Class