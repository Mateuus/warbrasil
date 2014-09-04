
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_SkillLearnPrepare]
	@in_CustomerID int,
	@in_LoadoutID int,
	@in_SkillID int
AS
BEGIN
	SET NOCOUNT ON;
	
	declare @SkillPoints int = 0
	select @SkillPoints=SkillPoints from LoginID where CustomerID=@in_CustomerID
	if(@@ROWCOUNT=0) begin
		select 6 as ResultCode, 'no customer' as ResultMsg
		return
	end
	
	declare @CustomerID int = 0
	declare @SpendSP1 int
	declare @SpendSP2 int
	declare @SpendSP3 int
	declare @Class int
	declare @Skills varchar(64)
	select 
		@CustomerID=CustomerID, 
		@Class=Class,
		@SpendSP1=SpendSP1, 
		@SpendSP2=SpendSP2, 
		@SpendSP3=SpendSP3, 
		@Skills=Skills
		from Profile_Chars where LoadoutID=@in_LoadoutID
	if(@CustomerID <> @in_CustomerID) begin
		select 6 as ResultCode, 'bad loadout' as ResultMsg
		return
	end
	
	select 0 as ResultCode
	
	select 
		@SkillPoints as 'PlayerSP',
		@SpendSP1 as 'SpendSP1',
		@SpendSP2 as 'SpendSP2',
		@SpendSP3 as 'SpendSP3',
		@Class as 'Class',
		@Skills as 'Skills'

	select * from DataSkill2Price where SkillID=@in_SkillID
END
GO
