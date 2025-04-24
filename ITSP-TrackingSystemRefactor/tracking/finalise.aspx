<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="finalise.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.CFinalise" %>

<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html lang="en">
<head id="Head1" runat="server">
  <title>Digital Learning Solutions Certificate</title>
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.4/css/all.min.css">
  <!--[if lt IE 7]> <link  runat="server" href="~/css/ie6.css" rel="stylesheet" type="text/css"  /><![endif]-->
  <!--[if IE 7]> <link  href="css/ie7.css" rel="stylesheet" type="text/css"  /><![endif]-->
  <style type="text/css">
      .mainPanelStandard{width:100%;}
      .mainPanelNoLogo{width:100%;}
  .style1 {font-size: 30px}
  .style2 {font-size: 30px; font-weight: bold; }
  .style3 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 24px; color: #000000; margin-left: 30px; margin-right: 30px;}
  .style4 {font-family: Verdana, Arial, Helvetica, sans-serif; color: #000000; }
  .style6 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 20px; }
  .style7 {font-size: 12px; color: #000000; }
  .card-default 
  {
  	border-style: solid; border-color: #00529E; border-width: 3px;
  	}
  	.CertBackPDF
  	{position:relative; background-color:white; margin-top:40px; width:900px; border-style: solid; border-color: #00529E; border-width: 3px;
  	  		}	  		
@media print 
{
	.maincontentcontainer
{
	margin: 0 0 0 0;
	min-height: 500px;
	color: #000;
	border: none;
	background-color: #FFFFFF;
}
    #header, 
    #footer         
    {
       visibility: hidden;
    }
    .no-print, .no-print *
    {
        display: none !important;
    }
}

  
  
  </style>
</head>
<body style="background-color:#D9ECFF;">
  <form id="form1" runat="server">
      <asp:HiddenField ID="hfHistory" EnableViewState="true" Value="0" ClientIDMode="Static" runat="server" />
    <div class="maincontentcontainer">
      <asp:MultiView ID="MultiView" runat="server">
        <asp:View ID="ErrorView" runat="server">
        <div style="background-color:white; padding: 10px; margin-left:auto; margin-right:auto; margin-top:20px; margin-bottom:20px;  " >
        There was a problem creating the page. Please notify your Centre Manager with the following information:
        <br />
        <asp:Label ID="ErrorText" runat="server" Text="Unknown error"></asp:Label>
        </div>
        </asp:View>
        <asp:View ID="EvaluationView" runat="server">
          <div style="background-color:white; padding: 20px; margin-left:auto; margin-right:auto; margin-top:20px; margin-bottom:20px; max-width:600px; border-style: solid; border-color: #003366; border-width: 3px; " >
          
            <div style="font-size: 1.2em;">
            <p align="center"><strong>Well done, you have successfully completed this course.</strong></p>
            <p>Please take a few moments to complete this short questionnaire. If your course is assessed then you can view and print the Certificate after clicking <strong>Submit</strong>.</p>
            <p>Your feedback will be used to help us to evaluate the usefulness of these learning resources and continue to improve them.</p>  
            <p>Your response will be stored anonymously.  If you do not wish to take part, click <strong>Submit</strong> without responding to any of the questions.</p>
            </div>
            
              <asp:ObjectDataSource ID="PayBandsDS" runat="server" 
                  OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
                  TypeName="ITSP_TrackingSystemRefactor.ITSPTableAdapters.PayBandsTableAdapter">
              </asp:ObjectDataSource>
            
            <br />
            <div class="evalBox">
            <strong>What is your NHS pay band?</strong>
            <br />
                <asp:DropDownList ID="PayBandDD" runat="server" DataSourceID="PayBandsDS" 
                    DataTextField="Band" DataValueField="BandID">
                </asp:DropDownList>
            </div>
            
            <br />
            <div class="evalBox">
            <strong>Will completing this course increase your productivity?</strong>
            <br />
            <asp:RadioButton GroupName="Q1" ID="Q1Yes" text="Yes" runat="server" />
            <br />
            <asp:RadioButton GroupName="Q1" ID="Q1No" text="No" runat="server" />
            </div>
            
            <br />

            <div class="evalBox">
            <strong>Has completing this course given you new skills that will help you with your day to day tasks?</strong>
            <br />
            <asp:RadioButton GroupName="Q2" ID="Q2Yes" text="Yes" runat="server" />
            <br />
            <asp:RadioButton GroupName="Q2" ID="Q2No" text="No" runat="server" />
            </div>
            
            <br />

            <div class="evalBox">
            <strong>Will you be able to perform everyday tasks using your PC faster and more efficiently?</strong>
            <br />
            <asp:RadioButton GroupName="Q3" ID="Q3Yes" text="Yes" runat="server" />
            <br />
            <asp:RadioButton GroupName="Q3" ID="Q3No" text="No" runat="server" />
            </div>
            
            <br />

            <div class="evalBox">
            <strong>If you answered Yes to the previous question, how much time do you think you will save per week?</strong>
            <br />
            <asp:RadioButton GroupName="Q4" ID="Q4gt6" text="Over 6 hours per week" runat="server" />
            <br />
            <asp:RadioButton GroupName="Q4" ID="Q44to6" text="4-6 hours per week" runat="server" />
            <br />
            <asp:RadioButton GroupName="Q4" ID="Q42to4" text="2-4 hours per week" runat="server" />
            <br />
            <asp:RadioButton GroupName="Q4" ID="Q41to2" text="1-2 hours per week" runat="server" />
            <br />
            <asp:RadioButton GroupName="Q4" ID="Q4lt1" text="Up to 1 hour per week" runat="server" />
            </div>
            
            <br />

            <div class="evalBox">
            <strong>Will you be able to pass on the new skills you have acquired through completing this course to others within your organisation?</strong>
            <br />
            <asp:RadioButton GroupName="Q5" ID="Q5Yes" text="Yes" runat="server" />
            <br />
            <asp:RadioButton GroupName="Q5" ID="Q5No" text="No" runat="server" />
            </div>
            
            <br />

            <div class="evalBox">
            <strong>Will your new skills help with patient / client care?</strong>
            <br />
            <asp:RadioButton GroupName="Q6" ID="Q6YesDirectly" text="Yes (Directly)" runat="server" />
            <br />
            <asp:RadioButton GroupName="Q6" ID="Q6YesIndirectly" text="Yes (Indirectly)" runat="server" />
            <br />
            <asp:RadioButton GroupName="Q6" ID="Q6No" text="No" runat="server" />
            <br />
            <asp:RadioButton GroupName="Q6" ID="Q6NA" text="N/A" runat="server" />
            </div>
            
            <br />

            <div class="evalBox">
            <strong>Would you recommend these learning materials to your colleagues?</strong>
            <br />
            <asp:RadioButton GroupName="Q7" ID="Q7Yes" text="Yes" runat="server" />
            <br />
            <asp:RadioButton GroupName="Q7" ID="Q7No" text="No" runat="server" />
            </div>
            
            <br />
<p>We would like to contact you to find out more about your experience with Digital Learning Solutions learning materials, if you are happy for us to do so, please provide the following details:</p>
       
            <div class="evalBox">
            <table><tr><td><strong>Name:&nbsp;</strong></td><td><asp:TextBox ID="tbName" runat="server" Width="280px"></asp:TextBox></td></tr>
            <tr><td><strong>Contact e-mail and or telephone number:&nbsp;</strong></td><td><asp:TextBox
                ID="tbContact" runat="server" Width="280px"></asp:TextBox></td></tr></table>
            </div>
                <br />
            <div style="text-align: center"><asp:Button ID="SubmitEval" runat="server" Text="Submit" />
            
            <br />
            <br />
            
            <p>If you wish to make any other comments / give any other feedback on this course, please e-mail <asp:HyperLink ID="hlSupportEmail" runat="server"></asp:HyperLink></p>
            </div>
            
          </div>
            <%--<script>
                if (window.history.length == 1) {
                    document.getElementById('hfHistory').value = "0";
                } else {
                    document.getElementById('hfHistory').value = "-2";   
                }           
            </script>--%>
        </asp:View>
        <asp:View ID="CertificateView" runat="server">
            <div class="container"><div class="row">
                    <div class="col">
            <asp:Panel ID="pnlToolbar" CssClass="btn-group btn-group-sm float-right no-print clearfix" runat="server" role="group" aria-label="...">
                
	<asp:LinkButton CssClass="btn btn-success" ID="btnPDFExport" tooltip="Open / Save / Print as PDF" runat="server"><i aria-hidden="true" class="far fa-file-pdf"></i> Open as  PDF</asp:LinkButton>
                <asp:LinkButton ID="lbtClose" OnClientClick="javascript:window.history.go(parseInt(document.getElementById('hfHistory').value));return false;" CssClass="btn btn-danger" runat="server"><i aria-hidden="true" class="fas fa-arrow-left"></i> Back to Learning </asp:LinkButton>
                    
		
                    </asp:Panel>
        </div>

                </div>
          <div class="row">
              <div class="col">
<div class="card card-default">
<div class="card-body">
                  <div class="row">
                      <div class="col">

    <dx:ASPxBinaryImage class="p-4 float-right" ID="bimgLogo" runat="server"></dx:ASPxBinaryImage>
                      
                  </div></div>
              
                  <div class="row">
                      <div class="col">
<div class="p-4 float-right"><asp:Image ID="Logo" runat="server" ImageUrl="~/images/logo.png" AlternateText="Organisation Logo" /></div>
                      </div>
                  </div>
              <div class="text-center style1">
                
                    
                <div class="clearfix"></div>
                <p class="style3 style4">&nbsp;</p>
                <p class="style3 style4">&nbsp;</p>
                <p class="style3 style4">This is to certify that </p>
              </div>      
              <div  class="text-center style4">
                <p class="style2">
                  <asp:Label ID="CertDelegate" runat="server" Text=""></asp:Label>
                </p>
              </div>      
              <div  class="text-center style4">
                  <p>&nbsp;</p>
                  <p class="style3">has completed</p>
                  <p class="style2">                  
                    <asp:Label ID="CertApplication" runat="server" Text=""></asp:Label>
                  </p>
                  <p class="style3"> 
                    <asp:Label ID="CertModifier" runat="server" Text=""></asp:Label>
                  </p>
                  <p class="style2">
                  </p>
                </div>      
                <div class="text-center ">
                  <p>&nbsp;</p>
                  <p class="style3">on                     
                    <asp:Label ID="CertCompletion" runat="server" Text=""></asp:Label>
                  </p>
                  <p class="style4">&nbsp;</p>
                  <p class="style4"><asp:Image ID="SignatureImage" AlternateText="Centre Manager Signature Image" runat="server" /></p>
                  <p class="style4">&nbsp;</p>
                  <p class="style4">
                    <asp:Label ID="CertManagerName" runat="server" Text=""></asp:Label>, Digital Learning Solutions Centre Manager
                  </p>
                 
                  <p class="style4">
                    <asp:Label ID="CertCentreName" runat="server" Text=""></asp:Label>
                  </p><p class="style4">&nbsp;</p>
                  <p class="style4">&nbsp;</p>
                  <p class="style4">&nbsp;</p>
                  <p class="style4">&nbsp;</p>
                  <p class="style7">This certificate does not signify completion of BCS qualifications or MOST exams.</p>
                  <p class="style4">&nbsp;</p>
                </div>
              </div>
              </div>
              </div>
              </div>
          </div>			
            <script>
                if (document.referrer == '' || document.getElementById('hfHistory').value == "0") {
                    lbt = document.getElementById('lbtClose');
                    lbt.setAttribute("style", "display:none;");
                }
      </script>
        </asp:View>
        <asp:View ID="BlankView" runat="server">
            <div class="row">
                    <div class="col">
            
                
	<asp:LinkButton CssClass="btn btn-success" ID="LinkButton1" tooltip="Open / Save / Print as PDF" runat="server"><i aria-hidden="true" class="far fa-file-pdf"></i> Open as  PDF</asp:LinkButton>
                <asp:LinkButton ID="LinkButton2" ClientIDMode="Static" OnClientClick="javascript:window.history.go(parseInt(document.getElementById('hfHistory').value));return false;" CssClass="btn btn-danger" runat="server"><i aria-hidden="true" class="fas fa-arrow-left"></i> Back to Learning </asp:LinkButton>
                    
		
        </div>
                <div class ="alert alert-info">
                    Thank you for submitting your evaluation. This window can now be closed.
                </div>

                </div>
            <script>
                if (document.referrer == '' || document.getElementById('hfHistory').value == "0")   {
                    lbt = document.getElementById('LinkButton2');
                    lbt.setAttribute("style", "display:none;");
                }
      </script>
        </asp:View>
      </asp:MultiView>
    </div>
    <asp:ScriptManager ID="SM" runat="server" EnablePartialRendering="true" EnableScriptGlobalization="true"
      EnableScriptLocalization="true">
    </asp:ScriptManager>        
      
  </form>
</body>
</html>
