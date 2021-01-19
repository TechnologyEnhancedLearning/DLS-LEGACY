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
{          'OptionsForms.AppointmentInplaceEditorFormTemplateUrl'                    }
{          property of the ASPxScheduler control.                                    }
{       3. If you need custom fields to be displayed and processed, you should       }
{          accomplish steps 4-9; otherwise, go to step 10.                           }
{       4. Create a class, derived from the                                          }
{          AppointmentInplaceEditorTemplateContainer, containing custom properties.  }
{          This class definition can be located within a class file in the App_Code  }
{          folder.                                                                   }
{       5. Replace AppointmentInplaceEditorTemplateContainer references in the       }
{          template page with the name of the class you've created in step 4.        }
{       6. Handle the AppointmentInplaceEditorFormShowing event to create an         }
{          instance of the template container class, defined in step 4, and specify  }
{          it as the destination container instead of the default one.               }
{       7. Define a class, which inherits from the                                   }
{          DevExpress.Web.ASPxScheduler.Internal.AppointmentFormController.          }
{          This class provides data exchange between the form and the appointment.   }
{          You should override ApplyCustomFieldsValues() method of the base class.   }
{       8. Define a class, which inherits from the                                   }
{          DevExpress.Web.ASPxScheduler.Internal.AppointmentFormSaveCallbackCommand. }
{          This class creates an instance of the AppointmentFormController inheritor }
{          (defined in step 7) via the CreateAppointmentFormController method and    }
{          overrides the AssignControllerValues method  of the base class to collect }
{          user data from the form's editors.                                        }
{       9. Handle the BeforeExecuteCallbackCommand event. The event handler code     }
{          should create an instance of the class defined in step 8, and specify it  }
{          as the destination command instead of the default one.                    }
{      10. Modify the overall appearance of the page and its layout.                 }
{                                                                                    }
{************************************************************************************}--%>

<%@ Control Language="vb" AutoEventWireup="true" Inherits="ITSP_TrackingSystemRefactor.InplaceEditor" Codebehind="InplaceEditor.ascx.vb" %>

<%@ Register Assembly="DevExpress.Web.ASPxScheduler.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxScheduler" TagPrefix="dxwschs" %>
<%@ Register Assembly="DevExpress.Web.ASPxScheduler.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxScheduler.Controls" TagPrefix="dxsc" %>
<%@ Register Assembly="DevExpress.Web.v19.2, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web"	TagPrefix="dx" %>

<table runat="server" id="mainContainer" style="width:100%; height:100%">
	<tr>
		<td class="dx-p2" style="width:100%" >
			<dx:ASPxMemo ClientInstanceName="_dx" ID="memSubject" runat="server" Width="100%" Rows="5" Text='<%#(CType(Container, AppointmentInplaceEditorTemplateContainer)).Appointment.Subject%>'>
			</dx:ASPxMemo>
		</td>
		<td runat="server" id="buttonContainer" class="dx-p2" style="vertical-align: top">

		<div>
            <dxsc:NoBorderButton runat="server" ClientInstanceName="_dx" ID="btnSave" Width="19px" Height="19px" /> 
		</div>

		<div style="padding-top:1px;">
            <dxsc:NoBorderButton runat="server" ClientInstanceName="_dx" ID="btnCancel" Width="19px" Height="19px" /> 
		</div>

		<div style="padding-top:6px;">
            <dxsc:NoBorderButton runat="server" ClientInstanceName="_dx" ID="btnEditForm" Width="19px" Height="19px" />
		</div>
		</td>
	</tr>
</table>