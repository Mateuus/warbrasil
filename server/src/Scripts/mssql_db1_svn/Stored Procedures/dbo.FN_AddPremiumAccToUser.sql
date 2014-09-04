
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE PROCEDURE [dbo].[FN_AddPremiumAccToUser]
	@in_CustomerID int,
	@in_ExpDays int
AS
BEGIN
	SET NOCOUNT ON;

	-- add Item_AccountPremium
	exec FN_AddItemToUser @in_CustomerID, 301004, @in_ExpDays

	-- add 1 SP - not anymore
	-- update LoginID SET SkillPoints=(SkillPoints+1) WHERE CustomerID=@in_CustomerID
	
	-- Item of the month - G11
	--exec FN_AddItemToUser @in_CustomerID, 101171, @in_ExpDays
END




GO
