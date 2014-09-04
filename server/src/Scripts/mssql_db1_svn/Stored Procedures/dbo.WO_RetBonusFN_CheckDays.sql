
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_RetBonusFN_CheckDays]
	@in_CustomerID int,
	@out_RetDays int out
AS
BEGIN
	SET NOCOUNT ON;
	
	-- get last gime when bonus was given
	declare @lastRetBonusDate datetime
	select @lastRetBonusDate=lastRetBonusDate from LoginID where CustomerID=@in_CustomerID
	if(@lastRetBonusDate is NULL) begin
		update LoginID set lastRetBonusDate=GETDATE() where CustomerID=@in_CustomerID
		set @out_RetDays = 0
		return
	end

	-- calc next possible date with same *time* as @lastRetBonusDate
	declare @NextBonusTime datetime = DATEADD(day, 1, @lastRetBonusDate)
	declare @SecToNextDay int = DATEDIFF(second, GETDATE(), @NextBonusTime) % (24*60*60)
	while(@SecToNextDay < 0) begin
		set @SecToNextDay = @SecToNextDay + (24*60*60)
	end
	set @NextBonusTime = DATEADD(second, @SecToNextDay + 2, GETDATE())	-- add 2 sec delta for lower loop compare

	-- loop into past per one day frame between and see if user was logged at least once per day
	declare @dt1 datetime = DATEADD(day, -2, @NextBonusTime)
	declare @dt2 datetime = DATEADD(day, -1, @NextBonusTime)
	declare @days int = 0

	while(@lastRetBonusDate < @dt1) 
	begin
		declare @NumGames int = 0
		select @NumGames=COUNT(*) from Logins 
			where CustomerID=@in_CustomerID and LoginTime>@dt1 and LoginTime<@dt2
		if(@NumGames = 0)
			break

		-- add one day to continued play time, limit by 15 days for now
		set @days = @days + 1
		if(@days > 15)
			break
			
		set @dt1 = DATEADD(day, -1, @dt1)
		set @dt2 = DATEADD(day, -1, @dt2)
	end
	
	set @out_RetDays = @days
	return

END
GO
