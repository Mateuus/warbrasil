USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[ECLIPSE_UseCouponPAX2011]    Script Date: 03/22/2012 12:26:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ECLIPSE_UseCouponPAX2011]
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
	
	if(@ExecCode = 0) 
	begin
		exec FN_AddItemToUser @in_CustomerID, 20071, 2000
		exec FN_AddItemToUser @in_CustomerID, 20058, 2000
		exec FN_AddItemToUser @in_CustomerID, 20046, 2000
		exec FN_AddItemToUser @in_CustomerID, 101219, 2000
		exec FN_AddItemToUser @in_CustomerID, 101090, 2000
		exec FN_AddItemToUser @in_CustomerID, 101189, 2000
		exec FN_AddItemToUser @in_CustomerID, 101214, 2000
		exec FN_AddItemToUser @in_CustomerID, 101103, 2000
		exec FN_AddItemToUser @in_CustomerID, 101206, 2000
		exec FN_AddItemToUser @in_CustomerID, 101114, 2000
		select 'Your PAX 2011 Blue team coupon code is activated' as ResultMsg
		return;
	end 
	
	if(@ExecCode = 1)
	begin
		exec FN_AddItemToUser @in_CustomerID, 20012, 2000
		exec FN_AddItemToUser @in_CustomerID, 20002, 2000
		exec FN_AddItemToUser @in_CustomerID, 20049, 2000
 		exec FN_AddItemToUser @in_CustomerID, 101191, 2000
		exec FN_AddItemToUser @in_CustomerID, 101085, 2000
		exec FN_AddItemToUser @in_CustomerID, 101130, 2000
		exec FN_AddItemToUser @in_CustomerID, 101060, 2000
		exec FN_AddItemToUser @in_CustomerID, 101108, 2000
		exec FN_AddItemToUser @in_CustomerID, 101099, 2000
		exec FN_AddItemToUser @in_CustomerID, 101111, 2000
		select 'Your PAX 2011 Red team coupon code is activated' as ResultMsg
		return;
	end

	if(@ExecCode = 2)
	begin
		update LoginID set GamePoints=GamePoints+10000 where CustomerID=@in_CustomerID
		select 'Your 10000GP coupon is activated' as ResultMsg
		return;
	end

	if(@ExecCode = 3)
	begin
		update LoginID set GamePoints=GamePoints+5000 where CustomerID=@in_CustomerID
		select 'Your 5000GP coupon is activated' as ResultMsg
		return;
	end
	
	if(@ExecCode = 4)
	begin
		exec FN_AddItemToUser @in_CustomerID, 20084, 2000	-- ARMOR_Slickman_Heavy_IGN
		exec FN_AddItemToUser @in_CustomerID, 20031, 2000	-- HGEAR_IGN_Helmet_01
		exec FN_AddItemToUser @in_CustomerID, 101115, 7		-- HK USP
		exec FN_AddItemToUser @in_CustomerID, 101060, 7		-- PKM Kobra
		exec FN_AddItemToUser @in_CustomerID, 101027, 7		-- AK 74M - Red Dot Sight - Gold Edition
		exec FN_AddItemToUser @in_CustomerID, 101089, 7		-- DSR-1
		exec FN_AddItemToUser @in_CustomerID, 301006, 7		-- UAV Camera Drone
		exec FN_AddItemToUser @in_CustomerID, 301003, 7		-- 2xGD Boost
		exec FN_AddItemToUser @in_CustomerID, 301001, 7		-- 2xXP Boost
		select 'Your IGN coupon is activated' as ResultMsg
		return;
	end
	
	if(@ExecCode = 5)
	begin
		update LoginID set GamePoints=GamePoints+50000 where CustomerID=@in_CustomerID
		select 'Your 50000GP coupon is activated' as ResultMsg
		return;
	end
	
	if(@ExecCode = 6)
	begin
		exec FN_AddItemToUser @in_CustomerID, 101170, 2000	-- FN 2000
		exec FN_AddItemToUser @in_CustomerID, 101037, 2000	-- FAMAS
		select 'Your FAMAS/FN 2000 coupon is activated' as ResultMsg
		return;
	end
	
	if(@ExecCode = 7)
	begin
		update LoginID set GamePoints=GamePoints+13000 where CustomerID=@in_CustomerID
		select 'Your 10 euro coupon is activated' as ResultMsg
		return;
	end

	-- Mark Davidson <mark.davidson@microprose.com>
	-- promo cards
	if(@ExecCode = 8) -- 25k codes
	begin
		update LoginID set GamePoints=GamePoints+7500 where CustomerID=@in_CustomerID
		select 'Your 7500GP coupon is activated' as ResultMsg
		return;
	end

	if(@ExecCode = 9) -- 25k codes
	begin
		update LoginID set GamePoints=GamePoints+15000 where CustomerID=@in_CustomerID
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
		update LoginID set GamePoints=GamePoints+7000 where CustomerID=@in_CustomerID
		select 'Your £5 coupon is activated. 7000GP has been added to your account' as ResultMsg
		return;
	end

	if(@ExecCode = 12)
	begin
		update LoginID set GamePoints=GamePoints+15000 where CustomerID=@in_CustomerID
		select 'Your £10 coupon is activated. 15000GP has been added to your account' as ResultMsg
		return;
	end

	if(@ExecCode = 13)
	begin
		update LoginID set GamePoints=GamePoints+10000 where CustomerID=@in_CustomerID
		select 'Your $10 Cash Card is activated. 10000GP has been added to your account' as ResultMsg
		return;
	end

	if(@ExecCode = 14)
	begin
		update LoginID set GamePoints=GamePoints+20000 where CustomerID=@in_CustomerID
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
		update LoginID set GamePoints=GamePoints+7900 where CustomerID=@in_CustomerID
		select 'Your £5 Card is activted. 7900 Gold Credit has been added to your account' as ResultMsg
		return;
	end

	-- 4000 x 17000 Gold Credit (Additional for UK, £10 - w/10% bonus over £5)
	if(@ExecCode = 18)
	begin
		update LoginID set GamePoints=GamePoints+17000 where CustomerID=@in_CustomerID
		select 'Your £10 Card is activted. 17000 Gold Credit has been added to your account' as ResultMsg
		return;
	end

	-- 8000 x 7500 Gold Credit (5€ for Italy and Spain)
	if(@ExecCode = 19)
	begin
		update LoginID set GamePoints=GamePoints+7500 where CustomerID=@in_CustomerID
		select 'Your 5€ Card is activted. 7500 Gold Credit has been added to your account' as ResultMsg
		return;
	end

	-- 8000 x 16500 Gold Credit (10€ for Italy and Spain - w/10% bonus over 5€)
	if(@ExecCode = 20)
	begin
		update LoginID set GamePoints=GamePoints+16500 where CustomerID=@in_CustomerID
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
		update LoginID set GamePoints=GamePoints+10000 where CustomerID=@in_CustomerID
		select 'Your Gamestop/Impulse coupon code is activated' as ResultMsg
		return;
	end

	-- XFire promo, 5k codes
	if(@ExecCode = 26)
	begin
		exec FN_AddItemToUser @in_CustomerID, 101243, 2000	-- ASR_tar21_Xfire
 		exec FN_AddItemToUser @in_CustomerID, 20093, 2000	-- Xfire body
		exec FN_AddItemToUser @in_CustomerID, 20103, 2000	-- Xfire armor
		exec FN_AddItemToUser @in_CustomerID, 20102, 2000	-- HGEAR_XFire_Maska
		select 'Your XFire coupon code is activated' as ResultMsg
		return;
	end

	-- gamesurferonline.com
	if(@ExecCode = 27)
	begin
		exec FN_AddItemToUser @in_CustomerID, 301001, 7	-- 2xXP
		select 'Your gamesurferonline.com coupon code is activated' as ResultMsg
		return;
	end

	-- freemmogame.com 
	if(@ExecCode = 28)
	begin
		exec FN_AddItemToUser @in_CustomerID, 301001, 7	-- 2xXP
		select 'Your freemmogame.com coupon code is activated' as ResultMsg
		return;
	end

	-- Atomicgamer.com 
	if(@ExecCode = 29)
	begin
		exec FN_AddItemToUser @in_CustomerID, 301001, 7	-- 2xXP
		select 'Your atomicgamer.com coupon code is activated' as ResultMsg
		return;
	end

	-- ausgamers.com
	if(@ExecCode = 30)
	begin
		exec FN_AddItemToUser @in_CustomerID, 301001, 7	-- 2xXP
		select 'Your gausgamers.com coupon code is activated' as ResultMsg
		return;
	end

	-- gamefront.com
	if(@ExecCode = 31)
	begin
		exec FN_AddItemToUser @in_CustomerID, 301001, 7	-- 2xXP
		select 'Your gamefront.com coupon code is activated' as ResultMsg
		return;
	end

	-- FB 1
	if(@ExecCode = 32)
	begin
		exec FN_AddItemToUser @in_CustomerID, 20105, 7	-- hero chick
		exec FN_AddItemToUser @in_CustomerID, 101001, 7	-- AN94
		select 'Your facebook promo coupon code is activated' as ResultMsg
		return;
	end

	-- FB 2
	if(@ExecCode = 33)
	begin
		exec FN_AddItemToUser @in_CustomerID, 301003, 7	-- 2xWP
		exec FN_AddItemToUser @in_CustomerID, 101218, 7	-- G36 Elite
		select 'Your facebook promo coupon code is activated' as ResultMsg
		return;
	end

	-- FB 3
	if(@ExecCode = 34)
	begin
		exec FN_AddItemToUser @in_CustomerID, 20104, 7	-- hero chick
		exec FN_AddItemToUser @in_CustomerID, 101060, 7	-- AK PKM
		select 'Your facebook promo coupon code is activated' as ResultMsg
		return;
	end

	-- FB 4
	if(@ExecCode = 35)
	begin
		exec FN_AddItemToUser @in_CustomerID, 101227, 7	-- bizon elite
		exec FN_AddItemToUser @in_CustomerID, 101173, 7	-- IMI Tavor TAR-21
		select 'Your facebook promo coupon code is activated' as ResultMsg
		return;
	end
	
	-- gameogre.com
	if(@ExecCode = 36)
	begin
		exec FN_AddItemToUser @in_CustomerID, 301001, 7	-- 2xXP
		select 'Your gameogre.com coupon code is activated' as ResultMsg
		return;
	end
	
	-- challenge FN F2000 Kills
	if(@ExecCode = 37)
	begin
 		exec FN_AddItemToUser @in_CustomerID, 101209, 3	-- XM8 Elite
		exec FN_AddItemToUser @in_CustomerID, 20104, 3	-- War Goddess Hero
		select 'Your FN F2000 kills challenge coupon code is activated' as ResultMsg
		return;
	end

	-- challenge PKM KOBRA Kills
	if(@ExecCode = 38)
	begin
 		exec FN_AddItemToUser @in_CustomerID, 101198, 7	-- LSAT
		exec FN_AddItemToUser @in_CustomerID, 20017, 7	-- Slickman gear
		select 'Your PKM KOBRA kills challenge coupon code is activated' as ResultMsg
		return;
	end
	
	-- FB 5
	if(@ExecCode = 39)
	begin
		exec FN_AddItemToUser @in_CustomerID, 20106, 7	
		exec FN_AddItemToUser @in_CustomerID, 101084, 7	
		select 'Your facebook promo coupon code is activated' as ResultMsg
		return;
	end

	-- FB 6
	if(@ExecCode = 40)
	begin
		exec FN_AddItemToUser @in_CustomerID, 20075, 7
		exec FN_AddItemToUser @in_CustomerID, 101202, 7
		select 'Your facebook promo coupon code is activated' as ResultMsg
		return;
	end

	-- FB 7
	if(@ExecCode = 41)
	begin
		exec FN_AddItemToUser @in_CustomerID, 20107, 7
		exec FN_AddItemToUser @in_CustomerID, 101218, 7
		select 'Your facebook promo coupon code is activated' as ResultMsg
		return;
	end

	-- FB 8
	if(@ExecCode = 42)
	begin
		exec FN_AddItemToUser @in_CustomerID, 20078, 7
		exec FN_AddItemToUser @in_CustomerID, 101061, 7
		select 'Your facebook promo coupon code is activated' as ResultMsg
		return;
	end
	
	-- freetoplay.org
	if(@ExecCode = 43)
	begin
		exec FN_AddItemToUser @in_CustomerID, 101077, 7
		exec FN_AddItemToUser @in_CustomerID, 101227, 7
		select 'Your freetoplay.org promo coupon code is activated' as ResultMsg
		return;
	end

	-- mmoattack.com
	if(@ExecCode = 44)
	begin
		exec FN_AddItemToUser @in_CustomerID, 101218, 7
		exec FN_AddItemToUser @in_CustomerID, 20105, 7
		select 'Your mmoattack.com promo coupon code is activated' as ResultMsg
		return;
	end
	
	select 'Invalid Coupon ID - please contact support@thewarinc.com' as ResultMsg

END
