
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_AMAZON_BuySKU]
	@in_Address varchar(128),
	@in_SKU varchar(128),
	@in_PurchaseId varchar(128)
AS
BEGIN
	SET NOCOUNT ON;

	-- this call is always valid
	select 0 as ResultCode
	
	-- NOTE: this can happen in case of retried FULLFIL query
	if(exists(select * from AmazonPurchases where PurchaseID=@in_PurchaseId)) begin
		select 'SUCCESS' as 'Status';
		return;
	end

	-- need for amazon sandbox test, convert test user to 0
	if(@in_Address = 'AMZNTESTVALIDADDRESS')
		set @in_Address = '0'

	-- NO other CHECKS - they WAS done in [WO_AMAZON_CheckSKU]
	declare @CustomerID int = convert(int, @in_Address)
	
	declare @PriceUSD float = 0
	select @PriceUSD=PriceUSD_For_Log from AmazonShop where SKU=@in_SKU

	-- log 1
	INSERT INTO FinancialTransactions VALUES (
		@CustomerID, 
		@in_PurchaseId, 
		1000, 
		GETDATE(), 
		@PriceUSD, 
		'AMAZON', 
		'APPROVED', 
		@in_SKU)
		
	-- log 2
	insert into AmazonPurchases (
		PurchaseID,
		CustomerID,
		PurchaseTime,
		SKU,
		IsRevoked
		)
		VALUES (
		@in_PurchaseID,
		@CustomerID,
		GETDATE(),
		@in_SKU,
		0
		)

	--
	-- make fucking sure that you handle ALL possible combinations for SKUs here
	-- and return with select 'SUCCESS' as 'Status';
	--
	
	if(@in_SKU = 'AMZNTESTVALIDSKU') begin
		select 'SUCCESS' as 'Status';
		return;
	end

	if(@in_SKU = 'AMZ_GP5') begin
		exec FN_AlterUserGP @CustomerID, 4480, 'WO_AMAZON_BuySKU'
		select 'SUCCESS' as 'Status';
		return;
	end

	if(@in_SKU = 'AMZ_GP8')	begin
		exec FN_AlterUserGP @CustomerID, 8000, 'WO_AMAZON_BuySKU'
		select 'SUCCESS' as 'Status';
		return;
	end
	
	if(@in_SKU = 'AMZ_GP12') begin
		exec FN_AlterUserGP @CustomerID, 12000, 'WO_AMAZON_BuySKU'
		select 'SUCCESS' as 'Status';
		return;
	end

	if(@in_SKU = 'AMZ_GP16') begin
		exec FN_AlterUserGP @CustomerID, 16800, 'WO_AMAZON_BuySKU'
		select 'SUCCESS' as 'Status';
		return;
	end

	if(@in_SKU = 'AMZ_GP26') begin
		exec FN_AlterUserGP @CustomerID, 26400, 'WO_AMAZON_BuySKU'
		select 'SUCCESS' as 'Status';
		return;
	end

	if(@in_SKU = 'AMZ_GP48') begin
		exec FN_AlterUserGP @CustomerID, 48000, 'WO_AMAZON_BuySKU'
		select 'SUCCESS' as 'Status';
		return;
	end

	if(@in_SKU = 'AMZ_PK1') begin
		exec FN_AddItemToUser @CustomerID, 301001, 7
		exec FN_AddItemToUser @CustomerID, 101037, 2000
		exec FN_AlterUserGP @CustomerID, 5000, 'WO_AMAZON_BuySKU'
		select 'SUCCESS' as 'Status';
		return;
	end

	if(@in_SKU = 'AMZ_PK2') begin
		exec FN_AddItemToUser @CustomerID, 301004, 30
		exec FN_AddItemToUser @CustomerID, 20016, 2000
		exec FN_AddItemToUser @CustomerID, 101027, 2000
		exec FN_AddItemToUser @CustomerID, 101140, 2000
		select 'SUCCESS' as 'Status';
		return;
	end

	if(@in_SKU = 'AMZ_PK3') begin
		declare @out_FNResult int
		exec FN_AddItemToUser @CustomerID, 101221, 2000
		exec FN_AddItemToUser @CustomerID, 101055, 2000
		exec FN_AddItemToUser @CustomerID, 101245, 2000
		exec FN_AddItemToUser @CustomerID, 301061, 2000
		exec FN_AddItemToUser @CustomerID, 301062, 2000
		exec FN_AddItemToUser @CustomerID, 301067, 2000
		exec FN_AddItemToUser @CustomerID, 301071, 2000
		exec FN_AlterUserGP @CustomerID, 20000, 'WO_AMAZON_BuySKU'
		select 'SUCCESS' as 'Status';
		return;
	end

	
	select 'FAILURE_SKU_INVALID' as 'Status';
	return
	
END
GO
