USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_DB_GenerateLeaderboard30]    Script Date: 03/16/2012 16:49:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_DB_GenerateLeaderboard30]
AS  
BEGIN  
	SET NOCOUNT ON;  

	/*
	The Query Processor estimates that implementing the following index could improve the query cost by 13.035%.
	NOTE: using index IX_DBG_UserRoundResults_LBIdx1 on DBG_UserRoundResults
	*/
	
	-- assemble start date of this month
	declare @StartDay date = '2000-01-01'
	set @StartDay = DATEADD(year, YEAR(GETDATE()) - 2000, @StartDay)
	set @StartDay = DATEADD(month, MONTH(GETDATE()) - 1, @StartDay)

	-- reset table with zero seed
	delete from Leaderboard30
	DBCC CHECKIDENT (Leaderboard30, RESEED, 0)
	
	-- insert all ordered by honorpoints
	insert into Leaderboard30 (
			CustomerID, gamertag, HonorPoints,
			Kills, Deaths, Wins, Losses, ShotsFired, ShotsHit, 
			TimePlayed,
			Rank,
			HavePremium)
		select
			urr.CustomerID,
			l.Gamertag,
			sum(urr.HonorPoints),
			sum(Kills), sum(Deaths), sum(Wins), sum(Losses), sum(ShotsFired), sum(ShotsHits),
			sum(TimePlayed),
			-- not need rank now
			0, --(select top(1) rank from DataRankPoints where LoginID.HonorPoints<DataRankPoints.HonorPoints order by HonorPoints asc),
			-- check if have premium
			(case when exists (select * from Inventory where ItemID=301004 and Inventory.CustomerID=urr.CustomerID and LeasedUntil>GETDATE()) 
				then 1
				else 0
			end)
		from DBG_UserRoundResults urr
		join LoginID l on (l.CustomerID=urr.CustomerID)
		where GameReportTime>=@StartDay and l.AccountStatus=101
		group by urr.CustomerID, l.Gamertag
		order by sum(urr.HonorPoints) desc
END
