
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_Login]
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
GO
