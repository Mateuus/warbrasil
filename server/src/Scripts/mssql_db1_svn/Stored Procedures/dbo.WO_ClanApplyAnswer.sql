SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_ClanApplyAnswer]
	@in_CustomerID int,
	@in_ClanApplicationID int,
	@in_Answer int
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
	
	-- only leader and officers can answer application
	if(@ClanRank > 1) begin
		select 23 as ResultCode, 'no permission' as ResultMsg
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

-- check application

	declare @AppClanID int = 0
	declare @AppCustomerID int
	select @AppClanID=ClanID, @AppCustomerID=CustomerID	from ClanApplications where ClanApplicationID=@in_ClanApplicationID
	if(@AppClanID <> @ClanID) begin
		select 6 as ResultCode, 'bad application id' as ResultMsg
		return
	end
	
	-- mark that application as processed
	update ClanApplications set IsProcessed=1 where ClanApplicationID=@in_ClanApplicationID
	
	-- make sure that this guy isn't joined other clan somehow (race condition)
	declare @AppGamertag nvarchar(64)
	select @AppClanID=ClanID, @AppGamertag=Gamertag from LoginID where CustomerID=@AppCustomerID
	if(@AppClanID <> 0) begin
		select 21 as ResultCode, 'applicant already joined clan' as ResultMsg
		return
	end

	if(@in_Answer = 0)
	begin
		-- declined clan joining
		-- TODO: send message to player about denial

		select 0 as ResultCode
		return
	end
	
	-- accept application, join player to clan
	update ClanData set NumClanMembers=(NumClanMembers + 1) where ClanID=@ClanID
	update LoginID set ClanID=@ClanID, ClanRank=99 where CustomerID=@AppCustomerID
	
	-- clear all other applications
	delete from ClanApplications where CustomerID=@AppCustomerID

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
		99, -- Visible to all
		@AppCustomerID,
		@AppGamertag
	)
	
	select 0 as ResultCode
	return

END
GO
