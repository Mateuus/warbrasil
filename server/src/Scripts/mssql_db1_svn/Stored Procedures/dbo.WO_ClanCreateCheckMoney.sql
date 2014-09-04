
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_ClanCreateCheckMoney]
	@in_CustomerID int
AS
BEGIN
	SET NOCOUNT ON;

	-- detect if user CAN create clan	
	declare @HonorPoints int = 0
	select @HonorPoints=HonorPoints from LoginID where CustomerID=@in_CustomerID
	
	declare @Rank int = 0
	select top(1) @Rank=rank from DataRankPoints where @HonorPoints<DataRankPoints.HonorPoints order by HonorPoints asc
	
	-- this call is always valid
	select 0 as ResultCode
	
	if(@Rank >= 45)
		select 0 as NeedMoney
	else
		select 1 as NeedMoney

	return
END
GO
