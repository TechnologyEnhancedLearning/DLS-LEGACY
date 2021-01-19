Imports System.Web.Script.Serialization
<Serializable()>
Public Class CourseSettings
    ''' <summary>
    ''' Set up default settings.
    ''' </summary>
    ''' <remarks>
    ''' This list must be updated whenever a new profile entry is created.
    ''' Profile entries no longer in use should be deleted.
    ''' If a default is changed then this affects all profiles that have
    ''' a value that was the same as the previous default, i.e. they have no
    ''' explicit value stored.
    ''' </remarks>
    Private Sub _SetCourseDefaults()
        Def("LearnMenu.ShowPercentage", "lm.sp", True)
        Def("LearnMenu.ShowTime", "lm.st", True)
        Def("LearnMenu.ShowLearnStatus", "lm.sl", True)
        Def("LearnMenu.Supervisor", "lm.su", "Supervisor")
        Def("LearnMenu.Verification", "lm.ve", "Verification")
        Def("LearnMenu.SupportingInformation", "lm.si", "Supporting Information")
        Def("LearnMenu.ConsolidationExercise", "lm.ce", "Consolidation Exercise")
        Def("LearnMenu.Review", "lm.re", "Review")
        Def("DevelopmentLog.ShowPlanned", "df.sp", True)
        Def("DevelopmentLog.ShowCompleted", "df.sc", True)
        Def("DevelopmentLog.IncludeReflectiveAccount", "dl.ra", False)
        Def("DevelopmentLog.DevelopmentLog", "dl.dl", "Development Log")
        Def("DevelopmentLog.Planned", "dl.pl", "Planned")
        Def("DevelopmentLog.Completed", "dl.co", "Completed")
        Def("DevelopmentLog.AddPlanned", "dl.ap", "Add Planned")
        Def("DevelopmentLog.AddCompleted", "dl.ac", "Add Completed")
        Def("DevelopmentLog.ExpectedOutcomes", "dl.ou", "Outcomes")
        Def("DevelopmentLogForm.ShowDLSCourses", "df.sd", True)
        Def("DevelopmentLogForm.ShowMethod", "df.sm", True)
        Def("DevelopmentLogForm.ShowFileUpload", "df.fu", True)
        Def("DevelopmentLogForm.ShowSkillMapping", "df.ss", True)
        Def("DevelopmentLogForm.RecordPlannedDevelopmentActivity", "df.rp", "Record Planned Development Activity")
        Def("DevelopmentLogForm.RecordCompletedDevelopmentActivityEvidence", "df.rc", "Record Completed Development Activity / Evidence")
        Def("DevelopmentLogForm.Method", "df.me", "Method")
        Def("DevelopmentLogForm.Activity", "df.ac", "Activity")
        Def("DevelopmentLogForm.DueDateTime", "df.dd", "Due Date and Time")
        Def("DevelopmentLogForm.CompletedDate", "df.cd", "Completed Date")
        Def("DevelopmentLogForm.Duration", "df.du", "Duration")
        Def("DevelopmentLogForm.Skill", "df.sk", "Skill")
    End Sub
    Private _bDirty As Boolean = False
    '
    ' Actual profile values which differ from the defaults
    '
    Private _dSettings As Dictionary(Of String, Object)
    '
    ' Default values in the profile
    '
    Private _dDefaultSettings As New Dictionary(Of String, Object)
    '
    ' Translate public names into private names - or "Also Known As" - AKA - names.
    ' These will keep the storage small. AKA names are stored in the profile.
    '
    Private _dAKA As New Dictionary(Of String, String)

    ''' <summary>
    ''' Constructor when settings have been deserialized
    ''' </summary>
    ''' <param name="dSettings">Profile dictionary</param>
    ''' <remarks></remarks>
    Private Sub New(ByRef dSettings As Dictionary(Of String, Object))
        '
        ' Remember the loaded Settings values
        '
        _dSettings = dSettings
        '
        ' Set the default values
        '
        _dDefaultSettings = New Dictionary(Of String, Object) ' stores defaults
        _dAKA = New Dictionary(Of String, String) ' stores translation from public verbose name to short AKA name
        _SetCourseDefaults()                          ' set defaults
        '
        ' If default values have been deleted since the Settings was stored
        ' then we shouldn't continue storing them in the Settings.
        ' Also, if the default value has been changed and now is the
        ' same as the Settings value we shouldn't continue storing it.
        ' Therefore we check if any values in dSettings are non-existent in 
        ' the defaults and remove them from dSettings.
        '
        Dim lsKeys As List(Of String) = _dSettings.Keys().ToList ' take a snap of the keys to allow modifications to Settings in for loop
        For Each sKey As String In lsKeys
            '
            ' Check if the default was there, and if so, what it was
            '
            Dim oDefaultValue As Object = Nothing
            Dim bRemove As Boolean              ' are we going to remove the entry?
            '
            ' Test if the value exists in the default Settings, and get its value if so
            '
            bRemove = Not _dDefaultSettings.TryGetValue(sKey, oDefaultValue) ' remove if not in the default Settings
            If Not bRemove Then                 ' if in the default Settings
                bRemove = (oDefaultValue = _dSettings(sKey)) ' check if it's the same as the default
            End If
            If bRemove Then                     ' do we want to remove the value?
                _dSettings.Remove(sKey)          ' yes, remove from the Settings
                _bDirty = True                  ' the Settings has been changed, so we should store it next time we can
            End If
        Next
    End Sub
    ''' <summary>
    ''' Add default value.
    ''' </summary>
    ''' <param name="sName">Full name of settings entry, must be unique</param>
    ''' <param name="sAKA">Short name of settings entry, must be unique</param>
    ''' <param name="oValue">Default value</param>
    ''' <remarks></remarks>
    Private Sub Def(ByVal sName As String, ByVal sAKA As String, ByVal oValue As Object)
        _dDefaultSettings.Add(sAKA, oValue)
        _dAKA.Add(sName, sAKA)
    End Sub
    ''' <summary>
    ''' Get a value from the Settings.
    ''' </summary>
    ''' <param name="sKey">Name of the value to get</param>
    ''' <returns>Stored Settings value</returns>
    ''' <remarks></remarks>
    Public Function GetValue(ByVal sKey As String) As Object
        '
        ' Value may not be in the dictionary. If not, return the default value
        ' If not in the default Settings an exception is thrown
        '
        Dim oValue As Object = ""
        If _dAKA.ContainsKey(sKey) Then
            sKey = _dAKA(sKey)                      ' translate to AKA key
            If Not _dSettings.TryGetValue(sKey, oValue) Then
                oValue = _dDefaultSettings(sKey)
            End If
        End If

        Return oValue
    End Function
    ''' <summary>
    ''' Set a value into the Settings. This is only explicitly saved if it is
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
        If _dSettings.ContainsKey(sKey) Then     ' only if key exists
            _bDirty = _bDirty Or (_dSettings.Item(sKey) <> oValue)
        End If
        '
        ' If it's the same as the default then we don't bother storing it
        ' in the Settings.
        '
        If _dDefaultSettings(sKey) = oValue Then
            If _dSettings.ContainsKey(sKey) Then ' if it's in the Settings we remove it so that default takes over
                _dSettings.Remove(sKey)
                _bDirty = True                  ' enforce dirty state; should be set anyway
            End If
        Else
            '
            ' Save the value which is different from the default
            '
            _dSettings(sKey) = oValue
            _bDirty = True                      ' must have changed the Settings
        End If
    End Sub
    ''' <summary>
    ''' Is the Settings dirty? Does it need to be saved
    ''' </summary>
    ''' <returns>True/False</returns>
    ''' <remarks></remarks>
    Public Function IsDirty() As Boolean
        Return _bDirty
    End Function

    ''' <summary>
    ''' Convert the Settings values to a JSON string.
    ''' </summary>
    ''' <returns>JSON string of Settings</returns>
    ''' <remarks></remarks>
    Public Function GetSettingsAsString() As String
        Dim oSerializer As New JavaScriptSerializer()

        _bDirty = False
        Return oSerializer.Serialize(_dSettings)
    End Function

    ''' <summary>
    ''' Load a Settings from a string and return a CEITSSettings object
    ''' </summary>
    ''' <param name="sCourseSettings">Settings string</param>
    ''' <returns>Object with Settings loaded</returns>
    ''' <remarks></remarks>
    Public Shared Function LoadSettingsFromString(ByVal sCourseSettings As String) As CourseSettings
        If sCourseSettings.Length = 0 Then
            sCourseSettings = "{}"
        End If
        Dim oSerializer As New JavaScriptSerializer()

        Return New CourseSettings(oSerializer.Deserialize(Of Dictionary(Of String, Object))(sCourseSettings))
    End Function

    ''' <summary>
    ''' Get a Settings from the session
    ''' </summary>
    ''' <param name="Session">Session object</param>
    ''' <returns>Settings object</returns>
    ''' <remarks></remarks>
    Public Shared Function GetSettings(ByVal Session As System.Web.SessionState.HttpSessionState) As CourseSettings
        Return CType(Session("CourseSettings"), CourseSettings)
    End Function

    ''' <summary>
    ''' Set the Settings into the session object
    ''' </summary>
    ''' <param name="Session">Session object</param>
    ''' <remarks></remarks>
    Public Sub SetSettings(ByVal Session As System.Web.SessionState.HttpSessionState)
        Session("CourseSettings") = Me
    End Sub
End Class
