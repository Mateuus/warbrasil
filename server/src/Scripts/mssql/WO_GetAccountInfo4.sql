USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_GetAccountInfo4]    Script Date: 03/21/2012 11:17:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_GetAccountInfo4] 
	@in_CustomerID int,
	@in_IsJoiningGame int
AS
BEGIN
	SET NOCOUNT ON;

	-- check if CustomerID is valid
	if not exists (SELECT CustomerID FROM LoginID WHERE CustomerID=@in_CustomerID)
	begin
		select 6 as ResultCode
		return;
	end
	
	if(@in_IsJoiningGame > 0) begin
		update LoginID set lastjoineddate=GETDATE() where CustomerID=@in_CustomerID
	end

	select 0 as ResultCode

	SELECT LoginID.CustomerID, AccountStatus, GamePoints, GameDollars, HonorPoints, SkillPoints, Gamertag,
		Faction1Score, Faction2Score, Faction3Score, Faction4Score, Faction5Score,
		ClanID, ClanRank, IsFPSEnabled,
		Kills, Deaths, ShotsFired, ShotsHits, Headshots, AssistKills, Wins, Losses, CaptureNeutralPoints, CaptureEnemyPoints, TimePlayed, 
		Skills, Abilities
	FROM LoginID 
	JOIN Stats ON (LoginID.CustomerID = Stats.CustomerID) 
	JOIN ProfileData ON (LoginID.CustomerID = ProfileData.CustomerID) 
	where LoginID.CustomerID=@in_CustomerID
	
--
-- report loadouts
--
	select * from Profile_Chars where CustomerID=@in_CustomerID order by LoadoutID asc

-- 
--	report achievements
--
	select * from Achievements where CustomerID=@in_CustomerID

--
-- report weapon attachments
--	
	select 
		*,
		DATEDIFF(mi, GETDATE(), LeasedUntil) as MinutesLeft
	from Inventory_FPS
	where CustomerID=@in_CustomerID and LeasedUntil>GETDATE()
	order by WeaponID

--
-- report inventory
--
	select 
		*,
		DATEDIFF(mi, GETDATE(), LeasedUntil) as MinutesLeft
	from Inventory
	where CustomerID=@in_CustomerID and LeasedUntil>GETDATE()

--
-- report new items
--
	select ItemID from Items_Weapons where IsNew > 0 and (Price1+Price7+Price30+PriceP+GPrice1+GPrice7+GPrice30+GPriceP) > 0
	union select ItemID from Items_Gear where IsNew > 0 and (Price1+Price7+Price30+PriceP+GPrice1+GPrice7+GPrice30+GPriceP) > 0
	union select ItemID from Items_Generic where IsNew > 0 and (Price1+Price7+Price30+PriceP+GPrice1+GPrice7+GPrice30+GPriceP) > 0
	union select ItemID from Items_Packages where IsNew > 0 and (Price1+Price7+Price30+PriceP+GPrice1+GPrice7+GPrice30+GPriceP) > 0

--
-- report statistics
--
	exec WO_GetAccountDailyStats @in_CustomerID
	exec WO_GetAccountWeeklyStats @in_CustomerID
	
END
