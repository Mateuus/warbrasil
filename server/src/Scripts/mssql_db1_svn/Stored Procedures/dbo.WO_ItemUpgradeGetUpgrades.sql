SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_ItemUpgradeGetUpgrades]
AS
BEGIN
	SET NOCOUNT ON;

	-- this call is always valid
	select 0 as ResultCode

	-- return upgrade types and their values
	select ItemID, Value, PriceP, GPChance, GPriceP, GDChance from Items_UpgradeData
END
GO
