SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_AMAZON_CheckSKU]
	@in_Address varchar(128),
	@in_SKU varchar(128)
AS
BEGIN
	SET NOCOUNT ON;

	-- this call is always valid
	select 0 as ResultCode
	
	-- need for amazon sandbox test
	if(@in_Address <> 'AMZNTESTVALIDADDRESS') 
	begin
		-- check if address is valid
		if(ISNUMERIC(@in_Address) <> 1) begin
			select 'FAILURE_ADDRESS_INVALID' as 'Status';
			return
		end
		if(not exists(select CustomerID from LoginID where CustomerID=@in_Address)) begin
			select 'FAILURE_ADDRESS_INVALID' as 'Status';
			return
		end
	end
	
	-- need for amazon sandbox test
	if(@in_SKU = 'AMZNTESTINELIGIBLESKU') begin
		select 'FAILURE_ADDRESS_NOT_ELIGIBLE' as 'Status';
		return
	end

	-- check for actual SKU
	declare @IsEnabled int = 0
	select @IsEnabled=IsEnabled from AmazonShop where SKU=@in_SKU
	if(@@ROWCOUNT = 0) begin
		select 'FAILURE_SKU_INVALID' as 'Status';
		return
	end

	if(@IsEnabled = 0) begin
		select 'FAILURE_SKU_DISABLED' as 'Status';
		return
	end
	
	select 'SUCCESS' as 'Status';
END
GO
