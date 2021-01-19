Public Class centredetails
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        SetupLogoSize()
        SetupSignatureSize()
    End Sub
    Private Sub fvEditcentreDetails_ItemUpdating(sender As Object, e As FormViewUpdateEventArgs) Handles fvEditcentreDetails.ItemUpdating
        If Not hfLattitude.Value = 0 Or Not hfLongitude.Value = 0 Then
            e.NewValues("Lat") = hfLattitude.Value
            e.NewValues("Longitude") = hfLongitude.Value
        End If
    End Sub
    Protected Sub SetupSignatureSize()
        Me.SignatureImagePanel.Visible = False
        Me.pnlSignatureNotLoaded.Visible = True
        If Not Session("UserCentreID") Is Nothing Then
            '
            ' We have to make the image the right size - not too big
            '
            Dim nCentreID As Integer = Session("UserCentreID")
            Dim CentresTA As New ITSPTableAdapters.CentresTableAdapter
            Dim tblCentres As New ITSP.CentresDataTable

            tblCentres = CentresTA.GetByCentreID(nCentreID)

            If tblCentres.Count = 1 Then
                Dim nWidth As Integer = tblCentres.First.SignatureWidth
                Dim nHeight As Integer = tblCentres.First.SignatureHeight

                If nWidth > 0 And nHeight > 0 Then
                    '
                    ' Check if the image is too big. If so, restrict the display size
                    ' and scale the height appropriately.
                    '
                    If nWidth > 300 Then
                        nHeight = CInt((CSng(300) / CSng(nWidth)) * CSng(nHeight))
                        nWidth = 300
                    End If
                    Me.SignatureImage.Width = nWidth
                    Me.SignatureImage.Height = nHeight
                    Me.SigDimensions.Text = tblCentres.First.SignatureWidth.ToString() + "x" + tblCentres.First.SignatureHeight.ToString()
                    Me.SignatureImagePanel.Visible = True
                    Me.pnlSignatureNotLoaded.Visible = False
                End If
            End If
        End If
    End Sub
    Protected Sub SetupLogoSize()
        Me.logoImagePanel.Visible = False
        Me.logoNotLoaded.Visible = True
        If Not Session("UserCentreID") Is Nothing Then
            '
            ' We have to make the image the right size - not too big
            '
            Dim nCentreID As Integer = Session("UserCentreID")
            Dim CentresTA As ITSPTableAdapters.CentresTableAdapter = New ITSPTableAdapters.CentresTableAdapter
            Dim tblCentres As ITSP.CentresDataTable

            tblCentres = CentresTA.GetByCentreID(nCentreID)

            If tblCentres.Count = 1 Then
                Dim nWidth As Integer = tblCentres.First.LogoWidth
                Dim nHeight As Integer = tblCentres.First.LogoHeight

                If nWidth > 0 And nHeight > 0 Then
                    '
                    ' Check if the image is too big. If so, restrict the display size
                    ' and scale the height appropriately.
                    '
                    If nWidth > 300 Then
                        nHeight = CInt((CSng(300) / CSng(nWidth)) * CSng(nHeight))
                        nWidth = 300
                    End If
                    Me.logoImage.Width = nWidth
                    Me.logoImage.Height = nHeight
                    Me.logDimensions.Text = tblCentres.First.LogoWidth.ToString() + "x" + tblCentres.First.LogoHeight.ToString()
                    Me.logoImagePanel.Visible = True
                    Me.logoNotLoaded.Visible = False
                End If
            End If
        End If
    End Sub
    Protected Sub SignatureUpload_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lbtSignatureUpload.Click
        '
        ' Make sure a file has been successfully uploaded
        '
        Me.sigMessage.Text = ""
        Me.sigMessage.ForeColor = Drawing.Color.Red
        If Me.fupSigFile.PostedFile Is Nothing OrElse
           String.IsNullOrEmpty(Me.fupSigFile.PostedFile.FileName) OrElse
           Me.fupSigFile.PostedFile.InputStream Is Nothing Then
            Me.sigMessage.Text = "Please select a gif, jpg or png to upload."
            Exit Sub
        End If
        '
        ' Make sure we are dealing with a JPG or GIF file
        '
        Dim sExtension As String = System.IO.Path.GetExtension(Me.fupSigFile.PostedFile.FileName).ToLower()
        Dim sFilename As String = System.IO.Path.GetFileName(Me.fupSigFile.PostedFile.FileName)
        Dim sMIMEType As String = Nothing
        Select Case sExtension
            Case ".gif"
                sMIMEType = "image/gif"
            Case ".jpg", ".jpeg", ".jpe"
                sMIMEType = "image/jpeg"
            Case ".png"
                sMIMEType = "image/png"
            Case Else
                'Invalid file type uploaded
                Me.sigMessage.Text = sFilename + " is not a valid file format. Please upload a gif, jpg or png."
                Exit Sub
        End Select
        '
        ' See how big the file is. We don't let them store a very large image.
        '
        Dim nMaxKB As Integer = 20

        If Me.fupSigFile.PostedFile.InputStream.Length > nMaxKB * 1024 Then
            Me.sigMessage.Text = sFilename + " is too big. Maximum file size is " + nMaxKB.ToString() + "K."
            Exit Sub
        End If
        '
        ' Grab the image
        '
        Dim ImageBytes(Me.fupSigFile.PostedFile.InputStream.Length) As Byte

        Me.fupSigFile.PostedFile.InputStream.Read(ImageBytes, 0, ImageBytes.Length)
        Dim sCheckStream As New System.IO.MemoryStream(ImageBytes)
        '
        ' Create an image object from the uploaded file
        '
        Dim UploadedImage As System.Drawing.Image = System.Drawing.Image.FromStream(sCheckStream)
        '
        ' Determine width and height of uploaded image
        '
        Dim nSignatureWidth As Integer = UploadedImage.PhysicalDimension.Width
        Dim nSignatureHeight As Integer = UploadedImage.PhysicalDimension.Height
        '
        ' Insert the image into the Centres table
        '
        Dim CentresTA As New ITSPTableAdapters.CentresTableAdapter

        CentresTA.UpdateSignature(sMIMEType, ImageBytes, nSignatureWidth, nSignatureHeight, Session("UserCentreID"))
        '
        ' Update the image size in the page
        '
        SetupSignatureSize()
        ' UpdateAll()
    End Sub
    Protected Sub logoUpload_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lbtLogoUpload.Click
        '
        ' Make sure a file has been successfully uploaded
        '
        Me.logMessage.Text = ""
        Me.logMessage.ForeColor = Drawing.Color.Red
        If Me.fupCentreLogo.PostedFile Is Nothing OrElse
           String.IsNullOrEmpty(Me.fupCentreLogo.PostedFile.FileName) OrElse
           Me.fupCentreLogo.PostedFile.InputStream Is Nothing Then
            Me.logMessage.Text = "Please select a gif, jpg or png to upload."
            Exit Sub
        End If
        '
        ' Make sure we are dealing with a JPG or GIF file
        '
        Dim sExtension As String = System.IO.Path.GetExtension(Me.fupCentreLogo.PostedFile.FileName).ToLower()
        Dim sFilename As String = System.IO.Path.GetFileName(Me.fupCentreLogo.PostedFile.FileName)
        Dim sMIMEType As String = Nothing
        Select Case sExtension
            Case ".gif"
                sMIMEType = "image/gif"
            Case ".jpg", ".jpeg", ".jpe"
                sMIMEType = "image/jpeg"
            Case ".png"
                sMIMEType = "image/png"
            Case Else
                'Invalid file type uploaded
                Me.logMessage.Text = sFilename + " is not a valid file format. Please upload a gif, jpg or png."
                Exit Sub
        End Select
        '
        ' See how big the file is. We don't let them store a very large image.
        '
        Dim nMaxKB As Integer = 50

        If Me.fupCentreLogo.PostedFile.InputStream.Length > nMaxKB * 1024 Then
            Me.logMessage.Text = sFilename + " is too big. Maximum file size is " + nMaxKB.ToString() + "K."
            Exit Sub
        End If
        '
        ' Grab the image
        '
        Dim ImageBytes(Me.fupCentreLogo.PostedFile.InputStream.Length) As Byte

        Me.fupCentreLogo.PostedFile.InputStream.Read(ImageBytes, 0, ImageBytes.Length)
        Dim sCheckStream As New System.IO.MemoryStream(ImageBytes)
        '
        ' Create an image object from the uploaded file
        '
        Dim UploadedImage As System.Drawing.Image = System.Drawing.Image.FromStream(sCheckStream)
        '
        ' Determine width and height of uploaded image
        '
        Dim nlogoWidth As Integer = UploadedImage.PhysicalDimension.Width
        Dim nlogoHeight As Integer = UploadedImage.PhysicalDimension.Height
        '
        ' Insert the image into the Centres table
        '
        Dim CentresTA As ITSPTableAdapters.CentresTableAdapter = New ITSPTableAdapters.CentresTableAdapter

        CentresTA.UpdateLogo(sMIMEType, ImageBytes, nlogoWidth, nlogoHeight, Session("UserCentreID"))
        '
        ' Update the image size in the page
        '
        SetupLogoSize()
        'UpdateAll()
    End Sub
    Protected Sub SignatureClear_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lbtSignatureClear.Click
        '
        ' Clear the signature
        '
        Dim CentresTA As New ITSPTableAdapters.CentresTableAdapter
        Dim ImageBytes(1) As Byte

        CentresTA.UpdateSignature("", ImageBytes, 0, 0, Session("UserCentreID"))
        '
        ' Refresh signature display
        '
        Me.sigMessage.Text = ""
        SetupSignatureSize()
        'UpdateAll()
    End Sub
    Protected Sub LogoClear_Click(ByVal sender As Object, ByVal e As EventArgs) Handles logoClear.Click
        '
        ' Clear the signature
        '
        Dim CentresTA As New ITSPTableAdapters.CentresTableAdapter
        Dim ImageBytes(1) As Byte

        CentresTA.UpdateLogo("", ImageBytes, 0, 0, Session("UserCentreID"))
        '
        ' Refresh signature display
        '
        Me.logMessage.Text = ""
        SetupLogoSize()
        ' UpdateAll()
    End Sub
End Class