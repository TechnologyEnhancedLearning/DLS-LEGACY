﻿'------------------------------------------------------------------------------
' <auto-generated>
'     This code was generated by a tool.
'
'     Changes to this file may cause incorrect behavior and will be lost if
'     the code is regenerated. 
' </auto-generated>
'------------------------------------------------------------------------------

Option Strict On
Option Explicit On


Partial Public Class tickets

    '''<summary>
    '''mvSupportTickets control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents mvSupportTickets As Global.System.Web.UI.WebControls.MultiView

    '''<summary>
    '''vTicketList control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents vTicketList As Global.System.Web.UI.WebControls.View

    '''<summary>
    '''dsTickets control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents dsTickets As Global.System.Web.UI.WebControls.ObjectDataSource

    '''<summary>
    '''dsReassigns control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents dsReassigns As Global.System.Web.UI.WebControls.ObjectDataSource

    '''<summary>
    '''dsTicketComments control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents dsTicketComments As Global.System.Web.UI.WebControls.ObjectDataSource

    '''<summary>
    '''dsCustomisations control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents dsCustomisations As Global.System.Web.UI.WebControls.ObjectDataSource

    '''<summary>
    '''dsTicketTypes control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents dsTicketTypes As Global.System.Web.UI.WebControls.ObjectDataSource

    '''<summary>
    '''dsCategoryID control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents dsCategoryID As Global.System.Web.UI.WebControls.ObjectDataSource

    '''<summary>
    '''bscbIncludeArchive control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents bscbIncludeArchive As Global.DevExpress.Web.Bootstrap.BootstrapCheckBox

    '''<summary>
    '''TicketGridViewExporter control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents TicketGridViewExporter As Global.DevExpress.Web.ASPxGridViewExporter

    '''<summary>
    '''bsgvTickets control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents bsgvTickets As Global.DevExpress.Web.Bootstrap.BootstrapGridView

    '''<summary>
    '''vManageTicket control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents vManageTicket As Global.System.Web.UI.WebControls.View

    '''<summary>
    '''hfTicketID control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents hfTicketID As Global.System.Web.UI.WebControls.HiddenField

    '''<summary>
    '''hfReporterEmail control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents hfReporterEmail As Global.System.Web.UI.WebControls.HiddenField

    '''<summary>
    '''hfReporterAUID control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents hfReporterAUID As Global.System.Web.UI.WebControls.HiddenField

    '''<summary>
    '''lblTicketHeader control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lblTicketHeader As Global.System.Web.UI.WebControls.Label

    '''<summary>
    '''lblTicketStatus control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lblTicketStatus As Global.System.Web.UI.WebControls.Label

    '''<summary>
    '''lbtCloseTicket control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lbtCloseTicket As Global.System.Web.UI.WebControls.LinkButton

    '''<summary>
    '''lbtArchiveTicket control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lbtArchiveTicket As Global.System.Web.UI.WebControls.LinkButton

    '''<summary>
    '''pnlAssignTo control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents pnlAssignTo As Global.System.Web.UI.WebControls.Panel

    '''<summary>
    '''btnAssignTo control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents btnAssignTo As Global.System.Web.UI.HtmlControls.HtmlButton

    '''<summary>
    '''lblAssignTo control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lblAssignTo As Global.System.Web.UI.WebControls.Label

    '''<summary>
    '''rptAssignTo control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents rptAssignTo As Global.System.Web.UI.WebControls.Repeater

    '''<summary>
    '''lbtRemoveAssign control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lbtRemoveAssign As Global.System.Web.UI.WebControls.LinkButton

    '''<summary>
    '''pnlPriority control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents pnlPriority As Global.System.Web.UI.WebControls.Panel

    '''<summary>
    '''Button1 control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents Button1 As Global.System.Web.UI.HtmlControls.HtmlButton

    '''<summary>
    '''lblResolveByDD control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lblResolveByDD As Global.System.Web.UI.WebControls.Label

    '''<summary>
    '''lbtSameDay control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lbtSameDay As Global.System.Web.UI.WebControls.LinkButton

    '''<summary>
    '''lbtNextDay control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lbtNextDay As Global.System.Web.UI.WebControls.LinkButton

    '''<summary>
    '''lbtOneWeek control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lbtOneWeek As Global.System.Web.UI.WebControls.LinkButton

    '''<summary>
    '''lbtChangeRequest control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lbtChangeRequest As Global.System.Web.UI.WebControls.LinkButton

    '''<summary>
    '''pnlTicketHeader control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents pnlTicketHeader As Global.System.Web.UI.WebControls.Panel

    '''<summary>
    '''lblTicketSubject control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lblTicketSubject As Global.System.Web.UI.WebControls.Label

    '''<summary>
    '''lblAddedBy control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lblAddedBy As Global.System.Web.UI.WebControls.Label

    '''<summary>
    '''lblAddedDate control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lblAddedDate As Global.System.Web.UI.WebControls.Label

    '''<summary>
    '''lblLastUpdate control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lblLastUpdate As Global.System.Web.UI.WebControls.Label

    '''<summary>
    '''resby1 control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents resby1 As Global.System.Web.UI.HtmlControls.HtmlGenericControl

    '''<summary>
    '''resby2 control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents resby2 As Global.System.Web.UI.HtmlControls.HtmlGenericControl

    '''<summary>
    '''lblResolveBy control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lblResolveBy As Global.System.Web.UI.WebControls.Label

    '''<summary>
    '''pnlCatType control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents pnlCatType As Global.System.Web.UI.WebControls.Panel

    '''<summary>
    '''UpdatePanel1 control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents UpdatePanel1 As Global.System.Web.UI.UpdatePanel

    '''<summary>
    '''ddTicketTypeManage control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents ddTicketTypeManage As Global.System.Web.UI.WebControls.DropDownList

    '''<summary>
    '''ddTicketCategoryManage control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents ddTicketCategoryManage As Global.System.Web.UI.WebControls.DropDownList

    '''<summary>
    '''pnlProblemContext control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents pnlProblemContext As Global.System.Web.UI.WebControls.Panel

    '''<summary>
    '''lbtLaunchCourse control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lbtLaunchCourse As Global.System.Web.UI.WebControls.LinkButton

    '''<summary>
    '''lblNoCourse control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lblNoCourse As Global.System.Web.UI.WebControls.Label

    '''<summary>
    '''lblDelID control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lblDelID As Global.System.Web.UI.WebControls.Label

    '''<summary>
    '''NewCommentPanel control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents NewCommentPanel As Global.System.Web.UI.WebControls.Panel

    '''<summary>
    '''htmlAddComment control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents htmlAddComment As Global.DevExpress.Web.ASPxHtmlEditor.ASPxHtmlEditor

    '''<summary>
    '''lbtSubmitNewComment control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lbtSubmitNewComment As Global.System.Web.UI.WebControls.LinkButton

    '''<summary>
    '''rptComments control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents rptComments As Global.System.Web.UI.WebControls.Repeater

    '''<summary>
    '''lblModalTitle control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lblModalTitle As Global.System.Web.UI.WebControls.Label

    '''<summary>
    '''lblModalBody control.
    '''</summary>
    '''<remarks>
    '''Auto-generated field.
    '''To modify move field declaration from designer file to code-behind file.
    '''</remarks>
    Protected WithEvents lblModalBody As Global.System.Web.UI.WebControls.Label
End Class
