SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_G1Login]
	@in_IP varchar(100),
	@in_G1ID bigint
AS
BEGIN
	SET NOCOUNT ON;

	-- this call is always valid
	select 0 as ResultCode

	-- find customer id based on id
	declare @CustomerID int
	select @CustomerID=CustomerID from GamersfirstUserIDMap where GamersfirstID=@in_G1ID
	if (@@RowCount = 0) begin
		select
			1 as LoginResult,
			0 as CustomerID,
			0 as AccountStatus,
			0 as SessionID
		return
	end
	
	-- get AccountStatus from LoginID
	declare @AccountStatus int
	select @AccountStatus=AccountStatus from LoginID where CustomerID=@CustomerID
	if (@@RowCount = 0) begin
		-- some crap happened - we have broken relationship between GamersfirstID-CustomerID
		-- delete that record, just in case.
		delete from GamersfirstUserIDMap where CustomerID=@CustomerID and GamersfirstID=@in_G1ID
		select
			9 as LoginResult,
			0 as CustomerID,
			0 as AccountStatus,
			0 as SessionID
		return
	end
	
	-- login user
	exec WO_LoginFN_Exec @in_IP, @CustomerID, @AccountStatus
END
GO
