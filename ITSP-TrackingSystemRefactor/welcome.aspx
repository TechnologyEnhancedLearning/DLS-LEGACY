<%@ Page Title="Welcome" Language="vb" AutoEventWireup="false" MasterPageFile="~/Landing.Master" CodeBehind="welcome.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.welcome" %>

<%@ Register Src="~/controls/brands.ascx" TagPrefix="uc1" TagName="brands" %>
<%@ Register Src="~/controls/products.ascx" TagPrefix="uc1" TagName="products" %>
<%@ Register Src="~/controls/cstories.ascx" TagPrefix="uc1" TagName="cstories" %>
<%@ Register Src="~/controls/quotes.ascx" TagPrefix="uc1" TagName="quotes" %>
<%@ Register Src="~/controls/newstimeline.ascx" TagPrefix="uc1" TagName="newstimeline" %>





<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        video {
    margin:0 auto;
    min-width: 100%;
    min-height: 100%;
    width: auto;
    height: auto;
    z-index: -100;
    background-size: cover;
    transition: 1s opacity;
}
    </style>
       <script src="Scripts/welcome.js"></script>
    <div class="intro-full ms-hero-bg-primary color-white" id="home">
        <div id="intro-video" class="plyr__video-embed">
            <video src="mp4/bkgvid.mp4" controls="controls" autoplay="autoplay" muted="muted" loop="loop" />
       </div>
        <div class="intro-full-content index-1">
          <div class="container">
            <div class="text-center mb-4">
                
                
              <span class="center-block mb-2 mt-2 animated zoomInDown animation-delay-5"><img src="Images/DLS-Logo-Colour-md.png" /></span>
              <h1 class="no-m ms-site-title color-white center-block ms-site-title-lg mt-2 animated zoomInDown animation-delay-5">
                <span>Digital Learning</span> Solutions
              </h1>
              <p class="lead lead-lg color-white text-center center-block mt-2 mw-800 text-uppercase fw-300 animated fadeInUp animation-delay-7">The complete
                <span class="color-success">digital learning </span> platform for health and social care</p>
            </div>
            <div class="text-center mb-2">
              <a id="go-intro-full-next" href="#intro-next" class="btn-circle btn-circle-raised btn-circle-white animated zoomInUp animation-delay-12">
                <i class="fas fa-arrow-down"></i>
              </a>
            </div>
          </div>
        </div>
      </div>
    <div class="bg-light index-1 intro-fixed-next pt-6" id="intro-next">
        <div class="container mt-4">
                <h2 class="text-center mb-4 wow fadeInUp animation-delay-2">Delivering Digital Learning to Health and Social Care</h2>
                <div class="row">
                    <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="card card-royal-inverse card-body overflow-hidden text-center wow zoomInUp animation-delay-5">
                      <h2 class="counter">
                          <asp:Label ID="lblCentreCount" runat="server" Text=""></asp:Label></h2>
                      <i class="fas fa-4x fa-building"></i>
                      <p class="mt-2 no-mb lead small-caps color-white">centres</p>
                    </div>
                  </div>
                  <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="card card-warning-inverse card-body overflow-hidden text-center wow zoomInUp animation-delay-2">
                      <h2 class="counter">
                          <asp:Label ID="lblLearnerCount" runat="server" Text=""></asp:Label></h2>
                      <i class="fa fa-4x fa-group"></i>
                      <p class="mt-2 no-mb lead small-caps color-white">learners</p>
                    </div>
                  </div>
                  
                  <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="card card-danger-inverse card-body overflow-hidden text-center wow zoomInUp animation-delay-4">
                      <h2 class="counter">
                          <asp:Label ID="lblLearningHours" runat="server" Text=""></asp:Label></h2>
                      <i class="fa fa-4x fa-clock"></i>
                      <p class="mt-2 no-mb lead small-caps color-white">learning hours</p>
                    </div>
                  </div>
                  <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="card card-success-inverse card-body overflow-hidden text-center wow zoomInUp animation-delay-3">
                      <h2 class="counter">
                          <asp:Label ID="lblCompletionsCount" runat="server" Text=""></asp:Label></h2>
                      <i class="fa fa-4x fa-graduation-cap"></i>
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
     <section id="learning">
             <uc1:brands runat="server" ID="brands" />
        </section>
    <section id="products">
        <uc1:products runat="server" ID="products1" />

        </section>
    <section id="customerstories">
        <uc1:cstories runat="server" ID="cstories" />
    </section>
    <section id="quotes">
        <uc1:quotes runat="server" ID="quotes1" ResultCount="100" BrandID="0" ProductID="0" />
    </section>
    <section id="news">
        <uc1:newstimeline runat="server" ID="newstimeline" ResultCount="100" BrandID="0" ProductID="0" />
    </section>
 
</asp:Content>
