SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[ECLIPSE_MatomyDoConversion]
	@in_CustomerID int
AS
BEGIN
	SET NOCOUNT ON;
	
	declare @ce_pub varchar(32)
	declare @ce_cid varchar(64)
	declare @IsConverted int
	select 
		@ce_pub=ce_pub,
		@ce_cid=ce_cid,
		@IsConverted=IsConverted
	from MatomyUserMap where CustomerID=@in_CustomerID
	
	if(@@ROWCOUNT = 0) begin
		-- not matomy user
		select 1 as ResultCode, '' as ce_pub, '' as ce_cid
		return
	end
	
	if(@IsConverted > 0) begin
		-- already converted
		select 2 as ResultCode, '' as ce_pub, '' as ce_cid
		return
	end

	update MatomyUserMap set IsConverted=1, DateConverted=GETDATE() 
		where CustomerID=@in_CustomerID

	-- converted
	select 0 as ResultCode, @ce_pub as ce_pub, @ce_cid as ce_cid
END

GO
