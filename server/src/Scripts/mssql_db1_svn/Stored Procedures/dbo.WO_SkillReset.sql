SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_SkillReset]
	@in_CustomerID int,
	@in_LoadoutID int
AS
BEGIN
	SET NOCOUNT ON;
	
	declare @CustomerID int = 0
	select @CustomerID=CustomerID from Profile_Chars where LoadoutID=@in_LoadoutID
	if(@CustomerID <> @in_CustomerID) begin
		select 6 as ResultCode, 'bad loadout' as ResultMsg
		return
	end
	
	select 0 as ResultCode
	
	update Profile_Chars set SpendSP1=0, SpendSP2=0, SpendSP3=0, Skills='' where LoadoutID=@in_LoadoutID
END
GO
