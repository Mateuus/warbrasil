SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_ClanGetPlayerData]
	@in_CustomerID int
AS
BEGIN
	SET NOCOUNT ON;

	-- success
	select 0 as ResultCode
	
	-- report player clan id and current clan info
	select l.ClanID, ClanRank, cd.*
		from LoginID l
		left join ClanData cd on cd.ClanID=l.ClanID
		where CustomerID=@in_CustomerID

	return
END
GO
