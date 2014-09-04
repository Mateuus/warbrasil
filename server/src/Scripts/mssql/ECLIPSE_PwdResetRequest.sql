USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[ECLIPSE_PwdResetRequest]    Script Date: 05/11/2011 23:26:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ECLIPSE_PwdResetRequest]
	@in_IP varchar(100),
	@in_email varchar(128)
AS
BEGIN
	SET NOCOUNT ON
	
	declare @CustomerID int
	select @CustomerID=CustomerID from AccountInfo where email=@in_email
	if(@@ROWCOUNT = 0) begin
		select 6 as ResultCode, 'No email' as ResultMsg
		return
	end
	
	-- generate password reset token
	declare @token varchar(100) = CONVERT(varchar(100), NEWID())
	set @token = SUBSTRING(master.dbo.fn_varbintohexstr(HashBytes('md5', @token)), 3, 999)
	
	DELETE FROM AccountPwdReset where token=@token
	INSERT INTO AccountPwdReset
		(RequestTime, IP, token, CustomerID, email)
		VALUES
		(GETDATE(), @in_IP, @token, @CustomerID, @in_email)

	select 0 as ResultCode, @token as 'token'
END
