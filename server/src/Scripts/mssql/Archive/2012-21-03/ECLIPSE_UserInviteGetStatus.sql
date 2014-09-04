USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[ECLIPSE_UserInviteGetStatus]    Script Date: 03/24/2011 16:56:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ECLIPSE_UserInviteGetStatus] 
	@in_CustomerID int
AS
BEGIN
	SET NOCOUNT ON;

	select email from AccountInfo where CustomerID=@in_CustomerID
	select TOP(10) * FROM InviteCodes where ReferralID=@in_CustomerID ORDER BY Used DESC
END
