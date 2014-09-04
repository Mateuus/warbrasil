USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[FN_GiveReferrerReward]    Script Date: 02/01/2012 16:51:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[FN_GiveReferrerReward] 
	@in_CustomerID int,	-- receiver of bonuses
	@in_InvitedID int	-- CustomerID of user who leveled up
AS
BEGIN
	SET NOCOUNT ON;
	
	-- ignore steam
	if(@in_CustomerID = 24388)
		return
	
	-- ignore special referrer users
	declare @AccountName nvarchar(128)
	select @AccountName=AccountName from LoginID where CustomerID=@in_CustomerID
	if(@AccountName like 'REFERID_%')
		return

	declare @out_FNResult int
	
	-- calculate total number of referrers >= lvl10
	declare @XP10 int
	declare @NumReferrals int
	select @XP10=HonorPoints from DataRankPoints where Rank=9
	select @NumReferrals = COUNT(*) from LoginID where ReferralID=@in_CustomerID and HonorPoints>=@XP10
	
	-- update number of referrers and remember old value. NOTE: must be SINGLE operation
	declare @CurRef int
	update AccountInfo set @CurRef=NumReferrals, NumReferrals=@NumReferrals where CustomerID = 1000

	-- make a loop for each added referrer
	set @CurRef = @CurRef + 1
	WHILE(@CurRef <= @NumReferrals)
	BEGIN
	
		insert into DBG_ReferredEvents
			(CustomerID, InvitedID, LevelUpTime, NumReferrers)
			values
			(@in_CustomerID, @in_InvitedID, GETDATE(), @CurRef)
	
		-- each successful referral we should give them 250 GC. 
		update LoginID set GamePoints=GamePoints+250 where CustomerID=@in_CustomerID

		-- 1	500 GC
		if(@CurRef = 1) begin
			update LoginID set GamePoints=GamePoints+500 where CustomerID=@in_CustomerID
		end

		--  5	?????? 30 day rental of any weapon
		--if(@CurRef = 5) begin
		--end

		-- 10	5,000 Gold Credits 
		if(@CurRef = 10) begin
			update LoginID set GamePoints=GamePoints+5000 where CustomerID=@in_CustomerID
		end

		-- 25	?????? Special "Recruiter" title on forums
		--if(@CurRef = 25) begin
		--end

		-- 50	Collectors Pack
		if(@CurRef = 50) begin
			-- 30days all weapon rent
			exec WO_BuyItemFN_RentWeapons @out_FNResult out, @in_CustomerID, 30, 0
			-- 30days premium acc
			exec FN_AddPremiumAccToUser @in_CustomerID, 30
			-- 20k GC
			update LoginID SET GamePoints=(GamePoints+20000) WHERE CustomerID=@in_CustomerID
			-- permanent QBZ 95
			exec FN_AddItemToUser @in_CustomerID, 101081, 2000
		end

		-- 100	50,000 Gold Credits
		if(@CurRef = 100) begin
			update LoginID set GamePoints=GamePoints+50000 where CustomerID=@in_CustomerID
		end

		-- 1000	permanent unlock of all items in a store
		if(@CurRef = 1000) begin
			exec WO_BuyItemFN_RentGears @out_FNResult out, @in_CustomerID, 2000, 0
			exec WO_BuyItemFN_RentWeapons @out_FNResult out, @in_CustomerID, 2000, 0
		end

		set @CurRef = @CurRef + 1
	END

END
