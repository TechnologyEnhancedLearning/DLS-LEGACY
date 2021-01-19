Imports HiQPdf
Partial Public Class CFinalise
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Not Page.Request.Item("lp") Is Nothing Then
                lbtClose.OnClientClick = ""
                lbtClose.PostBackUrl = "~/learningportal/completed"
            End If

            Try
                    '
                    ' Learning materials will open finalise.aspx with parameter being the SessionID, CustomisationID and CandidateID. 
                    '
                    If Session("UserCentreID") Is Nothing Then
                        Session("UserCentreID") = CInt(Page.Request.Item("UserCentreID"))
                    End If
                    If Not Page.Request.Item("Preview") Is Nothing Then
                        Dim nCentreID As Integer = Session("UserCentreID")
                        SetupPreview(nCentreID)
                    Else
                        Dim nProgressID As Integer = 0
                    If Not Page.Request.Item("ProgressID") Is Nothing Then
                        nProgressID = CInt(Page.Request.Item("ProgressID"))
                    End If
                    Dim bSessionVerified As Boolean = False
                    If Not Page.Request.Item("SessionID") Is Nothing Then
                        Dim nSessionID As Integer = Page.Request.Item("SessionID")

                        Dim taql As New LearnMenuTableAdapters.QueriesTableAdapter
                        If taql.CheckSessionProgress(nProgressID, nSessionID) > 0 Then
                            bSessionVerified = True
                        End If
                    End If


                        Dim bCentreManager As Boolean = False



                        Dim bIsPDF As Boolean
                        If Page.Request.Item("pdfexport") Is Nothing OrElse Page.Request.Item("pdfexport") = String.Empty Then
                            bIsPDF = False
                        Else
                            bIsPDF = True
                        End If
                        '
                        ' If no session ID then check if centre manager logged in
                        '
                        Dim taq As New ITSPTableAdapters.QueriesTableAdapter
                        If bIsPDF Then
                            Session("UserCentreID") = CInt(Page.Request.Item("UserCentreID"))
                            pnlToolbar.Visible = False
                            Me.Page.Header.Controls.Add(New LiteralControl("<style type=""text/css"">   .style2 {padding-bottom:8px; }  .style3  {padding-bottom:8px; }  .style4  {padding-bottom:8px; } </style>"))
                        End If
                        If nProgressID = 0 Then
                            If Session("UserName") Is Nothing Then
                                If Not bIsPDF Then
                                    '							Throw New ApplicationException("Invalid parameters")
                                End If

                            End If
                            If Page.Request.Item("ProgressKey") Is Nothing Then
                                bCentreManager = True
                            End If
                            nProgressID = 1                          ' provide something for code to chew on. It's ignored if centre manager logged in.
                        End If


                        '
                        ' Check if the user information is valid, and if the course is assessed then
                        '
                        Dim bImg As System.Byte() = taq.GetLogoForProgressID(nProgressID)
                        If Not bImg Is Nothing Then
                            bimgLogo.Value = bImg
                        Else
                            bimgLogo.Visible = False
                        End If
                        Dim progressAdapter As New ITSPTableAdapters.ProgressTableAdapter()
                        Dim tblProgress As ITSP.ProgressDataTable
                        'Dim nSessionID As Integer = CInt(sSessionID)

                        If bCentreManager Then
                            tblProgress = progressAdapter.GetForCertificate(nProgressID)
                        ElseIf Not Page.Request.Item("ProgressKey") Is Nothing Then


                            tblProgress = progressAdapter.GetForCertificate(nProgressID)
                            nProgressID = tblProgress.First.ProgressID
                            Dim idLPGUID As Guid = New Guid(Page.Request.Item("ProgressKey"))
                        If bSessionVerified = False And (Session("ProgressKeyChecked") Is Nothing Or Not Session("ProgressKeyChecked") = Page.Request.Item("ProgressKey")) Then
                            If Not Page.Request.Item("ProgressKey") = "Enroll" Then
                                If taq.CheckProgressKeyExistsAndRemove(idLPGUID, nProgressID) = 0 Then
                                    Throw New ApplicationException("Invalid Learner Portal Progress Key")
                                Else
                                    Session("ProgressKeyChecked") = idLPGUID.ToString
                                End If
                            End If
                        End If
                    Else
                            tblProgress = progressAdapter.GetForCertificate(nProgressID)
                        End If
                        If tblProgress.Count = 0 Then
                            Throw New ApplicationException("No progress")
                        End If
                        '
                        ' Get the Evaluated and Completed date/time as a string. A little complex
                        ' because DateTime is not nullable.
                        '
                        Dim bCompleted As Boolean = True
                        Dim bEvaluated As Boolean = True
                        Dim sCompleted As String = ""
                        Try
                            sCompleted = tblProgress.First.Completed.ToString("dd MMM yyyy")
                        Catch ex As System.Data.StrongTypingException
                            '
                            ' The Completed value must be DBNull but there's no way of testing it
                            ' so just depend on this exception!
                            '
                            bCompleted = False
                        End Try
                        Dim sEvaluated As String = ""
                        Try
                            sEvaluated = tblProgress.First.Evaluated.ToString("dd/MM/yyyy")
                        Catch ex As System.Data.StrongTypingException
                            bEvaluated = False
                        End Try
                        '
                        ' If the course is not completed then we don't do anything
                        '
                        If Not bCompleted Then
                            Throw New ApplicationException("Not completed")
                        End If
                    '
                    ' If it's already evaluated, show the certificate.
                    ' Also, if Centre Manager is logged in then we must be getting a duplicate certificate so just show it.
                    '
                    If bEvaluated Or bCentreManager Then
                        If Not Session("lmProgressID") Is Nothing Or Not Session("UserAdminID") Is Nothing Then
                            hfHistory.Value = -1
                        End If
                        SetupCertificate(nProgressID)
                        Else
                            '
                            ' Otherwise show the evaluation page
                            '
                            Me.MultiView.ActiveViewIndex = Me.MultiView.Views.IndexOf(Me.EvaluationView)
                        If Not Session("lmProgressID") Is Nothing Or Not Session("UserAdminID") Is Nothing Then
                            hfHistory.Value = -2
                        End If
                    End If

                End If

                Catch ex As Exception
                    '
                    ' There was a problem with the information passed in.
                    ' Show an error page.
                    '
                    Me.MultiView.ActiveViewIndex = Me.MultiView.Views.IndexOf(Me.ErrorView)
                    Me.ErrorText.Text = ex.ToString()
                End Try
            End If
    End Sub
    Sub SetupPreview(ByVal nCentreNumber As Integer)
        '
        ' Show the Certificate
        '
        Me.MultiView.ActiveViewIndex = Me.MultiView.Views.IndexOf(Me.CertificateView)
        '
        ' Determine field values using custom query
        ''
        Dim CertificateInfoTA As ITSPTableAdapters.CertificateInfoTableAdapter = New ITSPTableAdapters.CertificateInfoTableAdapter()
        Dim tblCertificateInfo As ITSP.CertificateInfoDataTable
        Dim rCert As ITSP.CertificateInfoRow

        tblCertificateInfo = CertificateInfoTA.GetPreviewByCentreID(nCentreNumber)
        If tblCertificateInfo.Count <> 1 Then
            '
            ' Not found - bomb out
            '
            Me.MultiView.ActiveViewIndex = Me.MultiView.Views.IndexOf(Me.ErrorView)
            Me.ErrorText.Text = "Certificate preview could not be generated for centre number " & nCentreNumber.ToString() & "."
            Exit Sub
        End If
        rCert = tblCertificateInfo.First
        SetUpCertFromRow(rCert, 0)
    End Sub
    Sub SetUpCertFromRow(ByVal rCert As ITSP.CertificateInfoRow, ByVal nProgressID As Integer)

        '
        ' Check if the Course is assessed or not
        '
        If Not Session("NoITSPLogo") Is Nothing Then
            bimgLogo.Visible = False
        End If

        If Not rCert.IsAssessed Then
            '
            ' All OK and course is not assessed, so just close page
            '
            Me.MultiView.ActiveViewIndex = Me.MultiView.Views.IndexOf(Me.BlankView)
            CCommon.RunStartupScript(Page, "CloseScript", "window.close();")
            Exit Sub
        End If
        If rCert.LogoHeight > 0 And rCert.LogoWidth > 0 Then
            Dim nWidth As Integer = rCert.LogoWidth
            Dim nHeight As Integer = rCert.LogoHeight

            If nHeight > 90 Then
                nWidth = CInt((CSng(90) / CSng(nHeight)) * CSng(nWidth))
                nHeight = 90
            End If
            If nWidth > 500 Then
                nHeight = CInt((CSng(500) / CSng(nWidth)) * CSng(nHeight))
                nWidth = 500
            End If
            Me.Logo.Width = nWidth
            Me.Logo.Height = nHeight
            '
            ' Pass three parameters to the signature loading so that it's unlikely that
            ' users can reload an odl signature.
            '

            Me.Logo.ImageUrl = "~/centrelogo"

        End If

        Me.CertApplication.Text = rCert.ApplicationName
        Me.CertCompletion.Text = rCert.Completed.ToString("dddd, dd MMMM yyyy")
        Me.CertDelegate.Text = rCert.FirstName + " " + rCert.LastName
        Me.CertManagerName.Text = rCert.ContactForename + " " + rCert.ContactSurname
        Me.CertCentreName.Text = rCert.CentreName
        '
        ' Set up the modifier text. Hard coded here for the moment.
        '
        Dim sModifier As String = ""
        Select Case rCert.ModifierID
            Case 0
                If Not rCert.CreatedByCentreID = 101 Then
                    sModifier = "Passing online post learning assessments"
                Else
                    sModifier = "Passing online Digital Learning Solutions post learning assessments"
                End If

            Case 1
                sModifier = "Passing the Entry Level assessments including mouse and keyboard skills, working with applications, file management, web and e-mail skills."
            Case 2
                sModifier = "Passing the Entry Level+ assessments including word processing and working safely in addition to the standard Entry Level content."
            Case 3
                sModifier = "Passing online Level 1 assessments"
        End Select
        Me.CertModifier.Text = sModifier
        '
        ' Set up the signature if present
        '
        If rCert.SignatureHeight = 0 Or rCert.SignatureWidth = 0 Then
            Me.SignatureImage.Visible = False
        Else
            Dim nWidth As Integer = rCert.SignatureWidth
            Dim nHeight As Integer = rCert.SignatureHeight

            If nWidth > 300 Then
                nHeight = CInt((CSng(300) / CSng(nWidth)) * CSng(nHeight))
                nWidth = 300
            End If
            Me.SignatureImage.Visible = True
            Me.SignatureImage.Width = nWidth
            Me.SignatureImage.Height = nHeight
            '
            ' Pass three parameters to the signature loading so that it's unlikely that
            ' users can reload an odl signature.
            '
            Me.SignatureImage.ImageUrl = "~/centresignature"
        End If
        'Image1.ImageUrl = "~/images/sidebar" & (rCert.AppGroupID - 1).ToString() & ".png"
        'CertBack.Style(HtmlTextWriterStyle.BackgroundImage) = "url('images/sidebar" & rCert.AppGroupID.ToString() & ".png'"
        'CertBack.Attributes.Add("style", "background-image: url('images/sidebar" & rCert.AppGroupID.ToString() & ".png')")
        '
        ' Set up script to print the page
        '
        CCommon.RunStartupScript(Page, "PrintScript", "window.print();")
    End Sub
    Sub SetupCertificate(ByVal nProgressID As Integer)
        '
        ' Show the Certificate
        '
        Me.MultiView.ActiveViewIndex = Me.MultiView.Views.IndexOf(Me.CertificateView)
        '
        ' Determine field values using custom query
        '
        Dim CertificateInfoTA As ITSPTableAdapters.CertificateInfoTableAdapter = New ITSPTableAdapters.CertificateInfoTableAdapter()
        Dim tblCertificateInfo As ITSP.CertificateInfoDataTable
        Dim rCert As ITSP.CertificateInfoRow

        tblCertificateInfo = CertificateInfoTA.GetDataByProgressID(nProgressID)
        If tblCertificateInfo.Count <> 1 Then
            '
            ' Not found - bomb out
            '
            Me.MultiView.ActiveViewIndex = Me.MultiView.Views.IndexOf(Me.ErrorView)
            Me.ErrorText.Text = "Certificate information not found."
            Exit Sub
        End If
        rCert = tblCertificateInfo.First
        SetUpCertFromRow(rCert, nProgressID)
    End Sub


    Protected Sub SubmitEval_Click(ByVal sender As Object, ByVal e As EventArgs) Handles SubmitEval.Click
        '
        ' Record the results of the evaluation
        '
        Dim nQ1 As Byte = 255
        Dim nQ2 As Byte = 255
        Dim nQ3 As Byte = 255
        Dim nQ4 As Byte = 255
        Dim nQ5 As Byte = 255
        Dim nQ6 As Byte = 255
        Dim nQ7 As Byte = 255
        Dim Band As Integer = 0
        If Me.Q1No.Checked Then nQ1 = 0
        If Me.Q1Yes.Checked Then nQ1 = 1
        If Me.Q2No.Checked Then nQ2 = 0
        If Me.Q2Yes.Checked Then nQ2 = 1
        If Me.Q3No.Checked Then nQ3 = 0
        If Me.Q3Yes.Checked Then nQ3 = 1
        If Me.Q4lt1.Checked Then nQ4 = 1
        If Me.Q41to2.Checked Then nQ4 = 2
        If Me.Q42to4.Checked Then nQ4 = 3
        If Me.Q44to6.Checked Then nQ4 = 4
        If Me.Q4gt6.Checked Then nQ4 = 5
        If Me.Q5No.Checked Then nQ5 = 0
        If Me.Q5Yes.Checked Then nQ5 = 1
        If Me.Q6NA.Checked Then nQ6 = 0
        If Me.Q6No.Checked Then nQ6 = 1
        If Me.Q6YesDirectly.Checked Then nQ6 = 2
        If Me.Q6YesIndirectly.Checked Then nQ6 = 3
        If Me.Q7No.Checked Then nQ7 = 0
        If Me.Q7Yes.Checked Then nQ7 = 1
        Band = Integer.Parse(PayBandDD.SelectedValue)
        Dim DelName As String = tbName.Text
        Dim DelContact As String = tbContact.Text
        Dim sProgressID As String = Page.Request.Item("ProgressID")
        Dim sCandidateNumber As String = ""


        If sProgressID Is Nothing Or
            Me.MultiView.ActiveViewIndex = Me.MultiView.Views.IndexOf(Me.ErrorView) Then
            Me.ErrorText.Text = "Parameters not found"
            Exit Sub
        End If
        '
        ' Convert values to IDs
        '
        Dim nProgressID As Integer = CInt(sProgressID)
        Dim nResult As Integer
        Dim QueriesTA As ITSPTableAdapters.QueriesTableAdapter = New ITSPTableAdapters.QueriesTableAdapter()

        nResult = QueriesTA.uspStoreEvaluation(nProgressID, nQ1, nQ2, nQ3, nQ4, nQ5, nQ6, nQ7, Band, DelName, DelContact)
        If nResult = 0 Then
            '
            ' All OK so show certificate
            '
            SetupCertificate(nProgressID)
            If Not Session("lmProgressID") Is Nothing Then
                hfHistory.Value = -2
            End If
        Else
            '
            ' There was an error - show error page
            '
            Me.MultiView.ActiveViewIndex = Me.MultiView.Views.IndexOf(Me.ErrorView)
            Me.ErrorText.Text = "Unable to store evaluation"
        End If

    End Sub

    Private Sub btnPDFExport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPDFExport.Click
        Dim htmlToPdfConverter As New HtmlToPdf()
        Dim nCentreID As Integer
        If Not Session("UserCentreID") Is Nothing Then
            nCentreID = CInt(Session("UserCentreID"))
        Else
            nCentreID = CInt(Session("CentreID"))
        End If
        Dim SUrl As String = Request.Url.AbsoluteUri
        SUrl = SUrl + "&pdfexport=1&UserCentreID=" & nCentreID.ToString()
        Dim pdfName As String = "ITSPCertificate_" & Me.CertApplication.Text.Replace(" ", "_") & ".pdf"
        CCommon.GeneratePDFFromURL(SUrl, pdfName)
    End Sub
End Class
