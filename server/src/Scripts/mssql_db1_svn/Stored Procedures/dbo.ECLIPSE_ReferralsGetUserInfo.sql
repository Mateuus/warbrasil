SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ECLIPSE_ReferralsGetUserInfo]
	@in_CustomerID int
AS
BEGIN
	SET NOCOUNT ON;

	select 0 as ResultCode
	
	declare @ReferralID int = 0
	declare @reg_sid varchar(128) = ''
	select @ReferralID=ReferralID, @reg_sid=reg_sid from LoginID where CustomerID=@in_CustomerID
	
	-- TODO: (think) check DBG_RefPixelLog to avoid double pixel firing?
	
	select @ReferralID as 'ReferralID', @reg_sid as 'reg_sid'
END



GO
