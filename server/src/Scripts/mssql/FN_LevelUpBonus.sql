USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[FN_LevelUpBonus]    Script Date: 03/22/2012 12:33:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








-- =============================================
-- Author:		Pavel Tumik
-- Create date: May 29, 2011
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[FN_LevelUpBonus] 
       @in_CustomerID int,
       @in_LevelUp int
AS
BEGIN
	SET NOCOUNT ON;

	declare @out_FNResult int
	
	declare @gp int
	declare @gd int
	declare @sp int
	set @gp=0
	set @gd=0 -- level up bonus
	set @sp=1 -- always give at least one SP

	if (@in_LevelUp = 2) begin
		exec FN_AddItemToUser @in_CustomerID, 301000, 5 -- blackops crate
		exec FN_AddItemToUser @in_CustomerID, 101173, 3 --	IMI Tavor
		set @gd=(@gd+5000)
	end
	if (@in_LevelUp = 3) begin
		exec FN_AddItemToUser @in_CustomerID, 301003, 1 -- 2X GD
		exec FN_AddItemToUser @in_CustomerID, 301006, 7 -- camera drone
		exec FN_AddItemToUser @in_CustomerID, 101085, 3 --	Mauser SRG
		set @gd=(@gd+5000)
	end
	if (@in_LevelUp = 4) begin
		exec FN_AddItemToUser @in_CustomerID, 101189, 2	--	M 202 Flash 
		exec FN_AddItemToUser @in_CustomerID, 101035, 2 --	Kalashnikov AKS-74U	22
		set @gd=(@gd+5000)
	end
	else if(@in_LevelUp = 5) begin
		exec FN_AddItemToUser @in_CustomerID, 101177, 2 --	G36 CMag	25
		exec FN_AddItemToUser @in_CustomerID, 101180, 2	-- 	Desert Eagle	45
		set @gd=(@gd+10000)
		set @gp=(@gp+500)
	end
	else if(@in_LevelUp = 6) begin
		exec FN_AddItemToUser @in_CustomerID, 301067, 7 --	big surprise
		exec FN_AddItemToUser @in_CustomerID, 101095, 2 --	FN M249 MkII	23
		exec FN_AddItemToUser @in_CustomerID, 101107, 2 --	FN P90 	30
		set @gp=(@gp+500)
	end
	else if(@in_LevelUp = 7) begin
		exec FN_AddItemToUser @in_CustomerID, 101092, 2 --	Pecheneg 	29
		exec FN_AddItemToUser @in_CustomerID, 101084, 2 --	VSS Vintorez 
		set @gp=(@gp+500)
	end
	else if(@in_LevelUp = 8) begin
		exec FN_AddItemToUser @in_CustomerID, 101037, 2 --	Famas F1	24
		set @gp=(@gp+500)
	end
	else if(@in_LevelUp = 9) begin
		exec FN_AddItemToUser @in_CustomerID, 101196, 3	-- 	Jericho
		exec FN_AddItemToUser @in_CustomerID, 101183, 2 --	KT Decider
	end
	else if(@in_LevelUp = 10) begin
		set @gd=(@gd+10000)
		set @gp=(@gp+3000)
		exec FN_AddItemToUser @in_CustomerID, 301003, 1 -- 2X GD
		exec FN_AddItemToUser @in_CustomerID, 301001, 1 -- 2X XP
	end
	else if(@in_LevelUp = 11) begin
		exec FN_AddItemToUser @in_CustomerID, 101202, 3	--	QLB 06
	end
	else if(@in_LevelUp = 12) begin
		exec FN_AddItemToUser @in_CustomerID, 101200, 3 -- AA-12, USAS-12
	end
	else if(@in_LevelUp = 14) begin
		exec FN_AddItemToUser @in_CustomerID, 101064, 3 --	UZI	31
	end
	else if(@in_LevelUp = 15) begin
		set @gd=(@gd+10000)
		set @gp=(@gp+1000)
	end
	else if(@in_LevelUp = 20) begin
		set @gd=(@gd+20000)
		set @gp=(@gp+5000)
		exec FN_AddItemToUser @in_CustomerID, 301003,2 -- 2X GD
		exec FN_AddItemToUser @in_CustomerID, 301001,2 -- 2X XP
	end
	else if(@in_LevelUp = 25) begin
		set @gd=(@gd+20000)
		set @gp=(@gp+2500)
		exec WO_BuyItemFN_RentWeapons @out_FNResult out, @in_CustomerID, 5, 0
	end
	else if(@in_LevelUp = 30) begin
		set @gd=(@gd+50000)
		set @gp=(@gp+7500)
		exec FN_AddItemToUser @in_CustomerID, 301003,2 -- 2X GD
		exec FN_AddItemToUser @in_CustomerID, 301001,2 -- 2X XP
	end
	else if(@in_LevelUp = 35) begin
		set @gd=(@gd+25000)
	end
	else if(@in_LevelUp = 40) begin
		set @gd=(@gd+50000)
		set @gp=(@gp+10000)
		exec FN_AddItemToUser @in_CustomerID, 301003,2 -- 2X GD
		exec FN_AddItemToUser @in_CustomerID, 301001,2 -- 2X XP
	end
	else if(@in_LevelUp = 41) begin
		-- no reward for now: was giving one loadout slot
		set @gp=(@gp+0)
	end
	else if(@in_LevelUp = 45) begin
		set @gd=(@gd+50000)
		exec WO_BuyItemFN_RentWeapons @out_FNResult out, @in_CustomerID, 7, 0
	end
	else if(@in_LevelUp = 50) begin
		set @gd=(@gd+100000)
		set @gp=(@gp+15000)
		exec FN_AddItemToUser @in_CustomerID, 301003,3 -- 2X GD
	end
	else if(@in_LevelUp = 55) begin
		set @gd=(@gd+150000)
		exec FN_AddItemToUser @in_CustomerID, 301003,2 -- 2X GD
	end
	else if(@in_LevelUp = 60) begin
		set @gd=(@gd+200000)
		set @gp=(@gp+50000)
		exec WO_BuyItemFN_RentWeapons @out_FNResult out, @in_CustomerID, 30, 0
	end
	
	UPDATE LoginID SET 
		GamePoints=(GamePoints + @gp), 
		GameDollars=(GameDollars + @gd),
		SkillPoints=(SkillPoints + @sp)
	where CustomerID=@in_CustomerID

END








