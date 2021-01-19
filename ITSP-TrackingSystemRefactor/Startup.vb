Imports Microsoft.Owin
Imports Owin
<Assembly: OwinStartupAttribute(GetType(Startup))>
Partial Public Class Startup
    Public Sub Configuration(ByVal app As IAppBuilder)
        ConfigureAuth(app)
    End Sub
End Class
