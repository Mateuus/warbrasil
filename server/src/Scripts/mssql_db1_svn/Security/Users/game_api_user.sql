IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'game_api_user')
CREATE LOGIN [game_api_user] WITH PASSWORD = 'p@ssw0rd'
GO
CREATE USER [game_api_user] FOR LOGIN [game_api_user]
GO
GRANT EXECUTE TO [game_api_user]
GRANT INSERT TO [game_api_user]
GRANT SELECT TO [game_api_user]
GRANT UPDATE TO [game_api_user]
