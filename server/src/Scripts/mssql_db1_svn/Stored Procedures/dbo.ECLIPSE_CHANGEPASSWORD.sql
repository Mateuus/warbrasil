SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ECLIPSE_CHANGEPASSWORD]
	@in_IP varchar(100),
	@in_CustomerID int, 
	@in_Password varchar(100),
	@in_NewPassword varchar(100)
AS
BEGIN
	SET NOCOUNT ON;

	declare @MD5Password varchar(100)

	-- search for record with username
	SELECT @MD5Password=MD5Password	FROM LoginID 
	WHERE CustomerID=@in_CustomerID
	if (@@RowCount = 0) begin
		select 6 as ResultCode, 'No CustomerID' as ResultMsg
		return
	end

	-- check MD5 password
	declare @MD5FromPwd varchar(100)
	exec FN_CreateMD5Password @in_Password, @MD5FromPwd OUTPUT
	if(@MD5Password <> @MD5FromPwd) begin
		select 6 as ResultCode, 'Wrong Password' as ResultMsg
		return
	end
	
	-- update new password
	exec FN_CreateMD5Password @in_NewPassword, @MD5FromPwd OUTPUT
	update LoginID set MD5Password=@MD5FromPwd where CustomerID=@in_CustomerID

	select 0 as ResultCode
END
GO
