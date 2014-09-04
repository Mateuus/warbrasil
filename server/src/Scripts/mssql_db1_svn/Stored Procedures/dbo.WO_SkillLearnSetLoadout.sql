
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_SkillLearnSetLoadout]
	@in_CustomerID int,
	@in_LoadoutID int,
	@in_SpendSP1 int,
	@in_SpendSP2 int,
	@in_SpendSP3 int,
	@in_Skills varchar(64)
AS
BEGIN
	SET NOCOUNT ON;
	
	select 0 as ResultCode
	
	-- convert to CURRENT size of Profile_Chars.Skills.
	declare @Skills char(31) = @in_Skills

	-- no checks, they was done in api_SkillLearn.aspx
	update Profile_Chars set 
		SpendSP1=@in_SpendSP1,
		SpendSP2=@in_SpendSP2,
		SpendSP3=@in_SpendSP3,
		Skills=@in_Skills 
		where LoadoutID=@in_LoadoutID
END
GO
