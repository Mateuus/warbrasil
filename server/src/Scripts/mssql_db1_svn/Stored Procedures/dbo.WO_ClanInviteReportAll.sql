SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_ClanInviteReportAll]
	@in_CustomerID int
AS
BEGIN
	SET NOCOUNT ON;

-- sanity checks

	-- clan id valudation of caller
	declare @ClanID int = 0
	declare @ClanRank int
	declare @Gamertag nvarchar(64)
	select @ClanID=ClanID, @ClanRank=ClanRank, @Gamertag=Gamertag from LoginID where CustomerID=@in_CustomerID
	if(@ClanID = 0) begin
		select 6 as ResultCode, 'no clan' as ResultMsg
		return
	end
	
-- validate that we can invite

	-- only leader and officers can invite
	if(@ClanRank > 1) begin
		select 6 as ResultCode, 'no permission' as ResultMsg
		return
	end

-- report all pending invites

	-- success
	select 0 as ResultCode
	
	select 
		i.ClanInviteID, 
		l.Gamertag, 
		DATEDIFF(mi, GETDATE(), i.ExpireTime) as MinutesLeft
	from ClanInvites i
	join LoginID l on (l.CustomerID=i.CustomerID)
	where i.ClanID=@ClanID and GETDATE()<ExpireTime
	
	return
END
GO
