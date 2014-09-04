SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_ClanSetMemberRank]
	@in_CustomerID int,
	@in_MemberID int,
	@in_Rank int
AS
BEGIN
	SET NOCOUNT ON;
	
-- sanity checks
	if(@in_CustomerID = @in_MemberID) begin
		select 6 as 'ResultCode', 'can not set own rank' as 'ResultMsg'
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
	
-- validate that we can change rank

	-- only leader and officers can change ranks
	if(@ClanRank > 1) begin
		select 23 as ResultCode, 'no permission' as ResultMsg
		return
	end

	-- cant change higher rank
	if(@ClanRank > 0 and @ClanRank >= @MemberClanRank) begin
		select 6 as ResultCode, 'cant change highter rank' as ResultMsg
		return
	end
	
	if(@ClanRank > 0 and @ClanRank >= @in_Rank) begin
		select 6 as ResultCode, 'cant set same rank' as ResultMsg
		return
	end
	
-- code for changing clan ownership, owner becomes officer
	if(@ClanRank = 0 and @in_Rank = 0) begin
		update LoginID set ClanRank=1 where CustomerID=@in_CustomerID
		update ClanData set OwnerID=@in_MemberID where ClanID=@ClanID
	end
	
-- update target member
	update LoginID set ClanRank=@in_Rank where CustomerID=@in_MemberID
	
-- generate clan set rank event
	insert into ClanEvents (
		ClanID,
		EventDate,
		EventType,
		EventRank,
		Var1,
		Var2,
		Var3,
		Text1,
		Text2
	) values (
		@ClanID,
		GETDATE(),
		3, -- CLANEVENT_SetRank
		99, -- Visible to all
		@in_CustomerID,
		@in_MemberID,
		@in_Rank,
		@Gamertag,
		@MemberGamertag
	)
	
	-- TODO: send message to player about rank change
	
	-- success
	select 0 as ResultCode
END
GO
