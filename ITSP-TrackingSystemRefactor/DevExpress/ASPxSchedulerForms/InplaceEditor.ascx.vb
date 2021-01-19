'
'{************************************************************************************}
'{                                                                                    }
'{   DO NOT MODIFY THIS FILE!                                                         }
'{                                                                                    }
'{   It will be overwritten without prompting when a new version becomes              }
'{   available. All your changes will be lost.                                        }
'{                                                                                    }
'{   This file contains the default template and is required for the form             }
'{   rendering. Improper modifications may result in incorrect behavior of            }
'{   the appointment form.                                                            }
'{                                                                                    }
'{   In order to create and use your own custom template, perform the following       }
'{   steps:                                                                           }
'{       1. Save a copy of this file with a different name in another location.       }
'{       2. Specify the file location as the                                          }
'{          'OptionsForms.AppointmentInplaceEditorFormTemplateUrl'                    }
'{          property of the ASPxScheduler control.                                    }
'{       3. If you need custom fields to be displayed and processed, you should       }
'{          accomplish steps 4-9; otherwise, go to step 10.                           }
'{       4. Create a class, derived from the                                          }
'{          AppointmentInplaceEditorTemplateContainer, containing custom properties.  }
'{          This class definition can be located within a class file in the App_Code  }
'{          folder.                                                                   }
'{       5. Replace AppointmentInplaceEditorTemplateContainer references in the       }
'{          template page with the name of the class you've created in step 4.        }
'{       6. Handle the AppointmentInplaceEditorFormShowing event to create an    }
'{          instance of the template container class, defined in step 4, and specify  }
'{          it as the destination container instead of the default one.               }
'{       7. Define a class, which inherits from the                                   }
'{          DevExpress.Web.ASPxScheduler.Internal.AppointmentFormController.          }
'{          This class provides data exchange between the form and the appointment.   }
'{          You should override ApplyCustomFieldsValues() method of the base class.   }
'{       8. Define a class, which inherits from the                                   }
'{          DevExpress.Web.ASPxScheduler.Internal.AppointmentFormSaveCallbackCommand. }
'{          This class creates an instance of the AppointmentFormController inheritor }
'{          (defined in step 7) via the CreateAppointmentFormController method and    }
'{          overrides the AssignControllerValues method  of the base class to collect }
'{          user data from the form's editors.                                        }
'{       9. Handle the BeforeExecuteCallbackCommand event. The event handler code     }
'{          should create an instance of the class defined in step 8, and specify it  }
'{          as the destination command instead of the default one.                    }
'{      10. Modify the overall appearance of the page and its layout.                 }
'{                                                                                    }
'{************************************************************************************}
'


Imports Microsoft.VisualBasic
Imports System
Imports DevExpress.Web.ASPxScheduler
Imports DevExpress.Web
Imports DevExpress.Web.Internal
Imports DevExpress.Web.ASPxScheduler.Localization

Partial Public Class InplaceEditor
	Inherits InplaceEditorBaseFormControl
	Protected Overrides Sub OnLoad(ByVal e As EventArgs)
        MyBase.OnLoad(e)
        PrepareMainContainer()
		Localize()
		memSubject.Focus()
    End Sub
    Private Sub PrepareMainContainer()
        RenderUtils.SetTableSpacings(mainContainer, 2, 0)
        RenderUtils.SetAlignAttributes(buttonContainer, Nothing, "top")
    End Sub
	Private Sub Localize()
		btnSave.ToolTip = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_Save)
		btnCancel.ToolTip = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_ButtonCancel)
		btnEditForm.ToolTip = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_OpenEditForm)
	End Sub
	Public Overrides Sub DataBind()
		MyBase.DataBind()
		Dim container As AppointmentInplaceEditorTemplateContainer = CType(Parent, AppointmentInplaceEditorTemplateContainer)

		btnCancel.Image.Assign(container.Control.Images.GetInplaceEditorCancelImage(Page))
		btnSave.Image.Assign(container.Control.Images.GetInplaceEditorSaveImage(Page))
		btnEditForm.Image.Assign(container.Control.Images.GetInplaceEditorEditFormImage(Page))

		btnSave.ClientSideEvents.Click = container.SaveHandler
		btnCancel.ClientSideEvents.Click = container.CancelHandler
		btnEditForm.ClientSideEvents.Click = container.EditFormHandler
	End Sub
	Protected Overrides Function GetChildEditors() As ASPxEditBase()
		Dim edits() As ASPxEditBase = { memSubject }
		Return edits
	End Function
	Protected Overrides Function GetChildButtons() As ASPxButton()
		Dim buttons() As ASPxButton = { btnSave, btnCancel, btnEditForm }
		Return buttons
	End Function
End Class
