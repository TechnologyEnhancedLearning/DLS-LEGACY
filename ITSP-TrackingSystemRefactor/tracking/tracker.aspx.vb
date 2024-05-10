'------------------------------------------------------------------------------
' CTrackerAPI 
'
' This class implements the tracking API. It short-circuits generation
' of the HTML for the ASPX page by writing the API return value as the Response
' then calling Response.End().
'
'------------------------------------------------------------------------------
Option Explicit On
Option Strict On

Imports ITSP_TrackingSystemRefactor.ITSP
Imports System.Data
Imports System.Text.RegularExpressions
Imports Newtonsoft.Json
Imports Newtonsoft.Json.Linq
Imports DevExpress.Web.Bootstrap.Internal
Imports DocumentFormat.OpenXml.Bibliography


Partial Public Class CTrackerAPI
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim sResponse As String
        Dim sLogMessage As String = ""

        Response.ContentType = "application/json"
        '
        ' Check for parameters. If set, return appropriate values.
        '
        Dim sAction As String = Page.Request.Item("Action")
        If sAction Is Nothing Then
            sResponse = "[#Result:-15]"
        ElseIf sAction = "InternalErrorTestForHugh" Then
            sResponse = GenerateInternalError()
        Else
            Try
                Select Case sAction.ToUpper()
                    Case "GETAPPLICATIONINFO"
                        sResponse = GetApplicationInfo(Page.Request.Item("ApplicationID"))
                    Case "JOBGROUPLIST"
                        sResponse = JobGroupList()
                    Case "REGIONLIST"
                        sResponse = RegionList()
                    Case "CENTRELIST"
                        sResponse = CentreList(Page.Request.Item("RegionID"))
                    Case "VERIFYCENTRE"
                        sResponse = VerifyCentre(Page.Request.Item("CentreID"))
                    Case "SEARCHCANDIDATE"
                        sResponse = SearchCandidate(Page.Request.Item("LastName"),
                                                        Page.Request.Item("CentreID"),
                                                        Page.Request.Item("MonthStart"))
                    Case "CREATECANDIDATE"
                        sResponse = CreateCandidate(Page.Request.Item("CentreID"),
                                                        Page.Request.Item("FirstName"),
                                                        Page.Request.Item("LastName"),
                                                        Page.Request.Item("JobGroupID"),
                                                        Page.Request.Item("Answer1"),
                                                        Page.Request.Item("Answer2"),
                                                        Page.Request.Item("Answer3"),
                                                        Page.Request.Item("Answer4"),
                                                        Page.Request.Item("Answer5"),
                                                        Page.Request.Item("Answer6"))
                    Case "VERIFYCANDIDATE"
                        sResponse = VerifyCandidate(Page.Request.Item("CentreID"),
                                                        Page.Request.Item("CandidateNumber"))
                    Case "STORENEWCUSTOMISATION"
                        sResponse = StoreNewCustomisation(Page.Request.Item("ApplicationID"),
                                                        Page.Request.Item("CentreID"),
                                                        Page.Request.Item("CustomisationName"),
                                                        Page.Request.Item("Active"),
                                                        Page.Request.Item("CustomisationText"),
                                                        Page.Request.Item("Question1"),
                                                        Page.Request.Item("Question2"),
                                                        Page.Request.Item("Question3"),
                                                        Page.Request.Item("IsAssessed"))
                    Case "UPDATECUSTOMISATION"
                        sResponse = UpdateCustomisation(Page.Request.Item("CustomisationID"),
                                                        Page.Request.Item("CustomisationName"),
                                                        Page.Request.Item("CustomisationText"),
                                                        Page.Request.Item("Question1"),
                                                        Page.Request.Item("Question2"),
                                                        Page.Request.Item("Question3"),
                                                        Page.Request.Item("IsAssessed"))
                    Case "CHANGECUSTOMISATIONSTATUS"
                        sResponse = ChangeCustomisationStatus(Page.Request.Item("CustomisationID"),
                                                        Page.Request.Item("Active"))
                    Case "LOADCUSTOMISATION"
                        sResponse = LoadCustomisation(Page.Request.Item("CentreID"),
                                                        Page.Request.Item("CustomisationID"),
                                                        Page.Request.Item("ApplicationID"),
                                                        Page.Request.Item("CustomisationName"))
                    Case "LISTCUSTOMISATIONS"
                        sResponse = ListCustomisation(Page.Request.Item("CentreID"),
                                                        Page.Request.Item("ApplicationID"))
                    Case "CANDIDATELOGIN"
                        sResponse = CandidateLogin(Page.Request.Item("CandidateNumber"),
                                                        Page.Request.Item("CustomisationID"))
                    Case "QUERYPROGRESS"
                        sResponse = QueryProgress(Page.Request.Item("CandidateNumber"),
                                                        Page.Request.Item("CentreID"))
                    Case "LOADPROGRESS"
                        sResponse = LoadProgress(Page.Request.Item("CandidateNumber"),
                                                        Page.Request.Item("CustomisationID"),
                                                        Page.Request.Item("SessionID"))
                    Case "STOREPROGRESS"
                        sResponse = StoreProgress(Page.Request.Item("CandidateNumber"),
                                                        Page.Request.Item("CustomisationID"),
                                                        Page.Request.Item("Version"),
                                                        Page.Request.Item("Completed"),
                                                        Page.Request.Item("ProgressText"),
                                                        Page.Request.Item("SessionID"),
                                                        Page.Request.Item("ModifierID"),
                                                        Page.Request.Item("DiagnosticScore"),
                                                        Page.Request.Item("LearningTime"))
                    Case "STOREASPASSESSNOSESSION"
                        sResponse = StoreASPAssessNoSession(Page.Request.Item("CandidateID"),
                        Page.Request.Item("CustomisationID"),
                             Page.Request.Item("Version"),
                        Page.Request.Item("SectionID"),
                        Page.Request.Item("Score"))
                    Case "STOREASPPROGRESSNOSESSION"
                        sResponse = StoreASPProgressNoSession(Page.Request.Item("TutorialStatus"),
                          Page.Request.Item("TutorialTime"),
                        Page.Request.Item("ProgressID"),
                        Page.Request.Item("CandidateID"),
                        Page.Request.Item("Version"),
                        Page.Request.Item("CustomisationID"))
                    Case "STOREASPPROGRESSV2"
                        sResponse = StoreASPProgressV2(Page.Request.Item("TutorialStatus"),
                          Page.Request.Item("TutorialTime"),
                        Page.Request.Item("ProgressID"),
                        Page.Request.Item("CandidateID"),
                        Page.Request.Item("Version"),
                        Page.Request.Item("CustomisationID"),
Page.Request.Item("TutorialID"))
                    Case "STOREASPDIAGSCORENOSESSION"
                        sResponse = StoreAspDiagScoreNoSession(Page.Request.Item("ObjectiveNum"),
                        Page.Request.Item("CandidateID"),
                           Page.Request.Item("CustomisationID"),
                        Page.Request.Item("ProgressID"),
                        Page.Request.Item("Version"),
                        Page.Request.Item("SectionID"),
                              Page.Request.Item("Score"))
                    Case "STOREASPPROGRESS"
                        sResponse = StoreASPProgress(Page.Request.Item("TutorialStatus"),
                          Page.Request.Item("TutorialTime"))
                    Case "STOREASSESSATTEMPT"
                        sResponse = StoreAssessAttempt(Page.Request.Item("CandidateNumber"),
                                                        Page.Request.Item("CustomisationID"),
                                                        Page.Request.Item("Version"),
                                                        Page.Request.Item("AssessInstance"),
                                                        Page.Request.Item("SectionNumber"),
                                                        Page.Request.Item("Score"),
                                                        Page.Request.Item("Status"),
                                                        Page.Request.Item("SessionID"))
                    Case "STOREASPASSESSATTEMPT"
                        sResponse = StoreASPAssessAttempt(Page.Request.Item("Score"),
                                                        Page.Request.Item("Status"))
                    Case "CANDIDATELOGOUT"
                        sResponse = CandidateLogout(Page.Request.Item("CandidateNumber"),
                                                        Page.Request.Item("CustomisationID"),
                                                        Page.Request.Item("SessionID"))
                    Case "GETTUTORIALLISTFORDIAG"
                        sResponse = GetTutorialListForDiag()
                    Case "GETTUTORIALLISTFORPL"
                        sResponse = GetTutorialListForPL()
                    Case "STOREASPDIAGSCORE"
                        sResponse = StoreAspDiagScore(Page.Request.Item("ObjectiveNum"),
                                                      Page.Request.Item("Score"))
                    Case "GETOBJECTIVEARRAY"
                        sResponse = GetObjectiveArray(CInt(Page.Request.Item("CustomisationID")), CInt(Page.Request.Item("SectionID")))
                    Case "GETOBJECTIVEARRAYCC"
                        sResponse = GetObjectiveArrayCC(CInt(Page.Request.Item("CustomisationID")), CInt(Page.Request.Item("SectionID")), CBool(Page.Request.Item("IsPostLearning")))
                    Case "STOREDIAGNOSTICJSON"
                        sResponse = StoreDiagnosticJson(CInt(Page.Request.Item("ProgressID")),
                                   Page.Request.Item("DiagnosticOutcome"))
                    Case "UPDATELESSONSTATE"
                        sResponse = UpdateLessonState(Page.Request.Item("TutorialID"),
                          Page.Request.Item("ProgressID"),
                        Page.Request.Item("CandidateID"),
                        Page.Request.Item("CustomisationID"),
                        Page.Request.Item("TutorialStatus"),
                        Page.Request.Item("TutorialTime"),
                        Page.Request.Item("SuspendData"),
                        Page.Request.Item("LessonLocation")
                        )
                    Case Else
                        sResponse = "[#Result:-2]"
                End Select
            Catch ex As ApplicationException
                '
                ' Message being sent from code!
                '
                Select Case ex.Message
                    Case "sCandidateNumber not found"
                        sResponse = "[#Result:-10]"

                    Case "sCandidateNumber duplicated"
                        sResponse = "[#Result:-11]"

                    Case "Session not found"
                        sResponse = "[#Result:-12]"

                    Case "Centre manager not logged in"
                        sResponse = "[#Result:-13]"

                    Case Else
                        sResponse = "[#Result:-1]"
                        CCommon.LogErrorToEmail(ex)
                End Select
                sLogMessage = ex.Message
            Catch ex As Exception
                '
                ' There was an internal error
                '
                sResponse = "[#Result:-1]"
                sLogMessage = ex.Message
                '
                ' Send an email about it
                '
                CCommon.LogErrorToEmail(ex)
            End Try
        End If
        '
        ' Check for any errors and log if so.
        ' Don't log comon errors for SearchCandidate and VerifyCandidate.
        '
        If sResponse.Contains("Result:-") And
            Not (sResponse.Contains("Result:-24") Or sResponse.Contains("Result:-27")) Then
            LogResponseErrors(sResponse, sLogMessage)
        End If
        '
        ' Finally write the response
        '
        Response.Write(sResponse)
        Response.End()
    End Sub

#Region "API Handler Functions"

    ''' <summary>
    ''' Handles the GetApplicationInfo API query
    ''' </summary>
    ''' <param name="sApplicationID">Application to load info for</param>
    ''' <returns>Lingo property list containing result code and info string</returns>
    ''' <remarks></remarks>
    Protected Function GetApplicationInfo(ByRef sApplicationID As String) As String
        '
        ' Check parameters are present
        '
        If sApplicationID Is Nothing Then
            Return "[#Result:-14]"
        End If

        Dim applicationAdapter As New ITSPTableAdapters.ApplicationsTableAdapter()
        Dim tApplications As ITSP.ApplicationsDataTable
        '
        ' Extract the parameters.
        ' Any problems will be caught by try/catch block at the caller level
        '
        Dim nApplicationID As Integer
        nApplicationID = CInt(sApplicationID)
        '
        ' Grab Application information
        '
        tApplications = applicationAdapter.GetByApplicationID(nApplicationID)
        If tApplications.Count = 1 Then
            Dim sApplicationInfo As String

            '
            ' Grab the field, but it might be NULL. 
            '
            Try
                sApplicationInfo = tApplications.First.ApplicationInfo
            Catch ex As StrongTypingException
                Return "[#Result:1,#Name:""" & tApplications.First.ApplicationName & """,#ApplicationInfo:[]]" ' Null, so give empty value
            End Try

            Return "[#Result:1,#Name:""" & tApplications.First.ApplicationName & """,#ApplicationInfo:" & sApplicationInfo & "]"
        End If
        Return "[#Result:-16]"

    End Function

    ''' <summary>
    ''' Handle the JobGroupList API query.
    ''' </summary>
    ''' <returns>Lingo property list containing list of job groups.</returns>
    ''' <remarks></remarks>
    Protected Function JobGroupList() As String
        Dim JobGroupsAdapter As New ITSPTableAdapters.JobGroupsTableAdapter()
        Dim tJobGroups As ITSP.JobGroupsDataTable
        Dim JobGroupRow As ITSP.JobGroupsRow
        Dim sResponse As New StringBuilder

        '
        ' Open dataset and add each region
        '
        tJobGroups = JobGroupsAdapter.GetData()
        For Each JobGroupRow In tJobGroups
            If sResponse.Length <> 0 Then
                sResponse.Append(",")
            End If
            sResponse.Append("[#Name:""" & JobGroupRow.JobGroupName & """,#JobGroupID:" & JobGroupRow.JobGroupID & "]")
        Next
        '
        ' Construct final response
        '
        Return "[#Result:1, #JobGroups:[" & sResponse.ToString() & "]]"
    End Function

    ''' <summary>
    ''' Handle the RegionList API query.
    ''' </summary>
    ''' <returns>Lingo property list containing sorted list of regions.</returns>
    ''' <remarks></remarks>
    Protected Function RegionList() As String
        Dim regionsAdapter As New ITSPTableAdapters.RegionsTableAdapter()
        Dim tRegions As ITSP.RegionsDataTable
        Dim RegionRow As ITSP.RegionsRow
        Dim sResponse As New StringBuilder

        '
        ' Open dataset and add each region
        '
        tRegions = regionsAdapter.GetData()
        For Each RegionRow In tRegions
            If sResponse.Length <> 0 Then
                sResponse.Append(",")
            End If
            sResponse.Append("[#Name:""" & RegionRow.RegionName & """,#RegionID:" & RegionRow.RegionID & "]")
        Next
        '
        ' Construct final response
        '
        Return "[#Result:1, #Regions:[" & sResponse.ToString() & "]]"
    End Function

    ''' <summary>
    ''' Handle the CentreList API query
    ''' </summary>
    ''' <param name="sRegionID">Raw API value for region ID</param>
    ''' <returns>Lingo property list containing sorted list of centres in region.</returns>
    ''' <remarks>Throws an exception if the parameter is not in the correct format</remarks>
    Protected Function CentreList(ByRef sRegionID As String) As String
        '
        ' Check parameters are present
        '
        If sRegionID Is Nothing Then
            Return "[#Result:-14]"
        End If

        Dim centresAdapter As New ITSPTableAdapters.CentresTableAdapter()
        Dim tCentres As ITSP.CentresDataTable
        Dim CentreRow As ITSP.CentresRow
        Dim sResponse As New StringBuilder

        '
        ' Extract the parameters.
        ' Any problems will be caught by try/catch block at the caller level
        '
        Dim nRegionID As Integer
        nRegionID = CInt(sRegionID)
        '
        ' Open dataset and add each centre
        '
        tCentres = centresAdapter.GetCentresForRegion(nRegionID)
        For Each CentreRow In tCentres
            If sResponse.Length <> 0 Then
                sResponse.Append(",")
            End If
            sResponse.Append("[#Name:""" & CentreRow.CentreName & """,#CentreID:" & CentreRow.CentreID & "]")
        Next
        '
        ' Construct final response
        '
        Return "[#Result:1, #Centres:[" & sResponse.ToString() & "]]"
    End Function

    ''' <summary>
    ''' Handle the VerifyCentre API query
    ''' </summary>
    ''' <param name="sCentreID">Cemtre ID</param>
    ''' <returns>Lingo property list containing result of 1 if centre is found, along with registration questions etc.</returns>
    ''' <remarks>Throws an exception if the parameter is not in the correct format</remarks>
    Protected Function VerifyCentre(ByRef sCentreID As String) As String
        '
        ' Check parameters are present
        '
        If sCentreID Is Nothing OrElse sCentreID.Trim() = String.Empty Then
            Return "[#Result:-14]"
        End If

        Dim centresAdapter As New ITSPTableAdapters.CentresTableAdapter()
        Dim tCentres As ITSP.CentresDataTable
        '
        ' Extract the parameters.
        ' Any problems will be caught by try/catch block at the caller level
        '
        Dim nCentreID As Integer
        nCentreID = CInt(sCentreID)
        '
        ' Grab centre
        '
        tCentres = centresAdapter.GetByCentreID(nCentreID)
        If tCentres.Count = 1 Then
            '
            ' Get banner text - might be empty
            '
            Dim sBannerText = String.Empty
            Try
                sBannerText = tCentres.First.BannerText.Replace("""", """ & QUOTE & """)
            Catch ex As System.Data.StrongTypingException
            End Try
            '
            ' Grab the Registration Questions, formatting the values.
            '
            Dim sbRegQuestions As New StringBuilder

            sbRegQuestions.Append(_GetRegQuestion("1", tCentres.First))
            sbRegQuestions.Append(",")
            sbRegQuestions.Append(_GetRegQuestion("2", tCentres.First))
            sbRegQuestions.Append(",")
            sbRegQuestions.Append(_GetRegQuestion("3", tCentres.First))
            Return "[#Result:1,#CentreName:""" & tCentres.First.CentreName & """,#BannerText:""" & sBannerText & """," & sbRegQuestions.ToString() & "]"
        End If
        Return "[#Result:-17]"
    End Function

    ''' <summary>
    ''' Extract the text for a single question
    ''' </summary>
    ''' <param name="sQ">Question number as string ("1", "2" or "3")</param>
    ''' <param name="recCentres">Record for the centre</param>
    ''' <returns>String describing one question</returns>
    ''' <remarks></remarks>
    Protected Function _GetRegQuestion(ByVal sQ As String, ByRef recCentres As ITSP.CentresRow) As String
        Dim sbRegQuestion As New StringBuilder
        Dim sFieldName As String = "F" + sQ + "Name"
        Dim sFieldOptions As String = "F" + sQ + "Options"
        Dim sFieldMandatory As String = "F" + sQ + "Mandatory"
        '
        ' Construct text for the question
        '
        sbRegQuestion.Append("#Field")
        sbRegQuestion.Append(sQ)
        sbRegQuestion.Append(":[#FName:""")
        Dim sQuestion As String = recCentres.Field(Of String)(sFieldName)
        If sQuestion Is Nothing Then            ' if there is no name put in empty values
            sbRegQuestion.Append(""",#FMandatory:0,#FChoices:[]]")
            Return sbRegQuestion.ToString()     ' and that's it
        End If
        '
        ' There is a question so tidy it up and add other values
        '
        sbRegQuestion.Append(sQuestion.Replace("""", """ & QUOTE & """))
        sbRegQuestion.Append(""",#FMandatory:")
        If recCentres.Field(Of Boolean)(sFieldMandatory) Then
            sbRegQuestion.Append("1")
        Else
            sbRegQuestion.Append("0")
        End If
        '
        ' Extract the choices as a list
        '
        sbRegQuestion.Append(",#FChoices:[")

        Dim sOptions As String = recCentres.Field(Of String)(sFieldOptions)
        If Not sOptions Is Nothing Then
            Dim lsOptions As String() = sOptions.Trim.Split(CChar(vbLf))

            For Each sOption As String In lsOptions
                sOption = sOption.Replace("""", """ & QUOTE & """)
                sbRegQuestion.Append("""" & sOption.Trim & """")
                sbRegQuestion.Append(",")
            Next
            sbRegQuestion.Remove(sbRegQuestion.Length() - 1, 1)     ' remove trailing comma
        End If
        sbRegQuestion.Append("]]")
        Return sbRegQuestion.ToString()
    End Function

    ''' <summary>
    ''' Handle the SearchCandidate API query
    ''' </summary>
    ''' <param name="sLastName">Last name of delegate</param>
    ''' <param name="sCentreID">Centre they are registered in</param>
    ''' <param name="sMonthStart">Month that they started</param>
    ''' <returns>Lingo property list containing candidate defails if found.</returns>
    ''' <remarks></remarks>
    Protected Function SearchCandidate(ByRef sLastName As String,
                                       ByRef sCentreID As String,
                                       ByRef sMonthStart As String) As String
        '
        ' Check parameters are present
        '
        If sLastName Is Nothing Or sCentreID Is Nothing Or sMonthStart Is Nothing Then
            Return "[#Result:-14]"
        End If

        Dim candidatesAdapter As New ITSPTableAdapters.SearchCandidatesTableAdapter()
        Dim tCandidates As ITSP.SearchCandidatesDataTable

        '
        ' Extract the parameters.
        ' Any problems will be caught by try/catch block at the caller level
        '
        Dim nCentreID As Integer = CInt(sCentreID)
        Dim nMonthStart As Integer = CInt(sMonthStart)
        sLastName = CCommon.ConvertQuotedParameter(sLastName)
        '
        ' Call the function and see how many candidates are returned. If just one, give back that candidate number.
        '
        tCandidates = candidatesAdapter.GetData(nCentreID, sLastName, nMonthStart)
        Select Case tCandidates.Count
            Case 0
                Return "[#Result:-27]"
            Case 1
                Dim sCandidateNumber As String = tCandidates.First.CandidateNumber
                Dim drCandidate As DataRow = tCandidates.First  ' convert to untyped row so Nulls don't trip us up

                If drCandidate("AliasID").ToString.Length > 0 Then    ' use the alias if present (Null gives zero length string)
                    sCandidateNumber = drCandidate("AliasID").ToString
                End If
                Return "[#Result:1, #CandidateNumber:""" & sCandidateNumber & """]]"
            Case Else
                Return "[#Result:-28]"
        End Select
    End Function

    ''' <summary>
    ''' Handle the CreateCandidate API query
    ''' </summary>
    ''' <param name="sCentreID">CentreID of the candidate</param>
    ''' <param name="sFirstName">First name of the candidate</param>
    ''' <param name="sLastName">Last name of the candidate</param>
    ''' <param name="sJobGroupID">ID of job group for candidate</param>
    ''' <param name="sAnswer1">Answer to first centre question</param>
    ''' <param name="sAnswer2">Answer to second centre question</param>
    ''' <param name="sAnswer3">Answer to third centre question</param>
    ''' <returns>Lingo property list containing candidate number if successful</returns>
    ''' <remarks></remarks>
    Protected Function CreateCandidate(ByRef sCentreID As String,
                                       ByRef sFirstName As String,
                                       ByRef sLastName As String,
                                       ByRef sJobGroupID As String,
                                       ByRef sAnswer1 As String,
                                       ByRef sAnswer2 As String,
                                       ByRef sAnswer3 As String,
                                       ByRef sAnswer4 As String,
                                       ByRef sAnswer5 As String,
                                       ByRef sAnswer6 As String) As String
        '
        ' Check parameters are present
        '
        If sCentreID Is Nothing Or sFirstName Is Nothing Or sLastName Is Nothing Or sJobGroupID Is Nothing Then
            Return "[#Result:-14]"
        End If

        '
        ' Convert and check parameters
        '
        Dim nCentreID As Integer = CInt(sCentreID)
        sFirstName = CCommon.ConvertQuotedParameter(sFirstName)
        sLastName = CCommon.ConvertQuotedParameter(sLastName)
        Dim nJobGroupID As Integer = CInt(sJobGroupID)
        sAnswer1 = CCommon.ConvertQuotedParameter(sAnswer1)
        sAnswer2 = CCommon.ConvertQuotedParameter(sAnswer2)
        sAnswer3 = CCommon.ConvertQuotedParameter(sAnswer3)
        sAnswer4 = CCommon.ConvertQuotedParameter(sAnswer4)
        sAnswer5 = CCommon.ConvertQuotedParameter(sAnswer5)
        sAnswer6 = CCommon.ConvertQuotedParameter(sAnswer6)
        If sFirstName.Length = 0 Or sLastName.Length = 0 Then
            Return "[#Result:0]"
        End If
        '
        ' Save candidate record, ensuring that CandidateNumber is unique
        '
        Dim sCandidateNumber As String = CCommon.SaveNewCandidate(nCentreID, sFirstName, sLastName, nJobGroupID, True,
                                                                  sAnswer1, sAnswer2, sAnswer3, sAnswer4, sAnswer5, sAnswer6, "", True, "", False, True, DateTime.Today())

        Return "[#Result:1,#CandidateNumber:""" & sCandidateNumber & """]"
    End Function

    ''' <summary>
    ''' Handle the VerifyCandidate API query
    ''' </summary>
    ''' <param name="sCentreID">CentreID of the candidate</param>
    ''' <param name="sCandidateNumber">Candidate number or Alias to check</param>
    ''' <returns>Lingo property list containing result indicating found/not found</returns>
    ''' <remarks></remarks>
    Protected Function VerifyCandidate(ByRef sCentreID As String,
                                       ByRef sCandidateNumber As String) As String
        '
        ' Check parameters are present
        '
        If sCentreID Is Nothing Or sCandidateNumber Is Nothing Then
            Return "[#Result:-14]"
        End If
        sCandidateNumber = CCommon.ConvertQuotedParameter(sCandidateNumber)
        If sCandidateNumber.Length = 0 Then     ' must supply a candidatenumber
            Return "[#Result:-14]"
        End If

        Dim CandidateQueriesAdapter As New ITSPTableAdapters.CandidatesTableAdapter()
        Dim tCandidates As ITSP.CandidatesDataTable

        '
        ' Convert and check parameters
        '
        Dim nCentreID As Integer = CInt(sCentreID)
        '
        ' If the AliasID matches the candidate number then return that candidate
        '
        tCandidates = CandidateQueriesAdapter.GetActiveCandidateByAlias(nCentreID, sCandidateNumber)
        If tCandidates.Count = 1 Then
            Return "[#Result:1,#FirstName:""" & tCandidates.First.FirstName & """,#LastName:""" & tCandidates.First.LastName &
                    """,#CandidateNumber:""" & tCandidates.First.CandidateNumber & """,#AliasID:""" & tCandidates.First.AliasID & """]"
        End If
        '
        ' Grab candidate record and check if CentreID matches
        '
        tCandidates = CandidateQueriesAdapter.GetActiveCandidateByID(sCandidateNumber)
        If tCandidates.Count() <> 1 Then
            Return "[#Result:-10]"
        End If
        If tCandidates.First.CentreID = nCentreID Then
            Return "[#Result:1,#FirstName:""" & tCandidates.First.FirstName & """,#LastName:""" & tCandidates.First.LastName &
                    """,#CandidateNumber:""" & tCandidates.First.CandidateNumber & """,#AliasID:""" & tCandidates.First.AliasID & """]"
        End If
        Return "[#Result:-24]"
    End Function
    ''' <summary>
    ''' Handle the StoreNewCustomisation API query
    ''' </summary>
    ''' <param name="sApplicationID">For application ID</param>
    ''' <param name="sCentreID">For this centre</param>
    ''' <param name="sCustomisationName">Name of the customisation</param>
    ''' <param name="sActive">Is the customisation to be active or not</param>
    ''' <param name="sCustomisationText">Text of the customisation</param>
    ''' <param name="sQuestion1">Text of first question</param>
    ''' <param name="sQuestion2">Text of second question</param>
    ''' <param name="sQuestion3">Text of third question</param>
    ''' <param name="sIsAssessed">Is this course assessed</param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Protected Function StoreNewCustomisation(ByRef sApplicationID As String,
                                          ByRef sCentreID As String,
                                          ByRef sCustomisationName As String,
                                          ByRef sActive As String,
                                          ByRef sCustomisationText As String,
                                          ByRef sQuestion1 As String,
                                          ByRef sQuestion2 As String,
                                          ByRef sQuestion3 As String,
                                          ByRef sIsAssessed As String) As String
        '
        ' Check parameters are present
        '
        If sApplicationID Is Nothing Or sCentreID Is Nothing Or sCustomisationName Is Nothing Or
            sActive Is Nothing Or sCustomisationText Is Nothing Or sQuestion1 Is Nothing Or
            sQuestion2 Is Nothing Or sQuestion3 Is Nothing Or sIsAssessed Is Nothing Then
            Return "[#Result:-14]"
        End If

        '
        ' Convert and check parameters
        '
        Dim nApplicationID As Integer = CInt(sApplicationID)
        Dim nCentreID As Integer = CInt(sCentreID)
        Dim bActive As Boolean = sActive <> "0"
        sCustomisationName = CCommon.ConvertQuotedParameter(sCustomisationName)
        sCustomisationText = CCommon.ConvertQuotedParameter(sCustomisationText)
        sQuestion1 = CCommon.ConvertQuotedParameter(sQuestion1)
        sQuestion2 = CCommon.ConvertQuotedParameter(sQuestion2)
        sQuestion3 = CCommon.ConvertQuotedParameter(sQuestion3)
        Dim bIsAssessed As Boolean = sIsAssessed <> "0"
        '
        ' Check if a centre administrator for this centre is logged on
        '
        CheckCentreAdmin(nCentreID)
        '
        ' Insert the customisation
        '
        Dim customisationAdapter As New ITSPTableAdapters.CustomisationsTableAdapter
        Dim nCustomisationID As Integer
        '
        ' OK, it's a new one, so create a new record of customisation and store the text.
        '
        ' Create the new customisations. Note that the executeMode of InsertAndGetID is set to Scalar so we
        ' can access the SCOPE_IDENTITY value, i.e. the value of the identity column in the new record.
        '
        ' If there is a duplicate, catch the exception and give an error result
        '
        Try
            nCustomisationID = CInt(customisationAdapter.InsertAndGetID(bActive, 1, nCentreID, nApplicationID, sCustomisationName,
                                                                        sCustomisationText, sQuestion1, sQuestion2, sQuestion3, bIsAssessed))
        Catch ex As Exception
            Dim sMsg As String = ex.Message()

            If sMsg.Contains("Cannot insert duplicate key row") AndAlso
               sMsg.Contains("IX_Customisations_CentreAppName") Then
                Return "[#Result:-18]"
            End If
            Throw                               ' rethrow unexpected exception
        End Try

        Return "[#Result:1,#CustomisationID:" & nCustomisationID.ToString() & ",#Version:1]"
    End Function

    ''' <summary>
    ''' Handle UpdateCustomisation API call
    ''' </summary>
    ''' <param name="sCustomisationID">Customisation to update</param>
    ''' <param name="sCustomisationName">New name of the customisation</param>
    ''' <param name="sCustomisationText">New text of the customisation</param>
    ''' <param name="sQuestion1">Text of first question</param>
    ''' <param name="sQuestion2">Text of second question</param>
    ''' <param name="sQuestion3">Text of third question</param>
    ''' <returns>Lingo property list giving result of call</returns>
    ''' <param name="sIsAssessed">Is this course assessed</param>
    ''' <remarks></remarks>
    Protected Function UpdateCustomisation(ByRef sCustomisationID As String,
                                           ByRef sCustomisationName As String,
                                           ByRef sCustomisationText As String,
                                           ByRef sQuestion1 As String,
                                           ByRef sQuestion2 As String,
                                           ByRef sQuestion3 As String,
                                           ByRef sIsAssessed As String) As String
        '
        ' Check parameters are present
        '
        If sCustomisationID Is Nothing Or sCustomisationName Is Nothing Or sCustomisationText Is Nothing Or
            sQuestion1 Is Nothing Or sQuestion2 Is Nothing Or sQuestion3 Is Nothing Or sIsAssessed Is Nothing Then
            Return "[#Result:-14]"
        End If

        '
        ' Convert and check parameters
        '
        Dim nCustomisationID As Integer = CInt(sCustomisationID)
        sCustomisationName = CCommon.ConvertQuotedParameter(sCustomisationName)
        sCustomisationText = CCommon.ConvertQuotedParameter(sCustomisationText)
        sQuestion1 = CCommon.ConvertQuotedParameter(sQuestion1)
        sQuestion2 = CCommon.ConvertQuotedParameter(sQuestion2)
        sQuestion3 = CCommon.ConvertQuotedParameter(sQuestion3)
        Dim bIsAssessed As Boolean = sIsAssessed <> "0"
        '
        ' Get the current version information
        '
        Dim customisationAdapter As New ITSPTableAdapters.CustomisationsTableAdapter
        Dim tCustomisations As ITSP.CustomisationsDataTable
        Dim nCurrentVersion As Integer
        Dim bCurrentActive As Boolean
        Dim nCentreID As Integer
        Dim nApplicationID As Integer

        tCustomisations = customisationAdapter.GetByID(nCustomisationID)
        Select Case tCustomisations.Count
            Case 0
                Return "[#Result:-19]"
            Case 1
                nCurrentVersion = tCustomisations.First.CurrentVersion
                bCurrentActive = tCustomisations.First.Active
                nCentreID = tCustomisations.First.CentreID
                nApplicationID = tCustomisations.First.ApplicationID
            Case Else
                Return "[#Result:-5]"
        End Select
        '
        ' Check if a centre administrator for this centre is logged on
        '
        CheckCentreAdmin(nCentreID)
        '
        ' Now update the version as well as storing the new name and text.
        ' If the new name is a duplicate then give error code -18
        '
        nCurrentVersion += 1
        Try
            customisationAdapter.UpdateRow(bCurrentActive, nCurrentVersion, nCentreID, nApplicationID, sCustomisationName, sCustomisationText,
                                        sQuestion1, sQuestion2, sQuestion3, bIsAssessed, nCustomisationID)
        Catch ex As Exception
            Dim sMsg As String = ex.Message()

            If sMsg.Contains("Cannot insert duplicate key row") AndAlso
               sMsg.Contains("IX_Customisations_CentreAppName") Then
                Return "[#Result:-18]"
            End If
            Throw                               ' rethrow unexpected exception
        End Try

        Return "[#Result:1,#CustomisationID:" & nCustomisationID.ToString() & ",#Version:" & nCurrentVersion.ToString() & "]"
    End Function

    ''' <summary>
    ''' Handle the Change Customisation Status API call
    ''' </summary>
    ''' <param name="sCustomisationID">Customisation to change</param>
    ''' <param name="sActive">0 means inactive, 1 means active, 2 means don't change state</param>
    ''' <returns>New status plus count of candidates using customisation</returns>
    ''' <remarks></remarks>
    Protected Function ChangeCustomisationStatus(ByRef sCustomisationID As String,
                                                 ByRef sActive As String) As String
        '
        ' Check parameters are present
        '
        If sCustomisationID Is Nothing Or sActive Is Nothing Then
            Return "[#Result:-14]"
        End If

        '
        ' Convert and check parameters
        '
        Dim nCustomisationID As Integer = CInt(sCustomisationID)
        Dim bCurrentActive As Boolean
        '
        ' Get the current version information
        '
        Dim customisationAdapter As New ITSPTableAdapters.CustomisationsTableAdapter
        Dim tCustomisations As ITSP.CustomisationsDataTable

        tCustomisations = customisationAdapter.GetByID(nCustomisationID)
        Select Case tCustomisations.Count
            Case 0
                Return "[#Result:-20]"
            Case 1
                bCurrentActive = tCustomisations.First.Active
            Case Else
                Return "[#Result:-5]"
        End Select
        '
        ' Check if a centre administrator for this centre is logged on
        '
        CheckCentreAdmin(tCustomisations.First.CentreID)
        '
        ' Now update the status if requested
        '
        Dim progressAdapter As New ITSPTableAdapters.ProgressTableAdapter
        Dim sActiveState As String

        Select Case sActive
            Case "0"
                customisationAdapter.UpdateActive(False, nCustomisationID)
                sActiveState = "0"

            Case "1"
                customisationAdapter.UpdateActive(True, nCustomisationID)
                sActiveState = "1"

            Case "2"
                If bCurrentActive Then
                    sActiveState = "1"
                Else
                    sActiveState = "0"
                End If

            Case Else
                Return "[#Result:-21]"
        End Select
        '
        ' Get the number of people using this customisation
        '
        Dim nProgressForCustomisation = progressAdapter.GetCountOfProgressForCustomisation(nCustomisationID)

        Return "[#Result:1,#Candidates:" & nProgressForCustomisation.ToString() & ",#Active:" & sActiveState & "]"
    End Function

    ''' <summary>
    ''' Handle LoadCustomisation API
    '''   Either CentreID and CustomisationID are supplied, or 
    '''   CentreID, ApplicationID and CustomisationName.
    ''' </summary>
    ''' <param name="sCentreID">Centre ID - optional</param>
    ''' <param name="sCustomisationID">Customisation ID - optional</param>
    ''' <param name="sApplicationID">Application ID - optional</param>
    ''' <param name="sCustomisationName">Customisation name - optional</param>
    ''' <returns>Lingo property list giving details of the customisation text</returns>
    ''' <remarks></remarks>
    Protected Function LoadCustomisation(ByRef sCentreID As String,
                                         ByRef sCustomisationID As String,
                                         ByRef sApplicationID As String,
                                         ByVal sCustomisationName As String) As String
        '
        ' Check parameters are present.
        ' Special check here as some parameters are optional
        '
        If Not ((Not sCentreID Is Nothing And Not sCustomisationID Is Nothing) Or
                (Not sCentreID Is Nothing And Not sApplicationID Is Nothing And Not sCustomisationName Is Nothing)) Then
            Return "[#Result:-14]"
        End If

        '
        ' Convert and check parameters
        '
        Dim nCentreID As Integer = CInt(sCentreID)
        Dim nCustomisationID As Integer
        '
        ' Get the current customisation information
        '
        Dim customisationAdapter As New ITSPTableAdapters.CustomisationsTableAdapter
        Dim tCustomisations As ITSP.CustomisationsDataTable
        '
        ' Access the table in two different ways depending on parameters.
        '
        If Not sCustomisationID Is Nothing AndAlso sCustomisationID.Length > 0 Then
            nCustomisationID = CInt(sCustomisationID)
            tCustomisations = customisationAdapter.GetByID(nCustomisationID)
        Else
            Dim nApplicationID As Integer = CInt(sApplicationID)
            sCustomisationName = CCommon.ConvertQuotedParameter(sCustomisationName)
            tCustomisations = customisationAdapter.GetByName(nApplicationID, sCustomisationName, nCentreID)
        End If

        Select Case tCustomisations.Count
            Case 0
                Return "[#Result:-23]"
            Case 1
                '
                ' Check if centre matches; if so, grab information we need
                '
                If tCustomisations.First.CentreID <> nCentreID Then
                    Return "[#Result:-22]"
                End If
                Return ("[#Result:1,#CustomisationID:" & tCustomisations.First.CustomisationID.ToString() &
                        ",#CustomisationName:""" & tCustomisations.First.CustomisationName & """" &
                        ",#Version:" & tCustomisations.First.CurrentVersion.ToString() &
                        ",#Active:" & GetStatusText(tCustomisations.First.Active) &
                        ",#CustomisationText:" & tCustomisations.First.CustomisationText.ToString() & "]")
            Case Else
                Return "[#Result:-7]"
        End Select
    End Function

    ''' <summary>
    ''' Handles the ListCustomisations API call
    ''' </summary>
    ''' <param name="sCentreID">For this Centre</param>
    ''' <param name="sApplicationID">For this Application</param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Protected Function ListCustomisation(ByRef sCentreID As String,
                                         ByRef sApplicationID As String) As String
        '
        ' Check parameters are present
        '
        If sCentreID Is Nothing Or sApplicationID Is Nothing Then
            Return "[#Result:-14]"
        End If

        '
        ' Convert and check parameters
        '
        Dim nCentreID As Integer = CInt(sCentreID)
        Dim nApplicationID As Integer = CInt(sApplicationID)
        '
        ' Get the current customisation information
        '
        Dim customisationAdapter As New ITSPTableAdapters.CustomisationsTableAdapter
        Dim tCustomisations As ITSP.CustomisationsDataTable
        Dim rowC As ITSP.CustomisationsRow
        Dim sbCustomisationInfo As New StringBuilder
        '
        ' Extract the data
        '
        tCustomisations = customisationAdapter.GetByApplication(nCentreID, nApplicationID)
        If tCustomisations.Count = 0 Then
            Dim taCentreApps As New ITSPTableAdapters.CentreApplicationsTableAdapter
            Dim tCentreApps As New ITSP.CentreApplicationsDataTable
            tCentreApps = taCentreApps.CheckAppForCentre(nCentreID, nApplicationID)
            If tCentreApps.Count > 0 Then
                Dim taQ As New ITSPTableAdapters.QueriesTableAdapter
                taQ.uspCreateESRCustomisation(nApplicationID, nCentreID)
                tCustomisations = customisationAdapter.GetByApplication(nCentreID, nApplicationID)
            End If
        End If
        For Each rowC In tCustomisations
            If sbCustomisationInfo.Length > 0 Then
                sbCustomisationInfo.Append(",")
            End If
            sbCustomisationInfo.Append("[#CustomisationID:" & rowC.CustomisationID.ToString() &
                                       ",#CustomisationName:""" & rowC.CustomisationName & """" &
                                       ",#Active:" & GetStatusText(rowC.Active) & "]")
        Next
        Return ("[#Result:1,#Customisations:[" & sbCustomisationInfo.ToString() & "]]")
    End Function

    ''' <summary>
    ''' Handle the QueryProgress API query
    ''' </summary>
    ''' <param name="sCandidateNumber">Candidate number</param>
    ''' <param name="sCentreID">Centre ID as cross-check</param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Protected Function QueryProgress(ByRef sCandidateNumber As String,
                                    ByRef sCentreID As String) As String
        '
        ' Check parameters are present
        '
        If sCandidateNumber Is Nothing Or sCentreID Is Nothing Then
            Return "[#Result:-14]"
        End If

        '
        ' Convert and check parameters
        '
        Dim rowCandidate As ITSP.CandidatesRow
        rowCandidate = CCommon.GetCandidate(sCandidateNumber)
        Dim nCandidateID As Integer = rowCandidate.CandidateID
        Dim nCandidateCentreID As Integer = rowCandidate.CentreID
        Dim nCentreID As Integer = CInt(sCentreID)
        '
        ' If the centreIDs don't match then give an error result
        '
        If nCentreID <> nCandidateCentreID Then
            Return "[#Result:-25]"
        End If
        '
        ' Grab the progress data
        '
        Dim progressAdapter As New ITSPTableAdapters.ProgressTableAdapter()
        Dim tProgress As ITSP.ProgressDataTable
        Dim rowP As ITSP.ProgressRow
        Dim sbProgressInfo As New StringBuilder

        tProgress = progressAdapter.GetAllForCandidate(nCandidateID)

        For Each rowP In tProgress
            '
            ' Get the completed date/time as a string. A little complex
            ' because DateTime is not nullable.
            '
            Dim sCompleted As String = ""
            Try
                sCompleted = rowP.Completed.ToString("dd/MM/yyyy HH:mm:ss")
            Catch ex As System.Data.StrongTypingException
                '
                ' The Completed value must be DBNull but there's no way of testing it
                ' so just depend on this exception!
                '
            End Try
            '
            ' Same for evaluated
            '
            Dim sEvaluated As String = ""
            Try
                sEvaluated = rowP.Evaluated.ToString("dd/MM/yyyy HH:mm:ss")
            Catch ex As System.Data.StrongTypingException
            End Try
            '
            ' Get text for this row. Put in a comma separator if necessary.
            '
            If sbProgressInfo.Length > 0 Then
                sbProgressInfo.Append(",")
            End If
            sbProgressInfo.Append("[#CustomisationID:" & rowP.CustomisationID.ToString() &
                                  ",#Version:" & rowP.CustomisationVersion.ToString() &
                                  ",#Submitted:""" & rowP.SubmittedTime.ToString("dd/MM/yyyy HH:mm:ss") & """" &
                                  ",#Completed:""" & sCompleted & """" &
                                  ",#Evaluated:""" & sEvaluated & """]")
        Next
        Return ("[#Result:1,#ProgressList:[" & sbProgressInfo.ToString() & "]]")
    End Function

    ''' <summary>
    ''' Handle the CandidateLogin API query
    ''' </summary>
    ''' <param name="sCandidateNumber">Candidate number</param>
    ''' <param name="sCustomisationID">ID of the customisation they are using</param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Protected Function CandidateLogin(ByRef sCandidateNumber As String,
                                        ByRef sCustomisationID As String) As String
        '
        ' Check parameters are present
        '
        If sCandidateNumber Is Nothing Or sCustomisationID Is Nothing Then
            Return "[#Result:-14]"
        End If

        Dim sessionAdapter As New ITSPTableAdapters.SessionsTableAdapter
        '
        ' Convert and check parameters
        '
        Dim nCustomisationID As Integer = CInt(sCustomisationID)
        Dim nCandidateID As Integer = CCommon.GetCandidate(sCandidateNumber, True).CandidateID
        '
        ' Close any old sessions, then open a new session
        ' Do this work in a transaction in case the information doesn't match
        '
        Dim nSessionID As Integer
        Dim sResult As String = "1"

        'sessionAdapter.BeginTransaction()
        Try
            '
            ' Close any open sessions and change the result code if any were closed
            '
            If CInt(sessionAdapter.CloseActiveSessions(nCandidateID, nCustomisationID)) > 0 Then
                sResult = "2"
            End If
            '
            ' Create a new session and get the SessionID
            '
            nSessionID = CInt(sessionAdapter.InsertAndGetID(nCandidateID, nCustomisationID, 0, True))
            'sessionAdapter.CommitTransaction()
        Catch ex As System.Data.SqlClient.SqlException
            'sessionAdapter.RollbackTransaction()
            If (ex.Errors.Item(0).Number = 547) Then ' 547 indicates foreign key violation
                Return "[#Result:-26]"          ' indicate violation to caller
            Else
                Throw                           ' not one we know about, give a generic error
            End If
        Catch ex As Exception                   ' any other problems rollback and give generic error
            'sessionAdapter.RollbackTransaction()
            Throw
        End Try

        Return "[#Result:" & sResult & ",#SessionID:" & nSessionID.ToString() & "]"
    End Function

    ''' <summary>
    ''' Handle the LoadProgress API query
    ''' </summary>
    ''' <param name="sCandidateNumber">Candidate number</param>
    ''' <param name="sCustomisationID">Customisation ID</param>
    ''' <param name="sSessionID">Session ID</param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Protected Function LoadProgress(ByRef sCandidateNumber As String,
                                    ByRef sCustomisationID As String,
                                    ByRef sSessionID As String) As String
        '
        ' Check parameters are present.
        ' Don't check SessionID as that isn't supplied when centre manager is logged in.
        '
        If sCandidateNumber Is Nothing Or sCustomisationID Is Nothing Then
            Return "[#Result:-14]"
        End If
        '
        ' Convert and check parameters
        '
        Dim nCustomisationID As Integer = CInt(sCustomisationID)
        Dim rowCandidate As ITSP.CandidatesRow
        rowCandidate = CCommon.GetCandidate(sCandidateNumber)
        Dim nCandidateID As Integer = rowCandidate.CandidateID
        Dim nCentreID As Integer = rowCandidate.CentreID
        '
        ' If the centre administrator is logged in then we allow them to load the progres
        ' regardless of session ID. The centre ID has to match the centre though.
        '
        Try
            CheckCentreAdmin(nCentreID)
        Catch ex As ApplicationException
            '
            ' Check the session (throws exception if a problem)
            '
            UpdateSession(sSessionID, nCandidateID, nCustomisationID, 0)
        End Try
        '
        ' Grab the progress data
        '
        Dim progressAdapter As New ITSPTableAdapters.ProgressTableAdapter()
        Dim tProgress As ITSP.ProgressDataTable
        Dim ProgressRow As ITSP.ProgressRow

        tProgress = progressAdapter.GetLastProgress(nCandidateID, nCustomisationID)
        Select Case tProgress.Count
            Case 0
                Return "[#Result:2]"
            Case 1
                ProgressRow = tProgress.First()
                '
                ' Get the completed date/time as a string. A little complex
                ' because DateTime is not nullable.
                '
                Dim sCompleted As String = ""
                Try
                    sCompleted = ProgressRow.Completed.ToString("dd/MM/yyyy HH:mm:ss")
                Catch ex As System.Data.StrongTypingException
                    '
                    ' The Completed value must be DBNull but there's no way of testing it
                    ' so just depend on this exception!
                    '
                End Try
                '
                ' Same for evaluated
                '
                Dim sEvaluated As String = ""
                Try
                    sEvaluated = ProgressRow.Evaluated.ToString("dd/MM/yyyy HH:mm:ss")
                Catch ex As System.Data.StrongTypingException
                End Try
                Return ("[#Result:1," &
                        "#CustomisationID:" & ProgressRow.CustomisationID.ToString() & "," &
                        "#Version:" & ProgressRow.CustomisationVersion.ToString() & "," &
                        "#Completed:""" & sCompleted & """," &
                        "#Evaluated:""" & sEvaluated & """," &
                        "#Progress:[""" & ProgressRow.ProgressText.Replace("""", """ & QUOTE & """) & """]]")
        End Select
        Return "[#Result:-3]"
    End Function

    ''' <summary>
    ''' Handle the StoreProgress API query
    ''' </summary>
    ''' <param name="sCandidateNumber">Candidate number</param>
    ''' <param name="sCustomisationID">Applicable customisation ID</param>
    ''' <param name="sVersion">Version of the customisation</param>
    ''' <param name="sCompleted">1/0 whether the unit was completed</param>
    ''' <param name="sProgressText">The progress text</param>
    ''' <param name="sSessionID">Session ID</param>
    ''' <param name="sModifierID">Modifier ID signifying what variation of the course they have completed</param>
    ''' <param name="sDiagnosticScore">Diagnostic score as percentage (v5)</param>
    ''' <param name="sLearningTime">Learning time calculated by learning materials (v5)</param>
    ''' <returns>Lingo property list indicating success/failure</returns>
    ''' <remarks></remarks>
    Protected Function StoreProgress(ByRef sCandidateNumber As String,
                                     ByRef sCustomisationID As String,
                                     ByRef sVersion As String,
                                     ByRef sCompleted As String,
                                     ByRef sProgressText As String,
                                     ByRef sSessionID As String,
                                     ByRef sModifierID As String,
                                     ByRef sDiagnosticScore As String,
                                     ByRef sLearningTime As String) As String
        '
        ' Check parameters are present. V4 list doesn't include sDiagnosticScore. Keep it compatible for the moment
        '
        If sCandidateNumber Is Nothing Or sCustomisationID Is Nothing Or sVersion Is Nothing Or
            sCompleted Is Nothing Or sProgressText Is Nothing Or sSessionID Is Nothing Or sModifierID Is Nothing Then
            Return "[#Result:-14]"
        End If

        Dim progressAdapter As New ITSPTableAdapters.ProgressTableAdapter()

        '
        ' Convert and check parameters.
        '
        Dim nCandidateID As Integer = CCommon.GetCandidate(sCandidateNumber).CandidateID
        Dim nCustomisationID As Integer = CInt(sCustomisationID)
        Dim nVersion As Integer = CInt(sVersion)
        Dim nModifierID As Integer = CInt(sModifierID)
        Dim bCompleted As Boolean = CBool(CInt(sCompleted))
        Dim dtCompleted As Global.System.Nullable(Of Date)
        Dim nLearningTime As Integer
        sProgressText = CCommon.ConvertQuotedParameter(sProgressText)
        If sLearningTime Is Nothing Then        ' parameter not supplied
            nLearningTime = -1                  ' indicates to use old method of calculating overall learning time, using date difference
        Else
            nLearningTime = CInt(sLearningTime) ' OK, must be a valid learning time so use it
            If nLearningTime > 500 Then         ' hack to prevent large learning times!
                '
                ' Log the fault so we don't lose it
                '
                Dim sMsg As String = "LearningTime too big (ignored): " & nLearningTime.ToString()
                Try
                    Throw New ApplicationException(sMsg)    ' so we can use existing exception mailing code....
                Catch ex As Exception
                    CCommon.LogErrorToEmail(ex) ' send it!
                End Try
                CCommon.LogErrorToDatabase(3, "0", sMsg, Request)
                '
                ' Use old method for calculating duration using real time
                '
                nLearningTime = -1
            End If
        End If

        If bCompleted Then
            dtCompleted = Date.UtcNow()
        End If
        '
        ' Check diagnostic score. It might not be supplied, or might be just an empty string.
        '
        Dim nDiagnosticScore As Global.System.Nullable(Of Integer)
        If Not sDiagnosticScore Is Nothing AndAlso sDiagnosticScore <> String.Empty Then
            nDiagnosticScore = CInt(sDiagnosticScore)
        End If
        '
        ' Check the session (throws exception if a problem)
        '
        UpdateSession(sSessionID, nCandidateID, nCustomisationID, nLearningTime)
        '
        ' Update the old progress record if present or insert new progress
        '
        'progressAdapter.BeginTransaction()
        Try
            '
            ' Determine if there is an old progress record.
            '
            Dim tblProgress As ITSP.ProgressDataTable
            Dim dtEvaluated As Global.System.Nullable(Of Date)

            tblProgress = progressAdapter.GetLastProgress(nCandidateID, nCustomisationID)
            If tblProgress.Count = 1 Then
                progressAdapter.UpdateProgress(nVersion, DateTime.UtcNow(), dtCompleted, sProgressText, nModifierID, nDiagnosticScore, tblProgress.First.ProgressID)
            Else
                progressAdapter.InsertProgress(nCandidateID, nCustomisationID, nVersion, DateTime.UtcNow(), dtCompleted, sProgressText, dtEvaluated, nModifierID, nDiagnosticScore)
            End If
            'progressAdapter.CommitTransaction()
        Catch ex As Exception
            'progressAdapter.RollbackTransaction()
            Return "[#Result:-4]"
        End Try
        Return "[#Result:1]"
    End Function
    '''<summary>Handle the StoreASPProgress API query</summary>
    '''
    Protected Function StoreASPProgress(ByRef sTutorialStatus As String,
                                         ByRef sLearningTime As String) As String
        '
        ' Check parameters are present
        '
        If sTutorialStatus Is Nothing Or sLearningTime Is Nothing Then
            Return "[#Result:-14]"
        End If
        Dim nProgressID As Integer = CInt(Session("lmProgressID"))
        Dim nCandidateID As Integer = CInt(Session("learnCandidateID"))
        Dim nVersion As Integer = CInt(Session("lmCustVersion"))
        Dim nCustomisationID As Integer = CInt(Session("lmCustomisationID"))
        Dim nLearningTime As Integer = CInt(sLearningTime) ' OK, must be a valid learning time so use it
        If nLearningTime > 500 Then         ' hack to prevent large learning times!
            '
            ' Log the fault so we don't lose it
            '
            Dim sMsg As String = "LearningTime too big (ignored): " & nLearningTime.ToString()
            Try
                Throw New ApplicationException(sMsg)    ' so we can use existing exception mailing code....
            Catch ex As Exception
                CCommon.LogErrorToEmail(ex) ' send it!
            End Try
            CCommon.LogErrorToDatabase(3, "0", sMsg, Request)
            '
            ' Use old method for calculating duration using real time
            '
            nLearningTime = -1
        End If
        Dim nTutorialStatus As Integer = CInt(sTutorialStatus)
        Dim taQueries As New LearnMenuTableAdapters.QueriesTableAdapter
        Dim sBookmark As String = ""
        If Not Session("lmGvSectionRow") Is Nothing Then
            sBookmark = Session("lmGvSectionRow").ToString()
        End If
        Try
            taQueries.UpdateSession(nLearningTime, True, CInt(Session("lmSessionID")), nCandidateID, nCustomisationID)
            taQueries.UpdateProgress(nVersion, DateTime.UtcNow(), sBookmark, nProgressID)
            taQueries.UpdateASPProgress(CInt(sLearningTime), CInt(Session("lmTutorialID")), nProgressID)
            taQueries.UpdateASPProgressStat(CByte(sTutorialStatus), CInt(Session("lmTutorialID")), nProgressID)
        Catch ex As Exception
            CCommon.LogErrorToEmail(ex)
            Return "[#Result:-24]"
        End Try
        Return "[#Result:1]"
    End Function
    Protected Sub UpdateProgress()
        Dim nProgressID As Integer = CInt(Session("lmProgressID"))
        Dim nCandidateID As Integer = CInt(Session("learnCandidateID"))
        Dim nVersion As Integer = CInt(Session("lmCustVersion"))
        Dim nCustomisationID As Integer = CInt(Session("lmCustomisationID"))
        Dim taQueries As New LearnMenuTableAdapters.QueriesTableAdapter
        Dim sBookmark As String = ""
        If Not Session("lmGvSectionRow") Is Nothing Then
            sBookmark = Session("lmGvSectionRow").ToString()
        End If
        Try
            taQueries.UpdateProgress(nVersion, DateTime.UtcNow(), sBookmark, nProgressID)
        Catch ex As Exception
            CCommon.LogErrorToEmail(ex)
        End Try
    End Sub

    ''' <summary>
    ''' Handle the StoreAssessAttempt API query
    ''' </summary>
    ''' <param name="sCandidateNumber">Candidate number</param>
    ''' <param name="sCustomisationID">Applicable customisation ID</param>
    ''' <param name="sVersion">Version of the customisation</param>
    ''' <param name="sAssessInstance">Questions used in the assessment</param>
    ''' <param name="sSectionNumber">Section of the material being assessed</param>
    ''' <param name="sScore">Score achieved</param>
    ''' <param name="sStatus">Status</param>
    ''' <param name="sSessionID">Session ID</param>
    ''' <returns>Lingo property list indicating success/failure</returns>
    ''' <remarks></remarks>
    Protected Function StoreAssessAttempt(ByRef sCandidateNumber As String,
                                          ByRef sCustomisationID As String,
                                          ByRef sVersion As String,
                                          ByRef sAssessInstance As String,
                                          ByRef sSectionNumber As String,
                                          ByRef sScore As String,
                                          ByRef sStatus As String,
                                          ByRef sSessionID As String) As String
        '
        ' Check parameters are present
        '
        If sCandidateNumber Is Nothing Or sCustomisationID Is Nothing Or sVersion Is Nothing Or
            sAssessInstance Is Nothing Or sSectionNumber Is Nothing Or sScore Is Nothing Or
            sStatus Is Nothing Or sSessionID Is Nothing Then
            Return "[#Result:-14]"
        End If

        Dim assessAttemptsAdapter As New ITSPTableAdapters.AssessAttemptsTableAdapter()

        '
        ' Convert and check parameters
        '
        Dim nCandidateID As Integer = CCommon.GetCandidate(sCandidateNumber).CandidateID
        Dim nCustomisationID As Integer = CInt(sCustomisationID)
        Dim nVersion As Integer = CInt(sVersion)
        Dim nAssessInstance As Integer = CInt(sAssessInstance)
        Dim nSectionNumber As Integer = CInt(sSectionNumber)
        Dim nScore As Integer = CInt(sScore)
        Dim bStatus As Boolean = CBool(CInt(sStatus))
        '
        ' Check the session (throws exception if a problem)
        '
        UpdateSession(sSessionID, nCandidateID, nCustomisationID, 0)
        '
        ' Convert the Section Number to a Section ID - testing that the Section Number is valid.
        '
        Dim taq As New ITSPTableAdapters.QueriesTableAdapter
        Dim nSectionID As Integer
        Try
            nSectionID = CInt(taq.GetSectionIDByCustomisation(nSectionNumber, nCustomisationID))
        Catch ex As Exception
            Return "[#Result:-6]"
        End Try
        '
        ' Insert new assessment attempt
        '
        assessAttemptsAdapter.InsertAssessAttempt(nCandidateID, nCustomisationID, nVersion, DateTime.UtcNow(), nSectionNumber, nScore, bStatus)
        Return "[#Result:1]"
    End Function

    Protected Function StoreASPAssessAttempt(ByRef sScore As String,
                                          ByRef sStatus As String) As String
        'Check parameters are present:
        If sScore Is Nothing Or
            sStatus Is Nothing Then
            Return "[#Result:-14]"
        End If
        '
        Dim assessAttemptsAdapter As New ITSPTableAdapters.AssessAttemptsTableAdapter()

        '
        ' Get session parameters:
        '
        Dim nCandidateID As Integer = CInt(Session("learnCandidateID"))
        Dim nCustomisationID As Integer = CInt(Session("lmCustomisationID"))
        Dim nVersion As Integer = CInt(Session("lmCustVersion"))
        Dim nAssessInstance As Integer = 1
        Dim nSectionID As Integer = CInt(Session("lmDiagSectionID"))
        Dim nScore As Integer = CInt(sScore)
        Dim bStatus As Boolean = CBool(CInt(sStatus))
        '
        ' Check the session (throws exception if a problem)
        '
        UpdateSession(Session("SessionID").ToString(), nCandidateID, nCustomisationID, 0)
        '
        ' Convert the Section ID to Section Number
        '
        Dim taq As New LearnMenuTableAdapters.QueriesTableAdapter
        Dim nSectionNumber As Integer
        Try
            nSectionNumber = CInt(taq.GetSecNumberByID(nSectionID))
        Catch ex As Exception
            CCommon.LogErrorToEmail(ex)
            Return "[#Result:-6]"
        End Try
        '
        ' Insert new assessment attempt
        '
        assessAttemptsAdapter.InsertAssessAttempt(nCandidateID, nCustomisationID, nVersion, DateTime.UtcNow(), nSectionNumber, nScore, bStatus)
        If bStatus = True Then
            CheckCompletion()

        End If
        Return "[#Result:1]"
    End Function
    Protected Function StoreASPAssessNoSession(ByRef sCandidateID As String,
    ByRef sCustomisationID As String,
    ByRef sVersion As String,
    ByRef sSectionNumber As String,
    ByRef sScore As String) As String
        Dim bStatus As Boolean = False
        'Check parameters are present:
        If sScore Is Nothing Then
            Return "[#Result:-14]"
        Else
            Dim taq1 As New ITSPTableAdapters.QueriesTableAdapter
            Dim nThresh As Integer = CInt(taq1.GetPassThresholdForCustomisation(CInt(sCustomisationID)))
            If CInt(sScore) >= nThresh Then
                bStatus = True
            End If
        End If
        '
        Dim assessAttemptsAdapter As New ITSPTableAdapters.AssessAttemptsTableAdapter()

        '
        ' Get session parameters:
        '
        Dim nCandidateID As Integer = CInt(sCandidateID)
        Dim nCustomisationID As Integer = CInt(sCustomisationID)
        Dim nVersion As Integer = CInt(sVersion)
        Dim nAssessInstance As Integer = 1
        Dim nSectionID As Integer = CInt(sSectionNumber)
        Dim nScore As Integer = CInt(sScore)
        '
        ' Check the session (throws exception if a problem)
        '
        If Not Session("lmSessionID") Is Nothing Then
            UpdateSession(Session("lmSessionID").ToString(), nCandidateID, nCustomisationID, 0)
        End If
        '
        ' Convert the Section ID to Section Number
        '
        Dim taq As New LearnMenuTableAdapters.QueriesTableAdapter
        Dim nSectionNumber As Integer
        Try
            nSectionNumber = CInt(taq.GetSecNumberByID(nSectionID))
        Catch ex As Exception
            Return "[#Result:-6]"
        End Try
        '
        ' Insert new assessment attempt
        '
        assessAttemptsAdapter.InsertAssessAttempt(nCandidateID, nCustomisationID, nVersion, DateTime.UtcNow(), nSectionNumber, nScore, bStatus)
        Dim nProgressID As Integer = CInt(taq.GetProgressID(nCandidateID, nCustomisationID))
        Dim nCentreID As Integer = CInt(taq.GetCentreIDForCandidate(nCandidateID))
        If bStatus = True Then
            CCommon.CheckProgressForCompletion(nProgressID, nCandidateID, nCentreID)
        End If

        Return "[#Result:1]"
    End Function

    ''' <summary>
    ''' Handle the CandidateLogout API call
    ''' </summary>
    ''' <param name="sCandidateNumber">Candidate number</param>
    ''' <param name="sCustomisationID">Customisation ID</param>
    ''' <param name="sSessionID">Session</param>
    ''' <returns>success/failure result</returns>
    ''' <remarks></remarks>
    Protected Function CandidateLogout(ByRef sCandidateNumber As String,
      ByRef sCustomisationID As String,
      ByRef sSessionID As String) As String
        '
        ' Check parameters are present
        '
        If sCandidateNumber Is Nothing Or sCustomisationID Is Nothing Or sSessionID Is Nothing Then
            Return "[#Result:-14]"
        End If

        '
        ' Convert and check parameters
        '
        Dim nCustomisationID As Integer = CInt(sCustomisationID)
        Dim nCandidateID As Integer = CCommon.GetCandidate(sCandidateNumber).CandidateID
        '
        ' Check the session (throws exception if a problem)
        '
        UpdateSession(sSessionID, nCandidateID, nCustomisationID, 0, False)
        Return "[#Result:1]"
    End Function

    Protected Function GenerateInternalError() As String
        '
        ' Generate an error 
        '
        Throw New ApplicationException("Hi Kevin and Hugh - this is a deliberate crash test.")

        Return ""
    End Function
    Protected Function GetTutorialListForDiag() As String
        UpdateProgress()
        Dim nSecID As Integer = CInt(Session("lmDiagSectionID"))
        Dim taSec As New LearnMenuTableAdapters.QueriesTableAdapter
        Dim sSecName As String = taSec.GetSecNameByID(nSecID)
        Dim taDO As New LearnMenuTableAdapters.DiagObjectivesTableAdapter
        Dim tDO As New LearnMenu.DiagObjectivesDataTable
        tDO = taDO.GetBySectionAndCustomisation(nSecID, CInt(Session("lmCustomisationID")))
        Dim sObjList As String = "["
        If tDO.Count > 0 Then
            For Each ObjRow As DataRow In tDO.Rows
                sObjList = sObjList + "[#ObjectiveNum:" + ObjRow.Item("ObjectiveNum").ToString + ",#ObjectiveName:""" + ObjRow.Item("TutorialName").ToString + """,#DiagOutOf:" + ObjRow.Item("DiagAssessOutOf").ToString + "],"
            Next
            sObjList = sObjList.Substring(0, sObjList.Length - 1) + "]"
            Return ("[#Result:1," &
              "#ObjectiveList:" & sObjList &
              ",#SectionName:""" & sSecName & """]")
        Else
            Return ("[#Result:1," &
              "#ObjectiveList:[]" &
              ",#SectionName:""" & sSecName & """]")
        End If

    End Function
    Protected Function GetTutorialListForPL() As String
        UpdateProgress()
        Dim nSecID As Integer = CInt(Session("lmDiagSectionID"))
        Dim taSec As New LearnMenuTableAdapters.QueriesTableAdapter
        Dim sSecName As String = taSec.GetSecNameByID(nSecID)
        Dim taDO As New LearnMenuTableAdapters.DiagObjectivesTableAdapter
        Dim tDO As New LearnMenu.DiagObjectivesDataTable
        tDO = taDO.GetAllBySectionAndCust(nSecID, CInt(Session("lmCustomisationID")))
        Dim sObjList As String = "["
        If tDO.Count > 0 Then
            For Each ObjRow As DataRow In tDO.Rows
                sObjList = sObjList + "[#ObjectiveNum:" + ObjRow.Item("ObjectiveNum").ToString + ",#ObjectiveName:""" + ObjRow.Item("TutorialName").ToString + """,#DiagOutOf:" + ObjRow.Item("DiagAssessOutOf").ToString + "],"
            Next
            sObjList = sObjList.Substring(0, sObjList.Length - 1) + "]"
            Return ("[#Result:1," &
              "#ObjectiveList:" & sObjList &
              ",#SectionName:""" & sSecName & """]")
        Else
            Return ("[#Result:1," &
              "#ObjectiveList:[]" &
              ",#SectionName:""" & sSecName & """]")
        End If

    End Function
    Protected Function StoreAspDiagScore(ByVal sObjNum As String, ByVal sScore As String) As String
        Dim taq As New LearnMenuTableAdapters.QueriesTableAdapter
        Dim nProgressID As Integer = CInt(Session("lmProgressID"))
        Dim nVersion As Integer = CInt(Session("lmCustVersion"))
        taq.StoreDiagnosticAttempt(CInt(sScore), CInt(Session("lmProgressID")), CInt(Session("lmDiagSectionID")), CInt(sObjNum))
        Dim sBookmark As String = ""
        If Not Session("lmGvSectionRow") Is Nothing Then
            sBookmark = Session("lmGvSectionRow").ToString()
        End If
        taq.UpdateProgress(nVersion, DateTime.UtcNow(), sBookmark, nProgressID)
        CheckCompletion()
        Return "[#Result:1]"
    End Function
    Protected Function StoreAspDiagScoreNoSession(ByVal sObjNum As String, ByRef sCandidateID As String,
    ByRef sCustomisationID As String,
    ByRef sProgressID As String,
    ByRef sVersion As String,
    ByRef sSectionID As String,
    ByRef sScore As String) As String
        Dim taq As New LearnMenuTableAdapters.QueriesTableAdapter
        Dim nProgressID As Integer = CInt(sProgressID)
        Dim nVersion As Integer = CInt(sVersion)
        taq.StoreDiagnosticAttempt(CInt(sScore), CInt(sProgressID), CInt(sSectionID), CInt(sObjNum))
        Dim sBookmark As String = ""
        If Not Session("lmGvSectionRow") Is Nothing Then
            sBookmark = Session("lmGvSectionRow").ToString()
        End If
        taq.UpdateProgress(nVersion, DateTime.UtcNow(), sBookmark, nProgressID)
        Dim nCandidateID = CInt(sCandidateID)
        Dim nCentreID = CInt(taq.GetCentreIDForCandidate(nCandidateID))
        CCommon.CheckProgressForCompletion(nProgressID, nCandidateID, nCentreID)
        Return "[#Result:1]"
    End Function
    Protected Function StoreASPProgressNoSession(ByRef sTutorialStatus As String,
  ByRef sLearningTime As String,
  ByRef sProgressID As String,
  ByRef sCandidateID As String,
  ByRef sCustVersion As String,
  ByRef sCustomisationID As String) As String
        '
        ' Check parameters are present
        '
        If sTutorialStatus Is Nothing Or sLearningTime Is Nothing Then
            Return "[#Result:-14]"
        End If
        Dim nProgressID As Integer = CInt(sProgressID)
        Dim nCandidateID As Integer = CInt(sCandidateID)
        Dim nVersion As Integer = CInt(sCustVersion)
        Dim nCustomisationID As Integer = CInt(sCustomisationID)
        Dim nLearningTime As Integer = CInt(sLearningTime) ' OK, must be a valid learning time so use it
        If nLearningTime > 500 Then         ' hack to prevent large learning times!
            '
            ' Log the fault so we don't lose it
            '
            Dim sMsg As String = "LearningTime too big (ignored): " & nLearningTime.ToString()
            Try
                Throw New ApplicationException(sMsg)    ' so we can use existing exception mailing code....
            Catch ex As Exception
                CCommon.LogErrorToEmail(ex) ' send it!
            End Try
            CCommon.LogErrorToDatabase(3, "0", sMsg, Request)
            '
            ' Use old method for calculating duration using real time
            '
            nLearningTime = -1
        End If
        Dim nTutorialStatus As Integer = CInt(sTutorialStatus)
        Dim taQueries As New LearnMenuTableAdapters.QueriesTableAdapter
        Dim sBookmark As String = ""
        If Not Session("lmGvSectionRow") Is Nothing Then
            sBookmark = Session("lmGvSectionRow").ToString()
        End If
        Try
            taQueries.UpdateSession(nLearningTime, True, CInt(Session("lmSessionID")), nCandidateID, nCustomisationID)
            taQueries.UpdateProgress(nVersion, DateTime.UtcNow(), sBookmark, nProgressID)
            taQueries.UpdateASPProgress(CInt(sLearningTime), CInt(Session("lmTutorialID")), nProgressID)
            taQueries.UpdateASPProgressStat(CByte(sTutorialStatus), CInt(Session("lmTutorialID")), nProgressID)
        Catch ex As Exception
            CCommon.LogErrorToEmail(ex)
            Return "[#Result:-24]"
        End Try
        If CByte(sTutorialStatus) = 2 Then
            CCommon.CheckProgressForCompletion(nProgressID, nCandidateID, CInt(Session("UserCentreID")))
        End If
        Return "[#Result:1]"
    End Function
    Protected Function StoreASPProgressV2(ByRef sTutorialStatus As String,
  ByRef sLearningTime As String,
  ByRef sProgressID As String,
  ByRef sCandidateID As String,
  ByRef sCustVersion As String,
  ByRef sCustomisationID As String,
                                          ByVal sTutorialID As String) As String
        '
        ' Check parameters are present
        '
        If sTutorialStatus Is Nothing Or sLearningTime Is Nothing Then
            Return "[#Result:-14]"
        End If
        Dim nProgressID As Integer = CInt(sProgressID)
        Dim nCandidateID As Integer = CInt(sCandidateID)
        Dim nVersion As Integer = CInt(sCustVersion)
        Dim nCustomisationID As Integer = CInt(sCustomisationID)
        Dim nLearningTime As Integer = CInt(sLearningTime)
        Dim nTutorialID As Integer = CInt(sTutorialID)
        If nLearningTime > 500 Then         ' hack to prevent large learning times!
            '
            ' Log the fault so we don't lose it
            '
            Dim sMsg As String = "LearningTime too big (ignored): " & nLearningTime.ToString()
            Try
                Throw New ApplicationException(sMsg)    ' so we can use existing exception mailing code....
            Catch ex As Exception
                CCommon.LogErrorToEmail(ex) ' send it!
            End Try
            CCommon.LogErrorToDatabase(3, "0", sMsg, Request)
            '
            ' Use old method for calculating duration using real time
            '
            nLearningTime = -1
        End If
        Dim nTutorialStatus As Integer = CInt(sTutorialStatus)
        Dim taQueries As New LearnMenuTableAdapters.QueriesTableAdapter
        Dim sBookmark As String = ""
        If Not Session("lmGvSectionRow") Is Nothing Then
            sBookmark = Session("lmGvSectionRow").ToString()
        End If
        Try
            'taQueries.UpdateSession(nLearningTime, True, CInt(Session("lmSessionID")), nCandidateID, nCustomisationID)
            taQueries.UpdateProgress(nVersion, DateTime.UtcNow(), sBookmark, nProgressID)
            taQueries.UpdateASPProgress(CInt(sLearningTime), nTutorialID, nProgressID)
            taQueries.UpdateASPProgressStat(CByte(sTutorialStatus), nTutorialID, nProgressID)
        Catch ex As Exception
            CCommon.LogErrorToEmail(ex)
            Return "[#Result:-24]"
        End Try
        If CByte(sTutorialStatus) = 2 Then
            Dim nCentreID As Integer = CInt(taQueries.GetCentreIDForCandidate(nCandidateID))
            CCommon.CheckProgressForCompletion(nProgressID, nCandidateID, nCentreID)
        End If
        Return "[#Result:1]"
    End Function
    Protected Function GetObjectiveArray(ByVal CustomisationID As Integer, ByVal SectionID As Integer) As String
        Dim taDO As New LearnMenuTableAdapters.DiagObjectivesTableAdapter
        Dim tDO As New LearnMenu.DiagObjectivesDataTable
        tDO = taDO.GetAllBySectionAndCust(SectionID, CustomisationID)
        Dim sObjList As String = "{""objectives"":["
        If tDO.Count > 0 Then
            For Each ObjRow As DataRow In tDO.Rows
                sObjList = sObjList + "{""tutorialid"":" + ObjRow.Item("TutorialID").ToString + ",""interactions"":[" + ObjRow.Item("CMIInteractionIDs").ToString + "],""possible"":" + ObjRow.Item("DiagAssessOutOf").ToString + ",""myscore"":0},"
            Next
            sObjList = sObjList.Substring(0, sObjList.Length - 1) + "]}"
            Return sObjList
        Else
            Return ("{}")
        End If
    End Function
    Protected Function GetObjectiveArrayCC(ByVal CustomisationID As Integer, ByVal SectionID As Integer, ByVal ReturnAll As Boolean) As String
        Dim taDO As New LearnMenuTableAdapters.DiagObjectivesTableAdapter
        Dim tDO As New LearnMenu.DiagObjectivesDataTable
        If ReturnAll Then
            tDO = taDO.GetData(SectionID, CustomisationID)
        Else
            tDO = taDO.GetBySectionAndCustomisation(SectionID, CustomisationID)
        End If
        Dim sObjList As String = "{""objectives"":["
        If tDO.Count > 0 Then
            For Each ObjRow As DataRow In tDO.Rows
                sObjList = sObjList + "{""tutorialid"":" + ObjRow.Item("TutorialID").ToString + ",""tutorialname"":""" + ObjRow.Item("TutorialName").ToString + """,""possible"":" + ObjRow.Item("DiagAssessOutOf").ToString + ",""myscore"":0,""wrongcount"":0},"
            Next
            sObjList = sObjList.Substring(0, sObjList.Length - 1) + "]}"
            Return sObjList
        Else
            Return ("{}")
        End If
    End Function
    Protected Function StoreDiagnosticJson(ByVal ProgressID As Integer, ByVal DiagnosticOutcome As String) As String
        Dim taq As New LearnMenuTableAdapters.QueriesTableAdapter
        Dim arr As JArray = TryCast(JArray.Parse(DiagnosticOutcome), JArray)
        Try
            For Each objective As JObject In arr
                Dim ntutid As Integer = CInt(objective("tutorialid"))
                Dim nscore As Integer = CInt(objective("myscore"))
                taq.StoreDiagnosticScoreSCO(nscore, ProgressID, ntutid)
            Next
        Catch ex As Exception
            CCommon.LogErrorToEmail(ex)
            Return "[#Result:-25]"
        End Try
        CheckCompletion()
        Return "[#Result:1]"
    End Function
    Protected Function UpdateLessonState(ByVal tutorialId As String, ByVal progressId As String, ByVal candidateId As String, ByVal customisationId As String, ByVal tutStat As String, ByVal tutTime As String, ByVal suspendData As String, ByVal lessonLocation As String) As String
        Dim taq As New LearnMenuTableAdapters.QueriesTableAdapter
        Try
            taq.UpdateLessonState(CByte(tutStat), CInt(tutTime), suspendData, lessonLocation, CInt(tutorialId), CInt(progressId), CInt(candidateId), CInt(customisationId))
        Catch ex As Exception
            CCommon.LogErrorToEmail(ex)
            Return "[#Result:-26]"
        End Try
        If CByte(tutStat) > 0 Then
            Dim nCentreID As Integer = CInt(taq.GetCentreIDForCandidate(CInt(candidateId)))
            CCommon.CheckProgressForCompletion(CInt(progressId), CInt(candidateId), nCentreID)
        End If
        Return "[#Result:1]"
    End Function
#End Region

#Region "Utility Functions to aupport API"
    ''' <summary>
    ''' Check that the session matches the parameters to other APIs and update Duration
    ''' </summary>
    ''' <param name="sSessionID">Session ID as string</param>
    ''' <param name="nCandidateID">Candidate ID</param>
    ''' <param name="nCustomisationID">Customisation ID</param>
    ''' <param name="nLearningTime">Learning time for this session; -ve indicates use time to calculate duration; 0 means not to update</param>
    ''' <param name="bActive">Is the session still active?</param>
    ''' <remarks>Throws an exception if there is a problem</remarks>
    Protected Sub UpdateSession(ByRef sSessionID As String,
     ByRef nCandidateID As Integer,
     ByRef nCustomisationID As Integer,
     ByVal nLearningTime As Integer,
     Optional ByVal bActive As Boolean = True)
        '
        ' Convert params
        '
        Dim nSessionID As Integer = CInt(sSessionID)
        '
        ' Try and update the session
        '
        Dim sessionAdapter As New ITSPTableAdapters.SessionsTableAdapter
        Dim nCount As Integer
        '
        ' If learning time is 0 then we might be logging off. Don't update the duration.
        '
        If nLearningTime = 0 Then
            nCount = CInt(sessionAdapter.UpdateActive(nCandidateID, nCustomisationID, bActive, nSessionID))
        ElseIf nLearningTime > 0 Then
            '
            ' Given a learning time, take this as learning time from start of session
            '
            nCount = CInt(sessionAdapter.UpdateDuration(nCandidateID, nCustomisationID, nLearningTime, bActive, nSessionID))
        Else
            '
            ' Otherwise calculate learning time the old way using current time
            '
            nCount = CInt(sessionAdapter.UpdateDurationV4(nCandidateID, nCustomisationID, nLearningTime, bActive))
        End If
        If nCount <> 1 Then
            Throw New ApplicationException("Session not found")
        End If
    End Sub

    ''' <summary>
    ''' Check if the centre administrator is logged in
    ''' </summary>
    ''' <param name="nCentreID">Centre ID being changed</param>
    ''' <remarks>Throws an exception if CentreID doesn't match logged in user</remarks>
    Protected Sub CheckCentreAdmin(ByVal nCentreID As Integer)
        '
        ' Check if the session variables match
        '
        If Session("UserName") Is Nothing OrElse CInt(Session("UserCentreID")) <> nCentreID Then
            Throw New ApplicationException("Centre manager not logged in")
        End If
    End Sub

    ''' <summary>
    ''' Convert status to boolean 1/0
    ''' </summary>
    ''' <param name="bStatus">Status from database - True or False</param>
    ''' <returns>"1" or "0"</returns>
    ''' <remarks></remarks>
    Protected Function GetStatusText(ByRef bStatus As Boolean) As String
        If bStatus Then
            Return "1"
        End If
        Return "0"
    End Function
    Protected Sub CheckCompletion()
        If Not Session("learnCandidateID") Is Nothing And Not Session("lmProgressID") Is Nothing Then
            CCommon.CheckProgressForCompletion(CInt(Session("lmProgressID")), CInt(Session("learnCandidateID")), CInt(Session("UserCentreID")))
        End If
    End Sub
#End Region

#Region "Log Response Errors"
    ''' <summary>
    ''' Log any response errors to the Log table
    ''' </summary>
    ''' <param name="sResponse">Complete response text</param>
    ''' <param name="sLogMessage">Possible log error message</param>
    ''' <remarks></remarks>
    Protected Sub LogResponseErrors(ByRef sResponse As String, ByRef sLogMessage As String)
        Dim rxResultCode As New Regex("Result\:(?<code>[0123456789-]+)", RegexOptions.Compiled Or RegexOptions.IgnoreCase)
        '
        ' Test if there's an error code in the request. The regex matches any number preceded by
        ' the text "Result:"
        '
        Dim matches As MatchCollection = rxResultCode.Matches(sResponse)
        If matches.Count = 1 Then
            '
            ' Extract the error code
            '
            Dim groups As GroupCollection = matches.Item(0).Groups
            Dim sCode As String = groups.Item("code").Value
            '
            ' Log the bad request
            '
            CCommon.LogErrorToDatabase(0, sCode, sLogMessage, Request)
        End If
    End Sub
#End Region
End Class

