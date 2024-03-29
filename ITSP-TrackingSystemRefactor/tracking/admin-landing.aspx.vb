﻿Imports System.IO
Imports DevExpress.Web
Imports DevExpress.Web.Bootstrap
Imports DevExpress.Web.Data

Public Class admin_landing
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub bsgv_BeforeGetCallbackResult(sender As Object, e As EventArgs)
        Dim bsgv As BootstrapGridView = TryCast(sender, BootstrapGridView)
        If Not bsgv Is Nothing Then
            If bsgv.IsNewRowEditing Then
                bsgv.SettingsText.PopupEditFormCaption = "Add"
                bsgv.SettingsCommandButton.UpdateButton.Text = "Add"
            Else
                bsgv.SettingsText.PopupEditFormCaption = "Edit"
                bsgv.SettingsCommandButton.UpdateButton.Text = "Update"
            End If
        End If
    End Sub


    Protected Sub InitNewRow_DefaultActive(sender As Object, e As ASPxDataInitNewRowEventArgs)
        e.NewValues("Active") = True
        'bsgvProducts.FindControl("Active")
    End Sub



    Protected Sub lbtMoveUpBrand_Command(sender As Object, e As CommandEventArgs)
        Dim taq As New prelogindataTableAdapters.QueriesTableAdapter
        Dim nBrandID As Integer = CInt(e.CommandArgument)
        taq.ReorderBrand(nBrandID, "UP")
        bsgvBrands.DataBind()
    End Sub


    Protected Sub lbtMoveDownBrand_Command(sender As Object, e As CommandEventArgs)
        Dim taq As New prelogindataTableAdapters.QueriesTableAdapter
        Dim nBrandID As Integer = CInt(e.CommandArgument)
        taq.ReorderBrand(nBrandID, "DOWN")
        bsgvBrands.DataBind()
    End Sub

    Protected Sub bsgv_CellEditorInitialize(sender As Object, e As BootstrapGridViewEditorEventArgs)
        If e.Column.Caption = "Image" Or e.Column.Caption = "Screenshot" Then
            Dim iedit As ASPxBinaryImage = e.Editor
            iedit.Height = 200
            iedit.Width = Nothing
        End If
    End Sub

    Protected Sub lbtViewBrand_Command(sender As Object, e As CommandEventArgs)
        Session("plBrandID") = e.CommandArgument
        frmPreview.Src = "../controls/brandpreview.aspx"
        bsppPreview.ShowOnPageLoad = True
    End Sub
    Protected Sub GridViewCustomToolbar_ToolbarItemClick(sender As Object, e As BootstrapGridViewToolbarItemClickEventArgs)
        Dim sSrc As String = ""
        Select Case e.Item.Name
            Case "PreviewBrands"
                sSrc = "../controls/brandspreview"
        End Select
        If Not sSrc = "" Then
            frmPreview.Src = sSrc
            bsppPreview.ShowOnPageLoad = True
        End If
    End Sub
    Protected Sub bspcLandingTabs_ActiveTabChanged(source As Object, e As BootstrapPageControlEventArgs) Handles bspcLandingTabs.ActiveTabChanged

    End Sub

    Protected Sub bsgvBrands_RowInserting(sender As Object, e As ASPxDataInsertingEventArgs)
        If e.NewValues("BrandImage").ToString.Length > 0 Then
            Dim myMemStream As New MemoryStream(CType(e.NewValues("BrandImage"), Byte()))
            myMemStream = CCommon.resizeImageFromMemoryStream(myMemStream, 400, 400)
            e.NewValues("BrandImage") = myMemStream.ToArray()
        End If
    End Sub


    Protected Sub bsgvBrands_RowUpdating(sender As Object, e As ASPxDataUpdatingEventArgs)
        If e.NewValues("BrandImage").ToString.Length > 0 Then
            Dim myMemStream As New MemoryStream(CType(e.NewValues("BrandImage"), Byte()))
            myMemStream = CCommon.resizeImageFromMemoryStream(myMemStream, 400, 400)
            e.NewValues("BrandImage") = myMemStream.ToArray()
        End If
    End Sub


    Protected Sub html_RtfContentPastingProcessed(sender As Object, e As ASPxHtmlEditor.RtfContentPastingProcessedEventArgs)
        e.Html = e.Html.Replace("div>", "p>")
    End Sub
    Protected Property bstb As BootstrapTextBox
    Protected Sub bsupVideo_FileUploadComplete(sender As Object, e As FileUploadCompleteEventArgs)
        Dim fileName As String = e.UploadedFile.FileName
        Dim virtPath As String = "~/mp4/features/" & fileName
        Dim filePath As String = Page.MapPath(virtPath)
        e.UploadedFile.SaveAs(filePath)
        e.CallbackData = virtPath
    End Sub
    Protected Sub ASPxCallbackPanel1_Callback(ByVal sender As Object, ByVal e As CallbackEventArgsBase)
        If Not bstb Is Nothing Then
            bstb.Text = e.Parameter
        End If
    End Sub
    Protected Function FindControlUpwards(currentControl As Control, controlId As String) As Control
        If currentControl.ID = controlId Then
            Return currentControl
        End If
        Return If(currentControl.NamingContainer IsNot Nothing, FindControlUpwards(currentControl.NamingContainer, controlId), Nothing)
    End Function

    Protected Sub bstb_DataBound(sender As Object, e As EventArgs)
        bstb = TryCast(sender, BootstrapTextBox)
    End Sub

    Private Function GetStringColumn() As String
        'Dim cp As ASPxCallbackPanel = CType(grid.FindEditFormTemplateControl("ASPxCallbackPanel1"), ASPxCallbackPanel)
        Return bstb.Text
    End Function
#Region "Bulletins"
    Protected Sub bsupBulletin_FileUploadComplete(sender As Object, e As FileUploadCompleteEventArgs)
        Dim fileName As String = e.UploadedFile.FileName.Replace(" ", "")
        Dim virtPath As String = "~/bulletins/" & fileName
        Dim filePath As String = Page.MapPath(virtPath)
        e.UploadedFile.SaveAs(filePath)
        e.CallbackData = fileName
    End Sub

    Protected Sub bsgvBulletins_RowInserting(sender As Object, e As ASPxDataInsertingEventArgs)
        If Not e.NewValues("BulletinImage") Is Nothing Then
            Dim myMemStream As New MemoryStream(CType(e.NewValues("BulletinImage"), Byte()))
            myMemStream = CCommon.resizeImageFromMemoryStream(myMemStream, 400, 400)
            e.NewValues("BulletinImage") = myMemStream.ToArray()
        End If
        Dim gridView As ASPxGridView = CType(sender, ASPxGridView)
        e.NewValues("BulletinFileName") = GetStringColumn()
    End Sub

    Protected Sub bsgvBulletins_RowUpdating(sender As Object, e As ASPxDataUpdatingEventArgs)
        If Not e.NewValues("BulletinImage") Is Nothing Then
            Dim myMemStream As New MemoryStream(CType(e.NewValues("BulletinImage"), Byte()))
            myMemStream = CCommon.resizeImageFromMemoryStream(myMemStream, 1024, 768)
            e.NewValues("BulletinImage") = myMemStream.ToArray()
        End If
        Dim gridView As ASPxGridView = CType(sender, ASPxGridView)
        e.NewValues("BulletinFileName") = GetStringColumn()
    End Sub
#End Region

End Class