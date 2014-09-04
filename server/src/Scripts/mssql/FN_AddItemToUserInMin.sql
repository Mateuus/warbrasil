USE [gameid_v1]
GO

/****** Object:  StoredProcedure [dbo].[FN_AddItemToUserInMin]    Script Date: 01/23/2012 15:06:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[FN_AddItemToUserInMin]
	@in_CustomerID int,
	@in_ItemId int,
	@in_ExpMin int
AS
BEGIN
	SET NOCOUNT ON;

	declare @LeasedUntil datetime
	declare @CurDate datetime = GETDATE()
       
	select @LeasedUntil=LeasedUntil from Inventory where (ItemID=@in_ItemId and CustomerID=@in_CustomerID)
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
			@in_ItemId,
			DATEADD(minute, @in_ExpMin, @CurDate),
			1
		)
		return
	end
       
	if(@LeasedUntil < @CurDate)
		set @LeasedUntil = DATEADD(minute, @in_ExpMin, @CurDate)
	else
		set @LeasedUntil = DATEADD(minute, @in_ExpMin, @LeasedUntil)
		
	if(@LeasedUntil > '2020-1-1')
		set @LeasedUntil = '2020-1-1'

	UPDATE Inventory SET 
		LeasedUntil=@LeasedUntil
	WHERE ItemID=@in_ItemId and CustomerID=@in_CustomerID
       
	-- set if we need to increase item quantity
	declare @IsStackable int = 0
	select @IsStackable=IsStackable from Items_Generic where ItemID=@in_ItemId
	if(@@ROWCOUNT > 0 and @IsStackable > 0) 
	begin
		update Inventory set Quantity=Quantity+1 
			where ItemID=@in_ItemId and CustomerID=@in_CustomerID
	end
END


GO


