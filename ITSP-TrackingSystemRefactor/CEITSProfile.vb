Imports System.Web.Script.Serialization
<Serializable()>
Public Class CEITSProfile
    ''' <summary>
    ''' Set up default profile.
    ''' </summary>
    ''' <remarks>
    ''' This list must be updated whenever a new profile entry is created.
    ''' Profile entries no longer in use should be deleted.
    ''' If a default is changed then this affects all profiles that have
    ''' a value that was the same as the previous default, i.e. they have no
    ''' explicit value stored.
    ''' </remarks>
    Private Sub _SetDefaults()
        '
        ' Entries are in the format:
        '
        ' _dDefaultProfile.Add("Option", 2)
        '
        ' Split entries up into the associated pages to make it easier to track and help SVN to merge changes.
        '
        '--------------------------------------------
        ' dashboard.aspx
        '
        DefGridView("dashboard.Customisations", "CH.C")
        '
        '--------------------------------------------
        ' CentreCandidates.aspx
        '
        DefGridView("CentreCandidate.Candidates", "CC.C")
        DefGridView("CentreCandidate.Customisations", "CC.CU")
        DefGridView("CentreCandidate.LearningEvents", "CC.LE")
        Def("CentreCandidate.Filter.Applied", "CC.FAP", 0)
        Def("CentreCandidate.Filter.FirstName", "CC.FFN", "")
        Def("CentreCandidate.Filter.LastName", "CC.FLN", "")
        Def("CentreCandidate.Filter.Login", "CC.FLG", "")
        Def("CentreCandidate.Filter.Alias", "CC.FAL", "")
        Def("CentreCandidate.Filter.Status", "CC.FST", 0)
        Def("CentreCandidate.Filter.JobGroup", "CC.FJG", 0)
        Def("CentreCandidate.Filter.RegDateHigh", "CC.FDH", "")
        Def("CentreCandidate.Filter.RegDateLow", "CC.FDL", "")
        Def("CentreCandidate.Filter.Answer1", "CC.FA1", "[All answers]")
        Def("CentreCandidate.Filter.Answer2", "CC.FA2", "[All answers]")
        Def("CentreCandidate.Filter.Answer3", "CC.FA3", "[All answers]")
        Def("CentreCandidate.Filter.Approved", "CC.APP", 0)
        '
        '--------------------------------------------
        ' CentreCourse.aspx
        '
        DefGridView("CentreCourse.Progress", "CO.P")
        Def("CentreCourse.SelectedCustomisation", "CO.SC", 0) ' stores ID of customisation
        Def("CentreCourse.Filter.Applied", "CO.FAP", 0)
        Def("CentreCourse.Filter.FirstName", "CO.FFN", "")
        Def("CentreCourse.Filter.LastName", "CO.FLN", "")
        Def("CentreCourse.Filter.CandidateNumber", "CO.FCN", "")
        Def("CentreCourse.Filter.AliasID", "CO.FA", "")
        Def("CentreCourse.Filter.Status", "CO.FS", 0)
        Def("CentreCourse.Filter.RegDateLow", "CO.FRL", "")
        Def("CentreCourse.Filter.RegDateHigh", "CO.FRH", "")
        Def("CentreCourse.Filter.UpdateDateLow", "CO.FUL", "")
        Def("CentreCourse.Filter.UpdateDateHigh", "CO.FUH", "")
        Def("CentreCourse.Filter.CompletedDateLow", "CO.FCL", "")
        Def("CentreCourse.Filter.CompletedDateHigh", "CO.FCH", "")
        Def("CentreCourse.Filter.LoginsLow", "CO.FLL", "")
        Def("CentreCourse.Filter.LoginsHigh", "CO.FLH", "")
        Def("CentreCourse.Filter.DurationLow", "CO.FDL", "")
        Def("CentreCourse.Filter.DurationHigh", "CO.FDH", "")
        Def("CentreCourse.Filter.PassesLow", "CO.FPAL", "")
        Def("CentreCourse.Filter.PassesHigh", "CO.FPAH", "")
        Def("CentreCourse.Filter.PassRateLow", "CO.FPL", "")
        Def("CentreCourse.Filter.PassRateHigh", "CO.FPH", "")
        Def("CentreCourse.Filter.DiagScoreLow", "CO.FSL", "")
        Def("CentreCourse.Filter.DiagScoreHigh", "CO.FSH", "")
        Def("CentreCourse.Filter.Answer1", "CO.FA1", "[All answers]")
        Def("CentreCourse.Filter.Answer2", "CO.FA2", "[All answers]")
        Def("CentreCourse.Filter.Answer3", "CO.FA3", "[All answers]")
        '
        '--------------------------------------------
        ' CentreCustomise.aspx
        '
        DefGridView("CentreCustomise.Customisations", "CM.C")
        Def("CentreCustomise.Filter.CourseGroup", "CM.FCG", 0)
        Def("CentreCustomise.Filter.Application", "CM.FAP", 0)
        Def("CentreCustomise.Filter.Version", "CM.FV", 0)
        Def("CentreCustomise.Filter.Status", "CM.FST", "True")
        '
        '--------------------------------------------
        ' CentreResources.aspx
        '
        DefGridView("CentreResources.Downloads", "CR.D")
        DefGridView("CentreResources.Confirm", "CR.C")
        DefGridView("CentreResources.Preorder", "CR.O")
        DefGridView("CentreResources.Products", "CR.P")
        '
        '--------------------------------------------
        ' CentreReports.aspx
        '
        Def("CentreReports.ShowAllCourse", "CP.D", False)
        Def("CentreReports.ddPeriodCount", "CP.C", 6)
        Def("CentreReports.ddPeriodType", "CP.O", 3)
        Def("CentreReports.ddCustomisation", "CP.U", -1)
        Def("CentreReports.ddJobGroupID", "CP.J", -1)
        Def("CentreReports.ddAssessed", "CP.A", -1)
        Def("CentreReports.ddCourseGroup", "CP.G", -1)
        Def("CentreReports.tbStartDate", "CP.SD", "")
        Def("CentreReports.tbEndDate", "CP.ED", "")
        '
        '--------------------------------------------
        ' Centres.aspx
        '
        DefGridView("Centres.Centres", "C.C")
        '
        '--------------------------------------------
        ' CentresUsers.aspx
        '
        DefGridView("CentreUsers.AdminUsers", "CU.C")
        '
        '--------------------------------------------
        ' CentresUsers.aspx
        '
        DefGridView("CentreSupport.Tickets", "CS.T")
        DefGridView("CentreSupport.TicketComments", "CS.TC")
        Def("CentreSupport.ShowArchivedTickets", "CS.A", False)
        '
        '--------------------------------------------
        ' Reports.aspx
        '
        Def("Reports.ShowAllCourse", "R.SAC", False)
        Def("Reports.ddPeriodCount", "R.PC", 6)
        Def("Reports.ddPeriodType", "R.PT", 3)
        Def("Reports.ddRegion", "R.R", -1)
        Def("Reports.ddCentreType", "R.CT", -1)
        Def("Reports.ddApplication", "R.A", -1)
        Def("Reports.ddJobGroupID", "R.J", -1)
        Def("Reports.ddAssessed", "R.S", -1)
        Def("Reports.ddCourseGroup", "R.G", -1)
        Def("Reports.tbStartDate", "R.SD", "")
        Def("Reports.tbEndDate", "R.ED", "")
        Def("Reports.ddCoreContent", "R.C", -1)
        '
        '--------------------------------------------
        ' Reports.aspx
        '
        Def("ReportFWA.ddJobGroupID", "RFW.J", -1)
        Def("ReportFWA.ddAnswer1", "RFW.A1", -1)
        Def("ReportFWA.ddAnswer2", "RFW.A2", -1)
        Def("ReportFWA.ddAnswer3", "RFW.A3", -1)
        Def("ReportFWA.ddAnswer4", "RFW.A4", -1)
        Def("ReportFWA.ddAnswer5", "RFW.A5", -1)
        Def("ReportFWA.ddAnswer6", "RFW.A6", -1)
        Def("ReportFWA.sAnswer1", "RFW.S1", "Any")
        Def("ReportFWA.sAnswer2", "RFW.S2", "Any")
        Def("ReportFWA.sAnswer3", "RFW.S3", "Any")
        Def("ReportFWA.sAnswer4", "RFW.S4", "Any")
        Def("ReportFWA.sAnswer5", "RFW.S5", "Any")
        Def("ReportFWA.sAnswer6", "RFW.S6", "Any")
        Def("ReportFWA.ddBrand", "RFW.B", -1)
        Def("ReportFWA.ddCategory", "RFW.C", -1)
        Def("ReportFWA.ddTopic", "RFW.T", -1)
        Def("ReportFWA.ddApplication", "RFW.A", -1)
        Def("ReportFWA.ddSection", "RFW.SE", "Any")
        Def("ReportFWA.ddSkill", "RFW.SK", "Any")
        Def("ReportFWA.tbStartDate", "RFW.SD", "")
        Def("ReportFWA.tbEndDate", "RFW.ED", "")
        Def("ReportFWA.cbSVVerified", "RFW.SV", False)
        Def("ReportFWA.cbStacked", "RFW.ST", True)
        Def("ReportFWA.cbPies", "RFW.P", False)
        '
        '--------------------------------------------
        ' TableAdmin.aspx
        '
        DefGridView("TableAdmin.Config", "TA.C")
        DefGridView("TableAdmin.Downloads", "TA.D")
        DefGridView("TableAdmin.Products", "TA.P")
        DefGridView("TableAdmin.Regions", "TA.R")
        DefGridView("TableAdmin.Centres", "TA.N")
        DefGridView("TableAdmin.JobGroups", "TA.J")
        DefGridView("TableAdmin.Applications", "TA.A")
        DefGridView("TableAdmin.Sections", "TA.S")
        DefGridView("TableAdmin.AdminUsers", "TA.U")
        DefGridView("TableAdmin.TicketStatus", "TA.T")
        DefGridView("TableAdmin.FAQs", "TA.F")
    End Sub
    '
    ' Dirty flag indicates if the profile needs to be persisted
    '
    Private _bDirty As Boolean = False
    '
    ' Actual profile values which differ from the defaults
    '
    Private _dProfile As Dictionary(Of String, Object)
    '
    ' Default values in the profile
    '
    Private _dDefaultProfile As New Dictionary(Of String, Object)
    '
    ' Translate public names into private names - or "Also Known As" - AKA - names.
    ' These will keep the storage small. AKA names are stored in the profile.
    '
    Private _dAKA As New Dictionary(Of String, String)

    ''' <summary>
    ''' Constructor when a profile has been deserialized
    ''' </summary>
    ''' <param name="dProfile">Profile dictionary</param>
    ''' <remarks></remarks>
    Private Sub New(ByRef dProfile As Dictionary(Of String, Object))
        '
        ' Remember the loaded profile values
        '
        _dProfile = dProfile
        '
        ' Set the default values
        '
        _dDefaultProfile = New Dictionary(Of String, Object) ' stores defaults
        _dAKA = New Dictionary(Of String, String) ' stores translation from public verbose name to short AKA name
        _SetDefaults()                          ' set defaults
        '
        ' If default values have been deleted since the profile was stored
        ' then we shouldn't continue storing them in the profile.
        ' Also, if the default value has been changed and now is the
        ' same as the profile value we shouldn't continue storing it.
        ' Therefore we check if any values in dProfile are non-existent in 
        ' the defaults and remove them from dProfile.
        '
        Dim lsKeys As List(Of String) = _dProfile.Keys().ToList ' take a snap of the keys to allow modifications to profile in for loop
        For Each sKey As String In lsKeys
            '
            ' Check if the default was there, and if so, what it was
            '
            Dim oDefaultValue As Object = Nothing
            Dim bRemove As Boolean              ' are we going to remove the entry?
            '
            ' Test if the value exists in the default profile, and get its value if so
            '
            bRemove = Not _dDefaultProfile.TryGetValue(sKey, oDefaultValue) ' remove if not in the default profile
            If Not bRemove Then                 ' if in the default profile
                bRemove = (oDefaultValue = _dProfile(sKey)) ' check if it's the same as the default
            End If
            If bRemove Then                     ' do we want to remove the value?
                _dProfile.Remove(sKey)          ' yes, remove from the profile
                _bDirty = True                  ' the profile has been changed, so we should store it next time we can
            End If
        Next
    End Sub

    ''' <summary>
    ''' Add default value.
    ''' </summary>
    ''' <param name="sName">Full name of profile entry, must be unique</param>
    ''' <param name="sAKA">Short name of profile entry, must be unique</param>
    ''' <param name="oValue">Default value</param>
    ''' <remarks></remarks>
    Private Sub Def(ByVal sName As String, ByVal sAKA As String, ByVal oValue As Object)
        _dDefaultProfile.Add(sAKA, oValue)
        _dAKA.Add(sName, sAKA)
    End Sub

    ''' <summary>
    ''' Add default values for a grid view control. Note that two entries with D and X are added
    ''' to short name of profile entries so that AKA values may give duplicates if you're not careful!
    ''' </summary>
    ''' <param name="sName">Full name of gridview, must be unique</param>
    ''' <param name="sAKA">Short name of gridview, must be unique</param>
    ''' <remarks></remarks>
    Private Sub DefGridView(ByVal sName As String, ByVal sAKA As String)
        Def(sName & ".SortDir", sAKA & "D", SortDirection.Ascending)
        Def(sName & ".SortExp", sAKA & "X", "")
    End Sub

    ''' <summary>
    ''' Get a value from the profile.
    ''' </summary>
    ''' <param name="sKey">Name of the value to get</param>
    ''' <returns>Stored profile value</returns>
    ''' <remarks></remarks>
    Public Function GetValue(ByVal sKey As String) As Object
        '
        ' Value may not be in the dictionary. If not, return the default value
        ' If not in the default profile an exception is thrown
        '
        Dim oValue As Object = ""
        If _dAKA.ContainsKey(sKey) Then
            sKey = _dAKA(sKey)                      ' translate to AKA key
            If Not _dProfile.TryGetValue(sKey, oValue) Then
                oValue = _dDefaultProfile(sKey)
            End If
        End If

        Return oValue
    End Function

    ''' <summary>
    ''' Set a value into the profile. This is only explicitly saved if it is
    ''' different from the default.
    ''' </summary>
    ''' <param name="sKey">Key for value</param>
    ''' <param name="oValue">Value being stored, as object</param>
    ''' <remarks></remarks>
    Public Sub SetValue(ByVal sKey As String, ByVal oValue As Object)
        '
        ' Check if it's changed that value
        '
        sKey = _dAKA(sKey)                      ' translate to AKA key
        If _dProfile.ContainsKey(sKey) Then     ' only if key exists
            _bDirty = _bDirty Or (_dProfile.Item(sKey) <> oValue)
        End If
        '
        ' If it's the same as the default then we don't bother storing it
        ' in the profile.
        '
        If _dDefaultProfile(sKey) = oValue Then
            If _dProfile.ContainsKey(sKey) Then ' if it's in the profile we remove it so that default takes over
                _dProfile.Remove(sKey)
                _bDirty = True                  ' enforce dirty state; should be set anyway
            End If
        Else
            '
            ' Save the value which is different from the default
            '
            _dProfile(sKey) = oValue
            _bDirty = True                      ' must have changed the profile
        End If
    End Sub

    ''' <summary>
    ''' Is the profile dirty? Does it need to be saved
    ''' </summary>
    ''' <returns>True/False</returns>
    ''' <remarks></remarks>
    Public Function IsDirty() As Boolean
        Return _bDirty
    End Function

    ''' <summary>
    ''' Convert the profile values to a JSON string.
    ''' </summary>
    ''' <returns>JSON string of profile</returns>
    ''' <remarks></remarks>
    Public Function GetProfileAsString() As String
        Dim oSerializer As New JavaScriptSerializer()

        _bDirty = False
        Return oSerializer.Serialize(_dProfile)
    End Function

    ''' <summary>
    ''' Load a profile from a string and return a CEITSProfile object
    ''' </summary>
    ''' <param name="EITSProfile">Profile string</param>
    ''' <returns>Object with profile loaded</returns>
    ''' <remarks></remarks>
    Public Shared Function LoadProfileFromString(ByVal EITSProfile As String) As CEITSProfile
        If EITSProfile.Length = 0 Then
            EITSProfile = "{}"
        End If
        Dim oSerializer As New JavaScriptSerializer()

        Return New CEITSProfile(oSerializer.Deserialize(Of Dictionary(Of String, Object))(EITSProfile))
    End Function

    ''' <summary>
    ''' Get a profile from the session
    ''' </summary>
    ''' <param name="Session">Session object</param>
    ''' <returns>Profile object</returns>
    ''' <remarks></remarks>
    Public Shared Function GetProfile(ByVal Session As System.Web.SessionState.HttpSessionState) As CEITSProfile
        Return CType(Session("UserProfile"), CEITSProfile)
    End Function

    ''' <summary>
    ''' Set the profile into the session object
    ''' </summary>
    ''' <param name="Session">Session object</param>
    ''' <remarks></remarks>
    Public Sub SetProfile(ByVal Session As System.Web.SessionState.HttpSessionState)
        Session("UserProfile") = Me
    End Sub
End Class
