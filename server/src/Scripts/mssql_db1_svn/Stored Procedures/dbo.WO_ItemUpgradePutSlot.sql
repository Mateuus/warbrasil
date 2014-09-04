SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_ItemUpgradePutSlot]
	@in_CustomerID int,
	@in_ItemID int,
	@in_SlotID int,
	@in_NewUpgradeID int,
	-- parameters for statistics
	@in_Success int,
	@in_Category int,
	@in_Type int,
	@in_Level int,
	@in_Price int,
	@in_IsGP int
AS
BEGIN
	SET NOCOUNT ON;
	
	-- check that we have that item
	declare @TempItemId int
	select @TempItemId=ItemID from Inventory 
		where CustomerID=@in_CustomerID and ItemID=@in_ItemID
	if(@@ROWCOUNT = 0) begin
		select 6 as ResultCode, 'no such item' as ResultMsg
		return
	end

	-- TODO (if needed) - add logging to some table...
	-- xxxx
	
	-- put new upgrade item to inventory slot
	if(@in_SlotID = 0) 
		update Inventory set UpSlot1=@in_NewUpgradeID where CustomerID=@in_CustomerID and ItemID=@in_ItemID
	else if(@in_SlotID = 1) 
		update Inventory set UpSlot2=@in_NewUpgradeID where CustomerID=@in_CustomerID and ItemID=@in_ItemID
	else if(@in_SlotID = 2) 
		update Inventory set UpSlot3=@in_NewUpgradeID where CustomerID=@in_CustomerID and ItemID=@in_ItemID
	else if(@in_SlotID = 3) 
		update Inventory set UpSlot4=@in_NewUpgradeID where CustomerID=@in_CustomerID and ItemID=@in_ItemID
	else if(@in_SlotID = 4) 
		update Inventory set UpSlot5=@in_NewUpgradeID where CustomerID=@in_CustomerID and ItemID=@in_ItemID
	else begin
		select 6 as ResultCode, 'invalid in_SlotID' as ResultMsg
		return
	end

	select 0 as ResultCode
	return
END
GO
