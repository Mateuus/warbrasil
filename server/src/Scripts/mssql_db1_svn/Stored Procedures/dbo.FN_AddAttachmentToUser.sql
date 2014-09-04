
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[FN_AddAttachmentToUser]
	@in_CustomerID int,
	@in_WeaponID int,
	@in_AttachmentID int,
	@in_ExpDays int
AS
BEGIN
	SET NOCOUNT ON;

	declare @LeasedUntil datetime
	declare @CurDate datetime = GETDATE()
       
	select @LeasedUntil=LeasedUntil from Inventory_FPS where (CustomerID=@in_CustomerID and WeaponID=@in_WeaponID and AttachmentID=@in_AttachmentID)
	if(@@ROWCOUNT = 0)
	begin
		-- detect attachment slot
		declare @Slot int = 0
		select @Slot=[Type] from Items_Attachments where ItemID=@in_AttachmentID
		if(@@ROWCOUNT = 0) begin
			-- error, no attachment. unfortunately we can't report this...
			return
		end

		-- check if we have equipped item in same slot
		declare @NumEquipped int = 0
		select @NumEquipped = count(*) from Inventory_FPS where CustomerID=@in_CustomerID and WeaponID=@in_WeaponID and Slot=@Slot and IsEquipped > 0

		-- add new attachment and equip it
		INSERT INTO Inventory_FPS (
			CustomerID, 
			WeaponID, 
			AttachmentID,
			LeasedUntil,
			Slot,
			IsEquipped
			)
			VALUES (
			@in_CustomerID,
			@in_WeaponID,
			@in_AttachmentID,
			DATEADD(day, @in_ExpDays, @CurDate),
			@Slot,
			0
			)

		-- if new attachment, equip it
		if(@NumEquipped = 0)
		begin
			update Inventory_FPS set IsEquipped=1 
				where CustomerID=@in_CustomerID and WeaponID=@in_WeaponID and AttachmentID=@in_AttachmentID
		end

		return
	end
       
	if(@LeasedUntil < @CurDate)
		set @LeasedUntil = DATEADD(day, @in_ExpDays, @CurDate)
	else
		set @LeasedUntil = DATEADD(day, @in_ExpDays, @LeasedUntil)
               
	if(@LeasedUntil > '2020-1-1')
		set @LeasedUntil = '2020-1-1'

	UPDATE Inventory_FPS SET 
		LeasedUntil=@LeasedUntil
	WHERE (CustomerID=@in_CustomerID and WeaponID=@in_WeaponID and AttachmentID=@in_AttachmentID)
END
GO
