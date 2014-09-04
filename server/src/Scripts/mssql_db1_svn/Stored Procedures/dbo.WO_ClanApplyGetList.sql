
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[WO_ClanApplyGetList]
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
	
-- give list of applyers

	-- only leader and officers can view application list
	if(@ClanRank > 1) begin
		select 6 as ResultCode, 'no permission' as ResultMsg
		return
	end

	-- success
	select 0 as ResultCode
	
	select 
		a.ClanApplicationID,
		a.ApplicationText,
		l.Gamertag,
		DATEDIFF(mi, GETDATE(), a.ExpireTime) as MinutesLeft,
		l.HonorPoints,
		s.Kills,
		s.Deaths,
		s.Wins,
		s.Losses,
		s.TimePlayed
	from ClanApplications a
	join LoginID l on (l.CustomerID=a.CustomerID)
	join Stats s on (s.CustomerID=a.CustomerID)
	where a.ClanID=@ClanID and GETDATE()<ExpireTime and IsProcessed=0
	
	return
	
END

GO
