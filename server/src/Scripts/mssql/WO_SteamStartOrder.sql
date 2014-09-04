USE [gameid_v1]
GO

/****** Object:  StoredProcedure [dbo].[WO_SteamStartOrder]    Script Date: 01/10/2012 15:20:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[WO_SteamStartOrder]
	@in_IP varchar(100),
	@in_CustomerID int,
	@in_SteamID bigint,
	@in_SteamGPItemId int
AS
BEGIN
	SET NOCOUNT ON;

	declare @TotalGP int = 0
	declare @PriceUSD int = 0
	declare @ItemName nvarchar(64) = NULL
	declare @ItemCode varchar(32) = NULL
	
	if(@in_SteamGPItemId = 1000) begin
		-- HARDBOILED
		set @PriceUSD = 1499
		set @ItemName = N'Hardboiled Package'
		set @ItemCode = 'PACK_RETAIL1'
	end
	else if(@in_SteamGPItemId = 1001) begin
		-- SNAKEEATER
		set @PriceUSD = 2499
		set @ItemName = N'Snake Eater Package'
		set @ItemCode = 'PACK_RETAIL2'
	end
	else if(@in_SteamGPItemId = 1002) begin
		-- WARLORD
		set @PriceUSD = 3999
		set @ItemName = N'WARLORD Package'
		set @ItemCode = 'PACK_RETAIL3'
	end
	else if(@in_SteamGPItemId = 1003) begin
		-- COLLECTOR EDITION
		set @PriceUSD = 3499
		set @ItemName = N'Collectors Edition'
		set @ItemCode = 'PACK_COLLECTOR_EDITION'
	end
	else begin
		select 
			@TotalGP=(GP+BonusGP), @PriceUSD=PriceCentsUSD
			from SteamGPShop 
			where IsEnabled>0 and SteamGPItemId=@in_SteamGPItemId
		if (@@RowCount = 0) begin
			select 6 as ResultCode, 'no steam item found' as ResultMsg
			return
		end
	end
	
	-- store transaction
	insert into SteamGPOrders
		(CustomerID, SteamID, InitTxnTime, Price, GP, ItemCode)
		values
		(@in_CustomerID, @in_SteamID, GETDATE(), @PriceUSD, @TotalGP, @ItemCode)
	declare @OrderID int = SCOPE_IDENTITY();

	select 0 as ResultCode
	select @TotalGP as 'GP', @PriceUSD as 'PriceUSD', 
		@OrderID as 'OrderID', @ItemName as 'ItemName'
END

GO


