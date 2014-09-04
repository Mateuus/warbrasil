SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_DB_GenerateLeaderboard7]
AS  
BEGIN  
	SET NOCOUNT ON;  

	/*
	The Query Processor estimates that implementing the following index could improve the query cost by 13.035%.
	NOTE: using index IX_DBG_UserRoundResults_LBIdx1 on DBG_UserRoundResults
	*/
	
	-- assemble start date of this week
	declare @StartDay date = GETDATE()
	set @StartDay = DATEADD(day, -(DATEPART(weekday, @StartDay) - 1), @StartDay)

	-- reset table with zero seed
	delete from Leaderboard7
	DBCC CHECKIDENT (Leaderboard7, RESEED, 0)
	
	-- insert all ordered by honorpoints
	insert into Leaderboard7 (
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
GO
