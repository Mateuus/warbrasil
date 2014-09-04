
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_ClanApplyToJoin]
	@in_CustomerID int,
	@in_ClanID int,
	@in_ApplicationText nvarchar(500)
AS
BEGIN
	SET NOCOUNT ON;

	declare @APPLY_EXPIRE_TIME_HOURS int = 72
	declare @MAX_PENDING_APPS int = 5	-- can be maximum 5 pending invitations
	
-- sanity checks

	-- player must be without clan
	declare @PlayerClanID int = 0
	select @PlayerClanID=ClanID from LoginID where CustomerID=@in_CustomerID
	if(@PlayerClanID > 0) begin
		select 6 as ResultCode, 'already in clan' as ResultMsg
		return
	end

	-- make sure clan exists
	if not exists (select ClanID from ClanData where ClanID=@in_ClanID) begin
		select 6 as ResultCode, 'no clanid' as ResultMsg
		return
	end
	
	-- see if we already have pending invidation
	declare @AppExpireTime datetime
	select @AppExpireTime=ExpireTime from ClanApplications where ClanID=@in_ClanID and CustomerID=@in_CustomerID and GETDATE()<ExpireTime
	if(@@ROWCOUNT > 0) begin
		select 24 as ResultCode, 'pending application' as ResultMsg
		return
	end
	
	-- see if we already have too much applications
	declare @AppTotalCounts int = 0
	select @AppTotalCounts=COUNT(*) from ClanApplications where CustomerID=@in_CustomerID and GETDATE()<ExpireTime
	if(@AppTotalCounts >= @MAX_PENDING_APPS) begin
		select 25 as ResultCode, 'too many applications' as ResultMsg
		return 
	end
	
-- send application

	insert into ClanApplications (
		ClanID,
		CustomerID,
		ExpireTime,
		ApplicationText,
		IsProcessed
	) values (
		@in_ClanID,
		@in_CustomerID,
		DATEADD(hour, @APPLY_EXPIRE_TIME_HOURS, GETDATE()),
		@in_ApplicationText,
		0
	)

	-- success
	select 0 as ResultCode
	return
	
END
GO
