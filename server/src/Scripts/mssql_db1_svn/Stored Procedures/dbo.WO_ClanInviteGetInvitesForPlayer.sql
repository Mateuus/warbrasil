SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_ClanInviteGetInvitesForPlayer]
	@in_CustomerID int
AS
BEGIN
	SET NOCOUNT ON;

-- report all pending invites

	select 0 as ResultCode
	
	select 
		i.ClanInviteID,
		l.Gamertag, 
		c.*
	from ClanInvites i
	join LoginID l on (l.CustomerID=i.InviterID)
	join ClanData c on (c.ClanID=i.ClanID)
	where i.CustomerID=@in_CustomerID and GETDATE()<ExpireTime
	
	return
END
GO
