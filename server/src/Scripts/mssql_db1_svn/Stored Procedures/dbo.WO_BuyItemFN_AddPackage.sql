SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_BuyItemFN_AddPackage]
	@out_FNResult int out,
	@in_CustomerID int,
	@in_ItemId int
AS
BEGIN
	SET NOCOUNT ON;
	
	--
	--
	-- function must be called from WO_BuyItemFN_Exec
	--
	--

	declare @IsEnabled int
	declare @AddGP int
	declare @AddSP int
	declare @Item1_ID int
	declare @Item1_Exp int
	declare @Item2_ID int
	declare @Item2_Exp int
	declare @Item3_ID int
	declare @Item3_Exp int
	declare @Item4_ID int
	declare @Item4_Exp int
	declare @Item5_ID int
	declare @Item5_Exp int
	declare @Item6_ID int
	declare @Item6_Exp int
	
	SELECT 
		@IsEnabled=IsEnabled,
		@AddGP=AddGP,
		@AddSP=AddSP,
		@Item1_ID=Item1_ID,
		@Item1_Exp=Item1_Exp,
		@Item2_ID=Item2_ID,
		@Item2_Exp=Item2_Exp,
		@Item3_ID=Item3_ID,
		@Item3_Exp=Item3_Exp,
		@Item4_ID=Item4_ID,
		@Item4_Exp=Item4_Exp,
		@Item5_ID=Item5_ID,
		@Item5_Exp=Item5_Exp,
		@Item6_ID=Item6_ID,
		@Item6_Exp=Item6_Exp
	FROM Items_Packages WHERE ItemID=@in_ItemId
	if (@@RowCount = 0) begin
		set @out_FNResult = 6
		return
	end
	
	--if(@IsEnabled = 0) begin
	--	set @out_FNResult = 7
	--	return
	--end
	
	if(@Item1_ID > 0) begin
		exec FN_AddItemToUser @in_CustomerID, @Item1_ID, @Item1_Exp
	end
	if(@Item2_ID > 0) begin
		exec FN_AddItemToUser @in_CustomerID, @Item2_ID, @Item2_Exp
	end
	if(@Item3_ID > 0) begin
		exec FN_AddItemToUser @in_CustomerID, @Item3_ID, @Item3_Exp
	end
	if(@Item4_ID > 0) begin
		exec FN_AddItemToUser @in_CustomerID, @Item4_ID, @Item4_Exp
	end
	if(@Item5_ID > 0) begin
		exec FN_AddItemToUser @in_CustomerID, @Item5_ID, @Item5_Exp
	end
	if(@Item6_ID > 0) begin
		exec FN_AddItemToUser @in_CustomerID, @Item6_ID, @Item6_Exp
	end
	
	update LoginID set 
		GameDollars=(GameDollars+@AddGP), 
		SkillPoints=(SkillPoints+@AddSP)
	where CustomerID=@in_CustomerID
	
	-- success
	set @out_FNResult = 0

END
GO
