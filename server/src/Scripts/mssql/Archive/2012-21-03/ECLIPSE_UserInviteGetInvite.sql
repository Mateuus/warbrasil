USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[ECLIPSE_UserInviteGetInvite]    Script Date: 03/25/2011 15:02:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ECLIPSE_UserInviteGetInvite]
	@in_CustomerID int,
	@in_Email varchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	declare @UsedInvites as int
	SELECT @UsedInvites=COUNT(*) FROM InviteCodes where ReferralID=@in_CustomerID
	if(@UsedInvites >= 5) begin
		-- all invites already used
		select 1 as 'ResultCode', '' as 'InviteCode'
		return
	end
	
	-- see if that user already got invite
	if exists (SELECT * from InviteCodes where SentToEmail=@in_Email) begin
		select 2 as 'ResultCode', '' as 'InviteCode'
		return
	end
	
	-- firstly, get free invite
	declare @InviteCode varchar(64)
	SELECT TOP(1) @InviteCode=invitecode FROM InviteCodes 
		where (IsSent=0 and ReferralID=0 and MultiUsesMax=0)
	if(@@ROWCOUNT = 0) begin
		-- there is no free invites
		select 3 as 'ResultCode', '' as 'InviteCode'
		return
	end
	
	-- mark that we used this code
	UPDATE InviteCodes SET
		IsSent=1,
		SentToEmail=@in_Email,
		SendDate=GETDATE(),
		ReferralID=@in_CustomerID
	WHERE invitecode=@InviteCode
	
	select 0 as 'ResultCode', @InviteCode as 'InviteCode'
	return
		
END
