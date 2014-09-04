USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_BuyItemFN_RentGears]    Script Date: 02/01/2012 16:20:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_BuyItemFN_RentGears]
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

	DECLARE t_cursorG CURSOR FOR select ItemID from Items_Gear
		where (Price1+Price7+Price30+PriceP + GPrice1+GPrice7+GPrice30+GPriceP) > 0
		and (@in_Category = 0 or @in_Category=Category)
	OPEN t_cursorG
	FETCH NEXT FROM t_cursorG into @ItemID
	while @@FETCH_STATUS = 0 
	begin
		exec FN_AddItemToUser @in_CustomerID, @ItemID, @in_BuyDays

		FETCH NEXT FROM t_cursorG into @ItemID
	end
	CLOSE t_cursorG
	DEALLOCATE t_cursorG

	-- success
	set @out_FNResult = 0

END
