USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_GetAccountWeeklyStats]    Script Date: 03/22/2012 17:07:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_GetAccountWeeklyStats]
	@in_CustomerID int
AS
BEGIN  
	SET NOCOUNT ON;  

	-- get current day and make current week range
	declare @dt1 date = GETDATE()
	set @dt1 = DATEADD(day, -(DATEPART(weekday, @dt1) - 1), @dt1)
	declare @dt2 date = DATEADD(day, 7, @dt1)

	declare @DailyGames int = 0
	declare @Kills int = 0
	declare @Headshots int = 0
	declare @CaptureFlags int = 0
	declare @MatchesCQ int = 0
	declare @MatchesDM int = 0
	declare @MatchesSB int = 0

	-- count daily games, kills, headshots, capture enemy flags
	select 
		@DailyGames = count(CustomerID), 
		@Kills = SUM(Kills), 
		@Headshots = SUM(Headshots), 
		@CaptureFlags = SUM(CaptureEnemyPoints)
	from DBG_UserRoundResults 
	where GameReportTime >= @dt1 and GameReportTime < @dt2 and CustomerID=@in_CustomerID

	select @MatchesCQ=COUNT(*) from DBG_UserRoundResults
		where CustomerID=@in_CustomerID and (GameReportTime >= @dt1 and GameReportTime < @dt2)
		and (MapType=0)

	select @MatchesDM=COUNT(*) from DBG_UserRoundResults
		where CustomerID=@in_CustomerID and (GameReportTime >= @dt1 and GameReportTime < @dt2)
		and (MapType=1)

	select @MatchesSB=COUNT(*) from DBG_UserRoundResults
		where CustomerID=@in_CustomerID and (GameReportTime >= @dt1 and GameReportTime < @dt2)
		and (MapType=3)

	-- report to us
	select 
		@DailyGames as 'DailyGames', 
		@Kills as 'Kills', 
		@Headshots as 'Headshots', 
		@CaptureFlags as 'CaptureFlags',
		@MatchesCQ as 'MatchesCQ',
		@MatchesDM as 'MatchesDM',
		@MatchesSB as 'MatchesSB'

END
