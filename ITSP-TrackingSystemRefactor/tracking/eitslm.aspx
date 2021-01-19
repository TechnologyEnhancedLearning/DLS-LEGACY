<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="eitslm.aspx.vb" Inherits="ITSP_TrackingSystemRefactor.CEitsLM" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    
  <head runat="server">
    <title>NHS EITS</title>
      <script src="../Scripts/sw_page_close.js"></script>
	<script src="../Scripts/jquery-1.12.4.min.js"></script>
			<%--<script src="js/jquery-1.9.1.min.js"></script>--%>			
    <script>
        function closeLearning() {
            //    alert('closeLearning called');
            //        __doPostBack('btnCloseLearning', '');

            window.parent.closeMpe();
        }
        </script>
    <script type="text/vbscript">
		sub EITSMovie_ExternalEvent(byVal aCommand)	
      call setupFunction(aCommand)
		end sub
    </script>
  </head>
  <body runat="server" id="LMBody">
    <form id="form1" runat="server">
      <div>
        <table border="0" width="100%">
         <tr>
            <td valign="middle" align="center">
              <asp:Literal id="LMMovie" runat="server"></asp:Literal>
            </td>
          </tr>
        </table>
        
      </div>
    </form>
<%--    <script src="js/jQueryResizeStop.js"></script>--%>
  </body>
</html>