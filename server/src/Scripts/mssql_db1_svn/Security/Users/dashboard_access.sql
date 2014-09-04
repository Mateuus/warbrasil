IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'dashboard_access')
CREATE LOGIN [dashboard_access] WITH PASSWORD = 'p@ssw0rd'
GO
CREATE USER [dashboard_access] FOR LOGIN [dashboard_access]
GO
