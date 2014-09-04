USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[FN_AddItemToUser]    Script Date: 11/18/2011 17:01:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FN_RemoveItemFromUser]
	@in_CustomerID int,
	@in_ItemId int
AS
BEGIN
	SET NOCOUNT ON;

	declare @Quantity int = 0
	select @Quantity=Quantity from Inventory where CustomerID=@in_CustomerID and ItemID=@in_ItemID
	if(@@ROWCOUNT = 0)
		return

	-- update item quantity
	set @Quantity = @Quantity - 1
	if(@Quantity <= 0)
		delete from Inventory where CustomerID=@in_CustomerID and ItemID=@in_ItemID
	else
		update Inventory set Quantity=@Quantity where CustomerID=@in_CustomerID and ItemID=@in_ItemID

END
