SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_DB_GenerateLeaderboard]
AS  
BEGIN  
	SET NOCOUNT ON;  
	
	-- reset table with zero seed
	delete from Leaderboard
	DBCC CHECKIDENT (Leaderboard, RESEED, 0)
	
	-- insert all ordered by honorpoints
	insert into Leaderboard (
			CustomerID, gamertag, HonorPoints,
			Kills, Deaths, Wins, Losses ,ShotsFired, ShotsHit, 
			TimePlayed,
			Rank,
			HavePremium)
		select
			LoginID.CustomerID, gamertag, HonorPoints,
			Stats.Kills, Stats.Deaths, Stats.Wins, Stats.Losses, Stats.ShotsFired, Stats.ShotsHits, 
			Stats.TimePlayed,
			-- get rank from table
			(select top(1) rank from DataRankPoints where LoginID.HonorPoints<DataRankPoints.HonorPoints order by HonorPoints asc),
			-- check if have premium
			(case when exists (select * from Inventory where ItemID=301004 and Inventory.CustomerID=LoginID.CustomerID and LeasedUntil>GETDATE()) 
				then 1
				else 0
			end)
		from LoginID
		join Stats on Stats.CustomerID=LoginID.CustomerID
		where AccountStatus=101
		order by LoginID.HonorPoints desc

END
GO
