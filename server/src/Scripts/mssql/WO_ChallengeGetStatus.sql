USE [gameid_v1]
GO

/****** Object:  StoredProcedure [dbo].[WO_ChallengeGetStatus]    Script Date: 03/15/2012 11:47:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[WO_ChallengeGetStatus]
AS
BEGIN
	SET NOCOUNT ON;

	declare @StartDate date = '2012-03-16'					-- challenge start
	declare @EndDate   date = dateadd(day, 7, @StartDate)	-- 3 days challenge
	declare @EndPerc   int  = 95							-- target ending percentage of challenge

	declare @IsActive  int  = 1
	if(GETDATE() < @StartDate or GETDATE() > @EndDate)
		set @IsActive = 0

	-- fake linear challenge progression
	declare @Target int = 100
	declare @Current int = DATEDIFF(minute, @StartDate, GETDATE()) * @EndPerc / DATEDIFF(minute, @StartDate, @EndDate)
	
	select
		@IsActive as 'IsActive',
		@StartDate as 'StartDate', 
		@EndDate as 'EndDate', 
		@Target as 'Target', 
		@Current as 'Current'
	
END


GO


