SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[FN_AddItemToGamertag]
	@in_Gamertag nvarchar(100),
	@in_ItemId int,
	@in_ExpDays int
AS
BEGIN
	SET NOCOUNT ON;
       
	declare @in_CustomerID int
	select @in_CustomerID=CustomerID from LoginID where Gamertag=@in_Gamertag
	if(@@ROWCOUNT = 0) begin
		print @in_Gamertag-- as 'Not Found'
		return
	end
	
	exec FN_AddItemToUser @in_CustomerID, @in_ItemID, @in_ExpDays
END
GO
