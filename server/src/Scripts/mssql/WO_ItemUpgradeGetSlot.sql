USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_ItemUpgradeGetSlot]    Script Date: 12/06/2011 19:23:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_ItemUpgradeGetSlot]
	@in_CustomerID int,
	@in_ItemID int
AS
BEGIN
	SET NOCOUNT ON;
	
	-- check that we have that item
	declare @UpSlot1 int
	declare @UpSlot2 int
	declare @UpSlot3 int
	declare @UpSlot4 int
	declare @UpSlot5 int
	select @UpSlot1=UpSlot1,
		@UpSlot2=UpSlot2, 
		@UpSlot3=UpSlot3, 
		@UpSlot4=UpSlot4, 
		@UpSlot5=UpSlot5
		from Inventory where CustomerID=@in_CustomerID and ItemID=@in_ItemID
	if(@@ROWCOUNT = 0) begin
		select 6 as ResultCode, 'no such item' as ResultMsg
		return
	end
	
	-- success
	select 0 as ResultCode
	
	declare @Category int = 0
	declare @IsUpgradeable int = 0
	select @Category=Category, @IsUpgradeable=IsUpgradeable from Items_Weapons 
		where ItemID=@in_ItemID
	
	select 
		@Category as 'Category',
		@IsUpgradeable as 'IsUpgradeable',
		@UpSlot1 as 'UpSlot1',
		@UpSlot2 as 'UpSlot2',
		@UpSlot3 as 'UpSlot3',
		@UpSlot4 as 'UpSlot4',
		@UpSlot5 as 'UpSlot5'
	return
	
END
