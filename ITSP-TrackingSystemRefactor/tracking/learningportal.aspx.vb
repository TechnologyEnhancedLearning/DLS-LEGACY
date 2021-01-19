Imports DevExpress.Web.Bootstrap

Public Class learningportal
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim pwl As TextBox = fvCentreKB.FindControl("tbPassword_RO")
            Dim pw As String = ""
            If Not pwl Is Nothing Then
                pw = pwl.Text
            End If
            SetupLinks(pw)

    End Sub
    Protected Sub SetupLinks(ByVal pwl As String)
        'generate a link for the knowledge bank for this centre:
        Dim linkEmailLP As HyperLink = fvCentreKB.FindControl("lbtSendLPMessage")
        If Not linkEmailLP Is Nothing Then
            Dim sLinkLP As String = CCommon.GetServerDomain("https", 80) & "home?action=login&app=lp&centreid=" & Session("UserCentreID")
            Dim lbtLaunch As LinkButton
            lbtLaunch = fvCentreKB.FindControl("lbtLaunchLearningPortal")
            If Not lbtLaunch Is Nothing Then
                lbtLaunch.PostBackUrl = sLinkLP
            End If
            'use this link in an e-mail on the send message link button:
            Dim sPassword As String = String.Empty

            '
            ' Set up password
            '

            If pwl <> String.Empty Then
                sPassword = ". Use the password '" & pwl & "'."
            End If
            Session("LinkAndPassLP") = sLinkLP.Replace("&", "%26") & sPassword.Replace("&", "%26")
            linkEmailLP.NavigateUrl = "mailto:?subject=Digital Learning Solutions Learning Portal Link&body=To access the Digital Learning Solutions Learning Portal, with access to all of your centre's Digital Learning Solutions courses, your completion certificates and searchable Knowledge Bank, click " & Session("LinkAndPassLP").ToString()
        End If
    End Sub

    Private Sub fvCentreKB_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs) Handles fvCentreKB.ItemUpdated
        Dim pwl As TextBox = fvCentreKB.FindControl("tbPassword")
        Dim pw As String = ""
        If Not pwl Is Nothing Then
            pw = pwl.Text
        End If
    End Sub
    Protected Sub detailGrid_DataSelect(sender As Object, e As EventArgs)
        Session("KBCID") = TryCast(sender, BootstrapGridView).GetMasterRowKeyValue()
    End Sub
    Protected Sub GridViewCustomToolbar_ToolbarItemClick(sender As Object, e As BootstrapGridViewToolbarItemClickEventArgs)
        If e.Item.Name = "ExcelExport" Then
            bsGridViewExporter.WriteXlsxToResponse()
        End If
    End Sub

    Private Sub fvCentreKB_DataBound(sender As Object, e As EventArgs) Handles fvCentreKB.DataBound
        Dim taCBE As New LearnerPortalTableAdapters.KBCentreBrandsExcludesTableAdapter
        Dim tCBE As New LearnerPortal.KBCentreBrandsExcludesDataTable
        tCBE = taCBE.GetData(Session("UserCentreID"))
        Dim bsl As BootstrapListBox = fvCentreKB.FindControl("bslbBrands")
        If tCBE.Count > 0 Then
            For Each r As LearnerPortal.KBCentreBrandsExcludesRow In tCBE.Rows

                For Each i As BootstrapListEditItem In bsl.Items
                    If CInt(i.Value) = r.BrandID Then
                        i.Selected = True
                    End If
                Next
            Next
        End If
        Dim taCCE As New LearnerPortalTableAdapters.KBCentreCategoryExcludesTableAdapter
        Dim tCCE As New LearnerPortal.KBCentreCategoryExcludesDataTable
        tCCE = taCCE.GetData(Session("UserCentreID"))
        bsl = fvCentreKB.FindControl("bslCategories")
        If tCCE.Count > 0 Then
            For Each r As LearnerPortal.KBCentreCategoryExcludesRow In tCCE.Rows

                For Each i As BootstrapListEditItem In bsl.Items
                    If CInt(i.Value) = r.CategoryID Then
                        i.Selected = True
                    End If
                Next
            Next
        End If
    End Sub

    Private Sub fvCentreKB_ItemUpdating(sender As Object, e As FormViewUpdateEventArgs) Handles fvCentreKB.ItemUpdating
        Dim taCBE As New LearnerPortalTableAdapters.KBCentreBrandsExcludesTableAdapter
        Dim taCCE As New LearnerPortalTableAdapters.KBCentreCategoryExcludesTableAdapter
        Dim bsl As BootstrapListBox = fvCentreKB.FindControl("bslbBrands")
        Dim nCentreID As Integer = Session("UserCentreID")
        For Each i As BootstrapListEditItem In bsl.Items
            taCBE.DeleteQuery(nCentreID, CInt(i.Value))
            If i.Selected Then
                taCBE.InsertIfNotExists(nCentreID, CInt(i.Value))
            End If
        Next
        bsl = fvCentreKB.FindControl("bslCategories")
        For Each i As BootstrapListEditItem In bsl.Items
            taCCE.DeleteQuery(nCentreID, CInt(i.Value))
            If i.Selected Then
                taCCE.InsertIfNotExists(nCentreID, CInt(i.Value))
            End If
        Next
    End Sub
End Class