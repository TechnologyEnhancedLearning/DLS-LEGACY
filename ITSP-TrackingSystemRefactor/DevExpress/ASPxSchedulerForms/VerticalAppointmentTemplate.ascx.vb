'
'{************************************************************************************}
'{                                                                                    }
'{   DO NOT MODIFY THIS FILE!                                                         }
'{                                                                                    }
'{   It will be overwritten without prompting when a new version becomes              }
'{   available. All your changes will be lost.                                        }
'{                                                                                    }
'{   This file contains the default template and is required for the appointment      }
'{   rendering. Improper modifications may result in incorrect appearance of the      }
'{   appointment.                                                                     }
'{                                                                                    }
'{   In order to create and use your own custom template, perform the following       }
'{   steps:                                                                           }
'{       1. Save a copy of this file with a different name in another location.       }
'{       2. Add a Register tag in the .aspx page header for each template you use,    }
'{          as follows: <%@ Register Src="PathToTemplateFile" TagName="NameOfTemplate"}
'{          TagPrefix="ShortNameOfTemplate" %>                                        }
'{       3. In the .aspx page find the tags for different scheduler views within      }
'{          the ASPxScheduler control tag. Insert template tags into the tags         }
'{          for the views which should be customized.                                 }
'{          The template tag should satisfy the following pattern:                    }
'{          <Templates>                                                               }
'{              <VerticalAppointmentTemplate>                                         }
'{                  < ShortNameOfTemplate: NameOfTemplate runat="server"/>            }
'{              </VerticalAppointmentTemplate>                                        }
'{          </Templates>                                                              }
'{          where ShortNameOfTemplate, NameOfTemplate are the names of the            }
'{          registered templates, defined in step 2.                                  }
'{************************************************************************************}
'

Imports Microsoft.VisualBasic
Imports System
Imports System.Web.UI.HtmlControls
Imports DevExpress.Web
Imports DevExpress.Web.Internal
Imports DevExpress.Web.ASPxScheduler
Imports DevExpress.Web.ASPxScheduler.Drawing
Imports DevExpress.Web.ASPxScheduler.Internal
Imports System.Web.UI
Imports System.Drawing

Partial Public Class VerticalAppointmentTemplate
	Inherits DevExpress.Web.ASPxScheduler.SchedulerUserControl
	Private ReadOnly Property Container() As VerticalAppointmentTemplateContainer
		Get
			Return CType(Parent, VerticalAppointmentTemplateContainer)
		End Get
	End Property
	Private ReadOnly Property Items() As VerticalAppointmentTemplateItems
		Get
			Return Container.Items
		End Get
	End Property

	Protected Overrides Sub OnLoad(ByVal e As EventArgs)
		MyBase.OnLoad(e)

		PrepareMainDiv()
		PrepareImageContainer()
		PrepareStatusControl()
		AssignBackgroundColor()
		ApplyCustomStyle()

		LayoutAppointmentImages()
	End Sub
	Protected Overrides Sub PrepareControls(ByVal scheduler As ASPxScheduler)
		lblStartTime.ControlStyle.MergeWith(Items.StartTimeText.Style)
		lblEndTime.ControlStyle.MergeWith(Items.EndTimeText.Style)
		lblTitle.ControlStyle.MergeWith(Items.Title.Style)
		lblDescription.ControlStyle.MergeWith(Items.Description.Style)

		lblStartTime.ParentSkinOwner = scheduler
		lblEndTime.ParentSkinOwner = scheduler
		lblTitle.ParentSkinOwner = scheduler
		lblDescription.ParentSkinOwner = scheduler
	End Sub
	Private Sub PrepareMainDiv()
		appointmentDiv.Style.Value = Items.AppointmentStyle.GetStyleAttributes(Page).Value
		appointmentDiv.Attributes("class") = RenderUtils.CombineCssClasses(appointmentDiv.Attributes("class"), Items.AppointmentStyle.CssClass)
	End Sub
	Private Sub PrepareImageContainer()
		imageContainer.Visible = Items.Images.Count > 0
	End Sub
	Private Sub PrepareStatusControl()
		statusBack.Visible = Items.StatusControl.Visible
		statusFore.Visible = Items.StatusControl.Visible

		If Items.StatusControl.Visible Then
			AssignStatusStyle()
		End If
	End Sub
	Private Sub AssignBackgroundColor()
		appointmentDiv.Style(HtmlTextWriterStyle.BackgroundColor) = String.Empty
		appointmentBackground.Style(HtmlTextWriterStyle.BackgroundColor) = HtmlConvertor.ToHtml(Items.AppointmentStyle.BackColor)
	End Sub
	Private Sub AssignStatusStyle()
		statusBack.Style.Add(HtmlTextWriterStyle.BackgroundColor, HtmlConvertor.ToHtml(Items.StatusControl.BackColor))
		statusBack.Style.Add(HtmlTextWriterStyle.BorderColor, HtmlConvertor.ToHtml(GetStatusBorderColor()))

		statusFore.Style.Add(HtmlTextWriterStyle.BackgroundColor, HtmlConvertor.ToHtml(Items.StatusControl.Color))
	End Sub
	Private Sub ApplyCustomStyle()
		Dim customStyle = GetCustomBackgroundStyle()
		customBackgroundLayer.Style.Value = customStyle.GetStyleAttributes(Page).Value
		customBackgroundLayer.Attributes("class") = RenderUtils.CombineCssClasses(customBackgroundLayer.Attributes("class"), customStyle.CssClass)
	End Sub
	Private Function GetCustomBackgroundStyle() As AppearanceStyleBase
		Dim customStyle As New AppearanceStyleBase()
		customStyle.AssignWithoutBorders(Items.AppointmentStyle)
		customStyle.BackColor = Color.Empty
		customStyle.CssClass = Items.AppointmentStyle.CssClass

		Return customStyle
	End Function
	Private Function GetStatusBorderColor() As Color
		Dim borderColor As Color = Items.StatusControl.Color
		If borderColor.IsEmpty OrElse HtmlConvertor.ToHtml(borderColor) = "#FFFFFF" Then
			borderColor = Color.LightGray
		End If

		Return borderColor
	End Function
	Private Sub LayoutAppointmentImages()
		Dim count As Integer = Items.Images.Count
		For i As Integer = 0 To count - 1
			AddImage(imageContainer, Items.Images(i))
		Next i
	End Sub
	Private Sub AddImage(ByVal container As HtmlGenericControl, ByVal imageItem As AppointmentImageItem)
		Dim image As New System.Web.UI.WebControls.Image()
		imageItem.ImageProperties.AssignToControl(image, False)
		SchedulerWebEventHelper.AddOnDragStartEvent(image, ASPxSchedulerScripts.GetPreventOnDragStart())
		container.Controls.Add(image)
	End Sub
End Class