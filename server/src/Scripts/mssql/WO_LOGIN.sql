USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_Login]    Script Date: 06/28/2011 21:44:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_Login]
	@in_IP varchar(100),
	@in_Username varchar(100), 
	@in_Password varchar(100)
AS
BEGIN
	SET NOCOUNT ON;

	declare @CustomerID int
	declare @AccountStatus int
	declare @MD5Password varchar(100)

	-- this call is always valid
	select 0 as ResultCode
	
	-- log some SQL hacks, just for info..
	if (CHARINDEX('''', @in_Username) > 0) begin
		INSERT INTO DBG_SQLHacks (IP, Query, StoredProc)
		VALUES                   (@in_IP, @in_Username, 'login')
	end
	if (CHARINDEX('''', @in_Password) > 0) begin
		INSERT INTO DBG_SQLHacks (IP, Query, StoredProc)
		VALUES                   (@in_IP, @in_Password, 'login')
	end

	-- search for record with username
	SELECT 
		@CustomerID=CustomerID,
		@AccountStatus=AccountStatus,
		@MD5Password=MD5Password
	FROM LoginID 
	WHERE AccountName=@in_Username
	if (@@RowCount = 0) begin
		--EXEC FN_ADD_SECURITY_LOG 100, @in_IP, 0, @in_Username
		select
			1 as LoginResult,
			0 as CustomerID,
			0 as AccountStatus
		return
	end

	-- check MD5 password
	declare @MD5FromPwd varchar(100)
	exec FN_CreateMD5Password @in_Password, @MD5FromPwd OUTPUT
	if(@MD5Password <> @MD5FromPwd) begin
		--EXEC FN_ADD_SECURITY_LOG 101, @in_IP, @CustomerID, ''
		select
			2 as LoginResult,
			0 as CustomerID,
			0 as AccountStatus
		return
	end
	
	-- perform actual login
	exec WO_LoginFN_Exec @in_IP, @CustomerID, @AccountStatus
END
