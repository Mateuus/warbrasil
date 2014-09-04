
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[WO_RetBonusGetInfo]
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
	select @lastRetBonusDate=lastRetBonusDate from LoginID where CustomerID=@in_CustomerID
	declare @NextDay datetime = DATEADD(day, 1, @lastRetBonusDate)
	declare @MinsToNextDay int = DATEDIFF(minute, GETDATE(), @NextDay) % (24*60)
	while(@MinsToNextDay < 0) begin 
		set @MinsToNextDay = @MinsToNextDay + (24*60)
	end

	if (@out_RetDays > 10 ) begin -- temp, need proper fix. do not return @out_RetDays bigger than DataRetentionBonuses elements
	 set @out_RetDays = 10
	end
	select @out_RetDays as 'RetDays', @MinsToNextDay as 'MinsToNextDay'

	-- get bonuses list
	select Bonus from DataRetentionBonuses order by [Day] asc

	return
END

GO
