Imports DevExpress.Web
Imports DevExpress.Web.Bootstrap
Imports DevExpress.Web.Data
Public Class admin_configuration
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub lbtAddCentreType_Click(sender As Object, e As EventArgs) Handles lbtAddCentreType.Click
        Dim taCT As New ITSPTableAdapters.CentreTypesTableAdapter
        taCT.Insert(tbCentreTypeAdd.Text.Trim())
        tbCentreTypeAdd.Text = ""
        gvCentreTypes.DataBind()
    End Sub

    Private Sub lbtAddJobGroup_Click(sender As Object, e As EventArgs) Handles lbtAddJobGroup.Click
        Dim taJG As New ITSPTableAdapters.JobGroupsTableAdapter
        taJG.Insert(tbJobGroupAdd.Text.Trim())
        tbJobGroupAdd.Text = ""
        gvJobGroups.DataBind()
    End Sub

    Private Sub lbtAddRegion_Click(sender As Object, e As EventArgs) Handles lbtAddRegion.Click
        Dim taRegion As New ITSPTableAdapters.RegionsTableAdapter
        taRegion.Insert(tbRegionAdd.Text.Trim())
        tbRegionAdd.Text = ""
        gvRegions.DataBind()
    End Sub


    Protected Sub _DoModal(ByVal sMessage As String, ByVal sTitle As String)
        lblModalHeading.Text = sTitle
        lblModalMessage.Text = sMessage
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "ShowModalMessage", "<script>$('#messageModal').modal('show');</script>")
    End Sub

    Protected Function undoCamelCase(ByVal sInput As String) As String
        Return CCommon.CamelCaseToHumanReadableString(sInput)
    End Function


    Private Sub vManageLists_Activate(sender As Object, e As EventArgs) Handles vManageLists.Activate
        clearClasses()
        lbtManageLists.CssClass = "nav-link active"
    End Sub

    Private Sub vStatements_Activate(sender As Object, e As EventArgs) Handles vStatements.Activate
        clearClasses()
        lbtStatements.CssClass = "nav-link active"
    End Sub
    Protected Sub clearClasses()
        lbtStatements.CssClass = "nav-link"
        lbtManageLists.CssClass = "nav-link"
    End Sub


    Private Sub lbtManageLists_Click(sender As Object, e As EventArgs) Handles lbtManageLists.Click
        mvConfig.SetActiveView(vManageLists)
    End Sub

    Private Sub lbtStatements_Click(sender As Object, e As EventArgs) Handles lbtStatements.Click
        mvConfig.SetActiveView(vStatements)
    End Sub

    Private Sub fvLoginMessage_DataBound(sender As Object, e As EventArgs) Handles fvLoginMessage.DataBound
        Dim hf As HiddenField = fvLoginMessage.FindControl("hfIsHtml")
        If Not hf Is Nothing Then
            If hf.Value = "True" Then
                fvLoginMessage.Visible = False
                fvLoginMessageHTML.Visible = True
            Else
                fvLoginMessage.Visible = True
                fvLoginMessageHTML.Visible = False
            End If
        End If
    End Sub

    Private Sub fvLoginMessageHTML_ItemUpdating(sender As Object, e As FormViewUpdateEventArgs) Handles fvLoginMessageHTML.ItemUpdating
        If ddConfigItem.SelectedValue = "CCReleaseNotes" Then
            Dim htmlEdit As ASPxHtmlEditor.ASPxHtmlEditor = fvLoginMessageHTML.FindControl("htmlConfigText")
            If Not htmlEdit Is Nothing Then
                Dim sHtml As String = htmlEdit.Html
                'now we need to e-mail CC users that are subscribed:
                Dim taN As New NotificationsTableAdapters.UsersForNotificationTableAdapter
                Dim tN As New Notifications.UsersForNotificationDataTable
                tN = taN.GetData(8)
                Dim sVers As String = CCommon.GetConfigString("ContentCreatorCurrentVersion")
                sHtml = "<p>Dear colleague</p><p>As a user of Content Creator, we thought you'd like to know that a version " & sVers & " of the software has just been released.</p><p>The release notes are as follows:</p><hr/>" & sHtml
                sHtml = sHtml & "<hr/><p>To download the new version, please login to CMS and vist the <a href='https://www.dls.nhs.uk/cms/ContentCreator'>Content Creator</a> tab.</p>"
                For Each r As DataRow In tN

                    CCommon.SendEmail(r.Item("Email"), "New version of Content Creator Available (version " & sVers & ")", sHtml, True, "Digital Learning Solutions Notifications <noreply@dls.nhs.uk>")
                Next
            End If
        End If
    End Sub
    Protected Sub InitNewRow_DefaultActive(sender As Object, e As ASPxDataInitNewRowEventArgs)
        e.NewValues("Active") = True
        e.NewValues("CentreID") = 0
    End Sub


    'Private Sub fvLoginMessageHTML_DataBound(sender As Object, e As EventArgs) Handles fvLoginMessageHTML.DataBound
    '    Dim hf As HiddenField = fvLoginMessageHTML.FindControl("hfIsHtml")
    '    If Not hf Is Nothing Then
    '        If Not hf.Value = "True" Then
    '            fvLoginMessage.Visible = True
    '            fvLoginMessageHTML.Visible = False
    '        Else
    '            fvLoginMessage.Visible = False
    '            fvLoginMessageHTML.Visible = True
    '        End If
    '    End If
    'End Sub
End Class