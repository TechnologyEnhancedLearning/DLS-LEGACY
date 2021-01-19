<%--
{************************************************************************************}
{                                                                                    }
{   DO NOT MODIFY THIS FILE!                                                         }
{                                                                                    }
{   It will be overwritten without prompting when a new version becomes              }
{   available. All your changes will be lost.                                        }
{                                                                                    }
{   This file contains the default template and is required for the form             }
{   rendering. Improper modifications may result in incorrect behavior of            }
{   the appointment form.                                                            }
{                                                                                    }
{   In order to create and use your own custom template, perform the following       }
{   steps:                                                                           }
{       1. Save a copy of this file with a different name in another location.       }
{       2. Specify the file location as the                                          }
{          'OptionsForms.RecurrentAppointmentEditFormTemplateUrl'                    }
{          property of the ASPxScheduler control.                                    }
{       3. If you need to display and process additional controls, you               }
{          should accomplish steps 4-6; otherwise, go to step 7.                     }
{       4. Create a class, derived from the                                          }
{          RecurrentAppointmentEditFormTemplateContainer,                            }
{          containing additional properties which correspond to your controls.       }
{          This class definition can be located within a class file in the App_Code  }
{          folder.                                                                   }
{       5. Replace RecurrentAppointmentEditFormTemplateContainer references in the   }
{          template page with the name of the class you've created in step 4.        }
{       6. Handle the RecurrentAppointmentEditFormShowing event to create an         }
{          instance of the  template container class, defined in step 5, and specify }
{          it as the destination container  instead of the  default one.             }
{       7. Modify the overall appearance of the page and its layout.                 }
{                                                                                    }
{************************************************************************************}
--%>
<%@ Control Language="vb" AutoEventWireup="true" Inherits="ITSP_TrackingSystemRefactor.RecurrentAppointmentEditForm" Codebehind="RecurrentAppointmentEditForm.ascx.vb" %>

<%@ Register Assembly="DevExpress.Web.ASPxScheduler.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxScheduler" TagPrefix="dxwschs" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<table style="width:100%; height:100%">
	<tr>
		<td rowspan="2"  style="vertical-align:top;">
            <dx:ASPxImage id="Image" runat="server" EnableViewState="False" Width="48px" Height="48px">
			</dx:ASPxImage>
		</td>
		<td style="width:100%;">
			<dx:ASPxLabel ID="lblConfirm" runat="server"/>
		</td>
	</tr>
	<tr>
		<td style="width:100%;">
			<dx:ASPxRadioButtonList ID="rbAction" runat="server" ValueType="System.Int32">
								<Border BorderStyle="None" />
								<Items>
									<dx:ListEditItem Value="1" />
									<dx:ListEditItem Value="2" />
								</Items>
							</dx:ASPxRadioButtonList>
		</td>
	</tr>
	<tr>
		<td class="dx-ac" <%= DevExpress.Web.Internal.RenderUtils.GetAlignAttributes(Me, "center", Nothing)%> style="width:100%" colspan="2">
			<table class="dxscButtonTable">
				<tr>
					<td class="dxscCellWithPadding">
						<dx:ASPxButton ID="btnOk" ClientInstanceName="_dx" runat="server" UseSubmitBehavior="false" AutoPostBack="false" EnableViewState="false" Width="91px" />
					</td>
					<td class="dxscCellWithPadding">
						<dx:ASPxButton ID="btnCancel" ClientInstanceName="_dx" runat="server" UseSubmitBehavior="false" AutoPostBack="false" EnableViewState="false" 
							Width="91px" CausesValidation="False" />
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>