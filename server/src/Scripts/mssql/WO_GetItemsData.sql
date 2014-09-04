USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_GetItemsData]    Script Date: 10/18/2011 13:59:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_GetItemsData] 
AS
BEGIN
	SET NOCOUNT ON;

	select 0 as ResultCode
	
	select * from Items_Gear
	select * from Items_Weapons;
END
