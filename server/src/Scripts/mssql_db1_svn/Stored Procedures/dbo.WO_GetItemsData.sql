
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_GetItemsData] 
AS
BEGIN
	SET NOCOUNT ON;

	select 0 as ResultCode
	
	select * from Items_Gear
	select * from Items_Weapons;
	select * from Items_Generic
	select * from Items_Packages
	
END
GO
