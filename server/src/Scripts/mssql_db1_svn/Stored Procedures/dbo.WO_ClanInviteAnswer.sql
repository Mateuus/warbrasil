SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_ClanInviteAnswer]
	@in_CustomerID int,
	@in_ClanInviteID int,
	@in_Answer int
AS
BEGIN
	SET NOCOUNT ON;

-- sanity checks

	-- must be free to join clan
	declare @ClanID int = 0
	declare @Gamertag nvarchar(64)
	select @ClanID=ClanID, @Gamertag=Gamertag from LoginID where CustomerID=@in_CustomerID
	if(@ClanID <> 0) begin
		select 6 as ResultCode, 'already in clan' as ResultMsg
		return
	end
	
	-- have valid invitation id (get actual ClanID here)
	declare @InvCustomerID int
	select @ClanID=ClanID, @InvCustomerID=CustomerID from ClanInvites where ClanInviteID=@in_ClanInviteID
	if(@@ROWCOUNT = 0) begin
		select 6 as ResultCode, 'bad inviteid #1' as ResultMsg
		return
	end
	if(@InvCustomerID <> @in_CustomerID) begin
		select 6 as ResultCode, 'bad inviteid #2' as ResultMsg
		return
	end

-- invite

	-- delete invite anyway
	delete from ClanInvites where ClanInviteID=@in_ClanInviteID
	
	-- check if invite is denied
	if(@in_Answer = 0) begin
		select 0 as ResultCode
		select @ClanID as ClanID
		return
	end

	-- check if we have enough slots in clan
	declare @MaxClanMembers int
	declare @NumClanMembers int
	select @MaxClanMembers=MaxClanMembers, @NumClanMembers=NumClanMembers from ClanData where ClanID=@ClanID
	if(@NumClanMembers >= @MaxClanMembers) begin
		select 20 as 'ResultCode', 'not enough slots' as ResultMsg
		return
	end
	
	-- join the clan!
	update ClanData set NumClanMembers=(NumClanMembers + 1) where ClanID=@ClanID
	update LoginID set ClanID=@ClanID, ClanRank=99 where CustomerID=@in_CustomerID

-- generate clan event
	insert into ClanEvents (
		ClanID,
		EventDate,
		EventType,
		EventRank,
		Var1,
		Text1
	) values (
		@ClanID,
		GETDATE(),
		4, -- CLANEvent_Join
		99, -- Visible to officers
		@in_CustomerID,
		@Gamertag
	)
	
	-- success
	select 0 as ResultCode
	select @ClanID as ClanID
END
GO
