USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_WELCOMEPACKAGE3]    Script Date: 11/29/2011 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







ALTER PROCEDURE [dbo].[WO_WELCOMEPACKAGE3] 
       @in_IP varchar(100),
       @in_CustomerID int,
       @selected_primaryID int = 0,
       @selected_secondaryID int = 0,
       @selected_headgearID int = 0,
       @selected_bodyID int = 0,
       @selected_bodygearID int = 0,
       @skillID int = 0,
       @selected_abilityID int = 0
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

       -- ability, by index
       declare @abilityID int = 0
       if(@selected_abilityID=1)        set @abilityID = 301071 -- Bulk Up
       else if(@selected_abilityID=2)        set @abilityID = 301072        -- Ninja Killer
       else if(@selected_abilityID=3)        set @abilityID = 301063        -- Guardian Angel
       else if(@selected_abilityID=4)        set @abilityID = 301061 -- Double Up
       else if(@selected_abilityID=5)        set @abilityID = 301064        -- Sniffer
       else
       begin
               declare @smsg3 varchar(1000) = 'bad ability: ' + LTRIM(STR(@selected_abilityID))
               EXEC FN_ADD_SECURITY_LOG 160, @in_IP, @in_CustomerID, @smsg3
               select 6 as ResultCode, 'bad abilityID' as ResultMsg
               return
       end

       declare @skills char(10) = '0000000000'
       if(@skillID=1)                set @skills='1000000000'
       else if(@skillID=2)        set @skills='0100000000'
       else if(@skillID=3)        set @skills='0010000000'
       else if(@skillID=4)        set @skills='0001000000'
       else if(@skillID=5)        set @skills='0000100000'
       else if(@skillID=6)        set @skills='0000010000'
       else if(@skillID=7)        set @skills='0000001000'
       else if(@skillID=8)        set @skills='0000000100'
       else
       begin
               declare @smsg2 varchar(1000) = 'bad skillid: ' + LTRIM(STR(@skillID))
               EXEC FN_ADD_SECURITY_LOG 160, @in_IP, @in_CustomerID, @smsg2
               select 6 as ResultCode, 'bad skillID' as ResultMsg
               return
       end
               
       -- add ability as item
       exec FN_AddItemToUser @in_CustomerID, @abilityID, 2000

       -- update skills
       UPDATE ProfileData SET Skills=@skills where CustomerID=@in_CustomerID



       -- actually add things to inventory - those are your permanent items
       exec FN_AddItemToUser @in_CustomerID, 101004, 2000 -- FN 57        35
       exec FN_AddItemToUser @in_CustomerID, 101008, 2000 -- M26 grenade
       exec FN_AddItemToUser @in_CustomerID, 101149, 2000 -- Green smoke grenade
       exec FN_AddItemToUser @in_CustomerID, 101032, 2000 -- Kalashnikov AKM        20

       exec FN_AddItemToUser @in_CustomerID, 20000, 2000 -- default body
       exec FN_AddItemToUser @in_CustomerID, 20001, 2000 -- default gear
       exec FN_AddItemToUser @in_CustomerID, 20019, 2000 -- default head
       exec FN_AddItemToUser @in_CustomerID, 20047, 2000 -- default helmet


       -- those are items to allow you to play different roles before deciding what you like more
       exec FN_AddItemToUser @in_CustomerID, 101068, 30 --        SVD 
       exec FN_AddItemToUser @in_CustomerID, 101158, 30 --        B. 1201
       exec FN_AddItemToUser @in_CustomerID, 101095, 30 --        M249         25

       exec FN_AddItemToUser @in_CustomerID, 101104, 30 --        MP5K         24

       exec FN_AddItemToUser @in_CustomerID, 20014, 30 -- ghillie suit

       -- Add lots of goodies but just for 5 days of playing game. 
exec FN_AddItemToUser @in_CustomerID, 101178, 2 --        Colt M4 Tactical Elite        23
exec FN_AddItemToUser @in_CustomerID, 101022, 5 --        Kalashnikov AK-74M        22
exec FN_AddItemToUser @in_CustomerID, 101025, 5 --        Kalashnikov AK-74M Kobra        22
exec FN_AddItemToUser @in_CustomerID, 101009, 5 --        Kalashnikov AK-103        25
exec FN_AddItemToUser @in_CustomerID, 101054, 3 --        Colt M4 Tactical Holosight        23
exec FN_AddItemToUser @in_CustomerID, 101005, 3 --        G36        25
exec FN_AddItemToUser @in_CustomerID, 101035, 3 --        Kalashnikov AKS-74U        22
exec FN_AddItemToUser @in_CustomerID, 101177, 3 --        G36 CMag        25
exec FN_AddItemToUser @in_CustomerID, 101169, 3 --        AEK 971        24
exec FN_AddItemToUser @in_CustomerID, 101037, 3 --        Famas F1        24

exec FN_AddItemToUser @in_CustomerID, 101084, 2 --        VSS Vintorez 
exec FN_AddItemToUser @in_CustomerID, 101085, 5 --        AW
exec FN_AddItemToUser @in_CustomerID, 101089, 3 --        DSR-1 

exec FN_AddItemToUser @in_CustomerID, 101199, 3 --                SA Type15
exec FN_AddItemToUser @in_CustomerID, 101098, 5 --                Saiga



exec FN_AddItemToUser @in_CustomerID, 101060, 5 --                Kalashnikov PKM        27


exec FN_AddItemToUser @in_CustomerID, 101115, 5        --         HKK USP        35
exec FN_AddItemToUser @in_CustomerID, 101112, 5        --         B93R         30
exec FN_AddItemToUser @in_CustomerID, 101180, 3        --         Desert Eagle        45

exec FN_AddItemToUser @in_CustomerID, 101107, 3 --        FN P90         30
exec FN_AddItemToUser @in_CustomerID, 101109, 3 --        Bizon         35



exec FN_AddItemToUser @in_CustomerID, 20022, 5 --        Beret Cover
exec FN_AddItemToUser @in_CustomerID, 20023, 5 --                Boonie Cover
exec FN_AddItemToUser @in_CustomerID, 20024, 5 --                M. Style Helmet
exec FN_AddItemToUser @in_CustomerID, 20025, 5 --                Shadow
exec FN_AddItemToUser @in_CustomerID, 20035, 5 --                Skull Mask
exec FN_AddItemToUser @in_CustomerID, 20036, 5 --                Slash Mask
exec FN_AddItemToUser @in_CustomerID, 20043, 5 --                M9 helmet black
exec FN_AddItemToUser @in_CustomerID, 20046, 5 --                M9 Helmet Googles
exec FN_AddItemToUser @in_CustomerID, 20052, 5 --                Maska Helmet
exec FN_AddItemToUser @in_CustomerID, 20067, 5 --                KStyle NVG

exec FN_AddItemToUser @in_CustomerID, 20018, 5 --                Sifu Lee
exec FN_AddItemToUser @in_CustomerID, 20019, 5 --                Joe the Lumberjack
exec FN_AddItemToUser @in_CustomerID, 20020, 5 --                Mr. East
exec FN_AddItemToUser @in_CustomerID, 20021, 5 --                Mr. West
exec FN_AddItemToUser @in_CustomerID, 20004, 5 --                Mr. Clean
exec FN_AddItemToUser @in_CustomerID, 20005, 5 --                The Stealth Man
exec FN_AddItemToUser @in_CustomerID, 20064, 5--                Night Stalker

exec FN_AddItemToUser @in_CustomerID, 20003, 5 --                Heavy Gear
exec FN_AddItemToUser @in_CustomerID, 20015, 5 --                Custom Guerilla
exec FN_AddItemToUser @in_CustomerID, 20016, 5 --                SWAT Heavy
exec FN_AddItemToUser @in_CustomerID, 20054, 5 --                IBA Sand
exec FN_AddItemToUser @in_CustomerID, 20056, 5 --                MTV Forest
exec FN_AddItemToUser @in_CustomerID, 20061, 5 --                Medium Desert
exec FN_AddItemToUser @in_CustomerID, 20065, 5 --                Night Stalker Vest

exec FN_AddItemToUser @in_CustomerID, 20007, 7 --        SpecOps
exec FN_AddItemToUser @in_CustomerID, 20011, 5 --        Slickman
exec FN_AddItemToUser @in_CustomerID, 20012, 5 --                Guerilla
exec FN_AddItemToUser @in_CustomerID, 20026, 5 --                PMC Soldier
exec FN_AddItemToUser @in_CustomerID, 20038, 5 --                PMC Desert
exec FN_AddItemToUser @in_CustomerID, 20039, 5 --                Prison Break
exec FN_AddItemToUser @in_CustomerID, 20063, 5 --                Night Stalker
exec FN_AddItemToUser @in_CustomerID, 20070, 5 --                Paradise Jack
exec FN_AddItemToUser @in_CustomerID, 20071, 5 --                Sandstorm



       -- update loadout slot
       declare        @Slot varchar(1000) = '0 0 0 0 0 0 0 0 0 0 0 0 0'
       set @Slot = LTRIM('20054') + ' '
       set @Slot = @Slot + LTRIM('20024') + ' '
       set @Slot = @Slot + LTRIM('20019') + ' '
       set @Slot = @Slot + LTRIM('20026') + ' 0 0 0 101008 '
       set @Slot = @Slot + LTRIM(STR(@abilityID)) + ' 0 '
       set @Slot = @Slot + LTRIM('101005') + ' '
       set @Slot = @Slot + LTRIM('101107') + ' '
       set @Slot = @Slot + LTRIM('101114')
       UPDATE Profile_Loadouts SET Loadout1=@Slot, Loadout2=@Slot, Loadout3=@Slot, Loadout4=@Slot, Loadout5=@Slot, Loadout6=@Slot where CustomerID=@in_CustomerID



       -- update account status and give 5000GD        
       declare @money int
       set @money = (SELECT GameDollars from LoginID where CustomerID=@in_CustomerID)
       set @money = @money+5000
       UPDATE LoginID SET AccountStatus=101,GameDollars=@money where CustomerID=@in_CustomerID

       select 0 as ResultCode
       return
END
