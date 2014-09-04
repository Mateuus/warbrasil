
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Denis Zhulitov
-- Create date: 03/15/2011
-- Description:	deleting unused records from tables if user record was deleted
-- =============================================
CREATE PROCEDURE [dbo].[DB_PurgeUnusedUserData]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	delete from AccountInfo
	where not exists (select * from LoginID where LoginID.CustomerID = AccountInfo.CustomerID)
	select @@RowCount as Deleted, 'AccountInfo' as FromTable

	delete from Profile_Chars
	where not exists (select * from LoginID where LoginID.CustomerID = Profile_Chars.CustomerID)
	select @@RowCount as Deleted, 'Profile_Chars' as FromTable

	delete from ProfileData
	where not exists (select * from LoginID where LoginID.CustomerID = ProfileData.CustomerID)
	select @@RowCount as Deleted, 'ProfileData' as FromTable

	delete from Stats
	where not exists (select * from LoginID where LoginID.CustomerID = Stats.CustomerID)
	select @@RowCount as Deleted, 'Stats' as FromTable

	delete from Logins
	where not exists (select * from LoginID where LoginID.CustomerID = Logins.CustomerID)
	select @@RowCount as Deleted, 'Logins' as FromTable

	delete from Inventory
	where not exists (select * from LoginID where LoginID.CustomerID = Inventory.CustomerID)
	select @@RowCount as Deleted, 'Inventory' as FromTable

	delete from Inventory_FPS
	where not exists (select * from LoginID where LoginID.CustomerID = Inventory_FPS.CustomerID)
	select @@RowCount as Deleted, 'Inventory_FPS' as FromTable

	delete from SteamUserIDMap
	where not exists (select * from LoginID where LoginID.CustomerID = SteamUserIDMap.CustomerID)
	select @@RowCount as Deleted, 'SteamUserIDMap' as FromTable

	delete from GamersfirstUserIDMap
	where not exists (select * from LoginID where LoginID.CustomerID = GamersfirstUserIDMap.CustomerID)
	select @@RowCount as Deleted, 'GamersfirstUserIDMap' as FromTable
	
	-- purge inventory
	declare @InvCleanDate datetime = DATEADD(day, -30, GETDATE())
	delete from Inventory where LeasedUntil<@InvCleanDate
	delete from Inventory_FPS where LeasedUntil<@InvCleanDate
	
END
GO
