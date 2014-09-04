USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[FN_AddItemToUser]    Script Date: 03/21/2012 14:50:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[FN_AddItemToUser]
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
			1
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
	if(@@ROWCOUNT > 0 and @IsStackable > 0) 
	begin
		update Inventory set Quantity=Quantity+1 
			where ItemID=@in_ItemID and CustomerID=@in_CustomerID
	end
END
