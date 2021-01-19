Partial Public Class summary
	Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim nProgressID As Integer = CInt(Page.Request.Item("ProgressID"))
        Session("ProgressID") = nProgressID

        'Session("UserCentreID") = CInt(Page.Request.Item("UserCentreID"))
        lblCurrentDate.Text = DateTime.Now.ToString("dd MMMM yyyy")
        Dim CertificateInfoTA As New ITSPTableAdapters.CertificateInfoTableAdapter
        Dim tblCertificateInfo As ITSP.CertificateInfoDataTable
        Dim rCert As ITSP.CertificateInfoRow

        tblCertificateInfo = CertificateInfoTA.GetDataByProgressID(nProgressID)

        If tblCertificateInfo.Count > 0 Then

            rCert = tblCertificateInfo.First
            If Session("UserCentreID") Is Nothing Then
                Session("UserCentreID") = rCert.CentreID
            End If

            If rCert.LogoHeight > 0 And rCert.LogoWidth > 0 Then
                Dim nWidth As Integer = rCert.LogoWidth
                Dim nHeight As Integer = rCert.LogoHeight

                If nHeight > 90 Then
                    nWidth = CInt((CSng(90) / CSng(nHeight)) * CSng(nWidth))
                    nHeight = 90
                End If
                Me.Logo.Width = nWidth
                Me.Logo.Height = nHeight
                '
                ' Pass three parameters to the signature loading so that it's unlikely that
                ' users can reload an odl signature.
                '

                Me.Logo.ImageUrl = "~/centrelogo?centreid=" & rCert.CentreID
            End If
        Else
            Logo.Visible = False
        End If
    End Sub

End Class