USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[FN_AddPremiumAccToUser]    Script Date: 04/05/2011 00:23:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[FN_AddPremiumAccToUser]
	@in_CustomerID int,
	@in_ExpDays int
AS
BEGIN
	SET NOCOUNT ON;

	-- add Item_AccountPremium
	exec FN_AddItemToUser @in_CustomerID, 301004, @in_ExpDays
	-- add Item_BoostXP1
	exec FN_AddItemToUser @in_CustomerID, 301001, @in_ExpDays
	-- add Item_BoostGP1
	exec FN_AddItemToUser @in_CustomerID, 301003, @in_ExpDays
	-- add 5 SP
	update LoginID SET SkillPoints=(SkillPoints+5) WHERE CustomerID=@in_CustomerID
	-- add 5000GP
	update LoginID SET GamePoints=(GamePoints+5000) WHERE CustomerID=@in_CustomerID

	-- Item of the month - ASR_XM8
	exec FN_AddItemToUser @in_CustomerID, 101076, 26

	--print 'Permanent account status set. Will expire on ' + DATEADD(day, 30, GETDATE()) + '\n\n\n'
END
