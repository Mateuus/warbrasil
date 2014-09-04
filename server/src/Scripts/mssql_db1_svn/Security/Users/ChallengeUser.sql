IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'ChallengeUser')
CREATE LOGIN [ChallengeUser] WITH PASSWORD = 'p@ssw0rd'
GO
CREATE USER [ChallengeUser] FOR LOGIN [ChallengeUser]
GO
