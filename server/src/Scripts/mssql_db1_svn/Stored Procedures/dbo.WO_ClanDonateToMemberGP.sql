
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_ClanDonateToMemberGP]
	@in_CustomerID int,
	@in_GP int,
	@in_MemberID int
AS
BEGIN
	SET NOCOUNT ON;
	
-- sanity checks

	-- clan id valudation of caller
	declare @ClanID int
	declare @ClanRank int
	declare @Gamertag nvarchar(64)
	declare @GamePoints int
	select @ClanID=ClanID, @ClanRank=ClanRank, @Gamertag=Gamertag, @GamePoints=GamePoints from LoginID where CustomerID=@in_CustomerID
	if(@ClanID = 0) begin
		select 6 as ResultCode, 'not in clan' as ResultMsg
		return
	end
	
	-- clan id validation of member
	declare @MemberClanID int = 0
	declare @MemberGamerTag nvarchar(64)
	select @MemberClanID=ClanID, @MemberGamerTag=GamerTag from LoginID where CustomerID=@in_MemberID
	if(@MemberClanID <> @ClanID) begin
		select 6 as ResultCode, 'member in wrong clan' as ResultMsg
		return
	end
	
-- donating
	if(@ClanRank > 0) begin
		select 23 as ResultCode, 'no permission' as ResultMsg
		return
	end
	
	declare @ClanGP int = 0
	select @ClanGP=ClanGP from ClanData where ClanID=@ClanID
	if(@in_GP < 0) begin
		select 6 as ResultCode, 'sneaky bastard...' as ResultMsg
		return
	end
	if(@in_GP > @ClanGP) begin
		select 6 as ResultCode, 'not enough GP in clan' as ResultMsg
		return
	end

	-- substract GP from clan
	update ClanData set ClanGP=(ClanGP-@in_GP) where ClanID=@ClanID

	-- add member gp
	exec FN_AlterUserGP @in_MemberID, @in_GP, 'fromclan'
	-- and record that
	INSERT INTO FinancialTransactions
		VALUES (@in_MemberID, 'CLAN_GPToMember', 4001, GETDATE(), 
				@in_GP, '1', 'APPROVED', @ClanID)
	
-- generate clan event
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
		11, -- CLANEvent_DonateToMemberGP
		1, -- Visible to officers
		@in_CustomerID,
		@in_MemberID,
		@in_GP,
		@Gamertag,
		@MemberGamertag
	)
	
-- TODO: send message to player about donate

	-- success
	select 0 as ResultCode
END
GO
