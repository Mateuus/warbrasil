SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_BuyItemFN_RentWeapons]
	@out_FNResult int out,
	@in_CustomerID int,
	@in_BuyDays int,
	@in_Category int	-- category can be 0 for all of them
AS
BEGIN
	SET NOCOUNT ON;
	
	--
	--
	-- function must be called from WO_BuyItemFN_Exec
	--
	--
	
	declare @ItemID int

	DECLARE t_cursorW CURSOR FOR select ItemID from Items_Weapons
		where (Price1+Price7+Price30+PriceP + GPrice1+GPrice7+GPrice30+GPriceP) > 0
		and (@in_Category = 0 or @in_Category=Category)
	OPEN t_cursorW
	FETCH NEXT FROM t_cursorW into @ItemID
	while @@FETCH_STATUS = 0 
	begin
		exec FN_AddItemToUser @in_CustomerID, @ItemID, @in_BuyDays

		FETCH NEXT FROM t_cursorW into @ItemID
	end
	CLOSE t_cursorW
	DEALLOCATE t_cursorW

	-- success
	set @out_FNResult = 0

END
GO
