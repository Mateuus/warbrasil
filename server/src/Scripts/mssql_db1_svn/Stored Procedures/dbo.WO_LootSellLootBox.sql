SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_LootSellLootBox]
	@in_CustomerID int,
	@in_ItemID int
AS
BEGIN
	SET NOCOUNT ON;
	
	declare @SellGD int = 0
	
	-- check if this item is actually a loot box and have sell price (in GD, Permanent)
	select @SellGD=GPriceP from Items_Generic where ItemID=@in_ItemID and Category=7
	if(@@ROWCOUNT = 0) begin
		select 6 as ResultCode, 'no loot box' as ResultMsg
		return
	end
	if(@SellGD = 0) begin
		select 6 as ResultCode, 'no loot box sell price set' as ResultMsg
		return
	end
	
	-- check if we actually have that box in inventory
	declare @Quantity int = 0
	select @Quantity=Quantity from Inventory where CustomerID=@in_CustomerID and ItemID=@in_ItemID
	if(@@ROWCOUNT = 0 or @Quantity < 1) begin
		select 6 as ResultCode, 'no loot box in inventory' as ResultMsg
		return
	end

	-- sell item
	update LoginID set GameDollars=GameDollars+@SellGD where CustomerID=@in_CustomerID
	
	-- update item quantity
	exec FN_RemoveOneItemFromUser @in_CustomerID, @in_ItemID
	
	-- record that
	INSERT INTO FinancialTransactions
		VALUES (@in_CustomerID, 'LOOTBOX_SELL', 2003, GETDATE(), 
				@SellGD, '1', 'APPROVED', @in_ItemId)

	-- success
	select 0 as ResultCode
END

GO
