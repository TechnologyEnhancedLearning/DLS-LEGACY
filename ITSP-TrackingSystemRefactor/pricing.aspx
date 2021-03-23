<%@ Page Title="Pricing" Language="vb" AutoEventWireup="false" CodeBehind="pricing.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.pricing" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ObjectDataSource ID="dsContractTypes" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.ContractTypesTableAdapter"></asp:ObjectDataSource>
    <div class="container"> 
    <div class="row pricing-table-container">
          <div class="col col-md-4 d-none d-lg-block pricing-col">
            <div class="pricing-table pricing-table-description">
              <div class="pricing-table-head">
                <h2> Plans Available
                  <span></span>
                </h2>
                <h3 class="price"> Annual cost </h3>
                  <div class="text-center">Setup fee (year one only)</div>
              </div>
              <ul class="pricing-table-content">
             
                <li>
                  <i class="fas fa-chart-line"></i>Tracking System Access </li>
                     <li>
                  <i class="fas fa-user-cog"></i>Administrators </li>
                     <li>
                 
                         <i class="fas fa-users"></i>Learners </li> 
                  <li>
                 
                         <a tabindex="0" class="" role="button" data-toggle="popover" data-trigger="focus" data-content="Trainers use the system to manage the delivery of face-to-face training sessions through the system. They can schedule training events for delegates to book and record attendance at events they've delivered.">
                             <i class="fas fa-chalkboard-teacher"></i>Trainers <small>(coming soon)</small></a> </li> 
                  <li>
                 
                         <a tabindex="0" class="" role="button" data-toggle="popover" data-trigger="focus" data-content="Supervisors use the system to monitor and sign off learner progress. They can also schedule one to one or group supervision sessions in the system (currently in pilot).">
                             <i class="fas fa-id-card-alt"></i>Supervisors</a> </li> 
                  <li>
                   <a tabindex="0" class="" role="button" data-toggle="popover" data-trigger="focus" data-content="Content Management System (CMS) Administrators can use the CMS to reconfigure and combine content from centrally provided courses to suit local needs.">
                       <i class="fas fa-cog"></i>CMS Administrators </a></li>
               
                     <li>
                  <a tabindex="0" class="" role="button" data-toggle="popover" data-trigger="focus" data-content="Content Management System (CMS) Managers use the CMS to configure bespoke courses for their organisation. They can upload e-learning content produced using Content Creator or other off-the-shelf authoring tools.">
                      <i class="fas fa-cogs"></i>CMS Managers </a></li>
                     <li>
                 
                  <a tabindex="0" class="" role="button" data-toggle="popover" data-trigger="focus" data-content="Custom courses are bespoke courses created by CMS Managers to deliver against organisational training needs.">
                      <i class="fas fa-book"></i>Custom courses hosted </a></li>
                  <li>
<a tabindex="0" class="" role="button" data-toggle="popover" data-trigger="focus" data-content="Learner upload space is used to allow learners to upload evidence to their development log for relevant activities.">
    <i class="fas fa-cloud-upload-alt"></i>Per learner upload space </a></li>
                  <li>
<a tabindex="0" class="" role="button" data-toggle="popover" data-trigger="focus" data-content="Server space is needed for uploading custom course content (e-learning, videos and supporting materials).">
    <i class="fas fa-cloud-upload-alt"></i>Server space </a></li>
                
               <li>
                  <i class="fas fa-laptop"></i> Webinar setup support</li>
                  <li>
                  <i class="fas fa-chalkboard"></i> Face-to-face consultancy</li>
                <li>
                  <i class="fas fa-life-ring"></i>Technical Support </li>
                  <li>
                  <i class="fas fa-question-circle"></i>Learner Support </li>
              </ul>
            </div>
          </div>
        <asp:Repeater ID="rptContractTypes" DataSourceID="dsContractTypes" runat="server">
            <ItemTemplate>
                <div class="col col-lg-2 col-md-6 pricing-col">
            <div class="pricing-table">
              <div class="pricing-table-head">
                <h2> <%# Eval("ContractType") %>
                  <span><%# Eval("ContractDescription") %></span>
                </h2>
                <h3 class="price">
                  £<i><%# Eval("AnnualCost", "{0:N0}") %></i>
                  <span class="d-inline d-lg-none">Per Year</span>
                </h3>
                  <div class="text-center">£<i><%# IIF(Eval("SetupFee") = 0, Eval("SetupFee", "{0:N0}"), Eval("SetupFee", "{0:N0}") & "**") %></i></div>
              </div>
              <ul class="pricing-table-content">
                <li> <%# IIF(Eval("TSAccess"), "<i class='fas fa-check'></i>", "<i class='fas fa-times'></i>") %>
                  <span class="d-block d-lg-none"><%# IIF(Eval("TSAccess"), "Tracking System Access", "No Tracking System Access") %></span>
                </li>
                <li> <%# IIF(Eval("Administrators") = -1, "<i class='fas fa-infinity text-success'></i>", Eval("Administrators").ToString) %>
                  <span class="d-block d-lg-none"><%# IIF(Eval("Administrators") = -1, "Unlimited Administrators", "Administrators") %></span>
                </li>
                <li><%# IIF(Eval("Learners") = -1, "<i class='fas fa-infinity text-success'></i>", Eval("Learners").ToString) %>
                      <span class="d-block d-lg-none"><%# IIF(Eval("Learners") = -1, "Unlimited Learners", "Learners") %></span>
                </li>
                  <li><%# IIF(Eval("Trainers") = -1, "<i class='fas fa-infinity text-success'></i>", Eval("Trainers").ToString) %>
                      <span class="d-block d-lg-none"><%# IIF(Eval("Trainers") = -1, "Unlimited Trainers", "Trainers") %></span>
                </li>
                  <li><%# IIF(Eval("Supervisors") = -1, "<i class='fas fa-infinity text-success'></i>", Eval("Supervisors").ToString) %>
                      <span class="d-block d-lg-none"><%# IIF(Eval("Supervisors") = -1, "Unlimited Supervisors", "Supervisors") %></span>
                </li>
                  <li> <%# IIF(Eval("CMSAdministratorsInc") = -1, "<i class='fas fa-infinity text-success'></i>", IIf(Eval("CMSAdministratorsInc") = 0, "<i class='fas fa-times'></i>", Eval("CMSAdministratorsInc").ToString)) %>
                  <span class="d-block d-lg-none"><%# IIF(Eval("CMSAdministratorsInc") = -1, "Unlimited CMS Administrators", "CMS Administrators") %></span>
                </li>
                   <li> <%# IIF(Eval("CMSManagersInc") = -1, "<i class='fas fa-infinity text-success'></i>", IIf(Eval("CMSManagersInc") = 0, "<i class='fas fa-times'></i>", Eval("CMSManagersInc").ToString)) %>
                  <span class="d-block d-lg-none"><%# IIF(Eval("CMSManagersInc") = -1, "Unlimited CMS Managers", "CMS Managers") %></span>
                </li>
                
                <li> <%# IIF(Eval("CustomCoursesInc") = -1, "<i class='fas fa-infinity text-success'></i>", IIf(Eval("CustomCoursesInc") = 0, "<i class='fas fa-times'></i>", Eval("CustomCoursesInc").ToString)) %>
                  <span class="d-block d-lg-none"><%# IIF(Eval("CustomCoursesInc") = -1, "Unlimited Custom Courses", "Custom Courses") %></span>
                </li>
                 <li>
                 <%# IIf(Eval("DelegateUploadSpace") = 0, "<i class='fas fa-times'></i>", NiceBytes(Eval("DelegateUploadSpace")))%>
                  <span class="d-block d-lg-none">Upload Space</span>
                </li>
                <li>
                 <%# IIf(Eval("ServerSpaceBytesInc") = 0, "<i class='fas fa-times'></i>", NiceBytes(Eval("ServerSpaceBytesInc")))%>
                  <span class="d-block d-lg-none">Server Space</span>
                </li>
                  <li>
                   <%# IIf(Eval("WebinarSupportHours") > 2, Eval("WebinarSupportHours") & " hours*", Eval("WebinarSupportHours") & " hours")%>
                  <span class="d-block d-lg-none">Webinar Support</span>
                </li>
                  <li>
                 <%# IIf(Eval("FaceToFaceSupportDays") = 1, "1 day", Eval("FaceToFaceSupportDays") & " days")%>
                  <span class="d-block d-lg-none">Face-to-face Training</span>
                </li>
                <li> <%# IIf(Eval("TechnicalSupport"), "<i class='fas fa-check'></i>", "<i class='fas fa-times'></i>") %>
                  <span class="d-block d-lg-none"><%# IIF(Eval("TechnicalSupport"), "Technical Support", "No Technical Support") %></span>
                </li>
                <li>
                  <%# IIf(Eval("LearnerSupport"), "<i class='fas fa-check'></i>", "<i class='fas fa-times'></i>") %>
                  <span class="d-block d-lg-none"><%# IIF(Eval("LearnerSupport"), "Learner Support", "No Learner Support") %></span>
                </li>
               
              </ul>
              <div class="pricing-table-footer text-center">
                <a href="home#contact" class="btn btn-info btn-raised">
                  <i class="fas fa-envelope"></i> Enquire</a>
              </div>
            </div>
          </div>
            </ItemTemplate>
        </asp:Repeater>
          
        
        <div class="col col-lg-2 col-md-6 pricing-col pricing-col-grey">
            <div class="pricing-table">
              <div class="pricing-table-head">
                <h2> Bespoke options
                  <span>Customise your package</span>
                </h2>
                <h3 class="price"> Itemised below
                  
                </h3>
                  <div class="text-center">-</div>
              </div>
              <ul class="pricing-table-content">
                <li> -
                </li>
                <li> -
                </li>
               
                <li>-
                  
                </li><li>-
                  
                </li>
                  <li> -
                </li>
                   <li> -
                </li>
                <li> -
                </li>
                <li> 
                     £250 per 10 <span class="d-block d-lg-none">Custom courses hosted</span>
                </li>
                  <li>
                  £250 per 50MB <span class="d-block d-lg-none">Learner Upload Space</span>
                </li>
                <li>
                  £250 per 5GB <span class="d-block d-lg-none">Server Space</span>
                </li>
               
                   <li>
                  £200 per hour <span class="d-block d-lg-none">Webinar Support</span>
                </li>
                  <li>
                  £600 per day + costs <span class="d-block d-lg-none">Face-to-face Training</span>
                </li>
                <li>
                  -
                </li>
                <li>
                  £POA <span class="d-block d-lg-none">Learner Support</span>
                </li>
               
              </ul>
              <div class="pricing-table-footer text-center">
                
              </div>
            </div>
          </div>
        </div>
        <hr />
        <div class="card card-default">
                  <div class="card-body">
                      <p>All prices are exclusive of VAT at the prevailing rate.</p>
                    <p>The prices listed above are applicable to public sector / not for profit health and social care organisations in England. Enquiries from other organisations are welcome but are subject to bespoke pricing.</p>
                      <p>The prices for bespoke options are only available to organisations who have purchased the Premium or Enterprise plan.</p>
                    <hr class="dashed">
                    <p>* Year 1 only - includes 2 hours Standard setup.</p>
                    <hr class="dashed">
                    <p>** Applies to new centres and existing standard centres that upgrade.</p>
                      <%--<hr class="dashed">
                      <h5>Additional Products and Services</h5>
                      <table class="table table-striped">
                          <tr>
                              <td>Content Creator single user licence (one off cost including 1st year technical support)</td>
                              <td>£350</td>
                          </tr>
                          <tr>
                              <td>Content Creator annual technical support</td>
                              <td>£100</td>
                          </tr>
                          <tr>
                              <td>Content Creator webinar training</td>
                              <td>£50 per hour</td>
                          </tr>
                      </table>--%>
                  </div>
                </div>
        </div>
</asp:Content>
