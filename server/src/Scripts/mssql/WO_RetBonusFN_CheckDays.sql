USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_RetBonusFN_CheckDays]    Script Date: 03/21/2012 10:56:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_RetBonusFN_CheckDays]
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

	-- loop for same days in backs and see if user was logged at least once
	declare @dt1 datetime = DATEADD(day, -1, GETDATE())
	declare @dt2 datetime = GETDATE()
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
