﻿'------------------------------------------------------------------------------
' <auto-generated>
'     This code was generated by a tool.
'     Runtime Version:4.0.30319.42000
'
'     Changes to this file may cause incorrect behavior and will be lost if
'     the code is regenerated.
' </auto-generated>
'------------------------------------------------------------------------------

Option Strict Off
Option Explicit On

Imports System
Imports System.ComponentModel
Imports System.Diagnostics
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Xml.Serialization

'
'This source code was auto-generated by Microsoft.VSDesigner, Version 4.0.30319.42000.
'
Namespace ts.services
    
    '''<remarks/>
    <System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.8.3752.0"),  _
     System.Diagnostics.DebuggerStepThroughAttribute(),  _
     System.ComponentModel.DesignerCategoryAttribute("code"),  _
     System.Web.Services.WebServiceBindingAttribute(Name:="servicesSoap", [Namespace]:="geo")>  _
    Partial Public Class services
        Inherits System.Web.Services.Protocols.SoapHttpClientProtocol
        
        Private GetGeoCodeOperationCompleted As System.Threading.SendOrPostCallback
        
        Private PingSessionOperationCompleted As System.Threading.SendOrPostCallback
        
        Private SendCoursePublishedNotificationsOperationCompleted As System.Threading.SendOrPostCallback
        
        Private SendDelegateRegRequiresApprovalNotificationOperationCompleted As System.Threading.SendOrPostCallback
        
        Private useDefaultCredentialsSetExplicitly As Boolean
        
        '''<remarks/>
        Public Sub New()
            MyBase.New
            Me.Url = Global.ITSP_TrackingSystemRefactor.My.MySettings.Default.ITSP_TrackingSystemRefactor_ts_services_services
            If (Me.IsLocalFileSystemWebService(Me.Url) = true) Then
                Me.UseDefaultCredentials = true
                Me.useDefaultCredentialsSetExplicitly = false
            Else
                Me.useDefaultCredentialsSetExplicitly = true
            End If
        End Sub
        
        Public Shadows Property Url() As String
            Get
                Return MyBase.Url
            End Get
            Set
                If (((Me.IsLocalFileSystemWebService(MyBase.Url) = true)  _
                            AndAlso (Me.useDefaultCredentialsSetExplicitly = false))  _
                            AndAlso (Me.IsLocalFileSystemWebService(value) = false)) Then
                    MyBase.UseDefaultCredentials = false
                End If
                MyBase.Url = value
            End Set
        End Property
        
        Public Shadows Property UseDefaultCredentials() As Boolean
            Get
                Return MyBase.UseDefaultCredentials
            End Get
            Set
                MyBase.UseDefaultCredentials = value
                Me.useDefaultCredentialsSetExplicitly = true
            End Set
        End Property
        
        '''<remarks/>
        Public Event GetGeoCodeCompleted As GetGeoCodeCompletedEventHandler
        
        '''<remarks/>
        Public Event PingSessionCompleted As PingSessionCompletedEventHandler
        
        '''<remarks/>
        Public Event SendCoursePublishedNotificationsCompleted As SendCoursePublishedNotificationsCompletedEventHandler
        
        '''<remarks/>
        Public Event SendDelegateRegRequiresApprovalNotificationCompleted As SendDelegateRegRequiresApprovalNotificationCompletedEventHandler
        
        '''<remarks/>
        <System.Web.Services.Protocols.SoapDocumentMethodAttribute("geo/GetGeoCode", RequestNamespace:="geo", ResponseNamespace:="geo", Use:=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle:=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)>  _
        Public Function GetGeoCode(ByVal addstr As String) As String
            Dim results() As Object = Me.Invoke("GetGeoCode", New Object() {addstr})
            Return CType(results(0),String)
        End Function
        
        '''<remarks/>
        Public Overloads Sub GetGeoCodeAsync(ByVal addstr As String)
            Me.GetGeoCodeAsync(addstr, Nothing)
        End Sub
        
        '''<remarks/>
        Public Overloads Sub GetGeoCodeAsync(ByVal addstr As String, ByVal userState As Object)
            If (Me.GetGeoCodeOperationCompleted Is Nothing) Then
                Me.GetGeoCodeOperationCompleted = AddressOf Me.OnGetGeoCodeOperationCompleted
            End If
            Me.InvokeAsync("GetGeoCode", New Object() {addstr}, Me.GetGeoCodeOperationCompleted, userState)
        End Sub
        
        Private Sub OnGetGeoCodeOperationCompleted(ByVal arg As Object)
            If (Not (Me.GetGeoCodeCompletedEvent) Is Nothing) Then
                Dim invokeArgs As System.Web.Services.Protocols.InvokeCompletedEventArgs = CType(arg,System.Web.Services.Protocols.InvokeCompletedEventArgs)
                RaiseEvent GetGeoCodeCompleted(Me, New GetGeoCodeCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState))
            End If
        End Sub
        
        '''<remarks/>
        <System.Web.Services.Protocols.SoapDocumentMethodAttribute("geo/PingSession", RequestNamespace:="geo", ResponseNamespace:="geo", Use:=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle:=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)>  _
        Public Sub PingSession()
            Me.Invoke("PingSession", New Object(-1) {})
        End Sub
        
        '''<remarks/>
        Public Overloads Sub PingSessionAsync()
            Me.PingSessionAsync(Nothing)
        End Sub
        
        '''<remarks/>
        Public Overloads Sub PingSessionAsync(ByVal userState As Object)
            If (Me.PingSessionOperationCompleted Is Nothing) Then
                Me.PingSessionOperationCompleted = AddressOf Me.OnPingSessionOperationCompleted
            End If
            Me.InvokeAsync("PingSession", New Object(-1) {}, Me.PingSessionOperationCompleted, userState)
        End Sub
        
        Private Sub OnPingSessionOperationCompleted(ByVal arg As Object)
            If (Not (Me.PingSessionCompletedEvent) Is Nothing) Then
                Dim invokeArgs As System.Web.Services.Protocols.InvokeCompletedEventArgs = CType(arg,System.Web.Services.Protocols.InvokeCompletedEventArgs)
                RaiseEvent PingSessionCompleted(Me, New System.ComponentModel.AsyncCompletedEventArgs(invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState))
            End If
        End Sub
        
        '''<remarks/>
        <System.Web.Services.Protocols.SoapDocumentMethodAttribute("geo/SendCoursePublishedNotifications", RequestNamespace:="geo", ResponseNamespace:="geo", Use:=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle:=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)>  _
        Public Function SendCoursePublishedNotifications(ByVal nCentreID As Integer, ByVal sCourseName As String) As Integer
            Dim results() As Object = Me.Invoke("SendCoursePublishedNotifications", New Object() {nCentreID, sCourseName})
            Return CType(results(0),Integer)
        End Function
        
        '''<remarks/>
        Public Overloads Sub SendCoursePublishedNotificationsAsync(ByVal nCentreID As Integer, ByVal sCourseName As String)
            Me.SendCoursePublishedNotificationsAsync(nCentreID, sCourseName, Nothing)
        End Sub
        
        '''<remarks/>
        Public Overloads Sub SendCoursePublishedNotificationsAsync(ByVal nCentreID As Integer, ByVal sCourseName As String, ByVal userState As Object)
            If (Me.SendCoursePublishedNotificationsOperationCompleted Is Nothing) Then
                Me.SendCoursePublishedNotificationsOperationCompleted = AddressOf Me.OnSendCoursePublishedNotificationsOperationCompleted
            End If
            Me.InvokeAsync("SendCoursePublishedNotifications", New Object() {nCentreID, sCourseName}, Me.SendCoursePublishedNotificationsOperationCompleted, userState)
        End Sub
        
        Private Sub OnSendCoursePublishedNotificationsOperationCompleted(ByVal arg As Object)
            If (Not (Me.SendCoursePublishedNotificationsCompletedEvent) Is Nothing) Then
                Dim invokeArgs As System.Web.Services.Protocols.InvokeCompletedEventArgs = CType(arg,System.Web.Services.Protocols.InvokeCompletedEventArgs)
                RaiseEvent SendCoursePublishedNotificationsCompleted(Me, New SendCoursePublishedNotificationsCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState))
            End If
        End Sub
        
        '''<remarks/>
        <System.Web.Services.Protocols.SoapDocumentMethodAttribute("geo/SendDelegateRegRequiresApprovalNotification", RequestNamespace:="geo", ResponseNamespace:="geo", Use:=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle:=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)>  _
        Public Sub SendDelegateRegRequiresApprovalNotification(ByVal sFName As String, ByVal sLName As String, ByVal nCentreID As Integer)
            Me.Invoke("SendDelegateRegRequiresApprovalNotification", New Object() {sFName, sLName, nCentreID})
        End Sub
        
        '''<remarks/>
        Public Overloads Sub SendDelegateRegRequiresApprovalNotificationAsync(ByVal sFName As String, ByVal sLName As String, ByVal nCentreID As Integer)
            Me.SendDelegateRegRequiresApprovalNotificationAsync(sFName, sLName, nCentreID, Nothing)
        End Sub
        
        '''<remarks/>
        Public Overloads Sub SendDelegateRegRequiresApprovalNotificationAsync(ByVal sFName As String, ByVal sLName As String, ByVal nCentreID As Integer, ByVal userState As Object)
            If (Me.SendDelegateRegRequiresApprovalNotificationOperationCompleted Is Nothing) Then
                Me.SendDelegateRegRequiresApprovalNotificationOperationCompleted = AddressOf Me.OnSendDelegateRegRequiresApprovalNotificationOperationCompleted
            End If
            Me.InvokeAsync("SendDelegateRegRequiresApprovalNotification", New Object() {sFName, sLName, nCentreID}, Me.SendDelegateRegRequiresApprovalNotificationOperationCompleted, userState)
        End Sub
        
        Private Sub OnSendDelegateRegRequiresApprovalNotificationOperationCompleted(ByVal arg As Object)
            If (Not (Me.SendDelegateRegRequiresApprovalNotificationCompletedEvent) Is Nothing) Then
                Dim invokeArgs As System.Web.Services.Protocols.InvokeCompletedEventArgs = CType(arg,System.Web.Services.Protocols.InvokeCompletedEventArgs)
                RaiseEvent SendDelegateRegRequiresApprovalNotificationCompleted(Me, New System.ComponentModel.AsyncCompletedEventArgs(invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState))
            End If
        End Sub
        
        '''<remarks/>
        Public Shadows Sub CancelAsync(ByVal userState As Object)
            MyBase.CancelAsync(userState)
        End Sub
        
        Private Function IsLocalFileSystemWebService(ByVal url As String) As Boolean
            If ((url Is Nothing)  _
                        OrElse (url Is String.Empty)) Then
                Return false
            End If
            Dim wsUri As System.Uri = New System.Uri(url)
            If ((wsUri.Port >= 1024)  _
                        AndAlso (String.Compare(wsUri.Host, "localHost", System.StringComparison.OrdinalIgnoreCase) = 0)) Then
                Return true
            End If
            Return false
        End Function
    End Class
    
    '''<remarks/>
    <System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.8.3752.0")>  _
    Public Delegate Sub GetGeoCodeCompletedEventHandler(ByVal sender As Object, ByVal e As GetGeoCodeCompletedEventArgs)
    
    '''<remarks/>
    <System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.8.3752.0"),  _
     System.Diagnostics.DebuggerStepThroughAttribute(),  _
     System.ComponentModel.DesignerCategoryAttribute("code")>  _
    Partial Public Class GetGeoCodeCompletedEventArgs
        Inherits System.ComponentModel.AsyncCompletedEventArgs
        
        Private results() As Object
        
        Friend Sub New(ByVal results() As Object, ByVal exception As System.Exception, ByVal cancelled As Boolean, ByVal userState As Object)
            MyBase.New(exception, cancelled, userState)
            Me.results = results
        End Sub
        
        '''<remarks/>
        Public ReadOnly Property Result() As String
            Get
                Me.RaiseExceptionIfNecessary
                Return CType(Me.results(0),String)
            End Get
        End Property
    End Class
    
    '''<remarks/>
    <System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.8.3752.0")>  _
    Public Delegate Sub PingSessionCompletedEventHandler(ByVal sender As Object, ByVal e As System.ComponentModel.AsyncCompletedEventArgs)
    
    '''<remarks/>
    <System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.8.3752.0")>  _
    Public Delegate Sub SendCoursePublishedNotificationsCompletedEventHandler(ByVal sender As Object, ByVal e As SendCoursePublishedNotificationsCompletedEventArgs)
    
    '''<remarks/>
    <System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.8.3752.0"),  _
     System.Diagnostics.DebuggerStepThroughAttribute(),  _
     System.ComponentModel.DesignerCategoryAttribute("code")>  _
    Partial Public Class SendCoursePublishedNotificationsCompletedEventArgs
        Inherits System.ComponentModel.AsyncCompletedEventArgs
        
        Private results() As Object
        
        Friend Sub New(ByVal results() As Object, ByVal exception As System.Exception, ByVal cancelled As Boolean, ByVal userState As Object)
            MyBase.New(exception, cancelled, userState)
            Me.results = results
        End Sub
        
        '''<remarks/>
        Public ReadOnly Property Result() As Integer
            Get
                Me.RaiseExceptionIfNecessary
                Return CType(Me.results(0),Integer)
            End Get
        End Property
    End Class
    
    '''<remarks/>
    <System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.8.3752.0")>  _
    Public Delegate Sub SendDelegateRegRequiresApprovalNotificationCompletedEventHandler(ByVal sender As Object, ByVal e As System.ComponentModel.AsyncCompletedEventArgs)
End Namespace
