USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_ItemUpgradeGetUpgrades]    Script Date: 12/06/2011 19:22:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_ItemUpgradeGetUpgrades]
AS
BEGIN
	SET NOCOUNT ON;

	-- this call is always valid
	select 0 as ResultCode

	-- return upgrade types and their values
	select ItemID, Value, PriceP, GPChance, GPriceP, GDChance from Items_UpgradeData
END
