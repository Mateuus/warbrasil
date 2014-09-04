SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_LootGetData] 
	@in_LootID int
AS
BEGIN
	SET NOCOUNT ON;

	-- success
	select 0 as ResultCode

	-- report item category (loot box or mystery box)
	declare @Category int = 0
	select @Category=Category from Items_Generic where ItemID=@in_LootID
	select @Category as 'Category'

	-- report content
	select * from Items_LootData where LootID=@in_LootID order by Chance asc
END
GO
