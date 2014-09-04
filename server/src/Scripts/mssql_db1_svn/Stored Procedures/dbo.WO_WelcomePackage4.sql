
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_WelcomePackage4] 
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
	exec FN_AddItemToUser @in_CustomerID, 101008, 2000 -- M26 grenade
	exec FN_AddItemToUser @in_CustomerID, 101149, 2000 -- Green smoke grenade
	
	-- Add lots of goodies but just for 5 days of playing game. 
	exec FN_AddItemToUser @in_CustomerID, 101085, 3 --	Mauser SRG
	exec FN_AddItemToUser @in_CustomerID, 101095, 3 --	FN M249 MkII	23
	exec FN_AddItemToUser @in_CustomerID, 101183, 3 --	KT Decider
	exec FN_AddItemToUser @in_CustomerID, 101196, 3	-- 	Jericho
	exec FN_AddItemToUser @in_CustomerID, 101107, 3 --	FN P90 	30	
	exec FN_AddItemToUser @in_CustomerID, 101193, 3 --	FN SCAR 16
	exec FN_AddItemToUser @in_CustomerID, 101158, 3 -- Mossberg 590
	
	exec FN_AddItemToUser @in_CustomerID, 301124, 2000
	exec FN_AddItemToUser @in_CustomerID, 301124, 2000
	exec FN_AddItemToUser @in_CustomerID, 301124, 2000
	exec FN_AddItemToUser @in_CustomerID, 301124, 2000
	exec FN_AddItemToUser @in_CustomerID, 301124, 2000
	
	

	exec FN_AddItemToUser @in_CustomerID, 20022, 3 --	Beret Cover
	exec FN_AddItemToUser @in_CustomerID, 20023, 3 --	Boonie Cover
	exec FN_AddItemToUser @in_CustomerID, 20024, 3 --	M. Style Helmet
	exec FN_AddItemToUser @in_CustomerID, 20025, 3 --	Shadow
	exec FN_AddItemToUser @in_CustomerID, 20035, 3 --	Skull Mask
	exec FN_AddItemToUser @in_CustomerID, 20036, 3 --	Slash Mask
	exec FN_AddItemToUser @in_CustomerID, 20043, 3 --	M9 helmet black
	exec FN_AddItemToUser @in_CustomerID, 20046, 3 --	M9 Helmet Googles
	exec FN_AddItemToUser @in_CustomerID, 20052, 3 --	Maska Helmet
	exec FN_AddItemToUser @in_CustomerID, 20067, 3 --	KStyle NVG

	exec FN_AddItemToUser @in_CustomerID, 20018, 3 --	Sifu Lee
	exec FN_AddItemToUser @in_CustomerID, 20019, 3 --	Joe the Lumberjack
	exec FN_AddItemToUser @in_CustomerID, 20020, 3 --	Mr. East
	exec FN_AddItemToUser @in_CustomerID, 20021, 3 --	Mr. West
	exec FN_AddItemToUser @in_CustomerID, 20004, 3 --	Mr. Clean
	exec FN_AddItemToUser @in_CustomerID, 20005, 3 --	The Stealth Man
	exec FN_AddItemToUser @in_CustomerID, 20064, 3 --	Night Stalker

	exec FN_AddItemToUser @in_CustomerID, 20003, 2 --	Heavy Gear
	exec FN_AddItemToUser @in_CustomerID, 20015, 2 --	Custom Guerilla
	exec FN_AddItemToUser @in_CustomerID, 20016, 2 --	SWAT Heavy
	exec FN_AddItemToUser @in_CustomerID, 20054, 2 --	IBA Sand
	exec FN_AddItemToUser @in_CustomerID, 20056, 2 --	MTV Forest
	exec FN_AddItemToUser @in_CustomerID, 20061, 2 --	Medium Desert
	exec FN_AddItemToUser @in_CustomerID, 20065, 2 --	Night Stalker Vest

	exec FN_AddItemToUser @in_CustomerID, 20007, 2 --	SpecOps
	exec FN_AddItemToUser @in_CustomerID, 20012, 2 --	Guerilla
	exec FN_AddItemToUser @in_CustomerID, 20026, 2 --	PMC Soldier
	exec FN_AddItemToUser @in_CustomerID, 20038, 2 --	PMC Desert
	exec FN_AddItemToUser @in_CustomerID, 20039, 2 --	Prison Break
	exec FN_AddItemToUser @in_CustomerID, 20070, 2 --	Paradise Jack
	exec FN_AddItemToUser @in_CustomerID, 20071, 2 --	Sandstorm


	-- update account status and give 5000GD	
	UPDATE LoginID SET AccountStatus=101,GameDollars=(GameDollars+5000), IsFPSEnabled=1 where CustomerID=@in_CustomerID
	exec FN_AlterUserGP @in_CustomerID, 500, 'WelcomePackage'

	-- pass to unlocking loadout base slot - it'll return correct ResultCode and things
	exec WO_LoadoutUnlock @in_CustomerID, @in_Class
	return
END
GO
