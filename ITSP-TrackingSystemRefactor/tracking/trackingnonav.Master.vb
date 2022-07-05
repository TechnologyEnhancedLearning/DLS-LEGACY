Imports System.Security.Claims
Imports Microsoft.Owin.Security
Imports Microsoft.Owin.Security.Cookies
Imports Microsoft.Owin.Security.OpenIdConnect
Public Class trackingnonav
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("UserAdminID") Is Nothing And Session("learnUserAuthenticated") Is Nothing Then
            If Request.IsAuthenticated Then
                Dim sEmailClaim As String = ConfigurationManager.AppSettings("ida:EmailClaim")
                If Not ClaimsPrincipal.Current.FindFirst(sEmailClaim) Is Nothing Then
                    Dim sEmail As String = System.Security.Claims.ClaimsPrincipal.Current.FindFirst(sEmailClaim).Value
                    If sEmail.Contains("@") Then
                        Dim taq As New AuthenticateTableAdapters.QueriesTableAdapter
                        Dim nCentreID As Integer = 0
                        If ClaimsPrincipal.Current.FindFirst("UserCentreID") IsNot Nothing Then
                            nCentreID = CInt(ClaimsPrincipal.Current.FindFirst("UserCentreID").Value)
                        Else
                            nCentreID = taq.GetCentreIDForEmail(sEmail)
                        End If

                        If nCentreID = 0 Then
                            If Session("PromptReg") Is Nothing Then

                                'user isn't currently registered to DLS - offer to register:

                                Session("PromptReg") = True
                                Dim sNameClaim As String = ConfigurationManager.AppSettings("ida:NameClaim")
                                If Not ClaimsPrincipal.Current.FindFirst(sNameClaim) Is Nothing Then
                                    Dim sName As String = ClaimsPrincipal.Current.FindFirst(sNameClaim).Value
                                    Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowRegModal", "<script>$('#registerMSUserModal').modal('show');</script>")
                                End If
                            End If
                        Else
                            Login(sEmail, nCentreID, "")
                        End If
                    End If
                End If
            End If
        End If
    End Sub
    Private Sub LogIn(ByVal sUsername As String, ByVal nCentreID As Integer, ByVal sPassword As String)
        'Setup variables requiring defaults:
        If sUsername.Length > 0 Then
            Session("bAliasLogin") = False
            Session("UserCentreID") = 0
            Session("UserCentreManager") = False
            Session("UserCentreAdmin") = False
            Session("UserUserAdmin") = False
            Session("UserContentCreator") = False
            Session("UserAuthenticatedCM") = False
            Session("UserPublishToAll") = False
            Session("UserImportOnly") = False
            Session("UserCentreReports") = False
            Session("learnCandidateID") = 0
            Session("learnUserAuthenticated") = False
            Session("AdminCategoryID") = 0
            Session("IsSupervisor") = False
            Session("IsTrainer") = False
            Session("IsFrameworkDeveloper") = False
            Session("IsFrameworkContributor") = False
            GetAdminRecord(sUsername, nCentreID, sPassword)
            GetDelegateRecord(sUsername, nCentreID, sPassword)
            If Session("UserAdminID") Is Nothing And Session("learnUserAuthenticated") Then
                GetAdminRecord(Session("UserEmail"), Session("UserCentreID"), sPassword)
            End If
            Session("LearningPortalUrl") = CCommon.GetLPURL(Session("UserAdminID"), Session("UserCentreID"))

            CCommon.LoginFromSession(False, Session, Request, Context)
            If Session("UserCentreID") > 0 Then
                Dim taCentre As New ITSPTableAdapters.CentresTableAdapter
                Dim tCtre As New ITSP.CentresDataTable
                tCtre = taCentre.GetByCentreID(CInt(Session("UserCentreID")))
                If tCtre.First.Active = False Then
                    Response.Redirect("~/CentreInactive")
                End If
                Session("kbYouTube") = tCtre.First.kbYouTube
                Session("kbOfficeVersion") = tCtre.First.kbDefaultOfficeVersion
                Session("BannerText") = tCtre.First.BannerText
                Dim nHeight As Integer = tCtre.First.LogoHeight
                If nHeight = 0 Then
                    Session("logoVisible") = False
                Else
                    Dim nWidth As Integer = tCtre.First.LogoWidth
                    Dim nNewWidth As Integer = nWidth
                    Dim nNewHeight As Integer = nHeight
                    If nNewHeight > 96 Then
                        nNewWidth = CInt((CSng(96) / CSng(nHeight)) * CSng(nWidth))
                        nNewHeight = 96
                    End If
                    If nNewWidth > 300 Then
                        nNewHeight = CInt((CSng(300) / CSng(nNewWidth)) * CSng(nNewHeight))
                        nNewWidth = 300
                    End If

                    Session("logoHeight") = nNewHeight
                    Session("logoWidth") = nNewWidth
                    Session("logoVisible") = True
                End If
            End If

        End If
    End Sub
    Private Sub GetAdminRecord(ByVal sUsername As String, ByVal nCentreID As Integer, ByVal sPassword As String)
        'Check for a matching Admin Record:
        Dim taAdminUsers As New AuthenticateTableAdapters.AdminUsersTableAdapter
        Dim tAdminUsers As New Authenticate.AdminUsersDataTable
        tAdminUsers = taAdminUsers.GetData(sUsername, nCentreID)
        If tAdminUsers.Count > 0 Then
            'go through each record looking for a match:
            For Each r As DataRow In tAdminUsers.Rows
                If Crypto.VerifyHashedPassword(CStr(r.Item("Password")), sPassword) Or Session("learnUserAuthenticated") Or Request.IsAuthenticated Then
                    Session("UserForename") = r.Item("Forename")
                    Session("UserSurname") = r.Item("Surname")
                    Session("UserEmail") = r.Item("Email")
                    Session("UserCentreID") = r.Item("CentreID")
                    Session("UserCentreName") = r.Item("CentreName")
                    Session("UserCentreManager") = r.Item("IsCentreManager")
                    Session("UserCentreAdmin") = r.Item("CentreAdmin")
                    Session("UserUserAdmin") = r.Item("UserAdmin")
                    Session("UserAdminID") = r.Item("AdminID")
                    Session("UserContentCreator") = r.Item("ContentCreator")
                    Session("UserAuthenticatedCM") = r.Item("ContentManager")
                    Session("UserPublishToAll") = r.Item("PublishToAll")
                    Session("UserImportOnly") = r.Item("ImportOnly")
                    Session("UserAdminSessionID") = CCommon.CreateAdminUserSession(Session("UserAdminID"))
                    Session("AdminCategoryID") = r.Item("CategoryID")
                    Session("IsSupervisor") = r.Item("Supervisor")
                    Session("IsTrainer") = r.Item("Trainer")
                    Session("UserCentreReports") = r.Item("SummaryReports")
                    Session("IsFrameworkDeveloper") = r.Item("IsFrameworkDeveloper")
                    Session("IsFrameworkContributor") = r.Item("IsFrameworkContributor")
                    CEITSProfile.LoadProfileFromString(r.Item("EITSProfile")).SetProfile(Session)
                    'lbtAccount.Visible = False
                    'lbtAppSelect.Visible = True
                    Exit For
                End If
            Next
        End If
    End Sub
    Private Sub GetDelegateRecord(ByVal sUsername As String, ByVal nCentreID As Integer, ByVal sPassword As String)
        'Now check for a matching learner record:
        Dim taCandidates As New AuthenticateTableAdapters.CandidatesTableAdapter
        Dim tCandidates As New Authenticate.CandidatesDataTable
        If Session("UserCentreID") > 0 Then
            tCandidates = taCandidates.GetData(Session("UserEmail"), Session("UserCentreID"))
        Else
            tCandidates = taCandidates.GetData(sUsername, nCentreID)
        End If

        If tCandidates.Count > 0 Then
            'go through each and look for matches:
            For Each r As DataRow In tCandidates.Rows
                If r.Item("Approved") Then
                    'Check that the password matches or an admin user at the same centre has already authenticated:
                    If (Session("UserCentreID") > 0 And r.Item("CentreID") = Session("UserCentreID")) Then
                        Session("learnCandidateID") = r.Item("CandidateID")
                        Session("learnCandidateNumber") = r.Item("CandidateNumber")
                        Session("learnUserAuthenticated") = True
                        'lbtAccount.Visible = False
                        'lbtAppSelect.Visible = True
                        Exit For
                    ElseIf Not IsDBNull(r.Item("Password")) Then
                        If Crypto.VerifyHashedPassword(CStr(r.Item("Password")), sPassword) Or Request.IsAuthenticated Then
                            If r.Item("EmailAddress").ToString.ToLower() <> sUsername.ToLower() And r.Item("CandidateNumber").ToString.ToLower() <> sUsername.ToLower() Then
                                Session("bAliasLogin") = True
                            End If
                            'Populate name, e-mail etc beccause it wasn't populated from admin user:
                            Session("UserForename") = r.Item("FirstName")
                            Session("UserSurname") = r.Item("LastName")
                            Session("UserEmail") = r.Item("EmailAddress")
                            Session("UserCentreID") = r.Item("CentreID")
                            Session("UserCentreName") = r.Item("CentreName")
                            Session("learnCandidateID") = r.Item("CandidateID")
                            Session("learnCandidateNumber") = r.Item("CandidateNumber")
                            Session("learnUserAuthenticated") = True
                            Dim taq As New AuthenticateTableAdapters.QueriesTableAdapter
                            If taq.GetFrameworkCollaboratorCountForEmail(Session("UserEmail").ToString.Trim()) > 0 Then
                                Try
                                    Dim nAdminId = taq.InsertAdminAccountFromDelegate(Session("learnCandidateID"), 0, 0, 0, 0, 0, 0)
                                    If nAdminId > 0 Then
                                        taq.SetAdminUserIsFrameworkContributor(nAdminId)
                                        taq.UpdateFrameworkCollaboratorAdminID(nAdminId, Session("UserEmail"))
                                    End If
                                Catch

                                End Try
                            End If
                            Exit For
                        End If

                    End If
                Else
                    Session("delUnapproved") = True
                End If
            Next
        End If
    End Sub
End Class