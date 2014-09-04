
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_ClanLeave]
	@in_CustomerID int
AS
BEGIN
	SET NOCOUNT ON;
	
-- sanity checks
	declare @ClanID int
	declare @ClanRank int
	declare @Gamertag nvarchar(64)
	select @ClanID=ClanID, @ClanRank=ClanRank, @Gamertag=Gamertag from LoginID where CustomerID=@in_CustomerID
	if(@ClanID = 0) begin
		select 6 as ResultCode, 'no clan' as ResultMsg
		return
	end
	
-- leader is leaving clan	
	if(@ClanRank = 0) 
	begin
		declare @NumClanMembers int
		select @NumClanMembers=COUNT(*) from LoginID where ClanID=@ClanID
		if(@NumClanMembers > 1) begin
			select 6 as ResultCode, 'owner cant leave - there is people left in clan' as ResultMsg
			return
		end

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
			99, -- CLANEvent_Disband
			99, -- Visible to all
			@in_CustomerID,
			@Gamertag
		)
		
		-- and delete clan
		exec WO_ClanFN_DeleteClan @ClanID
		
		select 0 as ResultCode
		return
	end

	-- actual leave
	update LoginID set ClanID=0, ClanContributedGP=0, ClanContributedXP=0 where CustomerID=@in_CustomerID
	update ClanData set NumClanMembers=(NumClanMembers - 1) where ClanID=@ClanID

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
		5, -- CLANEvent_Left
		99, -- Visible to all
		@in_CustomerID,
		@Gamertag
	)
	
	-- success
	select 0 as ResultCode
END
GO
