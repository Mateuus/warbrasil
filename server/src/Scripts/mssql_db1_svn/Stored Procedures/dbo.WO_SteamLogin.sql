SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_SteamLogin]
	@in_IP varchar(100),
	@in_SteamID bigint
AS
BEGIN
	SET NOCOUNT ON;

	-- this call is always valid
	select 0 as ResultCode

	-- find customer id based on steam id
	declare @CustomerID int
	select @CustomerID=CustomerID from SteamUserIDMap where SteamID=@in_SteamID
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
		-- some crap happened - we have broken relationship between SteamID-CustomerID
		-- delete that record, just in case.
		delete from SteamUserIdMap where CustomerID=@CustomerID and SteamID=@in_SteamID
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
