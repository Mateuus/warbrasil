SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_SRV_RemoveItem]
	@in_CustomerID int,
	@in_ItemID int
AS
BEGIN
	SET NOCOUNT ON;
	
	exec FN_RemoveOneItemFromUser @in_CustomerID, @in_ItemID
	
	-- success
	select 0 as ResultCode
END

GO
