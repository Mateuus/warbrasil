
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[FN_MNT_ResetInventoryToFPS]
	@in_CustomerID int
AS
BEGIN
	SET NOCOUNT ON;
	
	delete from Inventory where CustomerID=@in_CustomerID and ItemID>=100000 and ItemID<199999
	delete from Inventory_FPS where CustomerID=@in_CustomerID

	-- add all FPS weapons
	
	declare @ItemID int

	DECLARE t_cursorW CURSOR FOR select ItemID from Items_Weapons where IsFPS>0
	OPEN t_cursorW
	FETCH NEXT FROM t_cursorW into @ItemID
	while @@FETCH_STATUS = 0 
	begin
		exec FN_AddItemToUser @in_CustomerID, @ItemID, 2000

		FETCH NEXT FROM t_cursorW into @ItemID
	end
	CLOSE t_cursorW
	DEALLOCATE t_cursorW

END

GO
GRANT EXECUTE ON  [dbo].[FN_MNT_ResetInventoryToFPS] TO [support1]
GO
