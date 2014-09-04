
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_ClanCreate]
	@in_CustomerID int,
	@in_ClanName nvarchar(64),
	@in_ClanNameColor int,
	@in_ClanTag nvarchar(4),
	@in_ClanTagColor int,
	@in_ClanEmblemID int,
	@in_ClanEmblemColor int
AS
BEGIN
	SET NOCOUNT ON;
	
	declare @DEFAULT_CLAN_SIZE int = 15

	-- sanity check
	declare @ClanID int = 0
	declare @Gamertag nvarchar(64)
	select @ClanID=ClanID, @Gamertag=Gamertag from LoginID where CustomerID=@in_CustomerID
	if(@ClanID > 0) begin
		select 6 as 'ResultCode', 'already have clan' as 'ResultMsg'
		return
	end
	
	-- create clan!
	insert into ClanData (
		ClanName, ClanNameColor, 
		ClanTag, ClanTagColor,
		ClanEmblemID, ClanEmblemColor,
		ClanXP,	ClanLevel, ClanGP,
		OwnerID, MaxClanMembers, NumClanMembers,
		ClanCreateDate
	) values (
		@in_ClanName, @in_ClanNameColor,
		@in_ClanTag, @in_ClanTagColor,
		@in_ClanEmblemID, @in_ClanEmblemColor,
		0,	0,	0,
		@in_CustomerID,	@DEFAULT_CLAN_SIZE,	1,
		GETDATE()
	)
	
	-- get new clanID
	select @ClanID=ClanID from ClanData where OwnerID=@in_CustomerID
	if(@@ROWCOUNT = 0) begin
		select 6 as 'ResultCode', 'clan creation failed!' as 'ResultMsg'
		return
	end
	
	-- update owner clan data
	update LoginID set ClanID=@ClanID, ClanRank=0 where CustomerID=@in_CustomerID
	
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
		1, -- CLANEVENT_Created
		99, -- Visible to all
		@in_CustomerID,
		@Gamertag
	)
	
	-- success
	select 0 as ResultCode
	
	select @ClanID as 'ClanID'
END
GO
