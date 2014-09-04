
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[FN_AddItemToUser]
	@in_CustomerID int,
	@in_ItemID int,
	@in_ExpDays int
AS
BEGIN
	SET NOCOUNT ON;

	declare @LeasedUntil datetime
	declare @CurDate datetime = GETDATE()
	
	-- add default weapon attachments
	if(@in_ItemID >= 100000 and @in_ItemID <= 199999) begin
		exec FN_AddDefaultAttachments @in_CustomerID, @in_ItemID, @in_ExpDays
	end

	declare @Quantity int = 1

	-- check if this is usable item, if so - get buying stack size.
	-- usable items is weapons, with 28 category. stackable item defined where NumClips>1, Quantity is ClipSize
	declare @BuyStackSize int = 0
	select @BuyStackSize=ClipSize from Items_Weapons where ItemID=@in_ItemID and Category=28 and NumClips>1
	if(@BuyStackSize > 0)
		set @Quantity = @BuyStackSize

	-- add item to inventory
	select @LeasedUntil=LeasedUntil from Inventory where (ItemID=@in_ItemID and CustomerID=@in_CustomerID)
	if(@@ROWCOUNT = 0) 
	begin
		INSERT INTO Inventory (
			CustomerID, 
			ItemID, 
			LeasedUntil, 
			Quantity
		)
		VALUES (
			@in_CustomerID,
			@in_ItemID,
			DATEADD(day, @in_ExpDays, @CurDate),
			@Quantity
		)
		return
	end
       
	if(@LeasedUntil < @CurDate)
		set @LeasedUntil = DATEADD(day, @in_ExpDays, @CurDate)
	else
		set @LeasedUntil = DATEADD(day, @in_ExpDays, @LeasedUntil)
		
	if(@LeasedUntil > '2020-1-1')
		set @LeasedUntil = '2020-1-1'

	UPDATE Inventory SET 
		LeasedUntil=@LeasedUntil
	WHERE ItemID=@in_ItemID and CustomerID=@in_CustomerID
       
	-- set if we need to increase item quantity
	declare @IsStackable int = 0
	select @IsStackable=IsStackable from Items_Generic where ItemID=@in_ItemID
	if(@IsStackable > 0 or @BuyStackSize > 0) 
	begin
		update Inventory set Quantity=Quantity+@Quantity
			where ItemID=@in_ItemID and CustomerID=@in_CustomerID
	end
END
GO

GRANT EXECUTE ON  [dbo].[FN_AddItemToUser] TO [support1]
GO
