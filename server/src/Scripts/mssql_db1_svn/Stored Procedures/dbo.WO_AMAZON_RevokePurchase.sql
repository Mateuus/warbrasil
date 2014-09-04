SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_AMAZON_RevokePurchase]
	@in_PurchaseId varchar(128)
AS
BEGIN
	SET NOCOUNT ON;

	-- this call is always valid
	select 0 as ResultCode
	
	-- search for transaction
	declare @CustomerID int = 0
	declare @IsRevoked int = 0
	select @CustomerID=CustomerID, @IsRevoked=IsRevoked from AmazonPurchases where PurchaseId=@in_PurchaseId
	if(@@ROWCOUNT = 0) begin
		select 'FAILURE_PURCHASE_INVALID' as 'Status';
		return
	end
	if(@IsRevoked > 0) begin
		select 'FAILURE_ALREADY_REVOKED' as 'Status';
		return
	end

	update AmazonPurchases set IsRevoked=1 where PurchaseId=@in_PurchaseId
	
	-- and ban that sucker
	update LoginID set AccountStatus=200 where CustomerID=@CustomerID
	update AccountInfo set admin_note=admin_note+' AmazonRevoke' where CustomerID=@CustomerID

	select 'SUCCESS' as 'Status';
	return
END
GO
