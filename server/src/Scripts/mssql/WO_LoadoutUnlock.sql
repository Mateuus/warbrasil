USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_LoadoutUnlock]    Script Date: 03/26/2012 18:44:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[WO_LoadoutUnlock] 
	@in_CustomerID int,
	@in_Class int
AS
BEGIN
	SET NOCOUNT ON;
	
	declare @SlotData varchar(256) = ''
	
	if(@in_Class = 0) 
	begin
		-- assault
		exec FN_AddItemToUser @in_CustomerID, 20026, 2000 -- PMC Soldier Body
		exec FN_AddItemToUser @in_CustomerID, 20019, 2000 -- Lumberjack head
		exec FN_AddItemToUser @in_CustomerID, 20061, 2000 -- Medium Desert Armor
		exec FN_AddItemToUser @in_CustomerID, 101002, 2000 -- Colt M16
		exec FN_AddItemToUser @in_CustomerID, 101158, 2000 -- Mossberg 590
		exec FN_AddItemToUser @in_CustomerID, 101004, 2000 -- FN 57 handgun
		
		set @SlotData = '20061 0 20019 20026 0 0 0 0 0 0 101002 101158 101004'
	end

	if(@in_Class = 1) 
	begin
		-- specialist
		exec FN_AddItemToUser @in_CustomerID, 20092, 2000 -- Spetznaz body
		exec FN_AddItemToUser @in_CustomerID, 20020, 2000 -- Mr East head
		exec FN_AddItemToUser @in_CustomerID, 20056, 2000 -- MTV Forest Armor
		exec FN_AddItemToUser @in_CustomerID, 101093, 2000 -- RPK-74
		exec FN_AddItemToUser @in_CustomerID, 101003, 2000 -- RPG-7
		exec FN_AddItemToUser @in_CustomerID, 101004, 2000 -- FN 57 handgun

		set @SlotData = '20056 0 20020 20092 0 0 0 0 0 0 101093 101003 101004'
	end

	if(@in_Class = 2) 
	begin
		-- recon
		exec FN_AddItemToUser @in_CustomerID, 20000, 2000 -- Grunt Body
		exec FN_AddItemToUser @in_CustomerID, 20018, 2000 -- Chinese Melvin head
		exec FN_AddItemToUser @in_CustomerID, 20014, 2000 -- Ghili Suit
		exec FN_AddItemToUser @in_CustomerID, 101068, 2000 -- SVD
		exec FN_AddItemToUser @in_CustomerID, 101103, 2000 -- MP5 SMG
		exec FN_AddItemToUser @in_CustomerID, 101004, 2000 -- FN 57 handgun
		
		set @SlotData = '20014 0 20018 20000 0 0 0 0 0 0 101068 101103 101004'
	end

	if(@in_Class >= 3) 
	begin
		-- medic
		exec FN_AddItemToUser @in_CustomerID, 20007, 2000 -- Specops body
		exec FN_AddItemToUser @in_CustomerID, 20021, 2000 -- Mr West head
		exec FN_AddItemToUser @in_CustomerID, 20001, 2000 -- Light Gear
		exec FN_AddItemToUser @in_CustomerID, 20043, 2000 -- M9 Helmet Black
		exec FN_AddItemToUser @in_CustomerID, 101002, 2000 -- Colt M16
		exec FN_AddItemToUser @in_CustomerID, 101103, 2000 -- MP5 SMG
		exec FN_AddItemToUser @in_CustomerID, 101004, 2000 -- FN 57 handgun

		set @SlotData = '20001 0 20021 20007 0 0 0 0 0 0 101002 101103 101004'
	end
	
	insert into Profile_Chars (
		CustomerID,
		Class,
		Loadout
	) values (
		@in_CustomerID,
		@in_Class,
		@SlotData
	)
	
	-- detect loadout id
	declare @LoadoutID int
	select top(1) @LoadoutID=LoadoutID from Profile_Chars where CustomerID=@in_CustomerID order by LoadoutID desc

	select 0 as ResultCode
	select @LoadoutID as 'LoadoutID', @SlotData as 'Loadout'
END

