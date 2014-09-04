SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_ClanSetLore]
	@in_CustomerID int,
	@in_Lore nvarchar(512)
AS
BEGIN
	SET NOCOUNT ON;
	
	-- clan id valudation of caller
	declare @ClanID int = 0
	declare @ClanRank int = 99
	declare @Gamertag nvarchar(64)
	select @ClanID=ClanID, @ClanRank=ClanRank, @Gamertag=Gamertag from LoginID where CustomerID=@in_CustomerID
	if(@ClanID = 0) begin
		select 6 as ResultCode, 'no clan' as ResultMsg
		return
	end
	
	-- only leader and officers can change lore
	if(@ClanRank > 1) begin
		select 23 as ResultCode, 'no permission' as ResultMsg
		return
	end
	
	update ClanData set ClanLore=@in_Lore where ClanID=@ClanID

	-- success
	select 0 as ResultCode
END
GO
