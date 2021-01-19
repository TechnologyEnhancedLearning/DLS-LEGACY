Imports System.Security.Cryptography
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
                Case "dashboard"
                    If Not Session("UserCentreAdmin") Then
                        CCommon.AdminUserLogout()
                        Response.Redirect("~/Home?action=login&app=ts")
                    End If
                    hlHelp.NavigateUrl = "~/help/Dashboard.html"
                    liCentre.Attributes.Add("class", "nav-item dropdown active")
                Case "delegates"
                    If Not Session("UserCentreAdmin") Then
                        CCommon.AdminUserLogout()
                        Response.Redirect("~/Home?action=login&app=ts")
                    End If
                    hlHelp.NavigateUrl = "~/help/AllDelegates.html"
                    liDelegates.Attributes.Add("class", "nav-item dropdown active")
                Case "delegategroups"
                    If Not Session("UserCentreAdmin") Then
                        CCommon.AdminUserLogout()
                        Response.Redirect("~/Home?action=login&app=ts")
                    End If
                    hlHelp.NavigateUrl = "~/help/AllDelegates.html"
                    liDelegates.Attributes.Add("class", "nav-item dropdown active")
                Case "coursedelegates"
                    If Not Session("UserCentreAdmin") Then
                        CCommon.AdminUserLogout()
                        Response.Redirect("~/Home?action=login&app=ts")
                    End If
                    hlHelp.NavigateUrl = "~/help/CourseDelegates.html"
                    liDelegates.Attributes.Add("class", "nav-item dropdown active")
                Case "approvedelegates"
                    If Not Session("UserCentreAdmin") Then
                        CCommon.AdminUserLogout()
                        Response.Redirect("~/Home?action=login&app=ts")
                    End If
                    hlHelp.NavigateUrl = "~/help/ApprovingDelegateRegistrations.html"
                    liDelegates.Attributes.Add("class", "nav-item dropdown active")
                Case "coursesetup"
                    If Not Session("UserCentreAdmin") Then
                        CCommon.AdminUserLogout()
                        Response.Redirect("~/Home?action=login&app=ts")
                    End If
                    hlHelp.NavigateUrl = "~/help/CourseSetup.html"
                    liCourseSetup.Attributes.Add("class", "nav-item active")
                Case "sv-schedule"
                    If Not Session("IsSupervisor") Then
                        CCommon.AdminUserLogout()
                        Response.Redirect("~/Home?action=login&app=ts")
                    End If
                    liSupervisor.Attributes.Add("class", "nav-item dropdown active")
                    hlHelp.NavigateUrl = "~/help/SuperviseDelegates.html"
                Case "sv-schedule"
                    If Not Session("IsSupervisor") Then
                        CCommon.AdminUserLogout()
                        Response.Redirect("~/Home?action=login&app=ts")
                    End If
                    liSupervisor.Attributes.Add("class", "nav-item dropdown active")
                    hlHelp.NavigateUrl = "~/help/ScheduleBeta.html"
                Case "centrelogins"
                    If Not Session("UserCentreManager") Then
                        CCommon.AdminUserLogout()
                        Response.Redirect("~/Home?action=login&app=ts")
                    End If
                    hlHelp.NavigateUrl = "~/help/ApprovingaCentreUserRegistration.html"
                    liCentre.Attributes.Add("class", "nav-item dropdown active")
                Case "learningportal"
                    hlHelp.NavigateUrl = "~/help/LearningPortalConfiguration.html"
                    liCentre.Attributes.Add("class", "nav-item dropdown active")
                Case "resources"
                    hlHelp.NavigateUrl = "~/help/Resources.html"
                    liSupport.Attributes.Add("class", "nav-item dropdown active")
                Case "reports"
                    hlHelp.NavigateUrl = "~/help/Reports.html"
                    liCentre.Attributes.Add("class", "nav-item dropdown active")
                Case "reportfwa"
                    If Not Session("UserCentreReports") Then
                        CCommon.AdminUserLogout()
                        Response.Redirect("~/Home?action=login&app=ts")
                    End If
                    hlHelp.NavigateUrl = "~/help/Reports.html"
                    liCentre.Attributes.Add("class", "nav-item dropdown active")
                Case "faqs", "tickets"
                    hlHelp.NavigateUrl = "~/help/FAQs.html"
                    liSupport.Attributes.Add("class", "nav-item dropdown active")
                Case "tickets"
                    If Not Session("UserCentreAdmin") And Not Session("UserUserAdmin") Then
                        CCommon.AdminUserLogout()
                        Response.Redirect("~/Home?action=login&app=ts")
                    End If
                    hlHelp.NavigateUrl = "~/help/SupportTickets.html"
                    liSupport.Attributes.Add("class", "nav-item dropdown active")
                Case "statsdetail"
                    If Not Session("UserUserAdmin") And Not Session("UserSummaryReports") Then
                        'There is a problem, logout:
                        CCommon.AdminUserLogout()
                        Response.Redirect("~/Home?action=login&app=ts")
                    End If
                    liAdmin.Attributes.Add("class", "nav-item dropdown active")

                Case "admin-configuration", "admin-resources", "admin-faqs", "admin-centres", "admin-centrecourses", "admin-adminusers", "admin-delegates", "admin-notifications", "admin-landing", "statsdetail"
                    If Not Session("UserUserAdmin") Then
                        'There is a problem, logout:
                        CCommon.AdminUserLogout()
                        Response.Redirect("~/Home?action=login&app=ts")
                    End If
                    liAdmin.Attributes.Add("class", "nav-item dropdown active")
            End Select
            hlHelpBtn.NavigateUrl = hlHelp.NavigateUrl
        End If

        '
        ' Set up logged-in user
        '
        If Not Session("UserAdminID") Is Nothing And Not thisURL.StartsWith("error") Then
            CCommon.UpdateAdminUserSession(Session("UserAdminSessionID"), True)

            'show and hide tabs as appropriate
            If CInt(Session("IsSupervisor")) = 0 Then
                liSupervisor.Visible = False
                sch6.Visible = False
            End If
            If CInt(Session("UserCentreAdmin")) = 0 And CInt(Session("UserUserAdmin")) = 0 Then
                liCentre.Visible = False
                liDelegates.Visible = False
                liCourseSetup.Visible = False
                liTickets.Visible = False
                liTickets1.Visible = False
                sch1.Visible = False
                sch2.Visible = False
                sch3.Visible = False
                sch4.Visible = False
            End If
            If CInt(Session("UserUserAdmin")) = 0 Then
                liAdmin.Visible = False
                liAdminadminusers.Visible = False
                liAdmincentrecourses.Visible = False
                liAdmindelegates.Visible = False
                liAdmincentres.Visible = False
                liAdminConfiguration.Visible = False
                liAdminfaqs.Visible = False
                liAdminresources.Visible = False
                sch5.Visible = False
            End If
            If CInt(Session("UserCentreReports")) = 0 Then
                liReportFWA.Visible = False
            End If
            If CInt(Session("UserCentreManager")) = 0 Then
                liCentreLogins.Visible = False
                liCentreLogins2.Visible = False
            End If
            Dim taq As New ITSPTableAdapters.QueriesTableAdapter
            If taq.CheckCentreDCSA(Session("UserCentreID")) = 0 Then
                liDCSReport.Visible = False
            End If
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
    'Private Function GenerateHashKey() As String
    '    Dim myStr As New StringBuilder()
    '    myStr.Append(Request.Browser.Browser)
    '    myStr.Append(Request.Browser.Platform)
    '    myStr.Append(Request.Browser.MajorVersion)
    '    myStr.Append(Request.Browser.MinorVersion)
    '    'myStr.Append(Request.LogonUserIdentity.User.Value);
    '    Dim sha As SHA1 = New SHA1CryptoServiceProvider()
    '    Dim hashdata As Byte() = sha.ComputeHash(Encoding.UTF8.GetBytes(myStr.ToString()))
    '    Return Convert.ToBase64String(hashdata)
    'End Function

    ''' <summary>
    ''' The page has been loaded and all code has been set. All profile values, if being changed, 
    ''' should have been changed. So we can save the profile if it is dirty.
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
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

    Private Sub lbtDownloadDCSReport_Click(sender As Object, e As EventArgs) Handles lbtDownloadDCSReport.Click
        Dim taDCSA As New ITSPStatsTableAdapters.CentreDigitalCapabilityLearnerStatusTableAdapter
        Dim tDCSA As ITSPStats.CentreDigitalCapabilityLearnerStatusDataTable = taDCSA.GetData(Session("UserCentreID"))
        tDCSA.TableName = "DCSA Delegate Completion Status"
        Dim taDCSA2 As New ITSPStatsTableAdapters.CentreDigitalCapabilitySATableAdapter
        Dim tDCSA2 As ITSPStats.CentreDigitalCapabilitySADataTable = taDCSA2.GetData(Session("UserCentreID"))
        tDCSA2.TableName = "DCSA Outcome Summary"
        Dim DS_Export As New DataSet("Digital Capability Self Assessment Report")
        DS_Export.Tables.Add(tDCSA)
        DS_Export.Tables.Add(tDCSA2)
        XMLExport.ExportToExcel(DS_Export, "DLS DCSA Report - Centre " & Session("UserCentreID").ToString & " - " & CCommon.sCurrentDate & ".xlsx", Page.Response)
    End Sub
End Class