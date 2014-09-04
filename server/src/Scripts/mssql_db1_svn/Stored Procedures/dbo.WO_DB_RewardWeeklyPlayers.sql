
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[WO_DB_RewardWeeklyPlayers]
AS  
BEGIN  
	SET NOCOUNT ON;  

	--
	-- disabled per Sergey request
	--
	return

	-- make week range (>=dt1 && <dt2)
	declare @dt1 date = DATEADD(d, -6, GETDATE())
	declare @dt2 date = DATEADD(d, 1, GETDATE())

	-- Kill 200 Enemies	5000
	update LoginID set GameDollars=GameDollars+5000
	where CustomerID in (select d.CustomerID from DBG_UserRoundResults d
		where (GameReportTime >= @dt1 and GameReportTime < @dt2)
		group by CustomerID
		having SUM(Kills)>=200
		)

	-- 100 Headshots	2500
	update LoginID set GameDollars=GameDollars+2500
	where CustomerID in (select d.CustomerID from DBG_UserRoundResults d
		where (GameReportTime >= @dt1 and GameReportTime < @dt2)
		group by CustomerID
		having SUM(Headshots)>=100
		)
	
	-- Play 50 Matches	5000
	update LoginID set GameDollars=GameDollars+5000
	where CustomerID in (select d.CustomerID from DBG_UserRoundResults d
		where (GameReportTime >= @dt1 and GameReportTime < @dt2)
		group by CustomerID
		having count(*)>=50
		)
    
	-- Play 25 Conquest Matches	5000
	update LoginID set GameDollars=GameDollars+5000
	where CustomerID in (select d.CustomerID from DBG_UserRoundResults d
		where (GameReportTime >= @dt1 and GameReportTime < @dt2)
		and (MapType=0)
		group by CustomerID
		having count(*)>=25
		)
    
	-- Play 25 Deathmatch Matches	5000
	update LoginID set GameDollars=GameDollars+5000
	where CustomerID in (select d.CustomerID from DBG_UserRoundResults d
		where (GameReportTime >= @dt1 and GameReportTime < @dt2)
		and (MapType=1)
		group by CustomerID
		having count(*)>=25
		)
    
	-- Play 25 Sabotage Matches	5000	
	update LoginID set GameDollars=GameDollars+5000
	where CustomerID in (select d.CustomerID from DBG_UserRoundResults d
		where (GameReportTime >= @dt1 and GameReportTime < @dt2)
		and (MapType=3)
		group by CustomerID
		having count(*)>=25
		)

END

GO
