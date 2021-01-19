Public Class ContentCreator
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Session("UserContentCreator") Then
            Response.Redirect("~/cms/Courses.aspx")
        End If
        If Not Page.IsPostBack Then
            Dim taq As New itspdbTableAdapters.QueriesTableAdapter
            Dim nAdminID As Integer = Session("UserAdminID")
            Dim taCC As New itspdbTableAdapters.CCLicencesTableAdapter
            Dim tCC As New itspdb.CCLicencesDataTable
            tCC = taCC.GetActiveLicenceForUser(nAdminID)
            If tCC.Count = 0 Then
                'No licence exists, create one:

                taq.AssignCCLicenceToUser(nAdminID)
                tCC = taCC.GetActiveLicenceForUser(nAdminID)
            End If
            If tCC.Count > 0 Then
                lblCCVersion.Text = taq.GetCCVersion
                hlDownloadCC.NavigateUrl = taq.GetCCDownloadURL
                lblLicenceCode.Text = tCC.First.LicenceText
                lblLicenceStart.Text = tCC.First.ActivatedDate.ToString("dd/MM/yyyy")
                litReleaseNotes.Text = taq.GetCCReleaseNotes
            End If
        End If
    End Sub

End Class