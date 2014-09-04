IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'support1')
CREATE LOGIN [support1] WITH PASSWORD = 'p@ssw0rd'
GO
CREATE USER [support1] FOR LOGIN [support1]
GO
