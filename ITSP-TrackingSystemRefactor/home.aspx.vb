Public Class home
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

        If Not Session("UserCentreID") Is Nothing Then
            If Session("UserCentreID") > 0 Then
                pnlLogin.Visible = False
                pnlAppSelect.Visible = True
            End If
        End If
    End Sub
    Private Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        If Page.IsValid Then
            Try
                CCommon.SendEmail("dls@hee.nhs.uk", tbSubject.Text, tbMessage.Text, False,,,,,, tbEmail.Text)
            Catch ex As Exception
                lblHmConfirmTitle.Text = "Error Sending Message"
                lblHmConfirmMessage.Text = "<p>There was a problem sending your message. Please try emailing it to <a href='mailto:dls@hee.nhs.uk'>dls@hee.nhs.uk</a>.</p>"
            Finally
                lblHmConfirmTitle.Text = "Thank you for your Message"
                lblHmConfirmMessage.Text = "<p>Your message was successfully sent. We will aim to respond within 2 working days.</p><p>If you are a learner, we will be unable to respond to your request; it should be directed to your IT Training centre or Learning and Development department instead.</p>"
                tbSubject.Text = ""
                tbMessage.Text = ""
                tbEmail.Text = ""
            End Try
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowContactOutcome", "<script>$('#hmConfirmModal').modal('show');</script>")
        End If
    End Sub
End Class