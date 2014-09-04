USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_BuyItem_GD]    Script Date: 03/01/2012 18:32:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_BuyItem_GD]
	@in_IP char(32),
	@in_CustomerID int,
	@in_ItemId int,
	@in_BuyDays int,
	@in_Param1 int = 0 -- used for WeaponID in FPS attachment buys
AS
BEGIN
	SET NOCOUNT ON;

	-- get points for that customer
	declare @GameDollars int
	SELECT @GameDollars=GameDollars FROM LoginID WHERE CustomerID=@in_CustomerID
	if (@@RowCount = 0) begin
		select 6 as ResultCode, 'no CustomerID' as ResultMsg
		return
	end

	declare @smsg1 varchar(1000)
	declare @out_FNResult int = 100

	-- get price
	declare @FinalPrice int
	exec WO_BuyItemFN_GetPrice @out_FNResult out, @in_ItemId, @in_BuyDays, 'GD', @FinalPrice out
	if(@out_FNResult > 0) begin
		set @smsg1 = LTRIM(STR(@out_FNResult)) + ' GD '
		set @smsg1 = @smsg1 + LTRIM(STR(@in_BuyDays)) + ' ' + LTRIM(STR(@in_ItemID))
		EXEC FN_ADD_SECURITY_LOG 110, @in_IP, @in_CustomerID, @smsg1
		select 6 as ResultCode, 'bad GetPrice' as ResultMsg
		return
	end
	
	-- check if enough money
	if(@GameDollars < @FinalPrice) begin
		set @smsg1 = LTRIM(STR(@in_ItemId)) + ' ' + LTRIM(STR(@in_BuyDays)) + ' '
		set @smsg1 = @smsg1 + ' GD ' + LTRIM(STR(@FinalPrice)) + ' ' + LTRIM(STR(@GameDollars))
		EXEC FN_ADD_SECURITY_LOG 114, @in_IP, @in_CustomerID, @smsg1
		select 7 as ResultCode, 'Not Enough GD' as ResultMsg
		return
	end

	-- exec item adding function, if it fail, do not process transaction further
	exec WO_BuyItemFN_Exec @out_FNResult out, @in_CustomerID, @in_ItemId, @in_BuyDays, @in_Param1
	if(@out_FNResult <> 0) begin
		set @smsg1 = 'BuyExec failed' + LTRIM(STR(@out_FNResult))
		select 7 as ResultCode, @smsg1 as ResultMsg
		return
	end

	-- perform actual transaction
	set @GameDollars = @GameDollars-@FinalPrice;
	UPDATE LoginID SET GameDollars=@GameDollars where CustomerID=@in_CustomerID

	-- set transaction type
	declare @TType int = 0
	if(@in_BuyDays = 2000) set @TType = 3001;
	else set @TType = 2001;
	
	-- update transaction detail
	INSERT INTO FinancialTransactions
		VALUES (@in_CustomerID, 'INGAME', @TType, GETDATE(), 
				@FinalPrice, '1', 'APPROVED', @in_ItemId)

	select 0 as ResultCode
	select @GameDollars as 'Balance';

END
