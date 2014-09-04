USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[FN_LevelUpBonus]    Script Date: 01/27/2012 08:00:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[FN_LevelUpBonus] 
	@in_CustomerID int,
	@in_LevelUp int
AS
BEGIN
	--
	--
	-- WARNING. THIS IS GAMENET VERSION, 
	-- DO NOT USE IN USA SERVER :)
	--
	--

	SET NOCOUNT ON;
	
	declare @GameDollars int = 0
	declare @SP int = 0
	declare @ItemDays int = 0
	declare @ItemID_1 int = 0
	declare @ItemID_2 int = 0
	declare @ItemID_3 int = 0
	declare @ItemID_4 int = 0
	declare @ItemID_5 int = 0
	
	select 
		@GameDollars=GameDollars,
		@SP=SP,
		@ItemDays=ItemDays,
		@ItemID_1=ItemID_1,
		@ItemID_2=ItemID_2,
		@ItemID_3=ItemID_3,
		@ItemID_4=ItemID_4,
		@ItemID_5=ItemID_5
	from DataLevelUpBonuses where RankLevel=@in_LevelUp
	if(@@ROWCOUNT = 0) begin
		return
	end
		
	set @SP = @SP + 1 -- always give at least one SP
	
	UPDATE LoginID SET 
		GameDollars=(GameDollars + @GameDollars),
		SkillPoints=(SkillPoints + @SP)
	where CustomerID=@in_CustomerID
	
	if(@ItemID_1 > 0) exec FN_AddItemToUser @in_CustomerID, @ItemID_1, @ItemDays
	if(@ItemID_2 > 0) exec FN_AddItemToUser @in_CustomerID, @ItemID_2, @ItemDays
	if(@ItemID_3 > 0) exec FN_AddItemToUser @in_CustomerID, @ItemID_3, @ItemDays
	if(@ItemID_4 > 0) exec FN_AddItemToUser @in_CustomerID, @ItemID_4, @ItemDays
	if(@ItemID_5 > 0) exec FN_AddItemToUser @in_CustomerID, @ItemID_5, @ItemDays

END

