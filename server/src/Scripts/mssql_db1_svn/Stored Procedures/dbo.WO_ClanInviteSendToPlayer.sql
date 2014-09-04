SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_ClanInviteSendToPlayer]
	@in_CustomerID int,
	@in_InvGamertag nvarchar(64)
AS
BEGIN
	SET NOCOUNT ON;

	declare @INVITE_EXPIRE_TIME_HOURS int = 80
	
-- sanity checks

	-- clan id valudation of caller
	declare @ClanID int = 0
	declare @ClanRank int
	declare @Gamertag nvarchar(64)
	select @ClanID=ClanID, @ClanRank=ClanRank, @Gamertag=Gamertag from LoginID where CustomerID=@in_CustomerID
	if(@ClanID = 0) begin
		select 6 as ResultCode, 'not in clan' as ResultMsg
		return
	end
	
-- validate that we can invite

	-- only leader and officers can invite
	if(@ClanRank > 1) begin
		select 23 as ResultCode, 'no permission' as ResultMsg
		return
	end
	
	-- check if we have enough slots in clan
	declare @MaxClanMembers int
	declare @NumClanMembers int
	select @MaxClanMembers=MaxClanMembers, @NumClanMembers=NumClanMembers from ClanData where ClanID=@ClanID
	
	declare @PendingInvites int = 0
	--DISABLED FOR NOW: select @PendingInvites=COUNT(*) from ClanInvites where ClanID=@ClanID and GETDATE()<ExpireTime
	if((@NumClanMembers + @PendingInvites) >= @MaxClanMembers) begin
		select 20 as 'ResultCode', 'not enough slots' as ResultMsg
		return
	end

	-- check if user exists	
	declare @InvCustomerID int
	declare @InvClanID int
	select @InvCustomerID=CustomerID, @InvClanID=ClanID from LoginID where Gamertag=@in_InvGamertag
	if(@@ROWCOUNT = 0) begin
		select 22 as ResultCode, 'no such gamertag' as ResultMsg
		return
	end
	-- and have no clan
	if(@InvClanID <> 0) begin
		select 21 as ResultCode, 'already in clan' as ResultMsg
		return
	end
	
	-- check if we have pending invite
	if(exists(select * from ClanInvites where ClanID=@ClanID and CustomerID=@InvCustomerID and GETDATE()<ExpireTime)) begin
		select 24 as ResultCode, 'already invited' as ResultMsg
		return
	end
	
-- invite
	insert into ClanInvites (
		ClanID,
		InviterID,
		CustomerID,
		ExpireTime
	) values (
		@ClanID,
		@in_CustomerID,
		@InvCustomerID,
		DATEADD(hour, @INVITE_EXPIRE_TIME_HOURS, GETDATE())
	)

	-- success
	select 0 as ResultCode
END
GO
