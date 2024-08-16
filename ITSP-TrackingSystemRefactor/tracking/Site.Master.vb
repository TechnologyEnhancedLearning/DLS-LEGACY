Public Class SiteMaster
    Inherits MasterPage
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        ' Check if session is still alive and logoff if not:
        System.Threading.Thread.CurrentThread.CurrentCulture = New System.Globalization.CultureInfo("en-GB")
        If Context.Session IsNot Nothing Then
            If Session.IsNewSession Then
                Dim szCookieHeader As String = Request.Headers("Cookie")
                If (szCookieHeader IsNot Nothing) AndAlso (szCookieHeader.IndexOf("ASP.NET_SessionId") >= 0) Then
                    '
                    ' Do the logout - clearing the session.
                    '
                    CCommon.AdminUserLogout()
                    '
                    ' Reloading the default page will reset the tabs and menus
                    '
                    Try
                        If Page.Request.Item("redirected") Is Nothing Then
                            Page.Response.Redirect("~/home?action=login&app=ts&returnurl=" & Server.UrlEncode(Request.Url.AbsoluteUri))
                        Else
                            Page.Response.Redirect("~/home?action=login&app=ts")
                        End If

                    Catch

                    End Try
                End If
            End If
        End If
        Dim sPageName = Request.Url.AbsolutePath.Substring(Request.Url.AbsolutePath.LastIndexOf("/") + 1).ToLower().Replace(".aspx", "")
        If Session("UserAdminID") Is Nothing Then
            Session("NavigateTo") = Request.Url.AbsoluteUri
            Try
                If Page.Request.Item("redirected") Is Nothing Then
                    Page.Response.Redirect("~/home?action=login&app=ts&returnurl=" & Server.UrlEncode(Request.Url.AbsoluteUri))
                Else
                    Page.Response.Redirect("~/home?action=login&app=ts")
                End If
            Catch

            End Try
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            litAccess.Text = CCommon.GetConfigString("AccessibilityNotice")
            'litPrivacy.Text = CCommon.GetConfigString("PrivacyNotice")
            litTOUDetail.Text = CCommon.GetConfigString("TermsAndConditions")
        End If
        If Not Session("NoITSPLogo") Is Nothing Or Not Page.Request.Item("nobrand") Is Nothing Then
            logoImage.Attributes.Add("class", "mr-auto")
            Session("NoITSPLogo") = True
            pnlMainLogo.Visible = "False"
        End If
        Dim thisURL As String = Request.Url.Segments(Request.Url.Segments.Count - 1).ToLower()
        thisURL = thisURL.Replace(".aspx", "")
        If thisURL = "learn" Then
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(60))
            Response.Cache.SetCacheability(HttpCacheability.Private)
            Response.Cache.SetMaxAge(TimeSpan.FromMinutes(60))
        Else
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1))
            Response.Cache.SetCacheability(HttpCacheability.NoCache)
            Response.Cache.SetNoStore()
            Select Case thisURL

                Case "admin-configuration"
                    If Not Session("UserUserAdmin") Then
                        CCommon.AdminUserLogout()
                        Response.Redirect("~/Home?action=login&app=ts")
                    End If
                    liPrelogin.Attributes.Add("class", "nav-item active")
                Case "admin-faqs"
                    If Not Session("UserUserAdmin") Then
                        CCommon.AdminUserLogout()
                        Response.Redirect("~/Home?action=login&app=ts")
                    End If
                    liAdminfaqs.Attributes.Add("class", "nav-item active")
                Case "admin-notifications"
                    If Not Session("UserUserAdmin") Then
                        CCommon.AdminUserLogout()
                        Response.Redirect("~/Home?action=login&app=ts")
                    End If
                    liAdminNotifications.Attributes.Add("class", "nav-item active")
                Case "admin-resources"
                    If Not Session("UserUserAdmin") Then
                        CCommon.AdminUserLogout()
                        Response.Redirect("~/Home?action=login&app=ts")
                    End If
                    liAdminresources.Attributes.Add("class", "nav-item active")
            End Select
        End If

        '
        ' Set up logged-in user
        '
        If Not Session("UserAdminID") Is Nothing And Not thisURL.StartsWith("error") Then
            CCommon.UpdateAdminUserSession(Session("UserAdminSessionID"), True)
        End If



        '
        ' Highlight the tab by calling the menu script
        '


        'Me.logoImage.Height = 120
        Me.logoImage.Height = CInt(Session("logoHeight"))
        Me.logoImage.Width = CInt(Session("logoWidth"))
        Me.logoImage.Visible = Session("logoVisible")
        nhsdlogo.Visible = Not Session("logoVisible")
        Page.MaintainScrollPositionOnPostBack = True
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        Dim EITSProfileData As CEITSProfile = CEITSProfile.GetProfile(Session)

        If Not EITSProfileData Is Nothing Then
            '
            ' We've got a profile so must have a logged in user.
            ' If it's dirty then save it to the AdminUser table.
            '
            If EITSProfileData.IsDirty() Then
                Dim taAdminUsers = New ITSPTableAdapters.AdminUsersTableAdapter
                Dim EITSProfile As String = EITSProfileData.GetProfileAsString()

                taAdminUsers.UpdateEITSProfile(EITSProfile, CType(Session("UserAdminID"), Integer))
            End If
        End If
    End Sub


End Class