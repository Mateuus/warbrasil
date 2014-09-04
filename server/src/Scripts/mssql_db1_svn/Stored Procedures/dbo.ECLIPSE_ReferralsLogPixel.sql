
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ECLIPSE_ReferralsLogPixel]
	@in_CustomerID int,
	@in_ReferralID int,
	@in_PixelUrl varchar(128),
	@in_ErrorMsg varchar(128)
AS
BEGIN
	SET NOCOUNT ON;

	select 0 as ResultCode
	
	insert into DBG_RefPixelLog
		(CustomerID, ReferralID, PixelUrl, PixelCallTime, ErrorMsg)
		values
		(@in_CustomerID, @in_ReferralID, @in_PixelUrl, GETDATE(), @in_ErrorMsg)

	return
END



GO
