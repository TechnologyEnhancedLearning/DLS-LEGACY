Public Class lportal
    Inherits System.Web.UI.MasterPage
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        System.Threading.Thread.CurrentThread.CurrentCulture = New System.Globalization.CultureInfo("en-GB")
        Dim sPage As String = Request.Url.Segments.Last()
        'check if centreID has been loaded into session:
        If Not Page.IsPostBack Then
            If Session("BannerText") Is Nothing Then Session("BannerText") = ""
            litAccess.Text = CCommon.GetConfigString("AccessibilityNotice")
            'litPrivacy.Text = CCommon.GetConfigString("PrivacyNotice")
            litTOUDetail.Text = CCommon.GetConfigString("TermsAndConditions")

        End If

        ' check if user is logged in
        If Not Session("learnUserAuthenticated") Then
            If Page.Request.Item("redirected") Is Nothing Then
                Page.Response.Redirect("~/home?action=login&app=lp" & Server.UrlEncode(Request.Url.AbsoluteUri))
            ElseIf Not Page.Request.Item("centreid") Is Nothing Then
                Response.Redirect("~/Home?action=login&app=lp" & "&centreid=" & Page.Request.Item("centreid"))
            Else
                Response.Redirect("~/Home?action=login&app=lp")
            End If
            'user isn't authenticated so load the default page:

            pnlMenu.Visible = False
            pnlMenu.Visible = False
        Else
            'Me.logoImage.Height = 120
            Me.logoImage.Height = CInt(Session("logoHeight"))
            Me.logoImage.Width = CInt(Session("logoWidth"))
            Me.logoImage.Visible = Session("logoVisible")
            nhsdlogo.Visible = Not Session("logoVisible")




            pnlMenu.Visible = True
            pnlMenu.Visible = True
            Select Case sPage.ToLower()
                Case "current", "current.aspx"
                    'liCurrent.Attributes.Add("class", "active")
                    aCurrent.Attributes.Add("class", "menu-active")
                Case "completed.aspx", "completed"
                    'liCompleted.Attributes.Add("class", "active")
                    aCompleted.Attributes.Add("class", "menu-active")
                Case "available.aspx", "available"
                    aAvailable.Attributes.Add("class", "menu-active")
                Case "knowledgebank.aspx", "knowledgebank"
                    aKnowledgeBank.Attributes.Add("class", "menu-active")
            End Select
        End If


    End Sub


End Class