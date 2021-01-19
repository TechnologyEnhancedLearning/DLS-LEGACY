<%@ Page Title="Find Your Centre" Language="vb" AutoEventWireup="false" MasterPageFile="~/Landing.Master" CodeBehind="findyourcentre.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.findyourcentre" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ClientIDMode="Static" ContentPlaceHolderID="MainContent" runat="server">
    <style>
  #map {
    height: 100%;
     min-height:600px;
  }

</style>
    <script src="Scripts/centremap.js"></script>
    <script async defer
  src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCqD2kDsakQotSkBL-cmTrtx3GoyDN_Kmk&callback=initMap">
        
</script>
     <header class="ms-hero-page-bottom bg-info mb-3">
        <div class="container">
          <div class="row">
            <div class="text-center color-white">
            <h1 class="animated bounceInDown animation-delay-6">Find your centre</h1>
                <p class="lead lead-lg animated bounceInDown animation-delay-7 color-white">All of the learning content is delivered through our network of training centres. Use the map to find centres close to you (switch on location services) or search for a suitable centre using the table below. Click a centre on the map or grid for contact details.</p>
                </div>
            </div>
            </div>
         </header>
<div class="container">
    <div id="ctremap" class="row mb-3">
        <div class="col-12">
 <div id="map" aria-label="Interactive Google map showing locations of centres a tabular list of centres is also available on the page." class="animated fadeInUp animation-delay-8"></div>
        </div>
       
    </div>
    <div class="row">
<div class="col-12 animated fadeInUp animation-delay-9">
           <asp:ObjectDataSource ID="dsCentreList" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="ITSP_TrackingSystemRefactor.prelogindataTableAdapters.CentresListTableAdapter"></asp:ObjectDataSource>
           <dx:BootstrapGridView ID="bsgcvCentres" SettingsText-EmptyDataRow="<h4>Can't find your centre?</h1><p>Because some organisations share their training function with others it may be that your training centre is listed here but under a different name. If you can’t find your organisation, please check with your HR department or line manager to see if that is the case for you. </p>" runat="server" AutoGenerateColumns="False" DataSourceID="dsCentreList" KeyFieldName="CentreID" SettingsSearchPanel-Visible="True">
               <CssClasses Table="table-hover" />
               <SettingsBootstrap Striped="True" />
               <Settings GridLines="None" />
               <SettingsPager PageSize="12">
               </SettingsPager>
               
               <Columns>
                   <dx:BootstrapGridViewTextColumn Caption="Centre" FieldName="CentreName" VisibleIndex="2">
                   </dx:BootstrapGridViewTextColumn>
                   <dx:BootstrapGridViewTextColumn  FieldName="Region" VisibleIndex="3" Settings-AllowHeaderFilter="True">
<Settings AllowHeaderFilter="True"></Settings>
                   </dx:BootstrapGridViewTextColumn>
               </Columns>
               <ClientSideEvents RowClick="OnRowClick" />
               <SettingsBehavior AllowSelectByRowClick="true" />
<SettingsSearchPanel  Visible="True">
</SettingsSearchPanel>
           </dx:BootstrapGridView>
       </div>
    </div>

    </div>
    
</asp:Content>
