Public Class welcome
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Dim taHL As New prelogindataTableAdapters.HeadlineFiguresTableAdapter
            Dim tHL As New prelogindata.HeadlineFiguresDataTable
            tHL = taHL.GetData
            If tHL.Count > 0 Then
                lblCentreCount.Text = tHL.First.ActiveCentres.ToString("N0")
                lblLearnerCount.Text = tHL.First.Delegates.ToString("N0")
                lblCompletionsCount.Text = tHL.First.Completions.ToString("N0")
                lblLearningHours.Text = tHL.First.LearningTime.ToString("N0")
            End If
        End If
    End Sub

End Class