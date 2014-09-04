SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ECLIPSE_CREATEACCOUNT_CHECK]
	@in_Username varchar(16),
	@in_Email varchar(100)
AS
BEGIN
	SET NOCOUNT ON;

	-- validate that username & email is unique
	if exists (SELECT CustomerID FROM LoginID WHERE AccountName=@in_Username) begin
		select 1 as ResultCode, 'Username already in use' as ResultMsg;
		return;
	end
	if exists (SELECT CustomerID FROM LoginID WHERE Gamertag=@in_Username) begin
		select 1 as ResultCode, 'Gamertag already in use' as ResultMsg;
		return;
	end
	if exists (SELECT CustomerID from AccountInfo WHERE email=@in_Email) begin
		select 2 as ResultCode, 'Email already in use' as ResultMsg;
		return;
	end

	-- done
	select 0 as ResultCode
END

GO
