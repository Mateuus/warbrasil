USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[ECLIPSE_PROCESSTRANSACTION]    Script Date: 03/22/2012 12:22:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ECLIPSE_PROCESSTRANSACTION] 
	@tr_transid varchar(64) = '0000', 
	@tr_userid int = 0, 
	@tr_date varchar(64) = '12/1/1973', 
	@tr_amount float = 0, 
	@tr_result varchar(64) = '0000', 
	@tr_status varchar(64) = '0000', 
	@tr_itemid varchar(64) = '0000', 
	@pkey varchar(32) = 'wrong app key'
AS
BEGIN
	SET NOCOUNT ON;

	if(@pkey != 'SJFei937cjsjf029sdkWccYY9') begin
		return;
	end

	if(@tr_status != 'APPROVED') begin
		print 'transaction not approved\n'
		EXEC FN_ADD_SECURITY_LOG 301, '', @tr_userid, @tr_status
		return
	end

	-- special case for wrong paypal date
	if(@tr_result = 'PAYPAL')
		set @tr_date = GETDATE()

	INSERT INTO FinancialTransactions VALUES (
		@tr_userid, 
		@tr_transid, 
		1000, 
		@tr_date, 
		@tr_amount, 
		@tr_result, 
		@tr_status, 
		@tr_itemid)
		
-- was WARLORD1
	if(@tr_itemid = 'PACK_2WARLORD2') begin
		-- - 2X XP and GD boosts for 60 days
		exec FN_AddItemToUser @tr_userid, 301001, 60
		exec FN_AddItemToUser @tr_userid, 301003, 60

		update LoginID SET GameDollars=(GameDollars+50000) WHERE CustomerID=@tr_userid
		update LoginID SET GamePoints=(GamePoints+10000) WHERE CustomerID=@tr_userid
		update LoginID SET SkillPoints=(SkillPoints+4) WHERE CustomerID=@tr_userid
		
		-- add all abilities (301061-301072)
		declare @abilityItem int = 301061
		while(@abilityItem <= 301072) begin
			exec FN_AddItemToUser @tr_userid, @abilityItem, 2000
			set @abilityItem=@abilityItem+1
		end
		
		-- add 3 additional loadout slots: 
		-- can't be used anymore! exec FN_AddLoadoutSlotsToUser @tr_userid, 3

		return
	end

	if(@tr_itemid = 'PACK_RETAIL1') -- HARDBOILED
	begin
		-- - 2X XP and GD boosts for 60 days
		exec FN_AddItemToUser @tr_userid, 301001, 60
		exec FN_AddItemToUser @tr_userid, 301003, 60

		update LoginID SET GameDollars=(GameDollars+25000) WHERE CustomerID=@tr_userid

		-- add 3 additional loadout slots: 
		-- can't be used anymore! exec FN_AddLoadoutSlotsToUser @tr_userid, 3
		
		exec FN_AddItemToUser @tr_userid, 101037, 2000	-- - Permanent FAMAS Assault Rifle
		exec FN_AddItemToUser @tr_userid, 20069, 2000	-- - Veteran Beret

		return
	end

	if(@tr_itemid = 'PACK_RETAIL2') -- SNAKE EATER
	begin
		-- - 2X XP and GD boosts for 60 days
		exec FN_AddItemToUser @tr_userid, 301001, 60
		exec FN_AddItemToUser @tr_userid, 301003, 60

		update LoginID SET GameDollars=(GameDollars+50000) WHERE CustomerID=@tr_userid
		update LoginID SET SkillPoints=(SkillPoints+3) WHERE CustomerID=@tr_userid

		-- add 3 additional loadout slots: 
		-- can't be used anymore! exec FN_AddLoadoutSlotsToUser @tr_userid, 3
		
		exec FN_AddItemToUser @tr_userid, 101040, 2000	-- - Permanent HK416 Assault Rifle
		exec FN_AddItemToUser @tr_userid, 20069, 2000	-- - Veteran Beret

		return
	end

	if(@tr_itemid = 'PACK_RETAIL3') -- 
	begin
		-- - 2X XP and GD boosts for 90 days
		exec FN_AddItemToUser @tr_userid, 301001, 90
		exec FN_AddItemToUser @tr_userid, 301003, 90

		update LoginID SET GameDollars=(GameDollars+75000) WHERE CustomerID=@tr_userid
		update LoginID SET GamePoints=(GamePoints+10000) WHERE CustomerID=@tr_userid
		update LoginID SET SkillPoints=(SkillPoints+5) WHERE CustomerID=@tr_userid

		-- add 3 additional loadout slots:
		-- can't be used anymore! exec FN_AddLoadoutSlotsToUser @tr_userid, 6

		exec FN_AddItemToUser @tr_userid, 101171, 2000	-- - Permanent G11 Assault Rifle
		exec FN_AddItemToUser @tr_userid, 101217, 2000	-- - Permanent AW Desert Sniper rifle
		exec FN_AddItemToUser @tr_userid, 20069, 2000	-- - Veteran Beret

		return
	end

	if(@tr_itemid = 'PACK_COLLECTOR_EDITION') -- 
	begin
		declare @out_FNResult int
		
		-- 30days all weapon rent
		exec WO_BuyItemFN_RentWeapons @out_FNResult out, @tr_userid, 30, 0
		
		-- 30days premium acc
		--exec FN_AddPremiumAccToUser @tr_userid, 30
		
		--20k GC
		update LoginID SET GamePoints=(GamePoints+20000) WHERE CustomerID=@tr_userid
		
		-- permanent QBZ 95
		exec FN_AddItemToUser @tr_userid, 101081, 2000

		return
	end
	
	
	declare @GamePoints float
	SELECT @GamePoints=GamePoints FROM LoginID WHERE CustomerID=@tr_userid

	--print 'Adding GP to account...\n'
	--print 'Old Balance is ' + RTRIM(@GamePoints) +'\n'
	if (@tr_itemid = 'GPX4') set @GamePoints = @GamePoints + 3680 --+ 552
	else if (@tr_itemid = 'GPX10') set @GamePoints = @GamePoints + 9660 --+ 1449
	else if (@tr_itemid = 'GPX20') set @GamePoints = @GamePoints + 21160 --+ 4232
	else if (@tr_itemid = 'GPX25') set @GamePoints = @GamePoints + 27625 --+ 6906
	else if (@tr_itemid = 'GPX50') set @GamePoints = @GamePoints + 54252 --+ 27126
	else if (@tr_itemid = 'GP1500') set @GamePoints = @GamePoints + 1500
	else if (@tr_itemid = 'GP2500') set @GamePoints = @GamePoints + 2500
	else if (@tr_itemid = 'GP4000') set @GamePoints = @GamePoints + 4000
	else if (@tr_itemid = 'GP5000') set @GamePoints = @GamePoints + 5000
	else if (@tr_itemid = 'GP10K') set @GamePoints = @GamePoints + 10000
	else begin
		EXEC FN_ADD_SECURITY_LOG 300, '', @tr_userid, @tr_itemid
		return
	end

	UPDATE LoginID SET GamePoints=@GamePoints WHERE CustomerID=@tr_userid
	--print 'New Balance is ' + RTRIM(@GamePoints) +'\n'

END
