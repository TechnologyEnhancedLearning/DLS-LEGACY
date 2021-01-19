Imports Microsoft.AspNetCore.DataProtection
Imports Microsoft.IdentityModel.Protocols.OpenIdConnect
Imports Microsoft.IdentityModel.Tokens
Imports Microsoft.Owin.Extensions
Imports Microsoft.Owin.Security
Imports Microsoft.Owin.Security.Cookies
Imports Microsoft.Owin.Security.Notifications
Imports Microsoft.Owin.Security.OpenIdConnect
Imports Owin
Imports System
Imports System.Configuration
Imports System.Linq
Imports System.Security.Claims
Imports System.Threading.Tasks
Imports Microsoft.Owin.Security.Interop

Partial Public Class Startup
    Private Shared clientId As String = ConfigurationManager.AppSettings("ida:ClientId")
    Private Shared aadInstance As String = EnsureTrailingSlash(ConfigurationManager.AppSettings("ida:AADInstance"))
    'Private Shared tenantId As String = ConfigurationManager.AppSettings("ida:TenantId")
    Private Shared postLogoutRedirectUri As String = ConfigurationManager.AppSettings("ida:PostLogoutRedirectUri")
    Private Shared redirectUri As String = ConfigurationManager.AppSettings("ida:RedirectUri")
    Private Shared keyFolder As String = ConfigurationManager.AppSettings("ida:KeyFolder")
    'Private authority As String = aadInstance & tenantId
    'Private authority As String = "https://login.microsoftonline.com/common/v2.0"
    Public Sub ConfigureAuth(ByVal app As IAppBuilder)

        app.SetDefaultSignInAsAuthenticationType(CookieAuthenticationDefaults.AuthenticationType)
        app.UseCookieAuthentication(New CookieAuthenticationOptions With {
        .CookieName = ".AspNet.SharedCookie",
        .TicketDataFormat = New AspNetTicketDataFormat(New DataProtectorShim(DataProtectionProvider.Create(New IO.DirectoryInfo(keyFolder), Function(builder)
                                                                                                                                                builder.SetApplicationName("DLSSharedCookieApp")
                                                                                                                                            End Function).CreateProtector("Microsoft.AspNetCore.Authentication.Cookies." & "CookieAuthenticationMiddleware", "Identity.Application", "v2"))),
        .CookieManager = New ChunkingCookieManager()
        })
        app.UseOpenIdConnectAuthentication(New OpenIdConnectAuthenticationOptions With {
                .ClientId = clientId,
                .Authority = aadInstance,
                .ClientSecret = ConfigurationManager.AppSettings("ida:ClientSecret"),
                .PostLogoutRedirectUri = postLogoutRedirectUri,
                .RedirectUri = redirectUri,
                .Scope = "openid email profile OnlineMeetings.ReadWrite",
                .TokenValidationParameters = New TokenValidationParameters With {
                    .ValidateIssuer = False,
                    .NameClaimType = "name"
                },
                .Notifications = New OpenIdConnectAuthenticationNotifications() With {
                    .AuthenticationFailed = AddressOf OnAuthenticationFailed,
                    .SecurityTokenValidated = AddressOf OnSecurityTokenValidated
        }
            })
        app.UseStageMarker(PipelineStage.Authenticate)
    End Sub

    Private Shared Function EnsureTrailingSlash(ByVal value As String) As String
        If value Is Nothing Then
            value = String.Empty
        End If

        If Not value.EndsWith("/", StringComparison.Ordinal) Then
            Return value & "/"
        End If

        Return value
    End Function
    Public Function OnAuthenticationFailed(ByVal context As AuthenticationFailedNotification(Of OpenIdConnectMessage, OpenIdConnectAuthenticationOptions)) As Task
        context.HandleResponse()
        context.Response.Redirect("/?errormessage=" & context.Exception.Message)
        Return Task.FromResult(0)
    End Function
    Private Function OnSecurityTokenValidated(ByVal context As SecurityTokenValidatedNotification(Of OpenIdConnectMessage, OpenIdConnectAuthenticationOptions)) As Task
        Dim claims = context.AuthenticationTicket.Identity.Claims
        Dim groups = From c In claims Where c.Type = "groups" Select c

        For Each group In groups
            context.AuthenticationTicket.Identity.AddClaim(New Claim(ClaimTypes.Role, group.Value))
        Next
        If Not context.ProtocolMessage.AccessToken Is Nothing Then
            context.AuthenticationTicket.Identity.AddClaim(New Claim("access_token", context.ProtocolMessage.AccessToken))
        End If
        AddClaims(context.AuthenticationTicket.Identity, context)
        Return Task.FromResult(0)
    End Function
    Private Shared Sub AddClaims(ByRef claimsIdentity As ClaimsIdentity, ByRef context As SecurityTokenValidatedNotification(Of OpenIdConnectMessage, OpenIdConnectAuthenticationOptions))
        Dim sEmailClaim As String = ConfigurationManager.AppSettings("ida:EmailClaim")
        Dim sEmail As String = claimsIdentity.Claims.Where(Function(c) c.Type = sEmailClaim).[Select](Function(c) c.Value).SingleOrDefault()
        Dim nUserCentreID As Integer = 0
        Dim bUserCentreManager As Boolean = False
        Dim bUserCentreAdmin As Boolean = False
        Dim bUserUserAdmin As Boolean = False
        Dim nUserUserAdminID As Integer = 0
        Dim bUserContentCreator As Boolean = False
        Dim bUserAuthenticatedCM As Boolean = False
        Dim bUserPublishToAll As Boolean = False
        Dim bUserImportOnly As Boolean = False
        Dim bUserCentreReports As Boolean = False
        Dim nlearnCandidateID As Integer = 0
        Dim blearnUserAuthenticated As Boolean = False
        Dim nAdminCategoryID As Integer = 0
        Dim bIsSupervisor As Boolean = False
        Dim bIsTrainer As Boolean = False
        Dim sUserForename As String = ""
        Dim sUserSurname As String = ""
        Dim sUserCandidateNumber = ""
        Dim sUserCentreName = ""
        Dim taAdminUsers As New AuthenticateTableAdapters.AdminUsersTableAdapter
        Dim tAdminUsers As New Authenticate.AdminUsersDataTable
        tAdminUsers = taAdminUsers.GetData(sEmail, 0)
        If tAdminUsers.Count > 0 Then
            Dim r As Authenticate.AdminUsersRow = tAdminUsers.First
            nUserCentreID = r.CentreID
            bUserCentreManager = r.IsCentreManager
            bUserUserAdmin = r.UserAdmin
            nUserUserAdminID = r.AdminID
            bUserContentCreator = r.ContentCreator
            bUserAuthenticatedCM = r.ContentManager
            bUserPublishToAll = r.PublishToAll
            bUserImportOnly = r.ImportOnly
            bUserCentreReports = r.SummaryReports
            bIsSupervisor = r.Supervisor
            bIsTrainer = r.Trainer
            sUserForename = r.Forename
            sUserSurname = r.Surname
            nAdminCategoryID = r.CategoryID
            sUserCentreName = r.CentreName
        End If
        Dim taCandidates As New AuthenticateTableAdapters.CandidatesTableAdapter
        Dim tCandidates As New Authenticate.CandidatesDataTable
        If nUserCentreID > 0 Then
            tCandidates = taCandidates.GetData(sEmail, nUserCentreID)
        Else
            tCandidates = taCandidates.GetData(sEmail, 0)
        End If
        If tCandidates.Count > 0 Then
            Dim r As Authenticate.CandidatesRow = tCandidates.First
            If nUserCentreID = 0 Then
                nUserCentreID = r.CentreID
                sUserForename = r.FirstName
                sUserSurname = r.LastName
                sUserCentreName = r.CentreName
            End If
            blearnUserAuthenticated = True
            nlearnCandidateID = r.CandidateID
            sUserCandidateNumber = r.CandidateNumber
        End If
        context.AuthenticationTicket.Identity.AddClaim(New Claim(ClaimTypes.Email, sEmail))
        context.AuthenticationTicket.Identity.AddClaim(New Claim("UserCentreID", nUserCentreID))
        context.AuthenticationTicket.Identity.AddClaim(New Claim("UserCentreManager", bUserCentreManager))
        context.AuthenticationTicket.Identity.AddClaim(New Claim("UserCentreAdmin", bUserCentreAdmin))
        context.AuthenticationTicket.Identity.AddClaim(New Claim("UserUserAdmin", bUserUserAdmin))
        context.AuthenticationTicket.Identity.AddClaim(New Claim("UserContentCreator", bUserContentCreator))
        context.AuthenticationTicket.Identity.AddClaim(New Claim("UserAuthenticatedCM", bUserAuthenticatedCM))
        context.AuthenticationTicket.Identity.AddClaim(New Claim("UserPublishToAll", bUserPublishToAll))
        context.AuthenticationTicket.Identity.AddClaim(New Claim("UserCentreReports", bUserCentreReports))
        context.AuthenticationTicket.Identity.AddClaim(New Claim("learnCandidateID", nlearnCandidateID))
        context.AuthenticationTicket.Identity.AddClaim(New Claim("learnUserAuthenticated", blearnUserAuthenticated))
        context.AuthenticationTicket.Identity.AddClaim(New Claim("AdminCategoryID", nAdminCategoryID))
        context.AuthenticationTicket.Identity.AddClaim(New Claim("IsSupervisor", bIsSupervisor))
        context.AuthenticationTicket.Identity.AddClaim(New Claim("IsTrainer", bIsTrainer))
        context.AuthenticationTicket.Identity.AddClaim(New Claim("learnCandidateNumber", sUserCandidateNumber))
        context.AuthenticationTicket.Identity.AddClaim(New Claim("UserForename", sUserForename))
        context.AuthenticationTicket.Identity.AddClaim(New Claim("UserSurname", sUserSurname))
        context.AuthenticationTicket.Identity.AddClaim(New Claim("UserCentreName", sUserCentreName))
        context.AuthenticationTicket.Identity.AddClaim(New Claim("UserAdminID", nUserUserAdminID))
    End Sub
End Class
