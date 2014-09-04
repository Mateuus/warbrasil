USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[FN_VALIDATE_LOADOUT_ITEM]    Script Date: 03/20/2012 11:07:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[FN_VALIDATE_LOADOUT_ITEM] 
	@in_IP varchar(100),
	@in_CustomerID int,
	@in_ItemID int,
	@in_EquipIdx int
AS
BEGIN
	SET NOCOUNT ON;
	
	if @in_ItemID = 0
		return 0

	if not exists (SELECT ItemID from Inventory WHERE ItemID=@in_ItemID and CustomerID=@in_CustomerID and LeasedUntil>GETDATE()) begin
		return 0
	end

	-- item is valid
	return @in_ItemID
END
