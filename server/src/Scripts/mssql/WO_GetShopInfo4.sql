USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_GetShopInfo4]    Script Date: 03/04/2012 12:13:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_GetShopInfo4] 
AS
BEGIN
	SET NOCOUNT ON;

	select 0 as ResultCode
	
	SELECT * from DataSkillPrice

	-- select common shop items
	      SELECT ItemID, Category, Price1, Price7, Price30, PriceP, GPrice1, GPrice7, GPrice30, GPriceP FROM Items_Gear
	union SELECT ItemID, Category, Price1, Price7, Price30, PriceP, GPrice1, GPrice7, GPrice30, GPriceP	FROM Items_Weapons
	union SELECT ItemID, Category, Price1, Price7, Price30, PriceP, GPrice1, GPrice7, GPrice30, GPriceP	FROM Items_Generic
	union SELECT ItemID, Category, Price1, Price7, Price30, PriceP, GPrice1, GPrice7, GPrice30, GPriceP	FROM Items_Attachments
	
	-- packages (later we'll report their content as well)
	SELECT * from Items_Packages
	
END
