SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ECLIPSE_PwdResetExec]
	@in_IP varchar(100),
	@in_token varchar(128),
	@in_NewPassword varchar(100)
AS
BEGIN
	SET NOCOUNT ON
	
	declare @CustomerID int
	declare @RequestTime datetime
	declare @email varchar(100)
	select 
		@CustomerID=CustomerID, 
		@RequestTime=RequestTime,
		@email=email
	from AccountPwdReset where token=@in_token
	if(@@ROWCOUNT = 0) begin
		select 1 as ResultCode, 'Bad Token' as ResultMsg
		return
	end
	
	-- check if token expired
	if(GETDATE() > DATEADD(hour, 2, @RequestTime)) begin
		select 2 as ResultCode, 'Token Expired' as ResultMsg
		return
	end

	-- create MD5 password
	declare @MD5FromPwd varchar(100)
	exec FN_CreateMD5Password @in_NewPassword, @MD5FromPwd OUTPUT
	-- and set it
	update LoginID set MD5Password=@MD5FromPwd where CustomerID=@CustomerID
	
	-- clear that token
	delete from AccountPwdReset where token=@in_token
	
	-- get account name and return user info
	declare @AccountName varchar(64) = ''
	select @AccountName=AccountName from LoginID where CustomerID=@CustomerID
	
	select 0 as ResultCode, @email as 'email', @AccountName as 'AccountName'
END
GO
