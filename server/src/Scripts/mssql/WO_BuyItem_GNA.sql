USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_BuyItem_GNA]    Script Date: 06/03/2011 16:13:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_BuyItem_GNA]
	@in_IP char(32),
	@in_CustomerID int,
	@in_ItemId int,
	@in_BuyDays int,
	@in_Param1 int = 0 -- used for WeaponID in FPS attachment buys
AS
BEGIN
	SET NOCOUNT ON;

	-- gna service id for warinc
	declare @ServiceId bigint = 300005010000000000

	-- get GNA UserID for our customer
	declare @GNAUserId bigint
	select @GNAUserId=GNAUserId from LoginID where CustomerID=@in_CustomerID
	if (@@RowCount = 0) begin
		select 6 as ResultCode, 'no CustomerID' as ResultMsg
		return
	end
	declare @AuthId varchar(40)
	set @AuthId = convert(varchar(32), @GnaUserID)

	declare @smsg1 varchar(1000)
	declare @out_FNResult int = 100

	-- get item price first
	declare @FinalPrice int
	exec WO_BuyItemFN_GetPrice @out_FNResult out, @in_ItemId, @in_BuyDays, 'GP', @FinalPrice out
	if(@out_FNResult > 0) begin
		set @smsg1 = LTRIM(STR(@out_FNResult)) + ' GNA '
		set @smsg1 = @smsg1 + LTRIM(STR(@in_BuyDays)) + ' ' + LTRIM(STR(@in_ItemID))
		EXEC FN_ADD_SECURITY_LOG 110, @in_IP, @in_CustomerID, @smsg1
		select 6 as ResultCode, 'bad GetPrice' as ResultMsg
		return
	end

	-- get balance from gamenet
	DECLARE @o_Balance money;
	DECLARE @o_Error int;

	SET @o_Balance = NULL;
	SET @o_Error = NULL;
	EXEC dblink_api.billing.dbo.usp_GetBalance 
		@i_ServiceId = @ServiceId,
		@i_AuthType = 'user_id',
		@i_AuthId = @AuthId,
		@o_Balance = @o_Balance out,
		@o_Error = @o_Error out;
	if(@o_Error > 0) begin
		select 6 as ResultCode, 'can not get balance' as ResultMsg
		return
	end
	-- convert NULL to 0
	if(@o_Balance is NULL) set @o_Balance = 0
	
	-- check if enough money
	if(@o_Balance < @FinalPrice) begin
		set @smsg1 = LTRIM(STR(@in_ItemId)) + ' ' + LTRIM(STR(@in_BuyDays)) + ' '
		set @smsg1 = @smsg1 + ' GNA ' + LTRIM(STR(@FinalPrice)) + ' ' + LTRIM(STR(@o_Balance))
		EXEC FN_ADD_SECURITY_LOG 114, @in_IP, @in_CustomerID, @smsg1
		select 7 as ResultCode, 'Not Enough GNA' as ResultMsg
		return
	end
	
	-- create logical item id
	declare @LItemId int = 0
	if(@in_BuyDays = 1) set @LItemId = 1000000 + @in_ItemId
	else if(@in_BuyDays = 7) set @LItemId = 2000000 + @in_ItemId
	else if(@in_BuyDays = 30) set @LItemId = 3000000 + @in_ItemId
	else if(@in_BuyDays = 2000) set @LItemId = 4000000 + @in_ItemId
	declare @LItemIdStr varchar(32) = convert(varchar(32), @LItemId);
	
	-- perform actual transaction
	DECLARE @o_InvoceId int;

	SET @o_InvoceId = NULL;
	SET @o_Balance = NULL;
	SET @o_Error = NULL;
	EXEC dblink_api.billing.dbo.usp_SaleItem 
		@i_ServiceId = @ServiceId,
		@i_AuthType = 'user_id',
		@i_AuthId = @AuthId,
		@i_ItemId = @LItemIdStr,
		@i_ItemType = 'ingame',
		@i_ItemCost = @FinalPrice,
		@i_ItemCount = 1,
		@i_PerItem = 0,
		@i_VerifyCost = 1,
		@i_ServerId = 1,
		@i_ServerName = 'WarIncRU',
		@i_TransactionId = 100,
		@i_CharName = '',
		@o_InvoceId = @o_InvoceId out,
		@o_Balance = @o_Balance out,
		@o_Error = @o_Error out;
	if(@o_Error > 0) begin
		set @smsg1 = 'SaleItem ' + LTRIM(STR(@o_Error)) + ' '
		set @smsg1 = @smsg1 + LTRIM(STR(@in_BuyDays)) + ' ' + LTRIM(STR(@in_ItemID)) + ' ' + LTRIM(STR(@LItemID))
		EXEC FN_ADD_SECURITY_LOG 115, @in_IP, @in_CustomerID, @smsg1
		select 6 as ResultCode, @smsg1 as ResultMsg
		return
	end
	-- convert NULL to 0
	if(@o_Balance is NULL) set @o_Balance = 0

	-- exec item adding function, if it fail, do not process transaction further
	exec WO_BuyItemFN_Exec @out_FNResult out, @in_CustomerID, @in_ItemId, @in_BuyDays, @in_Param1
	if(@out_FNResult <> 0) begin
		set @smsg1 = 'BuyExec ' + LTRIM(STR(@out_FNResult)) + ' '
		set @smsg1 = @smsg1 + LTRIM(STR(@in_BuyDays)) + ' ' + LTRIM(STR(@in_ItemID))
		EXEC FN_ADD_SECURITY_LOG 116, @in_IP, @in_CustomerID, @smsg1
		select 7 as ResultCode, @smsg1 as ResultMsg
		return
	end

	-- set transaction type
	declare @TType int = 0
	if(@in_BuyDays = 2000) set @TType = 3000;
	else set @TType = 2000;
	
	-- update transaction detail
	INSERT INTO FinancialTransactions
		VALUES (@in_CustomerID, 'INGAME', @TType, GETDATE(), 
				@FinalPrice, CONVERT(varchar(32), @o_InvoceId), 'APPROVED', @in_ItemId)

	select 0 as ResultCode

	declare @NewBalance int = convert(int, @o_Balance)
	select @NewBalance as 'Balance'

END
