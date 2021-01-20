Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.ComponentModel
Imports System.Globalization
Imports System.Net
Imports System.IO

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
<System.Web.Script.Services.ScriptService()>
<System.Web.Services.WebService(Namespace:="geo")>
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<ToolboxItem(False)>
Public Class services
    Inherits System.Web.Services.WebService
    Private Shared ReadOnly FindGeocodeUrl As String = "https://maps.google.com/maps/api/geocode/json?address={0}&key=" & ConfigurationManager.AppSettings("mapsAPIKey")
    <WebMethod()>
    Public Function GetGeoCode(ByVal addstr As String) As String
        Dim formattedUri As String = [String].Format(CultureInfo.InvariantCulture, FindGeocodeUrl, addstr)
        Dim webRequest As HttpWebRequest = Net.WebRequest.Create(formattedUri)
        Dim response As HttpWebResponse = DirectCast(webRequest.GetResponse(), HttpWebResponse)
        Dim jsonResponse As String = String.Empty
        Using sr As New StreamReader(response.GetResponseStream())
            jsonResponse = sr.ReadToEnd()
        End Using
        Return jsonResponse
    End Function
    <WebMethod()>
    Public Sub PingSession()
        Exit Sub
    End Sub
    <WebMethod()>
    Public Function SendCoursePublishedNotifications(ByVal nCentreID As Integer, ByVal sCourseName As String) As Integer
        Dim taUFN As New NotificationsTableAdapters.UsersForNotificationTableAdapter
        Dim tUFN As New Notifications.UsersForNotificationDataTable
        Dim sFrom As String = "Digital Learning Solutions Notifications <noreply@dls.nhs.uk>"
        Dim sBodyHTML As String
        sBodyHTML = "<p>Dear colleague</p>" + "<p>This is to notify you that the course <b>" + sCourseName + "</b> has been made available to your centre in the Digital Learning Solutions Tracking System.</p><p>You are receiving this message because you are subscribed to notifications about new courses that are published to your centre.</p><p>To manage your notification subscriptions, login to the <a href='https://www.dls.nhs.uk/tracking'>Digital Learning Solutions Tracking System</a> and click the <b>My Details</b> link."
        Dim sSubjectLine As String = "New Digital Learning Solutions Course Available - " + sCourseName
        tUFN = taUFN.GetByCentre(3, nCentreID)
        Dim taq As New NotificationsTableAdapters.QueriesTableAdapter
        For Each r As DataRow In tUFN.Rows
            Dim sEmail As String = r.Item("Email")
            taq.InsertEmailOutMessage(sEmail, sFrom, sSubjectLine, sBodyHTML, "CoursePublishNotification", 1)
            'CCommon.SendEmail(sEmail, sSubjectLine, sBodyHTML, True, sFrom)
        Next
        Return tUFN.Count
    End Function
    <WebMethod()>
    Public Sub SendDelegateRegRequiresApprovalNotification(ByVal sFName As String, ByVal sLName As String, ByVal nCentreID As Integer)
        Dim SbBody As New StringBuilder
        SbBody.Append("<body style=""font-family: Calibri; font-size: small;"">")
        SbBody.Append("A learner, " & sFName & " " & sLName & ", has registered against your Digital Learning Solutions centre and requires approval before they can access courses.<br/><br/>")

        SbBody.Append("To approve or reject their registration please, click <a href=""https://www.dls.nhs.uk/tracking/approvedelegates"">here</a>.<br/><br/>")
        SbBody.Append("Learner registrations require approval if they are made from outside your network (based on IP address). If you need to alter your centre's accepted IP address range, please raise a Digital Learning Solutions support ticket.")

        SbBody.Append("</body>")
        Dim taq As New NotificationsTableAdapters.QueriesTableAdapter
        Dim sNotify As String = taq.GetNotifyEmailForCentre(nCentreID)
        If Not sNotify.ToString() = String.Empty Then
            CCommon.SendEmail(sNotify, "Digital Learning Solutions Registration Requires Approval - " & sFName & " " & sLName, SbBody.ToString(), True)
        End If
        'Now send to any subscribed admin users at centre:
        Dim taNotUsers As New NotificationsTableAdapters.UsersForNotificationTableAdapter
        Dim tNotUsers As New Notifications.UsersForNotificationDataTable
        tNotUsers = taNotUsers.GetByCentre(4, nCentreID)
        If tNotUsers.Count > 0 Then
            For Each r As DataRow In tNotUsers.Rows
                CCommon.SendEmail(r.Item("Email"), "Digital Learning Solutions Registration Requires Approval - " & sFName & " " & sLName, SbBody.ToString(), True)
            Next
        End If
    End Sub
    <WebMethod()>
    Public Function GetMapData(ByVal cid As Integer) As String
        Dim daresult As [String] = Nothing
        Dim taMapData As New prelogindataTableAdapters.CentresTableAdapter
        Dim tMapData As New prelogindata.CentresDataTable
        tMapData = taMapData.GetData(cid)
        daresult = CCommon.DataTableToJSON(tMapData)
        Return daresult
    End Function
    <WebMethod()>
    Public Function GetUsageData(ByVal CID As Integer, ByVal NumCols As Integer) As String

        Dim taRegComp As New itspdbTableAdapters.uspGetRegCompNewTableAdapter
        Dim tRegComp As New itspdb.uspGetRegCompNewDataTable
        Try
            tRegComp = taRegComp.GetFiltered(3, -1, CID, -1, -1, -1, -1, -1, -1, Date.Now.AddYears(-1), Date.Now())
        Catch ex As Exception

        End Try
        Dim sJSONString As String = CCommon.ConvertDataTabletoJSONString(tRegComp, NumCols)
        Return sJSONString
    End Function
    <WebMethod()>
    Public Function GetCourseName(ByVal CID As Integer) As String
        Dim nCourseID As Integer = CID
        Dim taApp As New itspdbTableAdapters.ApplicationsTableAdapter
        Dim tApp As New itspdb.ApplicationsDataTable
        tApp = taApp.GeByApplicationID(nCourseID)
        Dim sAppTitle As String = tApp.First.ApplicationName
        Return sAppTitle
    End Function
    <WebMethod()>
    Public Function IncrementVideo(ByVal tid As Integer, ByVal candidateid As Integer) As String
        Dim taq As New LearnerPortalTableAdapters.QueriesTableAdapter
        Dim nCount As Integer = taq.uspIncrementVideoCountKB(tid, candidateid)
        Return nCount
    End Function
    <WebMethod()>
    Public Function RateVideo(ByVal tid As Integer, ByVal rating As Integer, ByVal candidateid As Integer) As String
        Dim taq As New LearnerPortalTableAdapters.QueriesTableAdapter
        Dim centreid As Integer = taq.GetCentreForCandidate(candidateid)
        taq.InsertVideoRating(tid, rating, centreid)
        Dim nRating As Decimal = taq.GetAverageRatingForVideo(tid)
        Return nRating
    End Function
    <WebMethod()>
    Public Sub IncrementLearn(ByVal tid As Integer, ByVal candidateid As Integer)
        Dim taq As New LearnerPortalTableAdapters.QueriesTableAdapter
        taq.RecordLearnLaunch(tid, candidateid)
    End Sub
    <WebMethod()>
    Public Sub LogYouTube(ByVal cid As Integer, ByVal vurl As String, ByVal vtitle As String)
        Dim taq As New LearnerPortalTableAdapters.QueriesTableAdapter
        taq.uspLogKBYouTubeLaunch(cid, vurl, vtitle)
    End Sub
    <WebMethod()>
    Public Sub SetProgressText(ByVal sProgText As String, ByVal nProgressID As Integer)
        Dim taq As New LearnMenuTableAdapters.QueriesTableAdapter
        taq.UpdateProgressText(sProgText, nProgressID)
    End Sub
    <WebMethod()>
    Public Function GetProgressText(ByVal nProgressID As Integer) As String
        Dim taq As New LearnMenuTableAdapters.QueriesTableAdapter
        Return taq.GetProgressText(nProgressID)
    End Function
    <WebMethod(EnableSession:=True)>
    Public Function GetDiagnosticObjectives(ByVal nSecID As Integer, ByVal nCustomisationID As Integer, ByVal bGetAll As Boolean) As String
        Dim daresult As [String] = Nothing
        Session("lmDiagSectionID") = nSecID
        Dim taDO As New LearnMenuTableAdapters.DiagObjectivesTableAdapter
        Dim tDO As New LearnMenu.DiagObjectivesDataTable
        If Not bGetAll Then
            tDO = taDO.GetBySectionAndCustomisation(nSecID, nCustomisationID)
        Else
            tDO = taDO.GetData(nSecID, nCustomisationID)
        End If
        daresult = CCommon.DataTableToJSON(tDO)
        Return daresult
    End Function
    <WebMethod()>
    Public Sub SetLogItemUri(ByVal sURI As String, ByVal nLogItemID As Integer)
        Dim taq As New SuperviseDataTableAdapters.QueriesTableAdapter
        taq.UpdateCallUriForLogItem(sURI, nLogItemID)
    End Sub
    <WebMethod(EnableSession:=True)>
    Public Function ValidateSfbAdmin(ByVal sEmail As String) As String
        Dim taq As New SuperviseDataTableAdapters.QueriesTableAdapter
        Dim nAdminID As Integer = taq.GetValidAdminIDForLogItem(sEmail, Session("SkypeMeetingID"))
        If nAdminID > 0 Then
            'If Session("UserAdminID") Is Nothing Then
            '    Session("UserAdminID") = nAdminID
            'End If
            'If Session("UserCentreID") Is Nothing Then
            '    Session("UserCentreID") = taq.GetCentreIDForAdminUser(nAdminID)
            'End If
            'If Session("learnCandidateID") Is Nothing Then
            '    Session("learnCandidateID") = taq.GetValidCandidateForLogItem(Session("SkypeMeetingID"), sEmail)
            'End If
        End If
            Return nAdminID
    End Function
    <WebMethod(EnableSession:=True)>
    Public Function ValidateSfbDelegate(ByVal sEmail As String) As String
        Dim taq As New SuperviseDataTableAdapters.QueriesTableAdapter
        Return taq.GetValidCandidateForLogItem(Session("SkypeMeetingID"), sEmail)
    End Function
    <WebMethod(EnableSession:=True)>
    Public Function SendAppointmentsForLogItem(ByVal nLogItemID As Integer) As Integer
        Dim taSched As New SuperviseDataTableAdapters.SchedulerTableAdapter
        Dim r As SuperviseData.SchedulerRow = taSched.GetDataByIDs(nLogItemID, Nothing, "").First

        Dim sSummary As String = "DLS Supervisor Scheduled Activity: " & r.Subject

        Dim taq As New SuperviseDataTableAdapters.QueriesTableAdapter
        Dim sAttendees As String = taq.GetSIPsCSVForLogItem(nLogItemID, "")
        Dim gICSGUID As Guid = taq.GetGUIDForLogItemID(nLogItemID)
        Dim bAllDay As Boolean = False
        If r.StartDate.TimeOfDay.Ticks = 0 Then
            bAllDay = True
        End If
        Dim taAtt As New SuperviseDataTableAdapters.AttendeesTableAdapter
        Dim tAtt As SuperviseData.AttendeesDataTable = taAtt.GetByLogItemID(nLogItemID)
        If tAtt.Count > 0 Then
            For Each rAtt As SuperviseData.AttendeesRow In tAtt.Rows
                Dim sbDesc As String = CCommon.GetSupervisionSessionDesc(r, rAtt.EmailAddress, sAttendees, False)
                Dim sbDescHtml As String = CCommon.GetSupervisionSessionDesc(r, rAtt.EmailAddress, sAttendees, True)
                Dim sbCal As StringBuilder = CCommon.GetVCalendarString(r.StartDate, r.EndDate, rAtt.EmailAddress, "", sSummary, sbDesc, sbDescHtml, gICSGUID.ToString(), 0, 0, 15, bAllDay, sAttendees,,, r.SeqInt)
                CCommon.SendEmail(rAtt.EmailAddress, sSummary, sbDescHtml.ToString(), True, , , , , , Session("UserEmail"), sbCal.ToString())
            Next
        End If
        taSched.IncrementAptSequence(nLogItemID)
        Return tAtt.Count

    End Function
    <WebMethod()>
    Public Function EncryptPw(ByVal sEmail As String, ByVal sPassword As String) As String
        Return Crypto.EDEncrypt(sPassword, sEmail)
    End Function
    <WebMethod()>
    Public Function DecryptPw(ByVal sEmail As String, ByVal sCipher As String) As String
        Return Crypto.EDDecrypt(sCipher, sEmail)
    End Function
    <WebMethod()>
    Public Sub SaveURLAsProfileImage(ByVal sURL As String, ByVal sEmail As String)
        Dim request As HttpWebRequest = TryCast(WebRequest.Create(sURL), HttpWebRequest)
        Dim response As HttpWebResponse = TryCast(request.GetResponse(), HttpWebResponse)
        Dim stream As Stream = response.GetResponseStream()
        Dim ms As MemoryStream = New MemoryStream()
        stream.CopyTo(ms)
        ms = CCommon.squareImageFromMemoryStream(ms)
        ms = CCommon.resizeImageFromMemoryStream(ms, 300, 300)
        Dim taq As New AuthenticateTableAdapters.QueriesTableAdapter()
        taq.UpdateProfileImageByEmail(ms.ToArray(), sEmail)
    End Sub
End Class