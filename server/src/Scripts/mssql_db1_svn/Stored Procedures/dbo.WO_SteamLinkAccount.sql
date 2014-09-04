SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_SteamLinkAccount]
	@in_CustomerID int,
	@in_SteamID bigint
AS
BEGIN
	SET NOCOUNT ON;
	
	select 0 as ResultCode
	insert into SteamUserIDMap (CustomerID, SteamID) values (@in_CustomerID, @in_SteamID)
	
	-- steam account bonuses (was before 24th Jule)
	--update LoginID set GameDollars=GameDollars+5000 where CustomerID=@in_CustomerID
	--exec FN_AddItemToUser @in_CustomerID, 301001, 14
	--exec FN_AddItemToUser @in_CustomerID, 101210, 14
	--exec FN_AddItemToUser @in_CustomerID, 101083, 14
	--exec FN_AddItemToUser @in_CustomerID, 20063, 14
	--exec FN_AddItemToUser @in_CustomerID, 20065, 14
	--exec FN_AddItemToUser @in_CustomerID, 20064, 14
	--exec FN_AddItemToUser @in_CustomerID, 20066, 14
END
GO
