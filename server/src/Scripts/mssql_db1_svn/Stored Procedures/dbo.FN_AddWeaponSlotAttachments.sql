SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[FN_AddWeaponSlotAttachments]
	@in_CustomerID int,
	@in_WeaponID int,
	@in_SpecID int,
	@in_BuyDays int
AS
BEGIN
	SET NOCOUNT ON;
	
	if(@in_SpecID = 0)
		return;
	
	declare @ItemID int

	DECLARE t_cursorWA CURSOR FOR select ItemID from Items_Attachments where SpecID=@in_SpecID
	OPEN t_cursorWA
	FETCH NEXT FROM t_cursorWA into @ItemID
	while @@FETCH_STATUS = 0 
	begin
		exec FN_AddAttachmentToUser @in_CustomerID, @in_WeaponID, @ItemID, @in_BuyDays

		FETCH NEXT FROM t_cursorWA into @ItemID
	end
	CLOSE t_cursorWA
	DEALLOCATE t_cursorWA

END
GO
