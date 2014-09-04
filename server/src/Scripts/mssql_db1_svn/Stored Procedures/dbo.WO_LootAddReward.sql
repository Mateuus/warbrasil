SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_LootAddReward]
	@in_CustomerID int,
	@in_Roll float,
	@in_LootID int,
	@in_ItemID int,
	@in_ExpDays int,
	@in_GD int
AS
BEGIN
	SET NOCOUNT ON;
	
	-- check if we have item already, and if not - reset GD winning
	if(@in_ItemID > 0) begin
		if not exists (select ItemID from Inventory where CustomerID=@in_CustomerID and ItemID=@in_ItemID)
			set @in_GD = 0
	end
	
	-- log winning
	insert into DBG_LootRewards 
		(ReportTime, CustomerID, Roll, LootID, ItemID, ExpDays, GD)
	values	(GETDATE(), @in_CustomerID, @in_Roll, @in_LootID, @in_ItemID, @in_ExpDays, @in_GD)
	
	-- add rewards
	if(@in_GD > 0) begin
		update LoginID set GameDollars=GameDollars+@in_GD where CustomerID=@in_CustomerID
	end
	if(@in_ItemID > 0) begin
		exec FN_AddItemToUser @in_CustomerID, @in_ItemID, @in_ExpDays
	end

	-- success
	select 0 as ResultCode
	
	select @in_GD as 'GD'
END

GO
