USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_SteamFinishOrder]    Script Date: 07/07/2011 20:37:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_SteamFinishOrder]
	@in_IP varchar(100),
	@in_CustomerID int,
	@in_OrderID bigint,
	@in_transid varchar(64)
AS
BEGIN
	SET NOCOUNT ON;

	declare @TotalGP int
	declare @PriceUSD float
	declare @ItemCode varchar(32)
			
	select @PriceUSD=Price, @TotalGP=GP, @ItemCode=ItemCode
		from SteamGPOrders 
		where OrderID=@in_OrderID and CustomerID=@in_CustomerID
	if (@@RowCount = 0) begin
		select 7 as ResultCode, 'no order found' as ResultMsg
		return
	end
	
	set @PriceUSD = @PriceUSD / 100;	-- convert from cents to dollars
	
	-- clear that order
	delete from SteamGPOrders where OrderID=@in_OrderID and CustomerID=@in_CustomerID
	
	select @ItemCode
	-- special case for predefined packages
	if(@ItemCode is not NULL) 
	begin
		declare @tr_date varchar(32) = GETDATE()
	
		exec ECLIPSE_PROCESSTRANSACTION
			@in_transid,
			@in_CustomerID,
			@tr_date,
			@PriceUSD,
			'STEAM',
			'APPROVED',
			@ItemCode,
			'SJFei937cjsjf029sdkWccYY9';
	end
	else
	begin
		-- insert to table
		declare @ItemName varchar(100) = convert(varchar(50), @TotalGP) + ' GP'
		INSERT INTO FinancialTransactions VALUES (
			@in_CustomerID, 
			@in_transid, 
			1000, 
			GETDATE(), 
			@PriceUSD, 
			'STEAM', 
			'APPROVED', 
			@ItemName)
		
		-- increate GP
		declare @GamePoints int = 0
		update LoginID set GamePoints=(GamePoints+@TotalGP) where CustomerID=@in_CustomerID
	end
	
	select @GamePoints=GamePoints from LoginID where CustomerID=@in_CustomerID
	
	-- report balance
	select 0 as ResultCode
	select @GamePoints as 'Balance'
END
