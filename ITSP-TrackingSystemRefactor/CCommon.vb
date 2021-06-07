Imports System.Drawing.Imaging
Imports System.Drawing
Imports System.Net
Imports System.IO
Imports HiQPdf
Imports Microsoft.Owin.Security.OpenIdConnect
Imports Microsoft.Owin.Security.Cookies
Imports System.Security.Claims
Imports Microsoft.Owin.Security

Public Class CCommon
#Region "HTMLSetup"

    Public Shared ReadOnly Property sCurrentDate As String
        Get
            Return Date.Now.Year.ToString & "-" & Date.Now.Month.ToString & "-" & Date.Now.Day.ToString
        End Get
    End Property

    'Public Shared Function GetFileExtension(ByVal sFile As Image) As String
    '    Dim sReturnExt As String = ""
    '    Return sReturnExt
    'End Function
    Public Shared Sub RunStartupScript(ByRef oPage As System.Web.UI.Page, ByRef sScriptName As String, ByRef sScript As String)

        Dim typePage As Type = oPage.GetType
        Dim csManager As ClientScriptManager
        csManager = oPage.ClientScript

        If Not csManager.IsStartupScriptRegistered(typePage, sScriptName) Then
            Dim sbScript As New StringBuilder

            sbScript.Append("<script type='text/javascript'>")
            sbScript.Append(sScript)
            sbScript.Append("</script>")

            csManager.RegisterStartupScript(typePage, sScriptName, sbScript.ToString())
        End If
    End Sub

    ''' <summary>
    ''' Display a config item on a page
    ''' </summary>
    ''' <param name="sConfigItem">Name of configuration item</param>
    ''' <param name="ctlLiteral">Control to put value into</param>
    ''' <remarks></remarks>
    Public Shared Sub ConfigMessage(ByVal sConfigItem As String, ByRef ctlLiteral As Literal)
        Dim taConfig As New ITSPTableAdapters.ConfigTableAdapter
        Dim tblConfig As ITSP.ConfigDataTable
        tblConfig = taConfig.GetByName(sConfigItem)
        If tblConfig.Rows.Count = 1 Then
            ctlLiteral.Text = tblConfig.First.ConfigText
        End If
    End Sub
    Public Shared Function GetConfigString(ByVal sItem As String) As String
        Dim taq As New ITSPTableAdapters.ConfigTableAdapter
        Dim tConfig As New ITSP.ConfigDataTable
        Dim sReturn As String = ""
        tConfig = taq.GetByName(sItem)
        If tConfig.Count > 0 Then
            sReturn = tConfig.First.ConfigText
        End If
        Return sReturn
    End Function

    ''' <summary>
    ''' Set a shockwave object with correct text on the page
    ''' </summary>
    ''' <param name="sMoviePath">Path to the movie</param>
    ''' <param name="lSWParams">Array of 10 Shockwave parameters</param>
    ''' <param name="nWidth">Width of movie</param>
    ''' <param name="nHeight">Height of movie</param>
    ''' <returns> Text to insert into page for shockwave movie</returns>
    ''' <remarks></remarks>
    Public Shared Function GetShockwaveObject(ByRef Session As System.Web.SessionState.HttpSessionState,
       ByVal sMoviePath As String, ByRef lSWParams() As String,
       ByVal nWidth As Integer, ByVal nHeight As Integer) As String
        Dim sWidth As String = nWidth.ToString()
        Dim sHeight As String = nHeight.ToString()

        Dim nParam As Integer
        Dim sbParams As StringBuilder = New StringBuilder
        Dim sProgressID As String = ""
        If Not Session("lmProgressID") Is Nothing Then
            sProgressID = "<param name=""swText"" value=""" & Session("lmProgressID") & """ /> "
        End If
        For nParam = 1 To 10
            If Not lSWParams(nParam) Is Nothing AndAlso lSWParams(nParam) <> "" Then
                sbParams.Append("<param name=""sw" & nParam.ToString() & """ value=""" & lSWParams(nParam) & """ /> ")
            End If
        Next

        Return "<!--[if IE]>" & vbCrLf &
         "<object classid=""clsid:233C1507-6A77-46A4-9443-F871F945D258""" & vbCrLf &
         "codebase = ""http://download.macromedia.com/pub/shockwave/cabs/director/sw.cab#version=11,5,0,593""" & vbCrLf &
         "ID=""EITSMovie"" width=""" & sWidth & """ height=""" & sHeight & """>" & vbCrLf &
         "<param name=""src"" value=""" & sMoviePath & """/>" & vbCrLf &
         "<![endif]-->" & vbCrLf &
         "<!--[if !IE]>-->" & vbCrLf &
         "<object type=""application/x-director"" data=""" & sMoviePath & """ width=""" & sWidth & """ height=""" & sHeight & """ id=""EITSMovie"">" & vbCrLf &
         "<!--<![endif]-->" & vbCrLf &
         "<param name=""swRemote"" value=""swSaveEnabled='true' swVolume='false' swRestart='false' swPausePlay='false' swFastForward='false' swContextMenu='false' "" />" & vbCrLf &
         "<param name=""swStretchStyle"" value=""meet"" />" & vbCrLf &
         "<param name=""PlayerVersion"" value=""11"" />" & vbCrLf &
         "<param name=""bgColor"" value=""#FFFFFF"" />" & vbCrLf &
         sbParams.ToString() & vbCrLf &
         sProgressID & vbCrLf &
         "<p>" & vbCrLf &
         "These learning materials require Shockwave to be installed." & vbCrLf &
         "</p>" & vbCrLf &
         "</object>"
    End Function
    ''' <summary>
    ''' Get URL of server including port, protocol and path
    ''' </summary>
    ''' <returns>URL with trailing /</returns>
    ''' <param name="sProtocol">Protocol if it's going to be forced</param>
    ''' <param name="nPort">Port if it's going to be forced</param>
    ''' <remarks></remarks>
    Public Shared Function GetServerURL(Optional ByVal sProtocol As String = "", Optional ByVal nPort As Integer = 80)


        Return My.Settings.ITSPTrackingURL
    End Function
    Public Shared Function GetServerDomain(Optional ByVal sProtocol As String = "", Optional ByVal nPort As Integer = 80)
        Dim nExpectedPort As Integer = 80
        Dim sLink As String
        Dim sPort As String = String.Empty
        '
        ' Set up protocol if not already done
        '
        If sProtocol = String.Empty Then
            If HttpContext.Current.Request.IsSecureConnection Then
                sLink = "https"
                nExpectedPort = 443
            Else
                sLink = "http"
            End If
            If HttpContext.Current.Request.ServerVariables("SERVER_PORT") <> nExpectedPort Then
                sPort = ":" & HttpContext.Current.Request.ServerVariables("SERVER_PORT")
            End If
        Else
            sLink = sProtocol   ' leave off port in this case
        End If
        '
        ' Add server name and port if it's not as expected
        '
        sLink &= "://" & HttpContext.Current.Request.ServerVariables("SERVER_NAME") & sPort
        If Not sLink.EndsWith("/") Then
            sLink &= "/"
        End If
        Return sLink
    End Function
    ''' <summary>
    ''' Get the IP address for this request
    ''' </summary>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Protected Shared Function GetClientIP() As String
        Dim Request As System.Web.HttpRequest = System.Web.HttpContext.Current.Request

        Dim sClientIPAddress As String = Request.ServerVariables("HTTP_X_FORWARDED_FOR")
        If sClientIPAddress Is Nothing Then
            '
            ' No proxies so use simple remote_addr
            '
            sClientIPAddress = Request.ServerVariables("REMOTE_ADDR")
        Else
            '
            ' Could have been forwarded by multiple proxies so split on comma and find last entry
            '
            Dim lsParts As String() = sClientIPAddress.Split(","c)
            sClientIPAddress = lsParts.Last()
        End If

        Return sClientIPAddress
    End Function
    ''' <summary>
    ''' Get request string as POST etc.
    ''' </summary>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Protected Shared Function GetRequestString() As String
        Dim Request As System.Web.HttpRequest = System.Web.HttpContext.Current.Request
        '
        ' Get the request string including request type and requested to
        '
        Dim sbRequest As New StringBuilder("")

        sbRequest.AppendLine(Request.RequestType())
        sbRequest.AppendLine(Request.RawUrl())
        Dim reader As System.IO.StreamReader = New System.IO.StreamReader(Request.InputStream)
        While (Not reader.EndOfStream)
            sbRequest.AppendLine(reader.ReadLine())
        End While
        '
        ' Reset the input stream so other error handlers can use it
        '
        If Request.InputStream.CanSeek Then
            Request.InputStream.Seek(0, IO.SeekOrigin.Begin)
        End If

        Return sbRequest.ToString()
    End Function
    Public Shared Function GetIconClass(ByVal sFileName As String) As String
        Dim sReturnClass As String = "fas fa-file-export-file"
        Dim sExt As String = Path.GetExtension(sFileName)
        Select Case sExt
            Case ".xls", ".xlsx", ".xlt", ".xltx"
                sReturnClass = "icon-excel"
            Case ".doc", ".docx", ".dot", ".dotx"
                sReturnClass = "icon-word"
            Case ".ppt", ".pptx", ".potx", ".pot"
                sReturnClass = "icon-powerpoint"
            Case ".zip"
                sReturnClass = "icon-zip"
            Case ".mp4", ".avi", ".wmv"
                sReturnClass = "icon-video"
            Case ".png", ".jpg", ".jpeg", ".bmp"
                sReturnClass = "icon-image"
            Case ".mp3"
                sReturnClass = "icon-audio"
            Case ".pdf"
                sReturnClass = "icon-pdf"
            Case ".exe", ".msi"
                sReturnClass = "icon-exe"
            Case ".pub", ".pubx"
                sReturnClass = "icon-publisher"
        End Select
        Return sReturnClass
    End Function
#End Region
#Region "GridsAndRecords"

    ''' <summary>
    ''' Set up a column - change header text. If header is empty then hide the column
    ''' </summary>
    ''' <param name="sSortExpression">Sort expression for the column</param>
    ''' <param name="sHeaderText">New Header text</param>
    ''' <param name="lColumns">Column collection from the GridView</param>
    ''' <remarks></remarks>
    Public Shared Sub ChangeColumnHeader(ByRef sSortExpression As String, ByVal sHeaderText As String, ByRef lColumns As DataControlFieldCollection)
        Dim nColIndex As Integer = GetGridViewColumnIndex(sSortExpression, lColumns)
        If nColIndex > -1 Then
            lColumns.Item(nColIndex).HeaderText = sHeaderText
            If sHeaderText.Length = 0 Then
                lColumns.Item(nColIndex).Visible = False
            End If
        End If
    End Sub

    ''' <summary>
    ''' Gets the column index for a given column.
    ''' </summary>
    ''' <param name="sColumnName">Column name (must satisfy SortExpression.StartsWith)</param>
    ''' <param name="lColumns">Column collection from the GridView</param>
    ''' <returns>Index of the column or -1 if not found</returns>
    ''' <remarks>Note that this is really fast, taking around 2us on my machine, so there is no point in optimising code
    ''' by storing the returned index somewhere.</remarks>
    Public Shared Function GetGridViewColumnIndex(ByVal sColumnName As String, ByVal lColumns As DataControlFieldCollection) As Integer
        For Each field As DataControlField In lColumns
            If field.SortExpression.StartsWith(sColumnName) Then
                Return lColumns.IndexOf(field)
            End If
        Next
        Return -1
    End Function

    ''' <summary>
    ''' Common function to set up standard functionality in GridViews.
    '''  - Add up/down arrow for sorting
    ''' </summary>
    ''' <param name="ctlGridView">Control to set up</param>
    ''' <param name="sProfileName">Name of profile entry storing options for this grid. Leave empty to not store sort info.</param>
    ''' <remarks></remarks>
    Public Shared Sub SetupGrid(ByRef ctlGridView As GridView,
         Optional ByVal sProfileName As String = "")
        '
        ' Set up sorting from profile if required
        '
        SetupGridSorting(ctlGridView, sProfileName)
        '
        ' Set up handler to show image for sort direction next to sort column header
        '
        AddHandler ctlGridView.RowCreated, AddressOf GridViewSortImages
        '
        ' Set up row styles
        '
        ctlGridView.AlternatingRowStyle.CssClass = "Gridviewrowsstylealternate"
        ctlGridView.GridLines = GridLines.None          ' not required with alternating row styles
        ctlGridView.SelectedRowStyle.CssClass = "selectedrowsstyle"
        ctlGridView.HeaderStyle.CssClass = "Gridviewheaderstyle"
        ctlGridView.RowStyle.CssClass = "Gridviewrowsstyle"
        '
        ' Footer styles
        '
        ctlGridView.FooterStyle.BackColor = System.Drawing.Color.White
        ctlGridView.FooterStyle.ForeColor = System.Drawing.ColorTranslator.FromHtml("#00529B")
        ctlGridView.FooterStyle.HorizontalAlign = HorizontalAlign.Right
        '
        ' List of page styles
        '
        ctlGridView.PagerStyle.HorizontalAlign = HorizontalAlign.Right
        ctlGridView.PagerStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#E1EFFF")
        ctlGridView.PagerStyle.ForeColor = System.Drawing.ColorTranslator.FromHtml("#00529B")
        '
        ' Spacing of cells. Cellspacing puts a gap between all cells in the table which
        ' helps to line columns up vertically. Call padding isn't so useful. 
        '
        ctlGridView.CellSpacing = 2
        ctlGridView.CellPadding = 0
        '
        ' Find the Command column and change its style
        '
        Dim lColumns As DataControlFieldCollection = ctlGridView.Columns
        For Each field As DataControlField In lColumns
            If TypeOf field Is CommandField AndAlso CType(field, CommandField).ControlStyle.CssClass = String.Empty Then
                CType(field, CommandField).ControlStyle.CssClass = "EITSButton"
            End If
        Next
        '
        ' Text to show if text is empty
        '
        ctlGridView.EmptyDataText = "No records were found."
    End Sub

    ''' <summary>
    ''' Set up sorting from the profile
    ''' </summary>
    ''' <param name="ctlGridView">Gridview with sorting to be stored</param>
    ''' <param name="sProfileName">Profile name to use</param>
    ''' <remarks></remarks>
    Public Shared Sub SetupGridSorting(ByRef ctlGridView As GridView,
         ByVal sProfileName As String)
        If sProfileName.Length > 0 Then
            '
            ' If it's not a postback then set up initial sorting for the grid from 
            ' the profile.
            '
            If Not ctlGridView.Page.IsPostBack Then
                Dim Profile As CEITSProfile = CEITSProfile.GetProfile(ctlGridView.Page.Session)
                Dim oSortDirection As SortDirection = Profile.GetValue(sProfileName & ".SortDir")
                Dim sSortExpression As String = Profile.GetValue(sProfileName & ".SortExp")
                '
                ' Check if the field still exists in the grid.
                '
                If GetGridViewColumnIndex(sSortExpression, ctlGridView.Columns) = -1 Then
                    sSortExpression = String.Empty
                End If
                '
                ' Set sort direction. Control may not be visible so
                ' let any exceptions, typically caused by Sorting event not being handled, just fire.
                '
                Try
                    ctlGridView.Sort(sSortExpression, oSortDirection)
                Catch ex As System.Web.HttpException
                End Try
            End If
            '
            ' Set up pre-render handler to remember what the new settings are.
            ' This is done here because there may have been a click on a heading for a
            ' column to change sort order. That won't be reflected in the control until the
            ' click is handled, in code after page load.
            '
            ' The pre-render event fires after all postbacks have been handled, so the 
            ' control has the correct sort settings. We save it to the profile at that point.
            '
            ' Note that the Master page has a handler for the Unload event to save the profile
            ' to the database if it has changed. That is *after* the preload event.
            '
            ' We just use a custom attribute to remember the profile string.
            '
            ctlGridView.Attributes("EITSProfileName") = sProfileName
            AddHandler ctlGridView.PreRender, AddressOf GridViewStoreProfile ' add a pre-render handler
        End If
    End Sub


    ''' <summary>
    ''' Show sort image in gridview header. Call in RowCreated function of GridView.
    ''' Taken from http://forums.asp.net/t/1412417.aspx
    ''' </summary>
    ''' <param name="sender">Gridview being modified</param>
    ''' <param name="e">Row event arguments.</param>
    ''' <remarks></remarks>
    Public Shared Sub GridViewSortImages(ByVal sender As Object, ByVal e As GridViewRowEventArgs)
        Dim senderGridView As GridView = CType(sender, GridView)

        If Not (e.Row Is Nothing) AndAlso e.Row.RowType = DataControlRowType.Header Then
            For Each cell As TableCell In e.Row.Cells
                If cell.HasControls Then
                    Dim button As LinkButton = CType((cell.Controls(0)), LinkButton)
                    If Not (button Is Nothing) Then
                        Dim image As New System.Web.UI.WebControls.Image
                        image.ImageUrl = "~/images/sortnone.gif"
                        If senderGridView.SortExpression = button.CommandArgument Then
                            If senderGridView.SortDirection = SortDirection.Ascending Then
                                image.ImageUrl = "~/images/sortascending.gif"
                            Else
                                image.ImageUrl = "~/images/sortdescending.gif"
                            End If
                            cell.BackColor = Drawing.ColorTranslator.FromHtml("#D0E0F0")
                        End If
                        cell.Controls.Add(image)
                    End If
                Else
                    '
                    ' No sorting hotlinks, check if there is no text in the title.
                    '
                    If cell.Text = String.Empty OrElse cell.Text = "&nbsp;" Then
                        cell.BackColor = Drawing.ColorTranslator.FromHtml("#FFFFFF") ' no text so set to white
                    End If
                End If
            Next
        End If
    End Sub

    ''' <summary>
    ''' Store profile information. We have to do this after processing all the clicks etc
    ''' as a click on a hotlink in the header of a gridview column changes the sort order.
    ''' </summary>
    ''' <param name="sender">Gridview being modified</param>
    ''' <param name="e">Prerender event arguments.</param>
    ''' <remarks></remarks>
    Public Shared Sub GridViewStoreProfile(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim GV As GridView = CType(sender, GridView)
        Dim Profile As CEITSProfile = CEITSProfile.GetProfile(GV.Page.Session)
        Dim sProfileName As String = GV.Attributes("EITSProfileName")
        '
        ' Store profile values.
        '
        Profile.SetValue(sProfileName & ".SortDir", GV.SortDirection())
        Profile.SetValue(sProfileName & ".SortExp", GV.SortExpression())
    End Sub

    ''' <summary>
    ''' Download a file. This overwrites the response for the page.
    ''' </summary>
    ''' <param name="Response">Page response object.</param>
    ''' <param name="sContents">Contents to send</param>
    ''' <param name="sFilename">Filename to use</param>
    ''' <param name="sContentType">Content type, default is for Excel</param>
    ''' <remarks></remarks>
    Public Shared Sub WriteDownloadFile(ByRef Response As System.Web.HttpResponse,
          ByVal sContents As String,
          ByVal sFilename As String,
          Optional ByVal sContentType As String = "application/vnd.ms-excel")
        '
        ' Set up for download
        '
        Response.Buffer = True
        Response.ClearContent()
        Response.ClearHeaders()
        Response.ContentType = sContentType
        Response.AddHeader("content-disposition", "attachment; filename = " & sFilename)
        '
        ' Write the contents
        '
        Response.Write(sContents)
        '
        ' Terminate the download
        '
        Response.End()
    End Sub

    ''' <summary>
    ''' Convert datatable to CSV dump. Strings are quoted (with embedded quotes handled OK), null dates are handled
    ''' </summary>
    ''' <param name="table">Table to dump. All rows are given</param>
    ''' <returns>CSV string.</returns>
    ''' <remarks></remarks>
    Public Shared Function ToCSV(ByVal table As DataTable) As String
        Dim sbCSV As New StringBuilder
        '
        ' Put in the headers
        '
        For i As Integer = 0 To table.Columns.Count - 1
            If i > 0 Then
                sbCSV.Append(",")
            End If
            sbCSV.Append(table.Columns(i).ColumnName)
        Next
        sbCSV.Append(vbCrLf)
        '
        ' Now the data
        '
        For Each Row As System.Data.DataRow In table.Rows
            For i As Integer = 0 To table.Columns.Count - 1
                If i > 0 Then
                    sbCSV.Append(",")
                End If
                '
                ' Look carefully at the datatype and convert things properly.
                '
                Dim ColValue As Object = Row(i)
                Dim sValue As String = ""

                If ColValue.GetType() Is GetType(DateTime) Then
                    Try
                        sValue = CType(ColValue, DateTime).ToString("dd MMM yyyy HH:mm:ss")
                    Catch ex As System.Data.StrongTypingException
                        '
                        ' The date value must be DBNull but there's no way of testing it
                        ' so just depend on this exception!
                        '
                    End Try
                ElseIf ColValue.GetType() Is GetType(String) Then
                    sValue = """" & ColValue.ToString().Replace("""", """""") & """"
                ElseIf ColValue.GetType() Is GetType(Boolean) Then
                    sValue = Math.Abs(CInt(Row(i))).ToString()
                Else
                    sValue = ColValue.ToString()
                End If
                sbCSV.Append(sValue)
            Next
            sbCSV.Append(vbCrLf)
        Next

        Return sbCSV.ToString()
    End Function
    ''' <summary>
    ''' Log an Api error
    ''' </summary>
    ''' <param name="nType">Type - 0 = API, 1 = Download failure, 2 = Exception (more detail in email)</param>
    ''' <param name="sLogCode">Secondary code</param>
    ''' <param name="sLogMessage">Message</param>
    ''' <param name="Request">Request that generated failure</param>
    ''' <remarks></remarks>
    Public Shared Sub LogErrorToDatabase(ByVal nType As Integer, ByVal sLogCode As String, ByVal sLogMessage As String, ByVal Request As System.Web.HttpRequest)
        '
        ' Log a response error. Any problems are just ignored.
        '
        Try
            '
            ' Get the request string including request type and requested to
            '
            Dim sRequest As String = GetRequestString()
            '
            ' And the IP address
            '
            Dim sClientIPAddress As String = GetClientIP()
            '
            ' Insert log record
            '
            Dim taLogs As New ITSPTableAdapters.LogTableAdapter
            '
            ' Ensure that all strings will fit in case something big is passed in.
            '
            sClientIPAddress = sClientIPAddress.Substring(0, Math.Min(sClientIPAddress.Length, 50))
            sLogCode = sLogCode.Substring(0, Math.Min(sLogCode.Length, 20))
            sLogMessage = sLogMessage.Substring(0, Math.Min(sLogMessage.Length, 250))
            sRequest = sRequest.Substring(0, Math.Min(sRequest.Length, 1000))
            taLogs.Insert(nType, Date.UtcNow(), sClientIPAddress, sLogCode, sLogMessage, sRequest)
        Catch ex As Exception

        End Try
    End Sub


    Public Shared Sub CheckProgressForCompletion(ByVal nProgressID As Integer, ByVal nCandidateID As Integer, ByVal nCentreID As Integer)
        Dim taQ As New LearnMenuTableAdapters.QueriesTableAdapter
        If taQ.CheckIfComplete(nProgressID) = 0 Then
            Dim nCompStatus As Int32 = 2
            nCompStatus = taQ.GetAndReturnCompletionStatusByProgID(nProgressID)
            If nCompStatus > 0 Then
                Dim sNotifyEmail = taQ.GetNotifyEmailForProgress(nProgressID)
                Dim taDelegate As New LearnMenuTableAdapters.CandidatesTableAdapter
                Dim tDelegate As New LearnMenu.CandidatesDataTable
                tDelegate = taDelegate.GetByCandidateID(nCandidateID)
                Dim sCC As String = taQ.GetAdminCCEmail(nProgressID)
                If sCC.Length > 0 Then
                    If sNotifyEmail.Length > 0 Then
                        sCC = sCC & ";" & sNotifyEmail
                    End If
                Else
                    sCC = sNotifyEmail
                End If
                taQ.MarkProgComplete(nProgressID)
                'mark any related learning log items complete (and get the count):
                Dim nLogItemsCompleted As Integer = taQ.UpdateLearningLogItemsMarkCompleteForRelatedCourseCompletion(nProgressID)
                'get the course name:
                Dim sCourse As String = taQ.GetCourseNameByProgressID(nProgressID)
                'Now, let's get rid of the average time info if it's present:
                If sCourse.EndsWith(")") Then
                    sCourse = sCourse.Substring(0, sCourse.LastIndexOf("("))
                End If
                Dim sURL As String = My.Settings.ITSPTrackingURL & "finalise" &
                   "?SessionID=" & taQ.GetLastSessionIDByProgress(nProgressID) &
                   "&ProgressID=" & nProgressID.ToString &
                   "&UserCentreID=" & nCentreID.ToString
                Dim sbBody As New StringBuilder
                sbBody.Append("<body style=""font-family: Calibri; font-size: small;"">")
                sbBody.Append("<p>Dear " & tDelegate.First.FirstName & ",</p>")
                sbBody.Append("<p>You have completed the Digital Learning Solutions learning activity - " & sCourse & "</p>")
                If nCompStatus = 2 Then
                    sbBody.Append("<p>To evaluate the activity and access your certificate of completion, click <a href=""" & sURL & """>here</a>.</p>")
                Else
                    sbBody.Append("<p>If you haven't already done so, please evaluate the activity to help us to improve provision for future delegates by clicking <a href=""" & sURL & """>here</a>. Only one evaluation can be submitted per completion.</p>")
                End If
                If nLogItemsCompleted > 0 Then
                    sbBody.Append("<p>This activity is related to <b>" & nLogItemsCompleted.ToString & "</b> planned development log actions in other activities in your Learning Portal. These have automatically been marked as complete.</p>")
                End If
                If sCC.Length > 2 Then
                    sbBody.Append("<p><b>Note:</b> This message has been copied to the administrator(s) managing this activity, for their information.</p>")
                End If
                sbBody.Append("</body>")
                CCommon.SendEmail(tDelegate.First.EmailAddress, "Digital Learning Solutions Activity Complete", sbBody.ToString(), True,, sCC,, 11, nCandidateID)
            End If
        End If
    End Sub
    Public Shared Sub PopDDListFromReturnSeparatedString(ByVal sListString, ByVal cDDList, Optional ByVal sAny = "--Select--")
        cDDList.Items.Clear()
        cDDList.Items.Add(New ListItem(sAny, ""))
        Dim ddFieldArray() As String
        ddFieldArray = sListString.Split(New String() {vbCr & vbLf, vbLf}, StringSplitOptions.None)
        For Each ch In ddFieldArray
            cDDList.Items.Add(New ListItem(ch, ch))
        Next
    End Sub

#End Region
    '------------------------------------------------------------------------------
    ' Parameter handling
    '
    ' Used for verifying and manipulating tracker API parameters.
    '------------------------------------------------------------------------------
#Region "ParameterHandling"

    ''' <summary>
    ''' Return candidate record given candidate number
    ''' </summary>
    ''' <param name="sCandidateNumber">Candidate number e.g. KW1234 or "KW1234"</param>
    ''' <param name="bActiveOnly">Whether only Active candidates are to be returned</param>
    ''' <returns>Candidate record</returns>
    ''' <remarks>Throws an exception if there are no matching records</remarks>
    Public Shared Function GetCandidate(ByRef sCandidateNumber As String, Optional ByVal bActiveOnly As Boolean = False) As ITSP.CandidatesRow
        Dim CandidateQueriesAdapter As New ITSPTableAdapters.CandidatesTableAdapter()
        Dim tCandidates As ITSP.CandidatesDataTable

        sCandidateNumber = CCommon.ConvertQuotedParameter(sCandidateNumber)
        If bActiveOnly Then
            tCandidates = CandidateQueriesAdapter.GetActiveCandidateByID(sCandidateNumber)
        Else
            tCandidates = CandidateQueriesAdapter.GetCandidateByID(sCandidateNumber)
        End If
        Select Case tCandidates.Count()
            Case 0
                Throw New ApplicationException("sCandidateNumber not found")
            Case 1
                Return tCandidates.First
            Case Else
                Throw New ApplicationException("sCandidateNumber duplicated")
        End Select
    End Function

    ''' <summary>
    ''' Convert a quoted parameter to a non-quoted parameter
    ''' </summary>
    ''' <param name="sQuotedParameter">Quoted parameter</param>
    ''' <returns>Parameter without quotes</returns>
    ''' <remarks></remarks>
    Public Shared Function ConvertQuotedParameter(ByVal sQuotedParameter As String) As String
        '
        ' Check for nothing first
        '
        If sQuotedParameter Is Nothing OrElse sQuotedParameter = String.Empty Then
            Return String.Empty
        End If
        '
        ' OK, check if it's quoted
        '
        Dim nStartIndex As Integer = 0
        Dim nEndIndex As Integer = sQuotedParameter.Length

        If sQuotedParameter.StartsWith("""") AndAlso sQuotedParameter.EndsWith("""") Then
            If sQuotedParameter.Length = 1 Then
                Return String.Empty                         ' only a single quote - assume empty content
            End If
            nStartIndex = 1                                         ' don't include quotes in returned value
            nEndIndex -= 1
        End If
        Return sQuotedParameter.Substring(nStartIndex, nEndIndex - nStartIndex)
    End Function
#End Region
#Region "Candidates"

    ''' <summary>
    ''' Helper class to log candidate problems
    ''' </summary>
    ''' <remarks></remarks>
    Public Class CandidateException
        Inherits ApplicationException
        '
        ' Type of the exception
        '
        Protected _nType As Integer

        Property Type() As Integer
            Get
                Return _nType
            End Get
            Set(ByVal value As Integer)
                _nType = value
            End Set
        End Property

        ''' <summary>
        ''' Used to create an exception containing type and message
        ''' </summary>
        ''' <param name="nType">Type of problem</param>
        ''' <param name="sMessage">Message to show</param>
        ''' <remarks></remarks>
        Public Sub New(ByVal nType As Integer, ByVal sMessage As String)
            MyBase.New(sMessage)
            _nType = nType
        End Sub

    End Class

    ''' <summary>
    ''' Save a new candidate record.
    ''' </summary>
    ''' <param name="nCentreID">Centre ID</param>
    ''' <param name="sFirstName">First name of candidate</param>
    ''' <param name="sLastName">Last name of candidate</param>
    ''' <param name="nJobGroupID">Job Group</param>
    ''' <param name="bActive">Active?</param>
    ''' <param name="sAnswer1">Answer to first centre question</param>
    ''' <param name="sAnswer2">Answer to second centre question</param>
    ''' <param name="sAnswer3">Answer to third centre question</param>
    ''' <param name="sAliasID">Alias ID for this delegate</param>
    ''' <returns>New candidate number</returns>
    ''' <remarks>We use stored procedure to handle locking of the tables etc.</remarks>
    Public Shared Function SaveNewCandidate(ByVal nCentreID As Integer, ByVal sFirstName As String, ByVal sLastName As String, ByVal nJobGroupID As Integer, ByVal bActive As Boolean,
         ByVal sAnswer1 As String, ByVal sAnswer2 As String, ByVal sAnswer3 As String,
         ByVal sAnswer4 As String, ByVal sAnswer5 As String, ByVal sAnswer6 As String,
         ByVal sAliasID As String, ByVal bApproved As Boolean, ByVal sEmail As String, ByVal bExternalReg As Boolean, ByVal bSelfReg As Boolean, ByVal dNotifyDate As DateTime, Optional ByVal bBulk As Boolean = False, Optional ByVal bRaiseError As Boolean = True) As String
        Dim candidatesAdapter As New ITSPTableAdapters.CandidatesTableAdapter()
        Dim sCandidateNumber As String

        sCandidateNumber = candidatesAdapter.SaveNewCandidate(nCentreID, sFirstName, sLastName, nJobGroupID,
                 bActive, sAnswer1, sAnswer2, sAnswer3, sAnswer4, sAnswer5, sAnswer6, sAliasID, bApproved, sEmail, bExternalReg, bSelfReg, dNotifyDate, bBulk)
        If bRaiseError Then
            Select Case sCandidateNumber
                Case "-1"
                    Throw New CandidateException(-1, "Unexpected error")
                Case "-2"
                    Throw New CandidateException(-2, "FirstName, LastName and JobGroupID are required. JobGroupID must be between 1 and 14")
                Case "-3"
                    Throw New CandidateException(-3, "AliasID not unique for Centre")
                Case "-4"
                    Throw New CandidateException(-4, "The e-mail address provided is not unique for Centre")
            End Select
        End If

        Return sCandidateNumber
    End Function
#End Region
#Region "AdminSessions"

    ''' <summary>
    ''' Create new Admin User session
    ''' </summary>
    ''' <param name="nAdminID">AdminUserID</param>
    ''' <returns>Admin User Session ID</returns>
    ''' <remarks></remarks>
    Public Shared Function CreateAdminUserSession(ByVal nAdminID As Integer) As Integer
        Dim AdminSessionsAdapter As New ITSPTableAdapters.AdminSessionsTableAdapter()
        '
        ' Create the new session. Note that this query kills off any
        ' old sessions for the user.
        '
        Return CInt(AdminSessionsAdapter.NewSessionAndGetID(nAdminID))
    End Function
    Public Shared Function GetSessionID() As String
        'Dim context As System.Web.HttpContext = System.Web.HttpContext.Current
        'Dim ReturnVal As String = ""
        'Dim cookie = context.Request.Cookies("ASP.NET_SessionId")
        'If cookie IsNot Nothing Then
        '	ReturnVal = cookie.Value
        'Else
        '	Dim url = context.Request.Url.ToString()
        '	Dim start As Integer = url.LastIndexOf("S(")
        '	Dim finish As Integer = url.IndexOf("))")
        '	If start <> -1 AndAlso finish <> -1 Then
        '		ReturnVal = url.Substring(start + 1, finish - start - 1)
        '	End If
        'End If
        Return System.Web.HttpContext.Current.Session.SessionID
    End Function

    Public Shared Sub AdminUserLogout()
        Dim context As System.Web.HttpContext = System.Web.HttpContext.Current
        '
        ' Close the admin user's session
        '
        Dim sSessionID As String = GetSessionID()
        Dim taSessionHash As New ITSPTableAdapters.SessionHashTableAdapter
        taSessionHash.DeleteBySessionID(sSessionID)
        If Not context.Session Is Nothing Then
            If Not context.Session("UserAdminSessionID") Is Nothing Then
                UpdateAdminUserSession(context.Session("UserAdminSessionID"), False)
            End If
            '
            ' Clear the session cookie and kill off the session.
            '
            context.Session.Clear()
            context.Session.Abandon()
        End If
        If Not context.Request.Cookies("ASP.NET_SessionId") Is Nothing Then
            context.Response.Cookies("ASP.NET_SessionId").Expires = DateTime.Now.AddYears(-30)
        End If
        If context.Request.IsAuthenticated Then
            Dim cp As ClaimsPrincipal = context.User
            If Not cp.HasClaim(Function(c) c.Type = "iss") Then
                context.GetOwinContext().Authentication.SignOut(CookieAuthenticationDefaults.AuthenticationType)
            Else
                context.GetOwinContext().Authentication.SignOut(OpenIdConnectAuthenticationDefaults.AuthenticationType, CookieAuthenticationDefaults.AuthenticationType)
            End If

            DLS.Helpers.SDKHelper.SignOutClient()
        End If


    End Sub
    ''' <summary>
    ''' Update Admin User session
    ''' </summary>
    ''' <param name="nAdminSessionID">Admin session ID</param>
    ''' <remarks></remarks>
    Public Shared Sub UpdateAdminUserSession(ByVal nAdminSessionID As Integer, ByVal bLoggedIn As Boolean)
        Dim AdminSessionsAdapter As New ITSPTableAdapters.AdminSessionsTableAdapter()
        '
        ' Update the new session duration.
        '
        AdminSessionsAdapter.UpdateSession(nAdminSessionID, bLoggedIn)
    End Sub

#End Region
#Region "JSON encoding"
    Public Shared Function ConvertDataTabletoString(ByVal dt As DataTable) As String

        Dim serializer As New System.Web.Script.Serialization.JavaScriptSerializer()
        Dim rows As New List(Of Dictionary(Of String, Object))()
        Dim row As Dictionary(Of String, Object)
        For Each dr As DataRow In dt.Rows
            row = New Dictionary(Of String, Object)()
            For Each col As DataColumn In dt.Columns
                row.Add(col.ColumnName, dr(col))
            Next
            rows.Add(row)
        Next
        Dim sSerialized As String = serializer.Serialize(rows)
        sSerialized = sSerialized.Replace("{""", "{")
        sSerialized = sSerialized.Replace(""":", ":")
        sSerialized = sSerialized.Replace(",""", ",")
        sSerialized = sSerialized.Replace("""", "'")
        sSerialized = sSerialized.Replace(",", ", ")
        sSerialized = sSerialized.Replace(":", ": ")
        Return sSerialized
    End Function
    Public Shared Function ConvertDataTabletoJSONString(ByVal dt As DataTable, Optional numcols As Integer = 0) As String

        Dim serializer As New System.Web.Script.Serialization.JavaScriptSerializer()
        Dim rows As New List(Of List(Of Object))
        Dim cols As New List(Of Object)
        If numcols < 1 Then
            numcols = dt.Columns.Count
        End If

        Dim i As Integer = 0

        While i < numcols
            cols.Add(dt.Columns.Item(i).ColumnName)
            i = i + 1
        End While
        rows.Add(cols)
        i = 0

        Dim row As List(Of Object)
        For Each dr As DataRow In dt.Rows
            row = New List(Of Object)
            While i < numcols
                row.Add(dr.Item(i))
                i = i + 1
            End While
            rows.Add(row)
            i = 0
        Next
        Return serializer.Serialize(rows).ToString
    End Function
    Public Shared Function DataTableToJSON(ByVal dt As DataTable) As String
        Dim serializer As New System.Web.Script.Serialization.JavaScriptSerializer()
        Dim rows As New List(Of Dictionary(Of String, Object))()
        Dim row As Dictionary(Of String, Object)
        For Each dr As DataRow In dt.Rows
            row = New Dictionary(Of String, Object)()
            For Each col As DataColumn In dt.Columns
                row.Add(col.ColumnName, dr(col))
            Next
            rows.Add(row)
        Next
        Return serializer.Serialize(rows)
    End Function
#End Region
#Region "Email and Outlook"
    Public Shared Function SendEmail(ByVal sToAddress As String,
      ByVal sSubject As String,
      ByVal sBody As String,
      ByVal bIsHTML As Boolean,
      Optional ByVal sFromAddress As String = "",
      Optional ByVal sCC As String = "",
      Optional ByVal sBCC As String = "", Optional ByVal nNotificationID As Integer = 0, Optional ByVal nUserID As Integer = 0, Optional sReplyTo As String = "", Optional sCalendar As String = "") As Boolean
        If nNotificationID > 0 And nUserID > 0 Then
            Dim taq As New NotificationsTableAdapters.QueriesTableAdapter
            If taq.CheckNotificationForUser(nNotificationID, nUserID) = 0 Then
                Return False
                Exit Function
            End If
        End If
        Dim Msg As New Mail.MailMessage()
        Dim IsDelivered As Boolean = False
        If sFromAddress = "" Then sFromAddress = CCommon.GetConfigString("MailFromAddress")
        '
        ' Set up addresses
        ' Note that From address is fixed as only emails sent from nhselite.org will get through
        ' the NHS mail spam filter.
        '
        If sToAddress.Length < 4 Then
            Return False
        End If
        Msg.From = New Mail.MailAddress(sFromAddress)
        Msg.To.Add(New Mail.MailAddress(sToAddress))
        If Not sCC Is String.Empty Then
            Dim listCC() As String
            listCC = sCC.Split(New String() {";"c}, StringSplitOptions.RemoveEmptyEntries)
            For Each sAdd In listCC
                Msg.CC.Add(New Mail.MailAddress(sAdd.Trim()))
            Next
        End If
        If Not sBCC Is String.Empty Then
            Msg.Bcc.Add(New Mail.MailAddress(sBCC))
        End If
        If Not sReplyTo Is String.Empty Then
            Msg.ReplyToList.Add(New Mail.MailAddress(sReplyTo))
        End If
        '
        ' Set up content etc.
        '
        Msg.Subject = sSubject
        Msg.IsBodyHtml = bIsHTML
        Msg.Priority = Mail.MailPriority.Normal
        If bIsHTML Then
            '
            ' Set up proper HTML content
            '
            Msg.Body = sBody                                ' non-HTML message - they might be able to get something out of this!
            Dim avHTML As Mail.AlternateView = Mail.AlternateView.CreateAlternateViewFromString(sBody, System.Text.Encoding.Default,
              System.Net.Mime.MediaTypeNames.Text.Html)

            Msg.AlternateViews.Add(avHTML)
        Else
            Msg.Body = sBody                                ' not HTML content, just put it in
        End If
        'Check if a calendar invite is included:
        If sCalendar.Length > 0 Then
            Dim ct As Net.Mime.ContentType = New System.Net.Mime.ContentType("text/calendar")
            ct.Parameters.Add("method", "REQUEST")
            ct.Parameters.Add("name", "DLS_Appointment.ics")
            Dim avCal As Mail.AlternateView = Mail.AlternateView.CreateAlternateViewFromString(sCalendar.ToString(), ct)
            Msg.AlternateViews.Add(avCal)
        End If


        '
        ' Open up the email client. Have to use the correct address
        '
        Dim client As Mail.SmtpClient
        Dim myIPs As System.Net.IPHostEntry = System.Net.Dns.GetHostEntry("")
        Dim myIP As System.Net.IPAddress = myIPs.AddressList.First()
        '
        ' Decide whether to use local IP address or not.
        ' NHS network runs on the 10.x.x.x addresses.
        ' The first IP address from the Bytehouse server is an IP6 address, so 
        ' assume that if it isn't local, use the Bytehouse hosting IP address.
        '
        If myIP.ToString.StartsWith("10.") Then
            client = New Mail.SmtpClient(myIP.ToString(), 25)
        Else
            client = New Mail.SmtpClient(CCommon.GetConfigString("MailServer"), CCommon.GetConfigString("MailPort"))
        End If

        client.DeliveryMethod = Mail.SmtpDeliveryMethod.Network
        client.Credentials = New NetworkCredential(CCommon.GetConfigString("MailUsername"), CCommon.GetConfigString("MailPW"))
        'client.UseDefaultCredentials = False
        client.Timeout = 10000
        '
        ' Send the email
        '
        Try
            Dim sHost = HttpContext.Current.Request.Url.Host
            If sHost = "localhost" Then
                IsDelivered = True
            Else
                client.Send(Msg)
                IsDelivered = True
            End If
        Catch ex As Exception
            '
            ' Don't retry as probably it won't work, and we don't want to hold up the application too much
            '
            Throw
        Finally
            Msg = Nothing
        End Try

        Return IsDelivered
    End Function
    ''' <summary>
    ''' Log exception error to email
    ''' </summary>
    ''' <param name="exp">Exception to log</param>
    ''' <remarks>Doesn't use the database</remarks>
    Public Shared Sub LogErrorToEmail(ByVal exp As Exception)
        '
        ' Decide whether an error message should be sent.
        ' Default is Yes.
        '
        Dim bLogError As Boolean = True

        Try
            bLogError = Boolean.Parse(ConfigurationManager.AppSettings("EnableErrorLogEmail"))
        Catch ex As Exception
        End Try

        If Not bLogError Then
            Return                                                          ' error email logging is turned off
        End If
        '
        ' Decide who it should be sent to. Default values are set here
        ' in case the values are not in web.config.
        '
        Dim sTo As String = "kevin.whittaker@hee.nhs.uk"
        Dim sCC As String = "kevin.whittaker1@nhs.net"

        Try
            Dim sTestTo As String
            sTestTo = ConfigurationManager.AppSettings("ErrorLogEmailTo")
            If Not sTestTo Is Nothing Then
                sTo = sTestTo
            End If
        Catch ex As Exception
        End Try
        Try
            Dim sTestCC As String
            sTestCC = ConfigurationManager.AppSettings("ErrorLogEmailCC")
            If Not sTestCC Is Nothing Then
                sCC = sTestCC
            End If
        Catch ex As Exception
        End Try
        '
        ' Have addressing information, proceed with getting the error message and sending it.
        ' Any unexpected exceptions causes the error message to be truncated. We send what we can
        '
        Dim errorMessage As New StringBuilder
        Try
            '
            ' Build the error message
            '
            Dim context As System.Web.HttpContext = System.Web.HttpContext.Current

            errorMessage.Append("<b>DLS Error Report</b> generated on " + DateTime.Now.ToString("dd MMMM yyyy HH:mm:ss"))
            errorMessage.Append("<br/><br/><b>Message:</b> " + exp.Message)
            errorMessage.Append("<br/><br/><b>Page location:</b> " + context.Request.RawUrl)
            errorMessage.Append("<br/><br/><b>Source:</b> " + exp.Source)
            errorMessage.Append("<br/><br/><b>Client Details:</b>")
            errorMessage.Append("<br/><div style='margin-left:50px;'><b>IP:</b> " + GetClientIP())
            If Not context.Session("UserAdminID") Is Nothing Then
                errorMessage.Append("<br/><b>Centre:</b> " + context.Session("UserCentreName"))
                errorMessage.Append("<br/><b>Centre ID:</b> " + context.Session("UserCentreID").ToString)
                errorMessage.Append("<br/><b>User:</b> " + context.Session("UserForename") + " " + context.Session("UserSurname"))
                errorMessage.Append("<br/><b>Login:</b> " + context.Session("UserName"))
                errorMessage.Append("<br/><b>Email:</b> " + context.Session("UserEmail"))
                errorMessage.Append("<br/><b>Admin ID:</b> " + context.Session("UserAdminID").ToString)
            Else
                errorMessage.Append("<br/>User not logged in.")
            End If
            errorMessage.Append("</div>")

            Try
                errorMessage.Append("<br/><br/><b>More details:</b> <br/><br/>" + exp.InnerException.Message)
            Catch ex As Exception
            End Try

            errorMessage.Append("<br/><br/><b>Request:</b><br/><div style='margin-left:50px;'>" + GetRequestString() + "</div>")
            errorMessage.Append("<br/><b>Method:</b> " + exp.TargetSite.ToString)
            errorMessage.Append("<br/><br/><b>Stack trace:</b><br/><div style='margin-left:50px;'>" + exp.StackTrace.Replace(vbCrLf, "<br/>") + "</div>")
        Finally
        End Try
        '
        ' OK, send what we've got
        '
        Try
            '
            ' Send the error message
            '
            SendEmail(sTo, "DLS Error Report", errorMessage.ToString, True, sCC:=sCC)
        Catch ex As Exception
        End Try
    End Sub
    Public Shared Sub DownloadCalendarEntry(ByVal dttStartTime As DateTime, ByVal dttEndTime As DateTime, ByVal sOrganiserEmail As String, ByVal sVenue As String, ByVal sSummary As String, ByVal sDescription As String, ByVal sDescHtml As String, ByVal sGUID As String, ByVal nDayAlarm As Integer, ByVal nHourAlarm As Integer, ByVal nMinuteAlarm As Integer, ByVal bAllDay As Boolean, ByVal sFileName As String)
        Dim dtFormat As String = "yyyyMMddTHHmmssZ"
        Dim dOnlyFormat As String = "yyyyMMdd"
        Dim sb As StringBuilder = GetVCalendarString(dttStartTime, dttEndTime, sOrganiserEmail, sVenue, sSummary, sDescription, sDescHtml, sGUID, nDayAlarm, nHourAlarm, nMinuteAlarm, bAllDay)
        HttpContext.Current.Response.Clear()
        HttpContext.Current.Response.Charset = ""
        HttpContext.Current.Response.ContentType = "text/calendar"
        HttpContext.Current.Response.AddHeader("content-disposition", "attachment; filename=" & sFileName.Replace(" ", "") & ".ics")
        HttpContext.Current.Response.Write(sb)
        Try
            HttpContext.Current.Response.Flush()    ' this can generate HttpException if the remote host closes the connection
        Catch ex As HttpException
            Return                                  ' just ignore and finish
        End Try
        HttpContext.Current.Response.End()
    End Sub
    Public Shared Function GetVCalendarString(ByVal dttStartTime As DateTime, ByVal dttEndTime As DateTime, ByVal sOrganiserEmail As String, ByVal sVenue As String, ByVal sSummary As String, ByVal sDescription As String, ByVal sDescHtml As String, ByVal sGUID As String, ByVal nDayAlarm As Integer, ByVal nHourAlarm As Integer, ByVal nMinuteAlarm As Integer, ByVal bAllDay As Boolean, Optional ByVal sAttendees As String = "", Optional ByVal bCancel As Boolean = False, Optional ByVal bUpdate As Boolean = False, Optional ByVal nSeq As Integer = 0) As StringBuilder
        Dim dtFormat As String = "yyyyMMddTHHmmssZ"
        Dim dOnlyFormat As String = "yyyyMMdd"
        Dim sb As New StringBuilder()
        sb.Append("BEGIN:VCALENDAR" & vbCrLf)
        sb.Append("PRODID:-//Microsoft Corporation//Outlook 16.0 MIMEDIR//EN" & vbCrLf)
        sb.Append("VERSION:2.0" & vbCrLf)
        If bCancel Then
            sb.Append("STATUS:CANCELLED" & vbCrLf)
            sb.Append("METHOD:CANCEL" & vbCrLf)
        ElseIf sAttendees.Length > 0 Then
            sb.Append("METHOD:REQUEST" & vbCrLf)
        Else
            sb.Append("METHOD:PUBLISH" & vbCrLf)
        End If
        sb.Append("BEGIN:VTIMEZONE" & vbCrLf)
        sb.Append("TZID:GMT Standard Time" & vbCrLf)
        sb.Append("BEGIN:STANDARD" & vbCrLf)
        sb.Append("DTSTART:16011028T020000" & vbCrLf)
        sb.Append("RRULE:FREQ=YEARLY;BYDAY=-1SU;BYMONTH=10" & vbCrLf)
        sb.Append("TZOFFSETFROM:+0100" & vbCrLf)
        sb.Append("TZOFFSETTO:-0000" & vbCrLf)
        sb.Append("End:STANDARD" & vbCrLf)
        sb.Append("BEGIN:DAYLIGHT" & vbCrLf)
        sb.Append("DTSTART:16010325T010000" & vbCrLf)
        sb.Append("RRULE:FREQ=YEARLY;BYDAY=-1SU;BYMONTH=3" & vbCrLf)
        sb.Append("TZOFFSETFROM:-0000" & vbCrLf)
        sb.Append("TZOFFSETTO:+0100" & vbCrLf)
        sb.Append("End:DAYLIGHT" & vbCrLf)
        sb.Append("End:VTIMEZONE" & vbCrLf)
        sb.Append("BEGIN:VEVENT" & vbCrLf)
        sb.AppendFormat("ORGANIZER:MAILTO:{0}" & vbCrLf, sOrganiserEmail)

        'process attendees string:
        If sAttendees.Length > 0 Then
            Dim arrAtt As String() = sAttendees.Split(",")
            For Each satt As String In arrAtt
                sb.AppendFormat("ATTENDEE;RSVP=TRUE:mailto:{0}" & vbCrLf, satt)
            Next
        End If

        If bAllDay Then
            sb.AppendFormat("DTSTART;VALUE=DATE:{0}" & vbCrLf, dttStartTime.ToString(dOnlyFormat))
            sb.AppendFormat("DTEND;VALUE=DATE:{0}" & vbCrLf, dttEndTime.ToString(dOnlyFormat))
            sb.Append("X-MICROSOFT-CDO-BUSYSTATUS:FREE" & vbCrLf)
        Else
            sb.AppendFormat("DTSTART:{0}" & vbCrLf, dttStartTime.ToUniversalTime().ToString(dtFormat))
            sb.AppendFormat("DTEND:{0}" & vbCrLf, dttEndTime.ToUniversalTime().ToString(dtFormat))
        End If

        If sVenue.Length > 0 Then
            sb.AppendFormat("LOCATION:{0}" & vbCrLf, sVenue)
        End If
        sb.Append("TRANSP:OPAQUE" & vbCrLf)
        sb.AppendFormat("SEQUENCE:{0}" & vbCrLf, nSeq.ToString())
        sb.AppendFormat("UID:{0}" & vbCrLf, sGUID)
        sb.AppendFormat("DTSTAMP:{0}" & vbCrLf, DateTime.Now.ToUniversalTime.ToString(dtFormat))
        sb.AppendFormat("DESCRIPTION:{0}" & vbCrLf, sDescription)
        If sDescHtml.Length > 0 Then
            sb.AppendFormat("X-ALT-DESC;FMTTYPE=text/html:{0}" & vbCrLf, sDescHtml)
        End If
        sb.AppendFormat("SUMMARY;LANGUAGE=en-gb:{0}" & vbCrLf, sSummary)
        sb.AppendFormat("PRIORITY:{0}" & vbCrLf, 5)
        sb.Append("X-MICROSOFT-CDO-IMPORTANCE:1" & vbCrLf)
        sb.Append("CLASS:PUBLIC" & vbCrLf)
        '
        ' Reminder
        '
        sb.Append("BEGIN:VALARM" & vbCrLf)
        sb.AppendFormat("TRIGGER:-P{0}DT{1}H{2}M" & vbCrLf, nDayAlarm, nHourAlarm, nMinuteAlarm)
        If sAttendees.Length > 0 Then
            sb.Append("ACTION:Accept" & vbCrLf)
        Else
            sb.Append("ACTION:DISPLAY" & vbCrLf)
        End If
        sb.Append("DESCRIPTION:Reminder" & vbCrLf)
        If sAttendees.Length > 0 Then
            sb.Append("X-MICROSOFT-CDO-BUSYSTATUS:BUSY" & vbCrLf)
        End If
        sb.Append("END:VALARM" & vbCrLf)
        '
        ' End reminder
        '
        sb.Append("END:VEVENT" & vbCrLf)
        sb.Append("END:VCALENDAR" & vbCrLf)
        Return sb
    End Function
    Public Shared Function GetSupervisionSessionDesc(ByVal r As SuperviseData.SchedulerRow, ByVal sEmail As String, ByVal sAttendees As String, ByVal bReturnHTML As Boolean) As String
        Dim sUrl As String = ""
        Dim sAltURL As String = ""
        Dim sAttUrl As String = ""
        If Not r.IsCallUriNull Then
            If r.Label = 3 Then
                sUrl = My.Settings.MyURL & "sfb-session?uri=" & WebUtility.UrlEncode(r.CallUri)
                Dim sUname As String = r.CallUri.Substring(4, r.CallUri.IndexOf("@") - 4)
                Dim sID As String = r.CallUri.Substring(r.CallUri.LastIndexOf(":") + 1)
                sAltURL = "https://meet.nhs.net/" + sUname + "/" + sID
                sAttUrl = sUrl & "&attemail=" & WebUtility.UrlEncode(sEmail)
            Else
                sUrl = r.CallUri
                sAttUrl = sUrl
            End If
        End If
        Dim sSummary As String = "DLS Supervisor Scheduled Activity: " & r.Subject
        Dim taq As New SuperviseDataTableAdapters.QueriesTableAdapter
        Dim gICSGUID As Guid = taq.GetGUIDForLogItemID(r.UniqueID)
        Dim bAllDay As Boolean = False
        If r.StartDate.TimeOfDay.Ticks = 0 Then
            bAllDay = True
        End If
        Dim sbDesc As New StringBuilder()
        sbDesc.Append(sSummary & "\n\n")
        sbDesc.Append("Objectives/Agenda:\n")
        sbDesc.Append(r.Description & "\n\n")
        If sAttUrl.Length > 0 Then
            sbDesc.Append("To join your DLS supervision session, please use this link: " & sAttUrl)
            If r.Label = 3 Then
                sbDesc.Append("To join your session using the Skype for Business app or web app please use this link: " & sAltURL)
            End If
        End If
        Dim sbDescHtml As New StringBuilder()
        sbDescHtml.Append("<html><body>")
        sbDescHtml.AppendFormat("<h3>DLS Supervisor Scheduled Activity:</h3><h2>{0}</h2>", r.Subject)
        sbDescHtml.AppendFormat("<h3>Objectives/Agenda:</h3><p>{0}</p>", r.Description)
        If sAttUrl.Length > 0 Then
            sbDescHtml.AppendFormat("<p><a href='{0}'><span style=""font-size:13.5pt;font-family:'Segoe UI Semibold',sans-serif;color:#6264A7"">Join DLS Supervision Session</span></a></p>", sAttUrl)
            If r.Label = 3 Then
                sbDescHtml.AppendFormat("<p>Alternatively, <a href='{0}'>Join Using Skype for Business app</a>.</p>", sAltURL)
            End If
        End If

        sbDescHtml.Append("</body></html>")
        If bReturnHTML Then
            Return sbDescHtml.ToString()
        Else
            Return sbDesc.ToString()
        End If
    End Function
#End Region
#Region "PDFOutput"
    Public Shared Sub GeneratePDFFromURL(ByVal SUrl As String, ByVal SFname As String)
        Dim htmlToPdfConverter As New HtmlToPdf()

        ' set a demo serial number
        htmlToPdfConverter.SerialNumber = "x4+ulpej-oYuupbWm-tb7w6ffn-9uf05/7+-8uf09un2-9en+/v7+"


        ' convert HTML to PDF
        Dim pdfFile As String = Nothing
        Try

            ' convert URL

            Dim pdfBuffer() As Byte = Nothing
            htmlToPdfConverter.BrowserWidth = 750
            htmlToPdfConverter.Document.Margins = New PdfMargins(40)
            htmlToPdfConverter.MediaType = "print"
            pdfBuffer = htmlToPdfConverter.ConvertUrlToMemory(SUrl)
            HttpContext.Current.Response.AddHeader("Content-Type", "application/pdf")

            ' let the browser know how to open the PDF document
            Dim openMode As String = "attachment"

            HttpContext.Current.Response.AddHeader("Content-Disposition", String.Format("{0}; filename=" & SFname & "; size={1}", openMode, pdfBuffer.Length.ToString()))

            ' write the PDF buffer to HTTP response
            HttpContext.Current.Response.BinaryWrite(pdfBuffer)

            ' call End() method of HTTP response 
            ' to stop ASP.NET page processing
            HttpContext.Current.Response.End()


        Catch ex As Exception
            'MessageBox.Show([String].Format("Conversion failed. {0}", ex.Message))
            Return
        Finally
            'Cursor = Cursors.Arrow
        End Try
    End Sub
#End Region
#Region "String Manipulation"
    Private Shared CamelCaseRegex As New Regex("(?<=[a-z])(?=[A-Z])")

    Public Shared Function CamelCaseToHumanReadableString(ByRef inputString As String) As String

        Return String.Join(" ", CamelCaseRegex.Split(inputString))

    End Function
    Public Shared Function GetTruncatedString(ByVal sSource As String, ByVal MaxLength As Integer) As String
        Dim sReturn As String
        If sSource.Length > MaxLength Then
            sReturn = sSource.Substring(0, MaxLength - 3) + "..."
        Else
            sReturn = sSource
        End If
        Return sReturn
    End Function
    Public Shared Function GetPrettyDate(ByVal d As DateTime) As String
        Dim s As TimeSpan = DateTime.UtcNow.Subtract(d)
        Dim dayDiff As Integer = CInt(s.TotalDays)
        If dayDiff <= 1 Then
            Dim secDiff As Integer = CInt(s.TotalSeconds)
            If secDiff < 60 Then
                Return "just now"
            End If

            If secDiff < 120 Then
                Return "1 minute ago"
            End If

            If secDiff < 3600 Then
                Return String.Format("{0} minutes ago", Math.Floor(CDbl(secDiff) / 60))
            End If

            If secDiff < 7200 Then
                Return "1 hour ago"
            End If

            If secDiff < 86400 Then
                Return String.Format("{0} hours ago", Math.Floor(CDbl(secDiff) / 3600))
            End If
        End If


        If dayDiff < 0 Then
            Return "never"
        End If

        If dayDiff = 0 Then

            Return "right now"
        End If

        If dayDiff = 1 Then
            Return "yesterday"
        End If

        If dayDiff < 7 Then
            Return String.Format("{0} days ago", dayDiff)
        End If

        If dayDiff < 31 Then
            Return String.Format("{0} weeks ago", Math.Ceiling(CDbl(dayDiff) / 7))
        End If
        If dayDiff >= 31 And dayDiff <= 365 Then
            Return String.Format("{0} months ago", Math.Ceiling(CDbl(dayDiff) / 30))
        End If
        If dayDiff >= 365 And dayDiff < 3000 Then
            Return "more than a year ago"
        End If


        Return "never"
    End Function
    Public Shared Function TidyFileName(sFileName As String) As String
        For Each invalidChar In Path.GetInvalidFileNameChars
            sFileName = sFileName.Replace(invalidChar, "")
        Next
        sFileName = sFileName.Trim()
        sFileName = sFileName.Replace(" ", "_")
        Return sFileName
    End Function
    Public Shared Function TidyID(sInput As String) As String
        For Each invalidChar In Path.GetInvalidFileNameChars
            sInput = sInput.Replace(invalidChar, "")
        Next
        sInput = sInput.Trim()
        sInput = sInput.Replace(" ", "")
        sInput = sInput.Replace(".", "")
        sInput = sInput.Replace(",", "")
        Return sInput
    End Function
#End Region
#Region "Image Manipulation"
    Public Shared Function resizeImageFromMemoryStream(ByVal memstream As MemoryStream, ByVal maxwidth As Integer, ByVal maxheight As Integer) As MemoryStream
        Dim fullsizeImage As System.Drawing.Image = System.Drawing.Image.FromStream(memstream)
        Dim nHeight As Integer = fullsizeImage.Height

        Dim nWidth As Integer = fullsizeImage.Width
        If nWidth > maxwidth Or nHeight > maxheight Then
            Dim nNewWidth As Integer = nWidth
            Dim nNewHeight As Integer = nHeight
            If nNewHeight > maxwidth Then
                nNewWidth = CInt((CSng(maxwidth) / CSng(nHeight)) * CSng(nWidth))
                nNewHeight = maxwidth
            End If
            If nNewWidth > maxheight Then
                nNewHeight = CInt((CSng(maxheight) / CSng(nNewWidth)) * CSng(nNewHeight))
                nNewWidth = maxheight
            End If
            Dim newImage As System.Drawing.Image = fullsizeImage.GetThumbnailImage(nNewWidth, nNewHeight, Nothing, IntPtr.Zero)
            Dim myResult As New System.IO.MemoryStream()
            newImage.Save(myResult, System.Drawing.Imaging.ImageFormat.Jpeg)
            Return myResult
        End If
        Return memstream
    End Function
    Public Shared Function squareImageFromMemoryStream(ByVal memstream As MemoryStream) As MemoryStream
        Dim imgFromStream As System.Drawing.Image = System.Drawing.Image.FromStream(memstream)
        Dim nLength As Integer = imgFromStream.Height
        If imgFromStream.Height > imgFromStream.Width Then
            nLength = imgFromStream.Width
        End If
        Dim res As Bitmap = New Bitmap(nLength, nLength)
        Dim g As Graphics = Graphics.FromImage(res)
        g.FillRectangle(New SolidBrush(Color.White), 0, 0, nLength, nLength)
        Dim t As Integer = 0, l As Integer = 0
        If imgFromStream.Height > imgFromStream.Width Then
            t = (imgFromStream.Height - imgFromStream.Width) / 2
        Else
            l = (imgFromStream.Width - imgFromStream.Height) / 2
        End If
        g.DrawImage(imgFromStream, New Rectangle(0, 0, nLength, nLength), New Rectangle(l, t, imgFromStream.Width - l * 2, imgFromStream.Height - t * 2), GraphicsUnit.Pixel)
        Dim myResult As New System.IO.MemoryStream()
        res.Save(myResult, System.Drawing.Imaging.ImageFormat.Jpeg)
        Return myResult
    End Function
    Public Shared Function GetFileExtension(image As Image) As String
        Dim format As ImageFormat = image.RawFormat
        Dim fileExtension As String = ".jpeg"
        If ImageFormat.Bmp.Equals(format) Then
            fileExtension = ".bmp"
        ElseIf ImageFormat.Gif.Equals(format) Then
            fileExtension = ".gif"
        ElseIf ImageFormat.Png.Equals(format) Then
            fileExtension = ".png"
        End If
        Return fileExtension
    End Function
#End Region
#Region "File functions"
    Public Shared Function GetFolderSize(ByVal s As String) As Long

        Dim fileNames As String() = Directory.GetFiles(s, "*.*")
        Dim size As Long = 0

        For Each name As String In fileNames
            Dim details As FileInfo = New FileInfo(name)
            size += details.Length
        Next
        Dim d As DirectoryInfo = New DirectoryInfo(s)
        For Each c As DirectoryInfo In d.GetDirectories()
            size += GetFolderSize(c.FullName)
        Next
        Return size
    End Function

    Public Shared Function BytesToString(ByVal byteCount As Long) As String
        Dim suf As String() = {"B", "KiB", "MiB", "GiB", "TiB", "PiB", "EiB"}
        If byteCount = 0 Then Return "0" & suf(0)
        Dim bytes As Long = Math.Abs(byteCount)
        Dim place As Long = Convert.ToInt32(Math.Floor(Math.Log(bytes, 1024)))
        Dim num As Double = Math.Round(bytes / Math.Pow(1024, place), 1)
        Return (Math.Sign(byteCount) * num).ToString() & suf(place)
    End Function
    Public Shared Function GetCentreServerSpaceUsage(ByVal nCentreID As Integer, ByVal sPath As String) As Long
        Dim taAfC As New itspdbTableAdapters.ApplicationsForCentreTableAdapter
        Dim tAfC As New itspdb.ApplicationsForCentreDataTable
        tAfC = taAfC.GetData(nCentreID)
        Dim nTotalBytes As Long
        Dim taq As New itspdbTableAdapters.QueriesTableAdapter
        If tAfC.Count > 0 And tAfC.Count < 10 Then
            Dim sCPath As String = ""
            For Each r As DataRow In tAfC.Rows
                sCPath = sPath & "Course" + r.Item("ApplicationID").ToString() + "\"
                sCPath = sCPath.Replace("cms-dev-prev", "cms")
                If System.IO.Directory.Exists(sCPath) Then
                    nTotalBytes = nTotalBytes + CCommon.GetFolderSize(sCPath)
                End If
                taq.UpdateApplicationServerSpace(nTotalBytes, r.Item("ApplicationID"))
            Next
        End If
        taq.UpdateServerSpaceUsedForCentreID(nCentreID)
        Return nTotalBytes
    End Function
    Public Shared Function GetCourseServerSpaceUsage(ByVal nApplicationID As Integer, ByVal nCentreID As Integer, ByVal sPath As String) As Long

        Dim nTotalBytes As Long

        Dim sCPath As String = ""

        sCPath = sPath & "Course" & nApplicationID.ToString() & "\"
        sCPath = sCPath.Replace("cms-dev-prev", "cms")
        If System.IO.Directory.Exists(sCPath) Then
            nTotalBytes = nTotalBytes + CCommon.GetFolderSize(sCPath)
        End If
        Dim taq As New itspdbTableAdapters.QueriesTableAdapter
        taq.UpdateApplicationServerSpace(nTotalBytes, nApplicationID)
        taq.UpdateServerSpaceUsedForCentreID(nCentreID)
        Return nTotalBytes
    End Function
#End Region
#Region "Configuration"
    Public Shared Function GetLPURL(ByVal AdminID As Integer, ByVal CentreID As Integer) As String
        Dim sWCLPURL As String = My.Settings.LearningPortalURL
        If sWCLPURL = "https://www.dls.nhs.uk/dev-my-learning-portal/LearningPortal/Current" Then
            Return sWCLPURL
        Else
            Dim taQ As New itspdbTableAdapters.QueriesTableAdapter
            Dim sLPURL As String = taQ.GetLearningPortalUrlForCentre(CentreID)
            If Not sLPURL Is Nothing Then
                Return sLPURL
            ElseIf taQ.GetBetaTestingForCentreID(CentreID) And AdminID > 0 Then
                Return "https://www.dls.nhs.uk/v2/LearningPortal/Current"
            Else
                Return sWCLPURL
            End If
        End If
    End Function
#End Region
#Region "Login"
    Public Shared Sub LoginFromSession(ByVal bRememberMe As Boolean, ByRef Session As HttpSessionState, ByRef Request As HttpRequest, ByRef Context As HttpContext)
        If Not Session("UserEmail") Is Nothing Then
            Dim claims = New List(Of Claim)()
            claims.Add(New Claim(ClaimTypes.Email, Session("UserEmail")))
            claims.Add(New Claim("UserCentreID", Session("UserCentreID")))
            claims.Add(New Claim("UserCentreManager", Session("UserCentreManager")))
            claims.Add(New Claim("UserCentreAdmin", Session("UserCentreAdmin")))
            claims.Add(New Claim("UserUserAdmin", Session("UserUserAdmin")))
            claims.Add(New Claim("UserContentCreator", Session("UserContentCreator")))
            claims.Add(New Claim("UserAuthenticatedCM", Session("UserAuthenticatedCM")))
            claims.Add(New Claim("UserPublishToAll", Session("UserPublishToAll")))
            claims.Add(New Claim("UserCentreReports", Session("UserCentreReports")))
            claims.Add(New Claim("learnCandidateID", Session("learnCandidateID")))
            claims.Add(New Claim("learnUserAuthenticated", Session("learnUserAuthenticated")))
            claims.Add(New Claim("AdminCategoryID", Session("AdminCategoryID")))
            claims.Add(New Claim("IsSupervisor", Session("IsSupervisor")))
            claims.Add(New Claim("IsTrainer", Session("IsTrainer")))
            claims.Add(New Claim("IsFrameworkDeveloper", Session("IsFrameworkDeveloper")))
            claims.Add(New Claim("IsFrameworkContributor", Session("IsFrameworkContributor")))
            If Not Session("learnCandidateNumber") Is Nothing Then
                claims.Add(New Claim("learnCandidateNumber", Session("learnCandidateNumber"), ""))
            End If
            If Not Session("UserForename") Is Nothing Then
                claims.Add(New Claim("UserForename", Session("UserForename"), ""))
                claims.Add(New Claim("UserSurname", Session("UserSurname"), ""))
            End If
            If Not Session("UserCentreName") Is Nothing Then
                claims.Add(New Claim("UserCentreName", Session("UserCentreName"), ""))
            End If
            If Not Session("UserAdminID") Is Nothing Then
                claims.Add(New Claim("UserAdminID", Session("UserAdminID"), ""))
            End If
            Dim identity = New ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationType)

            If Request.IsAuthenticated Then
                Dim cp As ClaimsPrincipal = HttpContext.Current.User
                If Not cp.HasClaim(Function(c) c.Type = "UserCentreID") Then
                    cp.AddIdentity(identity)
                End If
            Else
                Context.GetOwinContext().Authentication.SignIn(New AuthenticationProperties() With {
               .IsPersistent = bRememberMe
           }, identity)
            End If
        End If
    End Sub

#End Region
End Class
