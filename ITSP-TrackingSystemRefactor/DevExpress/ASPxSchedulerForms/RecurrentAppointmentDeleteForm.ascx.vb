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
'{          'OptionsForms.RecurrentAppointmentDeleteFormTemplateUrl'                  }
'{          property of the ASPxScheduler control.                                    }
'{       3. If you need to display and process additional controls, you               }
'{          should accomplish steps 4-6; otherwise, go to step 7.                     }
'{       4. Create a class, derived from the                                          }
'{          RecurrentAppointmentDeleteFormTemplateContainer,                          }
'{          containing additional properties which correspond to your controls.       }
'{          This class definition can be located within a class file in the App_Code  }
'{          folder.                                                                   }
'{       5. Replace RecurrentAppointmentDeleteFormTemplateContainer references in the }
'{          template page with the name of the class you've created in step 4.        }
'{       6. Handle the RecurrentAppointmentDeleteFormShowing event to create an       }
'{          instance of the  template container class, defined in step 5, and specify }
'{          it as the destination container  instead of the  default one.             }
'{       7. Modify the overall appearance of the page and its layout.                 }
'{                                                                                    }
'{************************************************************************************}
'


Imports Microsoft.VisualBasic
Imports System
Imports DevExpress.Web.ASPxScheduler
Imports DevExpress.Web
Imports DevExpress.Web.ASPxScheduler.Localization

Partial Public Class RecurrentAppointmentDeleteForm
	Inherits SchedulerFormControl
	Protected Overrides Sub OnLoad(ByVal e As EventArgs)
		MyBase.OnLoad(e)
		Localize()
	End Sub
	Public Overrides Sub DataBind()
		MyBase.DataBind()
		Dim container As RecurrentAppointmentDeleteFormTemplateContainer = CType(Parent, RecurrentAppointmentDeleteFormTemplateContainer)
		rbAction.SelectedIndex = 0
		Localize(container)
		Dim imageProperties As ImageProperties = container.Control.Images.GetWarningImage(Me.Page)
		AssignImageProperties(imgWarning, imageProperties)
		btnOk.ClientSideEvents.Click = container.ApplyHandler
		btnCancel.ClientSideEvents.Click = container.CancelHandler
	End Sub
	Private Sub Localize()
		btnOk.Text = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_ButtonOk)
		btnCancel.Text = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_ButtonCancel)

		If rbAction.Items.Count = 2 Then
			Dim seriesItem As ListEditItem = rbAction.Items(0)
			seriesItem.Text = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_Series)
			Dim occurrenceItem As ListEditItem = rbAction.Items(1)
			occurrenceItem.Text = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_Occurrence)
		End If
	End Sub
	Private Sub Localize(ByVal container As RecurrentAppointmentDeleteFormTemplateContainer)
		Dim formatString As String = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_ConfirmDelete)
		lblConfirm.Text = String.Format(formatString, container.Appointment.Subject)
	End Sub
	Private Sub AssignImageProperties(ByVal image As ASPxImage, ByVal imageProperties As ImageProperties)
		image.ImageUrl = EmptyImageProperties.GetGlobalEmptyImage(Me.Page).Url
		image.CssClass = imageProperties.SpriteProperties.CssClass
		image.Width = imageProperties.Width
		image.Height = imageProperties.Height
		image.SpriteLeft = imageProperties.SpriteProperties.Left
		image.SpriteTop = imageProperties.SpriteProperties.Top
	End Sub
	Protected Overrides Function GetChildEditors() As ASPxEditBase()
		Dim edits() As ASPxEditBase = { lblConfirm, rbAction }
		Return edits
	End Function
	Protected Overrides Function GetChildButtons() As ASPxButton()
		Dim buttons() As ASPxButton = { btnOk, btnCancel }
		Return buttons
	End Function
End Class
