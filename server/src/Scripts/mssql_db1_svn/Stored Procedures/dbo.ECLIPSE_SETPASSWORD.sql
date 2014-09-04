SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ECLIPSE_SETPASSWORD]
	@in_CustomerID int, 
	@in_NewPassword varchar(100)
AS
BEGIN
	SET NOCOUNT ON;

	-- create MD5 password
	declare @MD5FromPwd varchar(100)
	exec FN_CreateMD5Password @in_NewPassword, @MD5FromPwd OUTPUT
	
	-- and set it
	update LoginID set MD5Password=@MD5FromPwd where CustomerID=@in_CustomerID

	select 0 as ResultCode
END
GO
