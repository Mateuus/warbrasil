USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_GetShopInfo2]    Script Date: 07/11/2011 20:35:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_GetShopInfo3] 
AS
BEGIN
	SET NOCOUNT ON;

	select 0 as ResultCode
	
	SELECT * from DataSkillPrice

	SELECT ItemID, Category, Price1, Price7, Price30, PriceP, GPrice1, GPrice7, GPrice30, GPriceP
	FROM Items_Gear

	SELECT ItemID, Category, Price1, Price7, Price30, PriceP, GPrice1, GPrice7, GPrice30, GPriceP
	FROM Items_Weapons

	SELECT ItemID, Category, Price1, Price7, Price30, PriceP, GPrice1, GPrice7, GPrice30, GPriceP
	FROM Items_Generic
	
	SELECT * from Items_Packages

END
