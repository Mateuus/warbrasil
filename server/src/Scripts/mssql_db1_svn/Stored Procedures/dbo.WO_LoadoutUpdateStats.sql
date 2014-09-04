SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_LoadoutUpdateStats] 
	@in_CustomerID int,
	@in_LoadoutID int,
	@in_TimePlayed int,
	@in_HonorPoints int
AS
BEGIN
	SET NOCOUNT ON;
	
	-- validate that player own that loadout	
	declare @CustomerID int = 0
	select @CustomerID=CustomerID from Profile_Chars where LoadoutID=@in_LoadoutID
	if(@@ROWCOUNT = 0) begin
		select 6 as ResultCode, 'no loadout id' as ResultMsg
		return
	end
	
	if(@CustomerID <> @in_CustomerID) begin
		select 6 as ResultCode, 'bad customerid' as ResultMsg
		return
	end

	-- update loadout data
	update Profile_Chars set 
		TimePlayed=(TimePlayed+@in_TimePlayed), 
		HonorPoints=(HonorPoints+@in_HonorPoints)
	where LoadoutID=@in_LoadoutID

	select 0 as ResultCode
END
GO
