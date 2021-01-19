Public Class Landing
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            litAccess.Text = CCommon.GetConfigString("AccessibilityNotice")
            'litPrivacy.Text = CCommon.GetConfigString("PrivacyNotice")
            litTOUDetail.Text = CCommon.GetConfigString("TermsAndConditions")
        End If
    End Sub


End Class