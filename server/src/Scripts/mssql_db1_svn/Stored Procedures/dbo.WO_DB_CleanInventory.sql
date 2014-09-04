SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_DB_CleanInventory] 
AS
BEGIN
	SET NOCOUNT ON;

	declare @EraseDate datetime = DATEADD(day, -7, GETDATE())
	
	delete from Inventory where LeasedUntil<@EraseDate
	delete from Inventory_FPS where LeasedUntil<@EraseDate

	select 0 as ResultCode
END


GO
