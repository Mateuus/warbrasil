
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_ClanGetInfo]
	@in_ClanID int,
	@in_GetMembers int
AS
BEGIN
	SET NOCOUNT ON;

	-- success
	select 0 as ResultCode
	
	-- and report clan data
	if(@in_ClanID > 0)
		select *, LoginID.gamertag from ClanData 
			left join LoginID on loginid.customerid=ClanData.OwnerID
			where ClanData.ClanID=@in_ClanID
	else
		select *, LoginID.gamertag from ClanData
			left join LoginID on loginid.customerid=ClanData.OwnerID
		
	-- if need to report members
	if(@in_ClanID > 0 and @in_GetMembers > 0) begin
		select LoginID.*, Stats.* 
			from LoginID
			join Stats on Stats.CustomerID=LoginID.CustomerID
			where ClanID=@in_ClanID
	end

	return
END
GO
