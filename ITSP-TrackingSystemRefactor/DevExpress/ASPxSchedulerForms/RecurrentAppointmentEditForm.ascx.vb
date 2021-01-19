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
'{          'OptionsForms.RecurrentAppointmentEditFormTemplateUrl'                    }
'{          property of the ASPxScheduler control.                                    }
'{       3. If you need to display and process additional controls, you               }
'{          should accomplish steps 4-6; otherwise, go to step 7.                     }
'{       4. Create a class, derived from the                                          }
'{          RecurrentAppointmentEditFormTemplateContainer,                            }
'{          containing additional properties which correspond to your controls.       }
'{          This class definition can be located within a class file in the App_Code  }
'{          folder.                                                                   }
'{       5. Replace RecurrentAppointmentEditFormTemplateContainer references in the   }
'{          template page with the name of the class you've created in step 4.        }
'{       6. Handle the RecurrentAppointmentEditFormShowing event to create an         }
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

Partial Public Class RecurrentAppointmentEditForm
	Inherits SchedulerFormControl
	Protected Overrides Sub OnLoad(ByVal e As EventArgs)
		MyBase.OnLoad(e)
		rbAction.SelectedIndex = 0
		Localize()
	End Sub

	Public Overrides Sub DataBind()
		MyBase.DataBind()
		Localize(CType(Parent, RecurrentAppointmentEditFormTemplateContainer))
		AssignStatusImage(Image)
		SubscribeButtons()
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
	Private Sub Localize(ByVal container As RecurrentAppointmentEditFormTemplateContainer)
		Dim formatString As String = ASPxSchedulerLocalizer.GetString(ASPxSchedulerStringId.Form_ConfirmEdit)
		lblConfirm.Text = String.Format(formatString, container.Appointment.Subject)
	End Sub
	Private Sub AssignStatusImage(ByVal image As ASPxImage)
		Dim container As RecurrentAppointmentEditFormTemplateContainer = CType(Parent, RecurrentAppointmentEditFormTemplateContainer)
		Dim images As ASPxSchedulerImages = container.Control.Images
		image.SpriteCssClass = images.GetStatusInfoImage(Page).SpriteProperties.CssClass
		image.SpriteImageUrl = images.SpriteImageUrl
	End Sub
	Private Sub SubscribeButtons()
		Dim container As RecurrentAppointmentEditFormTemplateContainer = CType(Parent, RecurrentAppointmentEditFormTemplateContainer)
		Me.btnOk.ClientSideEvents.Click = container.ApplyHandler
		Me.btnCancel.ClientSideEvents.Click = container.CancelHandler
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
