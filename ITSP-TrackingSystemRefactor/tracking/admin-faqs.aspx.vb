Imports System.Drawing
Imports System.Drawing.Imaging
Imports System.IO
Imports System.Text.RegularExpressions
Imports DevExpress.Web.ASPxHtmlEditor
Public Class admin_faqs
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub fvFAQ_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles fvFAQ.ItemCommand
        If e.CommandName = "CloseForm" Then
            mvFAQ.SetActiveView(vListFAQs)
        End If
    End Sub

    Private Sub fvFAQ_ItemInserted(sender As Object, e As FormViewInsertedEventArgs) Handles fvFAQ.ItemInserted
        Response.Redirect("admin-faqs")
        ' mvFAQ.SetActiveView(vListFAQs)
        'bsgvFAQs.DataBind()
    End Sub

    Private Sub fvFAQ_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles fvFAQ.ItemUpdated
        ' fvFAQ.ChangeMode(FormViewMode.Insert)
        Response.Redirect("admin-faqs")
        ' mvFAQ.SetActiveView(vListFAQs)
        'bsgvFAQs.DataBind()
    End Sub



    Private Sub lbtAddFAQ_Click(sender As Object, e As EventArgs) Handles lbtAddFAQ.Click
        Me.fvFAQ.ChangeMode(FormViewMode.Insert)
        'fvFAQ.PageIndex = gvFAQs.SelectedIndex + (gvFAQs.PageSize * gvFAQs.PageIndex)
        lblFAQTitle.Text = "Add FAQ"
        mvFAQ.SetActiveView(vAddEditFAQ)
    End Sub
    Protected Sub htmlFAQCorrecting(sender As Object, e As HtmlCorrectingEventArgs)
        Dim regex As New Regex("<img[^/]+src=[""'](?<data>data:image/[^'""]*)[""'][^/]*/>")
        e.Html = regex.Replace(e.Html, New MatchEvaluator(Function(m)
                                                              Dim base64Value As String = m.Groups("data").Value
                                                              Dim tagStr As String = m.Value
                                                              Return tagStr.Replace(base64Value, CreateImageFromBase64(base64Value))

                                                          End Function))
    End Sub
    Private Function CreateImageFromBase64(base64String As String) As String
        base64String = base64String.Split(New String() {"base64,"}, StringSplitOptions.RemoveEmptyEntries)(1)
        Dim imageBytes As Byte() = Convert.FromBase64String(base64String)
        Using ms As New MemoryStream(imageBytes, 0, imageBytes.Length)
            ms.Write(imageBytes, 0, imageBytes.Length)
            Using image__1 As Image = Image.FromStream(ms, True)
                Dim serverPath As String = String.Format("~/Images/uploaded/faq/{0}{1}", Guid.NewGuid(), CCommon.GetFileExtension(image__1))
                image__1.Save(Server.MapPath(serverPath))
                Return ResolveClientUrl(serverPath)
            End Using
        End Using
    End Function
    Protected Sub Select_Click(sender As Object, e As CommandEventArgs)
        dsFAQInsertEdit.SelectParameters(0).DefaultValue = e.CommandArgument
        Me.fvFAQ.ChangeMode(FormViewMode.Edit)
        fvFAQ.DataBind()
        lblFAQTitle.Text = "Edit FAQ"
        mvFAQ.SetActiveView(vAddEditFAQ)
    End Sub
    Protected Sub Delete_Click(sender As Object, e As CommandEventArgs)
        Dim nFAQID As Integer = CInt(e.CommandArgument)
        Dim taFAQs As New ITSPTableAdapters.FAQsTableAdapter
        taFAQs.Delete(nFAQID)
        bsgvFAQs.DataBind()
    End Sub
    Private Sub lbtDownloadFAQs_Click(sender As Object, e As EventArgs) Handles lbtDownloadFAQs.Click
        HideColumns(True)
        FAQsGridViewExporter.WriteXlsxToResponse()
        HideColumns(False)
    End Sub
    Protected Sub HideColumns(ByVal show As Boolean)
        bsgvFAQs.Columns("Edit").Visible = Not show
        bsgvFAQs.Columns("Delete").Visible = Not show
    End Sub
    Private Sub lbtClearFilters_Click(sender As Object, e As EventArgs) Handles lbtClearFilters.Click
        bsgvFAQs.FilterExpression = String.Empty
        bsgvFAQs.SearchPanelFilter = String.Empty
    End Sub
End Class