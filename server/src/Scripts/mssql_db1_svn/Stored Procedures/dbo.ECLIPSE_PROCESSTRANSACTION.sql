
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ECLIPSE_PROCESSTRANSACTION] 
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

	INSERT INTO FinancialTransactions VALUES (
		@tr_userid, 
		@tr_transid, 
		1000, 
		GETDATE(), 
		@tr_amount, 
		@tr_result, 
		@tr_status, 
		@tr_itemid)
	
	if(@tr_itemid = 'PACK_COLLECTOR_EDITION') -- 
	begin
		declare @out_FNResult int
		
		-- 30days all weapon rent
		exec WO_BuyItemFN_RentWeapons @out_FNResult out, @tr_userid, 30, 0
		
		-- 30days premium acc
		--exec FN_AddPremiumAccToUser @tr_userid, 30
		
		--20k GC
		exec FN_AlterUserGP @tr_userid, 20000, 'PACK_COLLECTOR_EDITION'
		
		-- permanent QBZ 95
		exec FN_AddItemToUser @tr_userid, 101081, 2000

		return
	end
	
	declare @AddedGP int = 0

	     if (@tr_itemid = 'GPX4') set @AddedGP = 3680 --+ 552
	else if (@tr_itemid = 'GPX10') set @AddedGP = 7370 --+ 1449
	else if (@tr_itemid = 'GPX20') set @AddedGP = 18220 --+ 4232
	else if (@tr_itemid = 'GPX25') set @AddedGP = 21880 --+ 6906
	else if (@tr_itemid = 'GPX50') set @AddedGP = 44080 --+ 27126
	else if (@tr_itemid = 'GP1500') set @AddedGP = 1500
	else if (@tr_itemid = 'GP2500') set @AddedGP = 2500
	else if (@tr_itemid = 'GP4000') set @AddedGP = 4000
	else if (@tr_itemid = 'GP5000') set @AddedGP = 5000
	else if (@tr_itemid = 'GP10K') set @AddedGP = 10000
	else if (@tr_itemid = 'G1C_GPX4') set @AddedGP = 4000
	else if (@tr_itemid = 'G1C_GPX10') set @AddedGP = 10000
	else if (@tr_itemid = 'G1C_GPX20') set @AddedGP = 20000
	else if (@tr_itemid = 'G1C_GPX30') set @AddedGP = 30000
	else if (@tr_itemid = 'G1C_GPX50') set @AddedGP = 50000
	else begin
		EXEC FN_ADD_SECURITY_LOG 300, '', @tr_userid, @tr_itemid
		return
	end

	exec FN_AlterUserGP @tr_userid, @AddedGP, 'ECLIPSE_PROCESSTRANSACTION'

END















GO
