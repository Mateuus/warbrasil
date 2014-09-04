USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_WelcomePackage4]    Script Date: 03/21/2012 12:12:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_WelcomePackage4] 
	@in_IP varchar(100),
	@in_CustomerID int,
	@in_Class int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @AccountStatus int
	SELECT @AccountStatus=AccountStatus FROM LoginID WHERE CustomerID=@in_CustomerID
	if (@@RowCount = 0) begin
		select 6 as ResultCode, 'no CustomerID' as ResultMsg
		return
	end

	if @AccountStatus <> 100 begin
		EXEC FN_ADD_SECURITY_LOG 161, @in_IP, @in_CustomerID, @AccountStatus
		select 7 as ResultCode, 'bad AccountStatus' as ResultMsg
		return
	end

	--
	-- NOTE: class related items is added inside 
	--  WO_LoadoutUnlock procedure
	--

	-- actually add things to inventory - those are your permanent items
	exec FN_AddItemToUser @in_CustomerID, 101004, 2000 -- FN 57	35
	exec FN_AddItemToUser @in_CustomerID, 101008, 2000 -- M26 grenade
	exec FN_AddItemToUser @in_CustomerID, 101149, 2000 -- Green smoke grenade
	exec FN_AddItemToUser @in_CustomerID, 101032, 2000 -- Kalashnikov AKM	20

	exec FN_AddItemToUser @in_CustomerID, 20000, 2000 -- default body
	exec FN_AddItemToUser @in_CustomerID, 20001, 2000 -- default gear
	exec FN_AddItemToUser @in_CustomerID, 20019, 2000 -- default head
	exec FN_AddItemToUser @in_CustomerID, 20047, 2000 -- default helmet
	exec FN_AddItemToUser @in_CustomerID, 20014, 2000 -- ghillie suit

	-- Add lots of goodies but just for 5 days of playing game. 
	exec FN_AddItemToUser @in_CustomerID, 101193, 5 --	FN SCAR 16
	exec FN_AddItemToUser @in_CustomerID, 101109, 5 --	Bizon
	exec FN_AddItemToUser @in_CustomerID, 101247, 5 --	Blaser 93R
	exec FN_AddItemToUser @in_CustomerID, 101183, 5 --	KT Decider
	exec FN_AddItemToUser @in_CustomerID, 101060, 5 --	PKM
	exec FN_AddItemToUser @in_CustomerID, 101202, 5 --	QLB
	exec FN_AddItemToUser @in_CustomerID, 101107, 5 --	FN P90
	exec FN_AddItemToUser @in_CustomerID, 101180, 5 --	Desert Eagle

	exec FN_AddItemToUser @in_CustomerID, 20022, 5 --	Beret Cover
	exec FN_AddItemToUser @in_CustomerID, 20023, 5 --	Boonie Cover
	exec FN_AddItemToUser @in_CustomerID, 20024, 5 --	M. Style Helmet
	exec FN_AddItemToUser @in_CustomerID, 20025, 5 --	Shadow
	exec FN_AddItemToUser @in_CustomerID, 20035, 5 --	Skull Mask
	exec FN_AddItemToUser @in_CustomerID, 20036, 5 --	Slash Mask
	exec FN_AddItemToUser @in_CustomerID, 20043, 5 --	M9 helmet black
	exec FN_AddItemToUser @in_CustomerID, 20046, 5 --	M9 Helmet Googles
	exec FN_AddItemToUser @in_CustomerID, 20052, 5 --	Maska Helmet
	exec FN_AddItemToUser @in_CustomerID, 20067, 5 --	KStyle NVG

	exec FN_AddItemToUser @in_CustomerID, 20018, 5 --	Sifu Lee
	exec FN_AddItemToUser @in_CustomerID, 20019, 5 --	Joe the Lumberjack
	exec FN_AddItemToUser @in_CustomerID, 20020, 5 --	Mr. East
	exec FN_AddItemToUser @in_CustomerID, 20021, 5 --	Mr. West
	exec FN_AddItemToUser @in_CustomerID, 20004, 5 --	Mr. Clean
	exec FN_AddItemToUser @in_CustomerID, 20005, 5 --	The Stealth Man
	exec FN_AddItemToUser @in_CustomerID, 20064, 5 --	Night Stalker

	exec FN_AddItemToUser @in_CustomerID, 20003, 5 --	Heavy Gear
	exec FN_AddItemToUser @in_CustomerID, 20015, 5 --	Custom Guerilla
	exec FN_AddItemToUser @in_CustomerID, 20016, 5 --	SWAT Heavy
	exec FN_AddItemToUser @in_CustomerID, 20054, 5 --	IBA Sand
	exec FN_AddItemToUser @in_CustomerID, 20056, 5 --	MTV Forest
	exec FN_AddItemToUser @in_CustomerID, 20061, 5 --	Medium Desert
	exec FN_AddItemToUser @in_CustomerID, 20065, 5 --	Night Stalker Vest

	exec FN_AddItemToUser @in_CustomerID, 20007, 5 --	SpecOps
	exec FN_AddItemToUser @in_CustomerID, 20012, 5 --	Guerilla
	exec FN_AddItemToUser @in_CustomerID, 20026, 5 --	PMC Soldier
	exec FN_AddItemToUser @in_CustomerID, 20038, 5 --	PMC Desert
	exec FN_AddItemToUser @in_CustomerID, 20039, 5 --	Prison Break
	exec FN_AddItemToUser @in_CustomerID, 20070, 5 --	Paradise Jack
	exec FN_AddItemToUser @in_CustomerID, 20071, 5 --	Sandstorm

	-- update account status and give 5000GD	
	UPDATE LoginID SET AccountStatus=101,GameDollars=(GameDollars+5000) where CustomerID=@in_CustomerID

	-- pass to unlocking loadout base slot - it'll return correct ResultCode and things
	exec WO_LoadoutUnlock @in_CustomerID, @in_Class
	return
END
