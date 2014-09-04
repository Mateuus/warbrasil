USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_BuyItemFN_Exec]    Script Date: 03/22/2012 12:16:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_BuyItemFN_Exec]
	@out_FNResult int out,
	@in_CustomerID int,
	@in_ItemId int,
	@in_BuyDays int,
	@in_Param1 int = 0
AS
BEGIN
	SET NOCOUNT ON;
	
	--
	--
	-- main function for buying items in game, should be called from WO_BuyItem2
	--
	--

	-- set success by default
	set @out_FNResult = 0
	
	-- weapon attachment item
	if(@in_ItemId >= 400000 and @in_ItemId < 490000) begin
		exec FN_AddAttachmentToUser @in_CustomerID, @in_Param1, @in_ItemId, @in_BuyDays
		return
	end

	-- package item
	if(@in_ItemId >= 500000 and @in_ItemId < 590000) begin
		exec WO_BuyItemFN_AddPackage @out_FNResult out, @in_CustomerID, @in_ItemId
		return
	end

	-- item upgrade item - skip inventory
	if(@in_ItemId >= 600000 and @in_ItemId < 699999) begin
		return
	end

	-- premium acc
	if(@in_ItemId = 301004) begin
		exec FN_AddPremiumAccToUser @in_CustomerID, @in_BuyDays
		return
	end
	
	-- unlock loadout (5 slots) : not used items
	if(@in_ItemId >= 301050 and @in_ItemId <= 301054) begin
		return
	end
	
	-- unlock new loadout. NOTE: no item adding
	if(@in_ItemId = 301142) begin
		return
	end

	-- add generic ability. NOTE: no item adding
	if(@in_ItemId = 301055) begin
		return
	end
	
	-- change gamertag. NOTE: no item adding
	if(@in_ItemId = 301045) begin
		return
	end
	
	-- reset stats
	if(@in_ItemId = 301046) begin 
		update Stats set ShotsFired=0, ShotsHits=0 where CustomerID=@in_CustomerID
		return
	end

	-- reset kill/death
	if(@in_ItemId = 301047) begin 
		update Stats set Kills=0, Deaths=0 where CustomerID=@in_CustomerID
		return
	end

	-- reset win/lose
	if(@in_ItemId = 301049) begin 
		update Stats set Wins=0, Losses=0 where CustomerID=@in_CustomerID
		return
	end

	-- reset skills
	if(@in_ItemId = 301048) begin 
		exec WO_BuyItemFN_UnlearnSkills @out_FNResult out, @in_CustomerID, 1
		return
	end
	
	-- skip adding to inventory by some special Items_Generic category
	--  3: mystery boxes
	--  6: airstrikes
	declare @ItemCategory int = 0
	select @ItemCategory=Category from Items_Generic where ItemID=@in_ItemId
	if(@ItemCategory = 3 or @ItemCategory = 6) begin
		return
	end
	-- loot boxes must be *removed* from user inventory, we're unlocking them
	--  7: loot boxes
	if(@ItemCategory = 7) begin
		exec FN_RemoveOneItemFromUser @in_CustomerID, @in_ItemID
		return
	end
	
	-- all weapon renting
	if(@in_ItemId = 301106) begin
		exec WO_BuyItemFN_RentWeapons @out_FNResult out, @in_CustomerID, @in_BuyDays, 0
		return
	end
	
	-- 10k GD
	if(@in_ItemId = 301107) begin
		update LoginID set GameDollars=GameDollars+10000 where CustomerID=@in_CustomerID
		return
	end
	
	-- normal item
	exec FN_AddItemToUser @in_CustomerID, @in_ItemId, @in_BuyDays
	set @out_FNResult = 0

END
