
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ECLIPSE_UseCouponPAX2011]
	@in_CustomerID int, 
	@in_CouponCode varchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	
	declare @IsUsed int
	declare @ExecCode int
	declare @MultiUse int
	select @IsUsed=IsUsed, @ExecCode=Team, @MultiUse=MultiUse from Coupons2 where CouponCode=@in_CouponCode
	if(@@RowCount = 0) begin
		select 'Invalid coupon code' as ResultMsg
		return
	end

	if(@MultiUse > 0)
	begin
		-- multi use coupon
		if exists (select * from Coupons2CustomerMap where CustomerID=@in_CustomerID and CouponID=@ExecCode) begin
			select 'You have already used this coupon' as ResultMsg
			return
		end

		insert into Coupons2CustomerMap 
			(CouponID, CustomerID, UseTime) 
			values 
			(@ExecCode, @in_CustomerID, GETDATE())
	end
	else
	begin
		-- single use coupon
		if(@IsUsed > 0) begin
			select 'This coupon code is already used' as ResultMsg
			return
		end
	
		update Coupons2 set IsUsed=1, CustomerID=@in_CustomerID where CouponCode=@in_CouponCode
	end

	
	if(@ExecCode = 7)
	begin
		exec FN_AlterUserGP @in_CustomerID, 13000, 'Coupon 7'
		select 'Your 10 euro coupon is activated' as ResultMsg
		return;
	end

	-- Mark Davidson <mark.davidson@microprose.com>
	-- promo cards
	if(@ExecCode = 8) -- 25k codes
	begin
		exec FN_AlterUserGP @in_CustomerID, 7500, 'Coupon 8'
		select 'Your 7500GP coupon is activated' as ResultMsg
		return;
	end

	if(@ExecCode = 9) -- 25k codes
	begin
		exec FN_AlterUserGP @in_CustomerID, 15000, 'Coupon 9'
		select 'Your 15000GP coupon is activated' as ResultMsg
		return;
	end

	if(@ExecCode = 10) -- 100k codes
	begin
		update LoginID set GameDollars=GameDollars+5000 where CustomerID=@in_CustomerID
		select 'Your 5000 Game Dollars coupon is activated' as ResultMsg
		return;
	end

	if(@ExecCode = 11)
	begin
		exec FN_AlterUserGP @in_CustomerID, 7000, 'Coupon 11'
		select 'Your £5 coupon is activated. 7000GP has been added to your account' as ResultMsg
		return;
	end

	if(@ExecCode = 12)
	begin
		exec FN_AlterUserGP @in_CustomerID, 15000, 'Coupon 12'
		select 'Your £10 coupon is activated. 15000GP has been added to your account' as ResultMsg
		return;
	end

	if(@ExecCode = 13)
	begin
		exec FN_AlterUserGP @in_CustomerID, 10000, 'Coupon 13'
		select 'Your $10 Cash Card is activated. 10000GP has been added to your account' as ResultMsg
		return;
	end

	if(@ExecCode = 14)
	begin
		exec FN_AlterUserGP @in_CustomerID, 20000, 'Coupon 14'
		select 'Your $20 Cash Card is activated. 20000GP has been added to your account' as ResultMsg
		return;
	end

	if(@ExecCode = 15)
	begin
		update LoginID set GameDollars=GameDollars+25000 where CustomerID=@in_CustomerID
		select 'Your 25,000GD Gift Card is activated' as ResultMsg
		return;
	end

	if(@ExecCode = 16)
	begin
		update LoginID set GameDollars=GameDollars+50000 where CustomerID=@in_CustomerID
		select 'Your 50,000GD Gift Card is activated' as ResultMsg
		return;
	end

	-- 4000 x 7900 Gold Credit (Additional for UK, £5)
	if(@ExecCode = 17)
	begin
		exec FN_AlterUserGP @in_CustomerID, 7900, 'Coupon 17'
		select 'Your £5 Card is activted. 7900 Gold Credit has been added to your account' as ResultMsg
		return;
	end

	-- 4000 x 17000 Gold Credit (Additional for UK, £10 - w/10% bonus over £5)
	if(@ExecCode = 18)
	begin
		exec FN_AlterUserGP @in_CustomerID, 17000, 'Coupon 18'
		select 'Your £10 Card is activted. 17000 Gold Credit has been added to your account' as ResultMsg
		return;
	end

	-- 8000 x 7500 Gold Credit (5€ for Italy and Spain)
	if(@ExecCode = 19)
	begin
		exec FN_AlterUserGP @in_CustomerID, 7500, 'Coupon 19'
		select 'Your 5€ Card is activted. 7500 Gold Credit has been added to your account' as ResultMsg
		return;
	end

	-- 8000 x 16500 Gold Credit (10€ for Italy and Spain - w/10% bonus over 5€)
	if(@ExecCode = 20)
	begin
		exec FN_AlterUserGP @in_CustomerID, 16500, 'Coupon 20'
		select 'Your 10€ Card is activted. 16500 Gold Credit has been added to your account' as ResultMsg
		return;
	end

	-- 45000 x 5000 War Points (Gift)
	if(@ExecCode = 21)
	begin
		update LoginID set GameDollars=GameDollars+5000 where CustomerID=@in_CustomerID
		select 'Your 5000 War Points coupon is activated' as ResultMsg
		return;
	end

	-- outdated sniper/assault/machine gun PAX2011 loadout coupons
	if(@ExecCode = 22 or @ExecCode = 23 or @ExecCode = 24)
	begin
		select 'Sorry, this coupon is outdated.' as ResultMsg
		return;
	end

	-- Gamestop/Impulse promo, 2k codes
	if(@ExecCode = 25)
	begin
		exec FN_AddItemToUser @in_CustomerID, 101241, 2000	-- snp_aw_impulse
		exec FN_AddItemToUser @in_CustomerID, 101242, 2000	-- ASR_tar21_Impulse
 		exec FN_AddItemToUser @in_CustomerID, 20099, 2000	-- BODY_Shadow_Impulse_01
		exec FN_AddItemToUser @in_CustomerID, 20100, 2000	-- Armor_MTV_01_Impulse_01
		exec FN_AddItemToUser @in_CustomerID, 20101, 2000	-- HGEAR_M9_Helmet_Impulse_01
		exec FN_AlterUserGP @in_CustomerID, 10000, 'Coupon 25'
		select 'Your Gamestop/Impulse coupon code is activated' as ResultMsg
		return;
	end


	--  2012-04-02 cybergun 300,000 x $5 GC
	if(@ExecCode = 50)
	begin
		exec FN_AlterUserGP @in_CustomerID, 5000, 'Coupon 50'
		select 'Your $5 coupon is activated. 4000 Gold Credit has been added to your account' as ResultMsg
		return;
	end

	--  2012-04-02 cybergun -  300,000 x $5 GC
	if(@ExecCode = 51)
	begin
		exec FN_AlterUserGP @in_CustomerID, 4000, 'Coupon 51'
		select 'Your $5 coupon is activated. 4000 Gold Credit has been added to your account' as ResultMsg
		return;
	end

	--  2012-04-02 cybergun - 15,000 x 7500GC 
	if(@ExecCode = 52)
	begin
		exec FN_AlterUserGP @in_CustomerID, 7500, 'Coupon 52'
		select 'Your coupon is activated. 7500 Gold Credit has been added to your account' as ResultMsg
		return;
	end

	--  2012-04-02 cybergun - multiuse 10,000 WP
	if(@ExecCode = 53)
	begin
		update LoginID set GameDollars=GameDollars+10000 where CustomerID=@in_CustomerID
		select 'Your coupon is activated. 10,000 WP has been added to your account' as ResultMsg
		return;
	end

	-- Play with Devs coupon code. Will re-enable once they have another promo
	if(@ExecCode = 2001111)
	begin
		exec FN_AddItemToUser @in_CustomerID, 101215, 3
		exec FN_AddItemToUser @in_CustomerID, 101227, 3			
		exec FN_AddItemToUser @in_CustomerID, 101245, 3			
		exec FN_AddItemToUser @in_CustomerID, 101216, 3			
		exec FN_AddItemToUser @in_CustomerID, 101232, 3			
		exec FN_AddItemToUser @in_CustomerID, 101214, 3			
		select 'Play With Devs coupon code is activated' as ResultMsg
		--select 'Play With Devs coupon code is not currently active' as ResultMsg
		return
	end

			
	select 'This coupon is expired. You can contact support at support@thewarinc.com' as ResultMsg

END
GO
