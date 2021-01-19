Imports System.IO
Imports System.Net
Imports System.Net.Http.Headers
Imports System.Security.Claims
Imports System.Threading.Tasks
Imports Microsoft.Graph

Namespace DLS.Helpers
    Public Class SDKHelper
        Private Shared graphClient As GraphServiceClient = Nothing

        Public Shared Function GetAuthenticatedClient() As GraphServiceClient
            Dim graphClient As GraphServiceClient = New GraphServiceClient(New DelegateAuthenticationProvider(Async Function(requestMessage)
                                                                                                                  Dim accessToken As String = ClaimsPrincipal.Current.FindFirst(Function(c) c.Type = "access_token")?.Value
                                                                                                                  requestMessage.Headers.Authorization = New AuthenticationHeaderValue("bearer", accessToken)
                                                                                                              End Function))
            Return graphClient
        End Function

        Public Shared Sub SignOutClient()
            graphClient = Nothing
        End Sub

        Public Shared Async Function GetCurrentUserPhotoStreamAsync() As Task(Of Stream)
            GetAuthenticatedClient()
            Dim currentUserPhotoStream As Stream = Nothing

            Try
                currentUserPhotoStream = Await graphClient.Me.Photo.Content.Request().GetAsync()
            Catch __unusedServiceException1__ As ServiceException
                Return Nothing
            End Try

            Return currentUserPhotoStream
        End Function
        Public Shared Async Function CreateOnlineMeeting(ByVal dtStart As DateTime, ByVal dtEnd As DateTime, ByVal sSubject As String, ByVal nID As Integer, ByVal sAttendees As String, ByVal sUserEmail As String) As Task(Of String)
            Dim graphClient As GraphServiceClient = GetAuthenticatedClient()
            Dim mParticipants As New MeetingParticipants
            Dim AttList = New List(Of MeetingParticipantInfo)()
            Dim sAttList As String() = sAttendees.Split(";")
            For Each s As String In sAttList
                If s.Contains("@") Then
                    AttList.Add(New MeetingParticipantInfo With {
                        .Upn = s
                    })

                    'Dim user As User = Await GetUserByEmail(s.Replace(";", ""), graphClient)
                    'If Not user Is Nothing Then
                    '    Dim pt As New MeetingParticipantInfo
                    '    pt.Identity = New IdentitySet
                    '    pt.Identity.User = New Identity
                    '    pt.Upn = user.UserPrincipalName
                    '    pt.Identity.User.Id = user.Id
                    '    pt.Identity.User.DisplayName = user.DisplayName
                    '    mParticipants.Attendees.Append(pt)
                    'End If
                End If
            Next

            mParticipants.Attendees = AttList
            mParticipants.Organizer = New MeetingParticipantInfo With {
                .Upn = sUserEmail
            }
            Dim OnlineMeeting = New OnlineMeeting With {
    .StartDateTime = dtStart,
    .EndDateTime = dtEnd,
    .Subject = sSubject,
    .Participants = mParticipants
}
            OnlineMeeting = Await graphClient.Me.OnlineMeetings.Request.Select("JoinWebUrl").AddAsync(OnlineMeeting).ConfigureAwait(False)

            Return OnlineMeeting.JoinWebUrl
        End Function
        Public Shared Async Function GetUserByEmail(ByVal sEmail As String, ByVal graphClient As GraphServiceClient) As Task(Of User)


            '        Dim options As List(Of QueryOption) = New List(Of QueryOption) From {
            '    New QueryOption("$filter", "userPrincipalName eq '" & sEmail & "'")
            '}
            Dim user As User = Nothing
            Try
                user = Await graphClient.Users(sEmail).Request().GetAsync().ConfigureAwait(False)
            Catch ex As ServiceException

                If ex.StatusCode = HttpStatusCode.NotFound Then
                    Console.WriteLine($"The user specified '{sEmail}' is not a valid Office 365 user. Error message: {ex}")
                Else
                    Throw ex
                End If
            End Try
            'Dim idset As New IdentitySet
            Return user
        End Function
    End Class

End Namespace
