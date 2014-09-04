
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_LoadoutUnlock] 
	@in_CustomerID int,
	@in_Class int
AS
BEGIN
	SET NOCOUNT ON;
	
	-- temp solution for now - limit maximum loadout slots to 6
	declare @NumLoadouts int = 0
	select @NumLoadouts=COUNT(*) from Profile_Chars where CustomerID=@in_CustomerID
	if(@NumLoadouts < 6) 
	begin
		insert into Profile_Chars (
			CustomerID,
			Class,
			Loadout
		) values (
			@in_CustomerID,
			@in_Class,
			''
		)
	end
	
	-- detect loadout id
	declare @LoadoutID int = 0
	select top(1) @LoadoutID=LoadoutID from Profile_Chars where CustomerID=@in_CustomerID order by LoadoutID desc
	
	-- fallthru to WO_LoadoutResetClass
	-- all items will be given there!
	-- ResultCode and data will be selected from there
	
	exec WO_LoadoutResetClass @in_CustomerID, @LoadoutID, @in_Class
END


GO
