Public Class SiteMasterCMS
    Inherits MasterPage

    Const AntiXsrfTokenKey As String = "__AntiXsrfToken"
    Const AntiXsrfUserNameKey As String = "__AntiXsrfUserName"
    Dim _antiXsrfTokenValue As String

    Protected Sub Page_Init(sender As Object, e As System.EventArgs)
        ' The code below helps to protect against XSRF attacks
        Dim requestCookie As HttpCookie = Request.Cookies(AntiXsrfTokenKey)
        Dim requestCookieGuidValue As Guid
        If ((Not requestCookie Is Nothing) AndAlso Guid.TryParse(requestCookie.Value, requestCookieGuidValue)) Then
            ' Use the Anti-XSRF token from the cookie
            _antiXsrfTokenValue = requestCookie.Value
            Page.ViewStateUserKey = _antiXsrfTokenValue
        Else
            ' Generate a new Anti-XSRF token and save to the cookie
            _antiXsrfTokenValue = Guid.NewGuid().ToString("N")
            Page.ViewStateUserKey = _antiXsrfTokenValue

            Dim responseCookie As HttpCookie = New HttpCookie(AntiXsrfTokenKey) With {.HttpOnly = True, .Value = _antiXsrfTokenValue}
            If (FormsAuthentication.RequireSSL And Request.IsSecureConnection) Then
                responseCookie.Secure = True
            End If
            Response.Cookies.Set(responseCookie)
        End If
        System.Threading.Thread.CurrentThread.CurrentCulture = New System.Globalization.CultureInfo("en-GB")
        AddHandler Page.PreLoad, AddressOf master_Page_PreLoad
    End Sub

    Private Sub master_Page_PreLoad(sender As Object, e As System.EventArgs)
        If (Not IsPostBack) Then
            ' Set Anti-XSRF token
            ViewState(AntiXsrfTokenKey) = Page.ViewStateUserKey
            ViewState(AntiXsrfUserNameKey) = If(Context.User.Identity.Name, String.Empty)
        Else
            ' Validate the Anti-XSRF token
            If (Not DirectCast(ViewState(AntiXsrfTokenKey), String) = _antiXsrfTokenValue _
                Or Not DirectCast(ViewState(AntiXsrfUserNameKey), String) = If(Context.User.Identity.Name, String.Empty)) Then
                Throw New InvalidOperationException("Validation of Anti-XSRF token failed.")
            End If
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            litAccess.Text = CCommon.GetConfigString("AccessibilityNotice")
            'litPrivacy.Text = CCommon.GetConfigString("PrivacyNotice")
            litTOUDetail.Text = CCommon.GetConfigString("TermsAndConditions")
        End If
        Dim sPage As String = Request.Url.Segments.Last()
        If Not Session("UserAuthenticatedCM") Then
            If Page.Request.Item("redirected") Is Nothing Then
                Page.Response.Redirect("~/home?action=login&app=cms" & Server.UrlEncode(Request.Url.AbsoluteUri))
            Else
                Page.Response.Redirect("~/home?action=login&app=cms")
            End If
            'ulManage.Visible = False
            'ulMenu.Visible = False
        Else
            liContentCreator.Visible = Session("UserContentCreator")
            'ulManage.Visible = True
            'ulManage.Visible = True
            sPage = sPage.Replace(".aspx", "").ToLower()
            Select Case sPage
                Case "courses"
                    liCourses.Attributes.Add("class", "nav-item active")
                Case "managecontent"
                    liContent.Attributes.Add("class", "nav-item active")
                Case "publish"
                    liPublish.Attributes.Add("class", "nav-item active")
                Case "contentcreator"
                    liContentCreator.Attributes.Add("class", "nav-item active")
                Case "config"
                    liConfig.Attributes.Add("class", "nav-item active")
            End Select
        End If
        'Me.logoImage.Height = 120
        Me.logoImage.Height = CInt(Session("logoHeight"))
        Me.logoImage.Width = CInt(Session("logoWidth"))
        Me.logoImage.Visible = Session("logoVisible")
        nhsdlogo.Visible = Not Session("logoVisible")
    End Sub

End Class