USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_RetBonusGetInfo]    Script Date: 03/22/2012 14:00:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_RetBonusGetInfo]
	@in_CustomerID int
AS
BEGIN
	SET NOCOUNT ON;

	select 0 as ResultCode

	-- detect retention days
	declare @out_RetDays int
	exec WO_RetBonusFN_CheckDays @in_CustomerID, @out_RetDays out

	-- calc minutes to next day
	declare @lastRetBonusDate datetime
	select @lastRetBonusDate=lastRetBonusDate from LoginID where CustomerID=1282052887
	declare @NextDay datetime = DATEADD(day, 1, @lastRetBonusDate)
	declare @MinsToNextDay int = DATEDIFF(minute, GETDATE(), @NextDay) % (24*60)
	while(@MinsToNextDay < 0) begin 
		set @MinsToNextDay = @MinsToNextDay + (24*60)
	end

	select @out_RetDays as 'RetDays', @MinsToNextDay as 'MinsToNextDay'

	-- get bonuses list
	select Bonus from DataRetentionBonuses order by [Day] asc

	return
END
