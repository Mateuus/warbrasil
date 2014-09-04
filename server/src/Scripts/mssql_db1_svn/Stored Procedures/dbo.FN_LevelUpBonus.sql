
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		Pavel Tumik
-- Create date: May 29, 2011
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[FN_LevelUpBonus] 
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
		exec FN_AddItemToUser @in_CustomerID, 301000, 3 -- blackops crate
		exec FN_AddItemToUser @in_CustomerID, 101173, 1 -- IMI Tavor
	end
	if (@in_LevelUp = 3) begin
		exec FN_AddItemToUser @in_CustomerID, 301003, 1 -- 2X GD
		exec FN_AddItemToUser @in_CustomerID, 101254, 3 -- camera drone
		exec FN_AddItemToUser @in_CustomerID, 101106, 1 --	Honey Badger
	end
	if (@in_LevelUp = 4) begin
		exec FN_AddItemToUser @in_CustomerID, 101218, 1 --	G36 Elite
	end
	else if(@in_LevelUp = 5) begin
		exec FN_AddItemToUser @in_CustomerID, 101180, 1	-- 	Desert Eagle	45
	end
	else if(@in_LevelUp = 6) begin
		exec FN_AddItemToUser @in_CustomerID, 301067, 3 --	big surprise
		exec FN_AddItemToUser @in_CustomerID, 101247, 1 --	Blaser 93R
	end
	else if(@in_LevelUp = 7) begin
		exec FN_AddItemToUser @in_CustomerID, 101092, 1 --	Pecheneg 	29
	end
	else if(@in_LevelUp = 8) begin
		exec FN_AddItemToUser @in_CustomerID, 101037, 1 --	Famas F1	24
	end
	else if(@in_LevelUp = 9) begin
		exec FN_AddItemToUser @in_CustomerID, 101109, 1 --	Bizon
	end
	else if(@in_LevelUp = 10) begin
		set @gd=(@gd+10000)
		exec FN_AddItemToUser @in_CustomerID, 301003, 1 -- 2X GD
		exec FN_AddItemToUser @in_CustomerID, 301001, 1 -- 2X XP
		exec FN_AddItemToUser @in_CustomerID, 101215, 1 --	Sig 516 Elite
	end
	else if(@in_LevelUp = 11) begin
		exec FN_AddItemToUser @in_CustomerID, 101202, 1	--	QLB 06
	end
	else if(@in_LevelUp = 12) begin
		exec FN_AddItemToUser @in_CustomerID, 101200, 1 -- AA-12, USAS-12
	end
	else if(@in_LevelUp = 13) begin
		exec FN_AddItemToUser @in_CustomerID, 101189, 1	--	M 202 Flash 
	end
	else if(@in_LevelUp = 14) begin
		exec FN_AddItemToUser @in_CustomerID, 101084, 1 --	VSS Vintorez 
	end
	else if(@in_LevelUp = 15) begin
		exec FN_AddItemToUser @in_CustomerID, 101214, 1 --	M249 Elite
		exec FN_AddItemToUser @in_CustomerID, 101227, 1 -- Bizon Elite
		exec FN_AddItemToUser @in_CustomerID, 101219, 1 -- SCAR ELITE
		exec WO_BuyItemFN_RentWeapons @out_FNResult out, @in_CustomerID, 1, 0
		set @gd=(@gd+10000)
	end
	else if(@in_LevelUp = 16) begin
		exec FN_AddItemToUser @in_CustomerID, 101087, 1 --	Mauser HP50
	end
	else if(@in_LevelUp = 17) begin
		exec FN_AddItemToUser @in_CustomerID, 101063, 1 --	TR7 SMG
	end
	else if(@in_LevelUp = 18) begin
		exec FN_AddItemToUser @in_CustomerID, 101106, 1 --	Honey Badger
	end
	else if(@in_LevelUp = 19) begin
		exec FN_AddItemToUser @in_CustomerID, 101246, 3 --	FN P90S
	end
	else if(@in_LevelUp = 20) begin
		set @gd=(@gd+10000)
		exec FN_AddItemToUser @in_CustomerID, 301003,1 -- 2X GD
		exec FN_AddItemToUser @in_CustomerID, 301001,1 -- 2X XP
		exec WO_BuyItemFN_RentWeapons @out_FNResult out, @in_CustomerID, 1, 0
	end
	else if(@in_LevelUp = 25) begin
		exec WO_BuyItemFN_RentWeapons @out_FNResult out, @in_CustomerID, 5, 0
	end
	else if(@in_LevelUp = 30) begin
		set @gd=(@gd+50000)
		exec FN_AddItemToUser @in_CustomerID, 301003,1 -- 2X GD
		exec FN_AddItemToUser @in_CustomerID, 301001,1 -- 2X XP
	end
	else if(@in_LevelUp = 35) begin
		set @gd=(@gd+15000)
	end
	else if(@in_LevelUp = 40) begin
		set @gd=(@gd+50000)
		exec FN_AddItemToUser @in_CustomerID, 301003,2 -- 2X GD
		exec FN_AddItemToUser @in_CustomerID, 301001,2 -- 2X XP
	end
	else if(@in_LevelUp = 45) begin
		set @gd=(@gd+15000)
		exec WO_BuyItemFN_RentWeapons @out_FNResult out, @in_CustomerID, 7, 0
	end
	else if(@in_LevelUp = 50) begin
		set @gd=(@gd+100000)
		exec FN_AddItemToUser @in_CustomerID, 301003,3 -- 2X GD
	end
	else if(@in_LevelUp = 55) begin
--		set @gd=(@gd+150000)
		exec FN_AddItemToUser @in_CustomerID, 301003,2 -- 2X GD
	end
	else if(@in_LevelUp = 60) begin
		set @gd=(@gd+200000)
		set @gp=(@gp+25000)
		exec WO_BuyItemFN_RentWeapons @out_FNResult out, @in_CustomerID, 30, 0
	end

	exec FN_AlterUserGP @in_CustomerID, @gp, 'levelup'
	
	UPDATE LoginID SET 
		GameDollars=(GameDollars + @gd),
		SkillPoints=(SkillPoints + @sp)
	where CustomerID=@in_CustomerID

END


















GO
