USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_BuyItemFN_GetPrice]    Script Date: 03/01/2012 18:01:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_BuyItemFN_GetPrice]
    @out_FNResult int out,
	@in_ItemId int,
	@in_BuyDays int,
	@in_Currency varchar(32),
	@o_FinalPrice int out
AS
BEGIN
	SET NOCOUNT ON;
	
--
-- get prices from table based on itemID
--
	declare @Price1 int = 0
	declare @Price7 int = 0
	declare @Price30 int = 0
	declare @PriceP int = 0
	declare @GPrice1 int = 0
	declare @GPrice7 int = 0
	declare @GPrice30 int = 0
	declare @GPriceP int = 0
	declare @IsEnabled int = 1

	if(@in_ItemId >= 20000 and @in_ItemId < 99999)
		SELECT
		   @Price1=Price1, @Price7=Price7, @Price30=Price30, @PriceP=PriceP, 
		   @GPrice1=GPrice1, @GPrice7=GPrice7, @GPrice30=GPrice30, @GPriceP=GPriceP
		FROM Items_Gear where ItemID=@in_ItemID
	else
	if(@in_ItemId >= 100000 and @in_ItemId < 190000)
		SELECT
		   @Price1=Price1, @Price7=Price7, @Price30=Price30, @PriceP=PriceP, 
		   @GPrice1=GPrice1, @GPrice7=GPrice7, @GPrice30=GPrice30, @GPriceP=GPriceP
		FROM Items_Weapons where ItemID=@in_ItemID
	else 
	if(@in_ItemId >= 300000 and @in_ItemId < 390000) 
		SELECT
		   @Price1=Price1, @Price7=Price7, @Price30=Price30, @PriceP=PriceP, 
		   @GPrice1=GPrice1, @GPrice7=GPrice7, @GPrice30=GPrice30, @GPriceP=GPriceP
		FROM Items_Generic where ItemID=@in_ItemID
	else 
	if(@in_ItemId >= 400000 and @in_ItemId < 490000) 
		SELECT
		   @Price1=Price1, @Price7=Price7, @Price30=Price30, @PriceP=PriceP, 
		   @GPrice1=GPrice1, @GPrice7=GPrice7, @GPrice30=GPrice30, @GPriceP=GPriceP
		FROM Items_Attachments where ItemID=@in_ItemID
	else 
	if(@in_ItemId >= 500000 and @in_ItemId < 590000) 
		SELECT
		   @Price1=Price1, @Price7=Price7, @Price30=Price30, @PriceP=PriceP, 
		   @GPrice1=GPrice1, @GPrice7=GPrice7, @GPrice30=GPrice30, @GPriceP=GPriceP,
		   @IsEnabled=IsEnabled
		FROM Items_Packages where ItemID=@in_ItemID
	else 
	if(@in_ItemId >= 600000 and @in_ItemId < 699999) 
		SELECT
		   @PriceP=PriceP, 
		   @GPriceP=GPriceP
		FROM Items_UpgradeData where ItemID=@in_ItemID
	else 
	begin
		set @out_FNResult = 1
		return
	end
	if (@@RowCount = 0) begin
		set @out_FNResult = 2
		return
	end
	
	     if(@in_Currency = 'GP' and @in_BuyDays = 1)    set @o_FinalPrice = @Price1
	else if(@in_Currency = 'GP' and @in_BuyDays = 7)    set @o_FinalPrice = @Price7
	else if(@in_Currency = 'GP' and @in_BuyDays = 30)   set @o_FinalPrice = @Price30
	else if(@in_Currency = 'GP' and @in_BuyDays = 2000) set @o_FinalPrice = @PriceP
	else if(@in_Currency = 'GD' and @in_BuyDays = 1)    set @o_FinalPrice = @GPrice1
	else if(@in_Currency = 'GD' and @in_BuyDays = 7)    set @o_FinalPrice = @GPrice7
	else if(@in_Currency = 'GD' and @in_BuyDays = 30)   set @o_FinalPrice = @GPrice30
	else if(@in_Currency = 'GD' and @in_BuyDays = 2000) set @o_FinalPrice = @GPriceP
	else begin
		set @out_FNResult = 3
		return
	end

	-- check if listed
	if(@o_FinalPrice <= 0 or @IsEnabled = 0) begin
		set @out_FNResult = 4
		return
	end
	
	set @out_FNResult = 0
END
