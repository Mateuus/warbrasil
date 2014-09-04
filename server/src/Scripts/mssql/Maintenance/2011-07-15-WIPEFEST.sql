USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_DB_Wipe2011_07_15]    Script Date: 07/15/2011 15:56:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_DB_Wipe2011_07_15]
AS
BEGIN
	SET NOCOUNT ON;

	-- backup DB
	exec DB_BackupDatabase

--
-- step 1 - GP refund for boosts
--
	declare @CustomerID int
	declare @Amount int

	DECLARE t_cursor1 CURSOR FOR 
		select FinancialTransactions.CustomerID, Amount
		from FinancialTransactions 
		join LoginID on FinancialTransactions.CustomerID=LoginID.CustomerID
		join Items_Generic on FinancialTransactions.ItemID=Items_Generic.ItemID
		where DateTime > '2011-05-29' and TransactionType = 2000 and FinancialTransactions.ItemID>301000 order by DateTime asc

	OPEN t_cursor1
	FETCH NEXT FROM t_cursor1 INTO @CustomerID, @Amount
	while @@FETCH_STATUS = 0 
	begin
		update LoginID set GamePoints=GamePoints+@Amount where CustomerID=@CustomerID
		FETCH NEXT FROM t_cursor1 INTO @CustomerID, @Amount
	end
	close t_cursor1
	deallocate t_cursor1

-- 
-- step 2 - SP refund and rewards
--
	declare @HonorPoints int
	
	DECLARE t_cursor2 CURSOR FOR 
		select CustomerID, HonorPoints from LoginID

	OPEN t_cursor2
	FETCH NEXT FROM t_cursor2 INTO @CustomerID, @HonorPoints
	while @@FETCH_STATUS = 0 
	begin
		-- get rank
		declare @Rank int
		select top(1) @Rank=rank from DataRankPoints where @HonorPoints<HonorPoints order by HonorPoints asc

		-- refund SP
		declare @out_FNResult int
		exec WO_BuyItemFN_UnlearnSkills @out_FNResult out, @CustomerID, 1

		-- set sp minus rank 
		declare @SkillPoints int
		select @SkillPoints=SkillPoints from LoginID where CustomerID=@CustomerID
		set @SkillPoints = @SkillPoints - @Rank
		if(@SkillPoints < 0) set @SkillPoints = 0
		update LoginID set SkillPoints=@SkillPoints where CustomerID=@CustomerID

		-- rewards
		if(@Rank<10) begin
			update LoginID set GameDollars=GameDollars+10000 where CustomerID=@CustomerID
			exec FN_AddItemToUser @CustomerID, 301001, 7
			exec FN_AddItemToUser @CustomerID, 301003, 7
		end
		if(@Rank>=10 and @Rank<=25) begin
			update LoginID set GameDollars=GameDollars+25000 where CustomerID=@CustomerID
			exec FN_AddItemToUser @CustomerID, 301001, 10
			exec FN_AddItemToUser @CustomerID, 301003, 10
		end
		if(@Rank>=26 and @Rank<=34) begin
			update LoginID set GamePoints=GamePoints+5000 where CustomerID=@CustomerID
			exec FN_AddItemToUser @CustomerID, 301001, 30
			exec FN_AddItemToUser @CustomerID, 301003, 30
		end
		if(@Rank>=35) begin
			update LoginID set GamePoints=GamePoints+10000 where CustomerID=@CustomerID
			exec FN_AddItemToUser @CustomerID, 301001, 30
			exec FN_AddItemToUser @CustomerID, 301003, 30
		end

		FETCH NEXT FROM t_cursor2 INTO @CustomerID, @HonorPoints
	end
	close t_cursor2
	deallocate t_cursor2
	
--
-- step 3 - reset!
--
	update LoginID set 
		HonorPoints=0,
		GameDollars=0,
		Faction1Score=0,
		Faction2Score=0,
		Faction3Score=0,
		Faction4Score=0,
		Faction5Score=0
	
	update Stats set
		Kills=0,
		Deaths=0,
		ShotsFired=0,
		ShotsHits=0,
		Headshots=0,
		AssistKills=0,
		Wins=0,
		Losses=0,
		CaptureNeutralPoints=0,
		CaptureEnemyPoints=0,
		TimePlayed=0,
		CheatAttempts=0
	
--
-- step 4 - profit
--
	
END
