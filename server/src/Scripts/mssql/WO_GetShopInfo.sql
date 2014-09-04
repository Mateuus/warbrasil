USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_GetShopInfo]    Script Date: 05/24/2011 21:56:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_GetShopInfo] 
AS
BEGIN
	SET NOCOUNT ON;

	select 0 as ResultCode
	
	SELECT * from DataLoadoutPrice
	SELECT * from DataSkillPrice
	SELECT * from DataAbilityPrice

	SELECT ItemID, Category, Price1, Price7, Price30, PriceP, GPrice1, GPrice7, GPrice30, GPriceP
	FROM Items_Gear

	SELECT ItemID, Category, Price1, Price7, Price30, PriceP, GPrice1, GPrice7, GPrice30, GPriceP
	FROM Items_Weapons

	SELECT ItemID, Category, Price1, Price7, Price30, PriceP, GPrice1, GPrice7, GPrice30, GPriceP
	FROM Items_Generic
	
	SELECT * from Items_Packages

END
