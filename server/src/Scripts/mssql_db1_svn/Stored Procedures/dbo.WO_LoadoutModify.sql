SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_LoadoutModify] 
	@in_CustomerID int,
	@in_LoadoutID int,
	@i1 int,
	@i2 int,
	@i3 int,
	@i4 int,
	@i5 int,
	@i6 int,
	@i7 int,
	@i8 int,
	@i9 int,
	@i10 int,
	@i11 int,
	@i12 int,
	@i13 int
AS
BEGIN
	SET NOCOUNT ON;
	
	-- validate that player own that loadout	
	declare @CustomerID int = 0
	select @CustomerID=CustomerID from Profile_Chars where LoadoutID=@in_LoadoutID
	if(@@ROWCOUNT = 0) begin
		select 6 as ResultCode, 'no loadout id' as ResultMsg
		return
	end
	
	if(@CustomerID <> @in_CustomerID) begin
		select 6 as ResultCode, 'bad customerid' as ResultMsg
		return
	end

--
-- verify all items against player inventory
--	
	EXEC @i1 = FN_VALIDATE_LOADOUT_ITEM '', @in_CustomerID, @i1, 0
	EXEC @i2 = FN_VALIDATE_LOADOUT_ITEM '', @in_CustomerID, @i2, 1
	EXEC @i3 = FN_VALIDATE_LOADOUT_ITEM '', @in_CustomerID, @i3, 2
	EXEC @i4 = FN_VALIDATE_LOADOUT_ITEM '', @in_CustomerID, @i4, 3
	EXEC @i5 = FN_VALIDATE_LOADOUT_ITEM '', @in_CustomerID, @i5, 4
	EXEC @i6 = FN_VALIDATE_LOADOUT_ITEM '', @in_CustomerID, @i6, 5
	EXEC @i7 = FN_VALIDATE_LOADOUT_ITEM '', @in_CustomerID, @i7, 6
	EXEC @i8 = FN_VALIDATE_LOADOUT_ITEM '', @in_CustomerID, @i8, 7
	EXEC @i9 = FN_VALIDATE_LOADOUT_ITEM '', @in_CustomerID, @i9, 8
	EXEC @i10 = FN_VALIDATE_LOADOUT_ITEM '', @in_CustomerID, @i10, 9
	EXEC @i11 = FN_VALIDATE_LOADOUT_ITEM '', @in_CustomerID, @i11, 10
	EXEC @i12 = FN_VALIDATE_LOADOUT_ITEM '', @in_CustomerID, @i12, 11
	EXEC @i13 = FN_VALIDATE_LOADOUT_ITEM '', @in_CustomerID, @i13, 12

	-- create loadout string.
	-- note that STR return leftpadded char of size 10
	declare @SlotData varchar(1000) = ''
	set @SlotData = LTRIM(STR(@i1)) + ' '
	set @SlotData = @SlotData + LTRIM(STR(@i2)) + ' '
	set @SlotData = @SlotData + LTRIM(STR(@i3)) + ' '
	set @SlotData = @SlotData + LTRIM(STR(@i4)) + ' '
	set @SlotData = @SlotData + LTRIM(STR(@i5)) + ' '
	set @SlotData = @SlotData + LTRIM(STR(@i6)) + ' '
	set @SlotData = @SlotData + LTRIM(STR(@i7)) + ' '
	set @SlotData = @SlotData + LTRIM(STR(@i8)) + ' '
	set @SlotData = @SlotData + LTRIM(STR(@i9)) + ' '
	set @SlotData = @SlotData + LTRIM(STR(@i10)) + ' '
	set @SlotData = @SlotData + LTRIM(STR(@i11)) + ' '
	set @SlotData = @SlotData + LTRIM(STR(@i12)) + ' '
	set @SlotData = @SlotData + LTRIM(STR(@i13))
	
	-- update loadout slot
	UPDATE Profile_Chars SET Loadout=@SlotData where LoadoutID=@in_LoadoutID

	select 0 as ResultCode
	select @SlotData as 'Loadout'
END
GO
