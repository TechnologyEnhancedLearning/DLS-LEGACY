Imports System.IO

Public Class filemx
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("lmDelegateByteLimit") Is Nothing Then
            Dim taq As New FilesDataTableAdapters.QueriesTableAdapter
            Session("lmDelegateByteLimit") = taq.GetCandidateByteLimitForCentreID(Session("UserCentreID"))
        End If
        If Page.IsPostBack Then
            If Session("bSizeExceeded") = True Then
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowLimitReachedModal", "<script>$('#noSpaceModal').modal('show');</script>")
                Session("bSizeExceeded") = False
            End If
            If dsFiles.SelectParameters(0).DefaultValue = 0 Then
                If Not Session("learnCurrentLogItemID") Is Nothing Then
                    dsFiles.SelectParameters(0).DefaultValue = Session("learnCurrentLogItemID")
                    rptFiles.DataBind()
                End If
            End If
            rptFiles.DataBind()
            updateStorageUsage()
        End If
    End Sub

    Protected Sub bsucEvidenceUpload_FileUploadComplete(sender As Object, e As DevExpress.Web.FileUploadCompleteEventArgs)
        Dim taFD As New FilesDataTableAdapters.FilesTableAdapter
        Dim nLID As Integer = Session("learnCurrentLogItemID")
        Dim taq As New FilesDataTableAdapters.QueriesTableAdapter
        Dim nSpaceUsed As Integer = taq.GetBytesUsedByCandidate(Session("learnCandidateID"))
        Dim bsuc As DevExpress.Web.Bootstrap.BootstrapUploadControl = TryCast(sender, DevExpress.Web.Bootstrap.BootstrapUploadControl)
        If (e.UploadedFile.FileBytes.Length + nSpaceUsed) > Session("lmDelegateByteLimit") Then
            Session("bSizeExceeded") = True
        Else
            taFD.InsertFileInFileGroup(e.UploadedFile.FileName, e.UploadedFile.ContentType, e.UploadedFile.ContentLength, e.UploadedFile.FileBytes, Session("learnCandidateID"), Session("UserEmail"), nLID)
        End If

    End Sub

    Protected Function GetIconClass(ByVal sFileName As String) As String
        Return CCommon.GetIconClass(sFileName)
    End Function
    Protected Function NiceBytes(ByVal lBytes As Long)
        Return CCommon.BytesToString(lBytes)
    End Function

    Private Sub dsFiles_Selected(sender As Object, e As ObjectDataSourceStatusEventArgs) Handles dsFiles.Selected
        If e.ReturnValue.Count = 0 Then
            trNoFilesAdd.Visible = True
            rptFiles.Visible = False
        Else
            trNoFilesAdd.Visible = False
            rptFiles.Visible = True
        End If
        Dim nLogItemID = dsFiles.SelectParameters(0).DefaultValue
        Dim taq As New FilesDataTableAdapters.QueriesTableAdapter
        Dim nLoggedByAdmin As Integer? = taq.GetLoggedByAdmin(nLogItemID)
        Dim bContRoleHide As Boolean = False
        If Not Session("ContributorRole") Is Nothing Then
            If Session("ContributorRole") = 1 Then
                bContRoleHide = True
            End If
        End If
        If (nLoggedByAdmin > 0 And nLoggedByAdmin <> Session("UserAdminID")) Or lblPercent.Text = "100%" Or bContRoleHide Then

            pnlUpload.Visible = False
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "disableDelete", "<script>setTimeout(function () {$('.btn-delete-file').addClass('d-none');}, 1);</script>")
        End If
    End Sub

    Protected Sub bsucEvidenceUpload_FilesUploadComplete(sender As Object, e As DevExpress.Web.FilesUploadCompleteEventArgs)

        Page.ClientScript.RegisterStartupScript(Me.GetType(), "submitFiles", "<script>setTimeout(function () { WebForm_DoPostBackWithOptions(new WebForm_PostBackOptions('btnFinish', '', true, '', '', false, true)); }, 1);</script>")
    End Sub

    Protected Sub rptFiles_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
        If e.CommandName = "Delete" Then
            Dim taF As New FilesDataTableAdapters.FilesTableAdapter
            taF.DeleteQuery(e.CommandArgument)
            rptFiles.DataBind()
        End If
    End Sub
    Protected Sub updateStorageUsage()
        Dim taq As New FilesDataTableAdapters.QueriesTableAdapter
        Dim nSpaceUsed As Long = taq.GetBytesUsedByCandidate(Session("learnCandidateID"))
        Dim nSpaceAvailable As Long = Session("lmDelegateByteLimit")
        lblUsed.Text = NiceBytes(nSpaceUsed)
        lblAvailable.Text = NiceBytes(nSpaceAvailable)
        Dim percentageusage As Long = 0
        If nSpaceAvailable > 0 Then
            percentageusage = (nSpaceUsed * 100) / nSpaceAvailable
        Else
            percentageusage = 100
        End If
        If percentageusage > 100 Then
            percentageusage = 100
        End If
        progbar.Attributes.Add("aria-valuenow", percentageusage.ToString())
        progbar.Attributes.Add("style", "width:" & percentageusage.ToString() & "%;")
        lblPercent.Text = percentageusage.ToString() & "%"
    End Sub
    'Private Sub filemx_Init(sender As Object, e As EventArgs) Handles Me.Init
    '    If dsFiles.SelectParameters(0).DefaultValue = 0 Then
    '        If Not Session("learnCurrentLogItemID") Is Nothing Then
    '            dsFiles.SelectParameters(0).DefaultValue = Session("learnCurrentLogItemID")
    '            rptFiles.DataBind()
    '        End If
    '    End If
    'End Sub
End Class