SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_ClanGetEvents]
	@in_CustomerID int,
	@in_Days int
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
	
-- report clan log
	select 0 as ResultCode
	
	declare @MinDate datetime = DATEADD(day, -@in_Days, GETDATE())
	select * from ClanEvents where ClanID=@ClanID and EventDate>=@MinDate and @ClanRank <= EventRank order by EventDate asc
	
	return
END
GO
