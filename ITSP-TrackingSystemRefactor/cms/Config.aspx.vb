Imports DevExpress.Web.Data
Public Class Config
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim taC As New itspdbTableAdapters.CentresTableAdapter
        Dim tC As New itspdb.CentresDataTable
        tC = taC.GetByCentreID(Session("UserCentreID"))
        If tC.Count = 1 Then
            Dim nTotalBytes As Long = tC.First.ServerSpaceUsed
            Dim sSize As String = CCommon.BytesToString(nTotalBytes)
            lblUsed.Text = sSize
            Dim nAvail As Long = tC.First.ServerSpaceBytes
            lblAvailable.Text = CCommon.BytesToString(nAvail)
            Dim percentageusage As Long = 0
            If nAvail > 0 Then
                percentageusage = (nTotalBytes * 100) / nAvail
            Else
                percentageusage = 100
            End If
            If percentageusage > 100 Then
                percentageusage = 100
            End If
            progbar.Attributes.Add("aria-valuenow", percentageusage.ToString())
            progbar.Attributes.Add("style", "width:" & percentageusage.ToString() & "%;")
            lblPercent.Text = percentageusage.ToString() & "%"
            Select Case percentageusage
                Case > 90
                    pnlUsage.Attributes.Add("class", "alert alert-danger")
                Case < 60
                    pnlUsage.Attributes.Add("class", "alert alert-success")
                Case Else
                    pnlUsage.Attributes.Add("class", "alert alert-warning")
            End Select

        End If

    End Sub
    Protected Sub InitNewRow_DefaultActive(sender As Object, e As ASPxDataInitNewRowEventArgs)
        e.NewValues("Active") = True
        e.NewValues("CentreID") = Session("UserCentreID")
    End Sub
End Class