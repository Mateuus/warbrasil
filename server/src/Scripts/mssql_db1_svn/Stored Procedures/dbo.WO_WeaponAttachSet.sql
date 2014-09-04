SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[WO_WeaponAttachSet]
	@in_CustomerID int,
	@in_WeaponID int,
	@in_AttachmentID int,
	@in_Slot int
AS
BEGIN
	SET NOCOUNT ON;
	
	-- clearing attachment
	if(@in_AttachmentID = 0) begin
		update Inventory_FPS set IsEquipped=0 where CustomerID=@in_CustomerID and WeaponID=@in_WeaponID and Slot=@in_Slot
		select 0 as 'ResultCode'
		return
	end
	
	-- check if we have that weapon attachment
	declare @Slot int = 0
	select @Slot=Slot from Inventory_FPS 
		where (CustomerID=@in_CustomerID and WeaponID=@in_WeaponID and AttachmentID=@in_AttachmentID)
	if(@@ROWCOUNT = 0) begin
		select 6 as 'ResultCode', 'attachment not exists' as 'ResultMsg'
		return
	end
	
	-- client sanity check against slot
	if(@in_Slot <> @Slot) begin
		select 6 as 'ResultCode', 'wrong slot' as 'ResultMsg'
		return
	end
	
	update Inventory_FPS set IsEquipped=0 where CustomerID=@in_CustomerID and WeaponID=@in_WeaponID and Slot=@Slot
	update Inventory_FPS set IsEquipped=1 where CustomerID=@in_CustomerID and WeaponID=@in_WeaponID and AttachmentID=@in_AttachmentID
	
	select 0 as 'ResultCode'
	return
END

GO
