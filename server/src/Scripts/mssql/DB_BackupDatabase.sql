USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[DB_BackupDatabase]    Script Date: 03/16/2011 13:34:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[DB_BackupDatabase]   
AS  
BEGIN  
	SET NOCOUNT ON;  

	declare @databaseName sysname = 'gameid_v1'
	declare @sqlCommand NVARCHAR(1000)
	declare @dateTime NVARCHAR(20)

	SELECT @dateTime = REPLACE(CONVERT(VARCHAR, GETDATE(),111),'/','') +
	REPLACE(CONVERT(VARCHAR, GETDATE(),108),':','')

	SET @sqlCommand = 'BACKUP DATABASE ' + @databaseName +
		' TO DISK = ''C:\SQL_Backup\' + @databaseName + '_Full_' + @dateTime + '.BAK'''
         
	select @sqlCommand
	EXECUTE sp_executesql @sqlCommand
END
