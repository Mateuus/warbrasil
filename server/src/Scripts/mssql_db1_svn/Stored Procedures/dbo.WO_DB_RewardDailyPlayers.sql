
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[WO_DB_RewardDailyPlayers]
AS  
BEGIN  
	SET NOCOUNT ON;  
	
	
	--
	-- disabled per Sergey request
	--
	return
	
	-- get current day and make 1 day range
	declare @dt1 date = GETDATE()
	declare @dt2 date = DATEADD(d, 1, GETDATE())

	-- Kill 10 Enemies - 250WP
	update LoginID set GameDollars=GameDollars+250
	where CustomerID in (select d.CustomerID from DBG_UserRoundResults d
		where (GameReportTime >= @dt1 and GameReportTime < @dt2)
		group by CustomerID
		having SUM(Kills)>=10
		)
	
	-- Play 5 Matches	500
	update LoginID set GameDollars=GameDollars+500
	where CustomerID in (select d.CustomerID from DBG_UserRoundResults d
		where (GameReportTime >= @dt1 and GameReportTime < @dt2)
		group by CustomerID
		having count(*)>=5
		)
    
	-- Play 2 Conquest Matches	1000
	update LoginID set GameDollars=GameDollars+1000
	where CustomerID in (select d.CustomerID from DBG_UserRoundResults d
		where (GameReportTime >= @dt1 and GameReportTime < @dt2)
		and (MapType=0)
		group by CustomerID
		having count(*)>=2
		)
    
	-- Play 2 Deathmatch Matches	1200
	update LoginID set GameDollars=GameDollars+1200
	where CustomerID in (select d.CustomerID from DBG_UserRoundResults d
		where (GameReportTime >= @dt1 and GameReportTime < @dt2)
		and (MapType=1)
		group by CustomerID
		having count(*)>=2
		)
    
	-- Play 2 Sabotage Matches	1200	
	update LoginID set GameDollars=GameDollars+1200
	where CustomerID in (select d.CustomerID from DBG_UserRoundResults d
		where (GameReportTime >= @dt1 and GameReportTime < @dt2)
		and (MapType=3)
		group by CustomerID
		having count(*)>=2
		)

END

GO
