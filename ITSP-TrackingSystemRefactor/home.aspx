<%@ Page Title="Welcome" Language="vb" AutoEventWireup="false" MasterPageFile="~/Landing.Master" CodeBehind="home.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.home" %>

<asp:Content ID="ContentSkipLink" ContentPlaceHolderID="SkipToContentLink" runat="server">
    <a id="go-content" href="#intro-next" class="skip-link">
                <i class="fas fa-arrow-down"></i> Skip to Content
              </a>
</asp:Content>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <meta name="Description" content="Digital Learning Solutions (DLS) home page, Information about products and services, learning content, the DLS team, customer stories, news and contact information"   />
    <style>
        
    </style>
       <script src="Scripts/welcome.js"></script>
    <div class="intro-full ms-hero-bg-primary color-white" id="home">
        <div id="intro-video">
            <video src="mp4/bkgvid.mp4" controls="controls" autoplay="autoplay" muted="muted" loop="loop"></video>
       </div>
        <div class="intro-full-content index-1">
          <div class="container">
            <div class="text-center mb-4">
                
                
              <span class="center-block mb-2 mt-2 animated zoomInDown animation-delay-5">
                  <img src="Images/DLS-Logo-XL.png" alt="Digital Learning Solutions Logo" /></span>
              <div class="h1 no-m ms-site-title color-white center-block ms-site-title-lg mt-2 animated zoomInDown animation-delay-5">
                <span>Digital Learning</span> Solutions
              </div>
              <p class="lead lead-lg color-white text-center center-block mt-2 mw-800 text-uppercase fw-300 animated fadeInUp animation-delay-7">The complete
                <span class="color-success">digital learning </span> platform for health and social care</p>
            </div>
              <div class="text-center mb-2">
                  <asp:Panel ID="pnlLogin" runat="server" Visible="True">
<a href="javascript:void(0)" data-toggle="modal" data-target="#pnlAccount" class="btn btn-raised btn-xlg btn-success animated zoomInUp animation-delay-10">
<i class="fas fa-sign-in-alt"></i> Login / Register
              </a>
                  </asp:Panel>
              <asp:Panel ID="pnlAppSelect" runat="server" Visible="False">
                  <a href="javascript:void(0)" aria-label="Open Digital Learning Solutions application selector modal" data-toggle="modal" data-target="#pnlAppSelect" class="btn btn-raised btn-xlg btn-success animated zoomInUp animation-delay-10">
<i class="fas fa-th-large"></i> Application Selector
              </a>
                       </asp:Panel>
                
            </div>
            <div class="text-center mb-2">
              <a id="go-intro-full-next" aria-label="Scroll to content" href="#intro-next" class="btn-circle btn-circle-raised btn-circle-white animated zoomInUp animation-delay-12">
                <i class="fas fa-arrow-down"></i>
              </a>
            </div>
          </div>
        </div>
      </div>
    <div id="intro-next"></div>
    <div class="bg-dark index-1 intro-fixed-next" tabindex="-1" id="coronavirus">
        <div class="container pt-4 pb-4 center-block">
        <a href="https://www.e-lfh.org.uk/programmes/coronavirus/" target="_blank" tabindex="-1">
<img src="https://www.e-lfh.org.uk/wp-content/uploads/2020/03/C19_Banner.jpg" alt="home-page-banner-Covid 19" title="home-page-banner-Covid 19"></a>
             <div class="text-center mw-800 center-block mt-4 mb-4">
                  <p class="lead lead-lg wow fadeInUp animation-delay-2">A new, free to access Coronavirus learning programme is now available on the e-Learning for Healthcare platform. Click the banner above to access.</p>
                 
                </div>
            </div>
    </div>
    <div class="bg-light index-2 intro-fixed-next pt-6">
        <div class="container mt-4">
                <h2 class="text-center mb-4 wow fadeInUp animation-delay-2">Delivering Digital Learning to Health and Social Care</h2>
                <div class="row">
                    <div class="col col-lg-3 col-md-6 col-sm-6">
                    <div class="card card-royal-inverse card-body overflow-hidden text-center wow zoomInUp animation-delay-5">
                      <div class="h2 counter">
                          <asp:Label ID="lblCentreCount" runat="server" Text=""></asp:Label></div>
                      <i aria-hidden="true" class="fas fa-4x fa-building"></i>
                      <p class="mt-2 no-mb lead small-caps color-white">centres</p>
                    </div>
                  </div>
                  <div class="col col-lg-3 col-md-6 col-sm-6">
                    <div class="card card-warning-inverse card-body overflow-hidden text-center wow zoomInUp animation-delay-2">
                      <div class="h2 counter">
                          <asp:Label ID="lblLearnerCount" runat="server" Text=""></asp:Label></div>
                      <i aria-hidden="true" class="fa fa-4x fa-group"></i>
                      <p class="mt-2 no-mb lead small-caps color-white">learners</p>
                    </div>
                  </div>
                  
                  <div class="col col-lg-3 col-md-6 col-sm-6">
                    <div class="card card-danger-inverse card-body overflow-hidden text-center wow zoomInUp animation-delay-4">
                      <div class="h2 counter">
                          <asp:Label ID="lblLearningHours" runat="server" Text=""></asp:Label></div>
                      <i aria-hidden="true" class="fa fa-4x fa-clock"></i>
                      <p class="mt-2 no-mb lead small-caps color-white">learning hours</p>
                    </div>
                  </div>
                  <div class="col col-lg-3 col-md-6 col-sm-6">
                    <div class="card card-success-inverse card-body overflow-hidden text-center wow zoomInUp animation-delay-3">
                      <div class="h2 counter">
                          <asp:Label ID="lblCompletionsCount" runat="server" Text=""></asp:Label></div>
                      <i aria-hidden="true" class="fa fa-4x fa-graduation-cap"></i>
                      <p class="mt-2 no-mb lead small-caps color-white">courses completed</p>
                    </div>
                  </div>
                </div>
                <div class="text-center mw-800 center-block mt-4">
                  <p class="lead lead-lg wow fadeInUp animation-delay-2">Our products and services can help you manage digital learning delivery for the benefit of the people in your organisation.</p>
                 
                </div>
            <div class="header-spacer"></div>
            </div>
         </div>
   
  <section id="team">
          <div class="container pt-6">
            <h2 class="color-primary text-center wow fadeInUp animation-delay-2">Meet the Team</h2>
            <div class="row">
              <div class="col-6">
                <div class="card mt-4 card-danger wow zoomInUp animation-delay-7">
                  <div class="ms-hero-bg-danger ms-hero-img-csbkg">
                    <img src="Images/claire.jpg" alt="Claire Adams portrait" class="img-avatar-circle">
                  </div>
                  <div class="card-body pt-6 text-center">
                    <h3 class="color-danger">Claire Adams</h3>
                    <p>Service Management Lead<br />Digital Learning Solutions</p>
                  </div>
                </div>
              </div>
              <div class="col-6">
                <div class="card mt-4 card-info wow zoomInUp animation-delay-7">
                  <div class="ms-hero-bg-info ms-hero-img-csbkg">
                    <img src="Images/david.jpg" alt=" David Levison portrait" class="img-avatar-circle">
                  </div>
                  <div class="card-body pt-6 text-center">
                    <h3 class="color-info">David Levison</h3>
                    <p>Senior Service Manager<br />Digital Learning Solutions</p>
                      </div>
                </div>
              </div>
              <div class="col-6">
                <div class="card mt-4 card-warning wow zoomInUp animation-delay-7">
                  <div class="ms-hero-bg-warning ms-hero-img-csbkg">
                    <img src="Images/carolyn.jpg" alt="Carolyn Mawdesley portrait" class="img-avatar-circle">
                  </div>
                  <div class="card-body pt-6 text-center">
                    <h3 class="color-warning">Carolyn Mawdesley</h3>
                    <p>Service Management Analyst<br /> Digital Learning Solutions</p>

                  </div>
                </div>
              </div>
              <div class="col-6">
                <div class="card mt-4 card-royal wow zoomInUp animation-delay-7">
                  <div class="ms-hero-bg-royal ms-hero-img-csbkg">
                    <img src="Images/kevin.jpg" alt="Kevin Whittaker portrait" class="img-avatar-circle">
                  </div>
                  <div class="card-body pt-6 text-center">
                    <h3 class="color-royal">Kevin Whittaker</h3>
                    <p>Senior Systems Developer<br />Digital Learning Solutions</p>
                  </div>
                </div>
              </div>
             
            </div>
              <div class="row">

              </div>
          </div>
        </section>
        <section id="contact" class="mt-6">
          <div class="wrap ms-hero-bg-dark ms-hero-img-study ms-bg-fixed">
            <div class="container">
              <h2 class="text-center color-white mb-4 wow fadeInUp animation-delay-2">Contact Us</h2>
              <div class="row">
                <div class="col-lg-12">
                  <%--<div class="card card-primary animated zoomInUp animation-delay-5">--%>
                    <%--<div class="card-body">--%>
                       <input style="display:none" type="text" name="fakeusernameremembered"/>
<input style="display:none" type="password" name="fakepasswordremembered"/>
                        <div class="row">
                            <div class="col-sm-8">
                                <div class="card card-light wow zoomInUp animation-delay-5">
                                    <div class="card-header">
 <p>If you are interested in accessing learning content, please <b><a href="findyourcentre">Find Your Centre</a></b> and contact them for more information.</p>
                            <p>If you represent a centre using or interested in using Digital Learning Solutions, get in touch using the form below</p>
                                    </div>
                                    <div class="card-body">
<div class="form-horizontal">
                        <fieldset class="container">
                          
                          <div class="form-group row">
                            <label for="tbEmail" class="col-lg-2 control-label">Email</label>
                            <div class="col-lg-9">
                                <asp:TextBox ID="tbEmail" autocomplete="off" ClientIDMode="static" cssclass="form-control" placeholder="Your e-mail address" runat="server"></asp:TextBox><asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="tbEmail"  CssClass="hiddencol" ValidationGroup="vgEmail" Text=" " ErrorMessage="Your address required"></asp:RequiredFieldValidator>
                  
                            </div>
                          </div>
                          <div class="form-group row">
                            <label for="tbSubject" class="col-lg-2 control-label">Subject</label>
                            <div class="col-lg-9">
                            
                                <asp:TextBox ID="tbSubject" autocomplete="off" ClientIDMode="static" cssclass="form-control" runat="server" placeholder="Subject" ToolTip="Subject"></asp:TextBox><asp:RequiredFieldValidator ID="rfvSubject" runat="server" ControlToValidate="tbSubject"  CssClass="hiddencol" ValidationGroup="vgEmail" ToolTip="Subject line required" Text=" " ErrorMessage="Subject line required"></asp:RequiredFieldValidator>
             
                            </div>
                          </div>
                          <div class="form-group row">
                            <label for="tbMessage" class="col-lg-2 control-label">Message</label>
                            <div class="col-lg-9">
                                     <asp:TextBox ID="tbMessage" autocomplete="off" ClientIDMode="static" cssclass="form-control" runat="server" placeholder="Your message / query ..." TextMode="MultiLine" Rows="3"></asp:TextBox><asp:RequiredFieldValidator ID="rfvMessage" runat="server" ControlToValidate="tbMessage"  CssClass="hiddencol" ValidationGroup="vgEmail" ToolTip="Message required" Text=" " ErrorMessage="Message required"></asp:RequiredFieldValidator>
                   
                            </div>
                          </div>
                          <div class="form-group row justify-content-end">
                            <div class="col-lg-10">
                               <asp:LinkButton ID="btnSubmit" CausesValidation="True" runat="server"
                                      CssClass="btn btn-primary btn-raised float-right" Style="font-weight: normal" ValidationGroup="vgEmail">
                 <i aria-hidden="true" class="icon-check"></i> Submit
                                    </asp:LinkButton>
                            </div>
                          </div>
                        </fieldset>
                      </div>
                                    </div>
                                </div>


                            </div>
                            <div class=" col-sm-4 pl-5">
                                <div class="card card-light wow zoomInUp animation-delay-5">
                                   
                                    <div class="card-body">
            <p> 
Health Education England<br />
Stewart House<br />
32 Russell Square<br />
London<br />
WC1B 5DN
            </p>
            <p>
                <asp:HyperLink ID="hlSupportEmail" runat="server"></asp:HyperLink></p>
                                    </div>
                                </div>
                                            


                            </div>
                        </div>
                      
                    
                </div>
              </div>
            </div> <!-- container -->
          </div>
            </section>
     <%-- Manage details modal popup ends here --%>
        <div class="modal fade" id="hmConfirmModal" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        
                        <h5 class="modal-title" id="hmConfirmModalLabel">
                            <asp:Label ID="lblHmConfirmTitle" runat="server" Text="Changes Saved"></asp:Label></h5><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    </div>
                    <div class="modal-body">
                        <asp:Label ID="lblHmConfirmMessage" runat="server" Text="Your changes have been saved successfully."></asp:Label>
                    </div>
                    <div class="modal-footer">
                        <asp:LinkButton ID="lbtHmConfirmOK" CssClass="btn btn-primary float-right" runat="server">OK</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
