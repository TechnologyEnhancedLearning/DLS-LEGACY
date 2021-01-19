<%@ Page Title="Current Courses" Language="vb" AutoEventWireup="false" MasterPageFile="~/learningportal/lportal.Master" CodeBehind="Current.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.Current" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    <style>
        .push-right{
            margin-left:72px;
        }
    </style>
    <h2>My Current Courses</h2>
    <hr />
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ObjectDataSource ID="dsCurrentCourses" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.LearnerPortalTableAdapters.GetCurrentCoursesForCandidateTableAdapter">
        <SelectParameters>
            <asp:SessionParameter Name="CandidateID" SessionField="learnCandidateID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <dx:BootstrapGridView EnableCallBacks="false" ID="bsgvCurrent" runat="server" Settings-GridLines="None" AutoGenerateColumns="False" DataSourceID="dsCurrentCourses" KeyFieldName="ProgressID" SettingsBootstrap-Sizing="Large">
        <CssClasses Table="table table-striped" />

                        <Settings ShowHeaderFilterButton="True" />
                        <SettingsCookies Enabled="True" Version="0.1" StoreFiltering="False" StorePaging="False" StoreSearchPanelFiltering="False" />
                        <SettingsPager PageSize="15">
                        </SettingsPager>
        <Columns>
            <dx:BootstrapGridViewTextColumn VisibleIndex="0">
                <DataItemTemplate>
                    <asp:LinkButton EnableViewState="false" ID="lbtLaunch" CssClass="btn btn-success" tooltip="Launch Course" OnCommand="lbtLaunch_Command" CommandArgument='<%#Eval("CustomisationID")%>' runat="server"><i aria-hidden="true" class="fas fa-play"></i></asp:LinkButton>
       
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="CourseName" Settings-AllowHeaderFilter="False" Caption="Course" ReadOnly="True" VisibleIndex="1">
                <DataItemTemplate>
                    <asp:Label ID="Label4" EnableViewState="false" runat="server" Text='<%# Eval("CourseName") %>'></asp:Label> <asp:LinkButton ID="lbtUnlockRequest" EnableViewState="false" OnCommand="lbtUnlockRequest_Command" CommandArgument='<%#Eval("ProgressID")%>' CssClass="btn btn-outline-secondary" Visible='<%# Eval("PLLocked") %>' ToolTip="Assessment limit reached - request unlock" runat="server"><i aria-hidden="true" class="fas fa-lock"></i></asp:LinkButton>
                   
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn Name="Content" Caption="Content" VisibleIndex="2">
                <DataItemTemplate>
                    <span class="text-info small">
                     <i aria-hidden="true" visible='<%# Eval("HasDiagnostic") %>' runat="server" title="Includes Diagnostic Assessment" class="fas fa-bullseye"></i>&nbsp;
                    <i aria-hidden="true" visible='<%# Eval("HasLearning") %>' runat="server" title="Includes Learning Content" class="fas fa-book"></i>&nbsp;
                    <i aria-hidden="true" title="Includes Post Learning Assessment and Certification" visible='<%# Eval("IsAssessed") %>' runat="server" class="fas fa-graduation-cap"></i>&nbsp;
                        <i class="fas fa-chalkboard-teacher" title="Course supervisor" aria-hidden="true" runat="server" visible='<%# Eval("SupervisorAdminID") > 0 %>'></i>&nbsp;
                        <i class="fas fa-users" title="Enrolled with group" aria-hidden="true" runat="server" visible='<%# Eval("GroupCustomisationID") > 0 %>'></i>
                    </span>
               </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewDateColumn FieldName="StartedDate" Caption="Enrolled" VisibleIndex="3">
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewDateColumn FieldName="LastAccessed" Caption="Last Access" VisibleIndex="4">
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewDateColumn FieldName="CompleteByDate" Caption="Complete By" VisibleIndex="5">
                <DataItemTemplate>
                     <asp:LinkButton ID="lbtSetUTC" EnableViewState="false" OnCommand="lbtSetUTC_Command" CommandArgument='<%# Eval("ProgressID") %>' Visible='<%# Eval("CompleteByDate").ToString.Length = 0%>' CssClass="push-right btn btn-xs btn-info" ToolTip="Set Complete By Date" runat="server"><i aria-hidden="true" class="fas fa-pencil-alt"></i></asp:LinkButton>
                    <asp:Label ID="lblCompBy" EnableViewState="false" runat="server" Visible='<%# Eval("CompleteByDate").ToString.Length > 0%>' Text='<%# Eval("CompleteByDate", "{0:d}") %>'></asp:Label>
                     <asp:LinkButton ID="lbtEditUTC" EnableViewState="false" OnCommand="lbtEditUTC_Command" CommandArgument='<%# Eval("ProgressID") %>'  Visible='<%# Eval("CompleteByDate").ToString.Length > 0 And Eval("EnrollmentMethodID") = 1 %>' CssClass="btn btn-xs" ToolTip="Alter Complete By Date" runat="server"><i aria-hidden="true" class="fas fa-pencil-alt"></i></asp:LinkButton>
               
                </DataItemTemplate>
            </dx:BootstrapGridViewDateColumn>
            <dx:BootstrapGridViewTextColumn FieldName="DiagnosticScore" Caption="Diag" Settings-AllowHeaderFilter="False"  VisibleIndex="6">
                <DataItemTemplate>
                    <asp:Label ID="Label1" EnableViewState="false" runat="server" Visible='<%#Eval("HasDiagnostic") And Not Eval("DiagnosticScore").ToString = "" And Not Eval("DiagnosticScore").ToString = "0"%>' Text='<%# Eval("DiagnosticScore") & "%" %>'></asp:Label>
                    <asp:Label ID="Label3" EnableViewState="false" runat="server" Visible='<%#Not Eval("HasDiagnostic") Or Eval("DiagnosticScore").ToString = "" Or Eval("DiagnosticScore").ToString = "0"%>' Text="-"></asp:Label>
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn FieldName="Passes" Caption="Assess" Settings-AllowHeaderFilter="False"  ReadOnly="True" VisibleIndex="7">
                <DataItemTemplate>
                    <asp:Label ID="Label2" EnableViewState="false" runat="server" Visible='<%# Eval("IsAssessed") %>' Text='<%# Eval("Passes") & "/" & Eval("Sections") %>'></asp:Label>
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
            <dx:BootstrapGridViewTextColumn VisibleIndex="8">
                <DataItemTemplate>
                    <asp:LinkButton EnableViewState="false" ID="lbtRemove" ToolTip="Remove from Current Courses" aria-label='<%# Eval("CourseName", "Remove {0} from Current Courses") %>' CssClass="btn btn-danger btn-sm" Visible='<%# Eval("EnrollmentMethodID") = 1 %>' CommandArgument='<%# Eval("ProgressID") %>' OnCommand="lbtRemove_Command" runat="server"><i aria-hidden="true" class="fas fa-trash"></i> </asp:LinkButton>
                </DataItemTemplate>
            </dx:BootstrapGridViewTextColumn>
        </Columns>
        <FormatConditions>
            <dx:GridViewFormatConditionHighlight FieldName="CompleteByDate"  Expression="[OverDue] = 2" ApplyToRow="true" Format="Custom">
                <RowStyle BackColor="#f8d7da" />
            </dx:GridViewFormatConditionHighlight>
            <dx:GridViewFormatConditionHighlight FieldName="CompleteByDate"  Expression="[OverDue] = 1" ApplyToRow="true" Format="Custom">
                <RowStyle BackColor="#fff3cd" />
            </dx:GridViewFormatConditionHighlight>
            <dx:GridViewFormatConditionHighlight FieldName="CompleteByDate"  Expression="[OverDue] = 2" Format="LightRedFillWithDarkRedText" />
            <dx:GridViewFormatConditionHighlight FieldName="CompleteByDate"  Expression="[OverDue] = 1" Format="YellowFillWithDarkYellowText" />
        </FormatConditions>
        <SettingsSearchPanel Visible="True" />
    </dx:BootstrapGridView>
  
    <div class="modal fade" tabindex="-1" id="modalUnlockConfirm" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        
        <h5 class="modal-title">Unlock Request Submitted</h5><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
        <p>Your request to unlock your progress for this course has been submitted by e-mail to your Digital Learning Solutions centre administrators.</p>
          <p>You should receive a copy of this e-mail at the e-mail address associated with your Digital Learning Solutions registration.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary float-right" data-dismiss="modal">OK</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
     <div class="modal fade" tabindex="-1" id="modalSetDate" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        
        <h5 class="modal-title">Set Complete By Date for Course: <asp:Label ID="lblCourseName" runat="server" Text="Label"></asp:Label></h5><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
          <div class="alert alert-info">
              Setting a complete by date for a course will allow you to receive reminders to complete your course as the date approaches.
          </div>
        <div class="m-3">
            <div class="form-group row">
                <asp:Label ID="lblDate" CssClass="col col-sm-4 control-label" runat="server" Text="Complete by:"></asp:Label>
                <div class="col col-sm-8">
                    <asp:HiddenField ID="hfProgressID" runat="server" />
                    <asp:TextBox ID="tbCompleteBy" Text='<%# Bind("CompleteByDate", "{0:dd/MM/yyyy}") %>' data-provide="datepicker" data-date-format="dd/mm/yyyy" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-secondary mr-auto float-left" data-dismiss="modal">Cancel</button>
          <asp:LinkButton ID="lbtSubmitTBC" CssClass="btn btn-primary float-right" runat="server">Submit</asp:LinkButton>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
     <div class="modal fade" tabindex="-1" id="modalConfirm" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
       
        <h5 class="modal-title">Remove Course from Current Courses?</h5> <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
          <asp:HiddenField ID="hfRemoveProgressID" runat="server" />
        <p>Are you sure that you wish to remove this course from your Current Courses list?</p>
          <p>If you remove it, and decide that you wish to add it again in future, your current progress will be lost.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-secondary mr-auto float-left" data-dismiss="modal">Cancel</button>
          <asp:LinkButton ID="lbtConfirmRemove" ToolTip="Confirm remove" class="btn btn-danger float-right" runat="server">Remove</asp:LinkButton>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
        <div class="modal fade" tabindex="-1" id="modalInvalidCourse" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        
        <h5 class="modal-title">Invalid Course</h5><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
        <p>You attempted to enrol on an invalid course.</p>
          <p>This is probably because the course is no longer active.</p>
          <p>For help, please contact your centre administrator.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary float-right" data-dismiss="modal">OK</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
     <script>
                $('.pick-date').datepicker({
                    format: "dd/mm/yyyy"
                });
            </script>
</asp:Content>

