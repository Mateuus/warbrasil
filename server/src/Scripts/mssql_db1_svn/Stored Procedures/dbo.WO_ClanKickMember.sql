
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_ClanKickMember]
	@in_CustomerID int,
	@in_MemberID int
AS
BEGIN
	SET NOCOUNT ON;
	
-- sanity checks
	if(@in_CustomerID = @in_MemberID) begin
		select 6 as 'ResultCode', 'cant kick himselft' as 'ResultMsg'
		return
	end

	-- clan id valudation of caller
	declare @ClanID int = 0
	declare @ClanRank int
	declare @Gamertag nvarchar(64)
	select @ClanID=ClanID, @ClanRank=ClanRank, @Gamertag=Gamertag from LoginID where CustomerID=@in_CustomerID
	if(@ClanID = 0) begin
		select 6 as ResultCode, 'no clan' as ResultMsg
		return
	end
	
	-- clan id validation of member
	declare @MemberClanID int = 0
	declare @MemberGamerTag nvarchar(64)
	declare @MemberClanRank int
	select @MemberClanID=ClanID, @MemberClanRank=ClanRank, @MemberGamerTag=GamerTag from LoginID where CustomerID=@in_MemberID
	if(@MemberClanID <> @ClanID) begin
		select 6 as ResultCode, 'member in wrong clan' as ResultMsg
		return
	end
	
-- validate that we can kick

	-- only leader and officers can kick
	if(@ClanRank > 1) begin
		select 23 as ResultCode, 'no permission' as ResultMsg
		return
	end

	-- cant kick higher rank
	if(@ClanRank > 0 and @ClanRank >= @MemberClanRank) begin
		select 6 as ResultCode, 'cant kick highter rank' as ResultMsg
		return
	end
	
-- update clan info and kick player
	update ClanData set NumClanMembers=(NumClanMembers-1) where ClanID=@ClanID
	update LoginID set ClanID=0, ClanContributedGP=0, ClanContributedXP=0 where CustomerID=@in_MemberID
	
-- generate clan event
	insert into ClanEvents (
		ClanID,
		EventDate,
		EventType,
		EventRank,
		Var1,
		Var2,
		Text1,
		Text2
	) values (
		@ClanID,
		GETDATE(),
		6, -- CLANEvent_Kick
		99, -- Visible to all
		@in_CustomerID,
		@in_MemberID,
		@Gamertag,
		@MemberGamertag
	)
	
	-- TODO: send message to player about kick
	
	-- success
	select 0 as ResultCode
END
GO
