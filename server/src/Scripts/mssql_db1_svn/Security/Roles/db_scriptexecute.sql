CREATE ROLE [db_scriptexecute]
AUTHORIZATION [dbo]
GO
EXEC sp_addrolemember N'db_scriptexecute', N'dashboard_access'
GO
EXEC sp_addrolemember N'db_scriptexecute', N'support1'
GO
