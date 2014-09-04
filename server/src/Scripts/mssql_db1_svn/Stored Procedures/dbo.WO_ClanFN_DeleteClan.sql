SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_ClanFN_DeleteClan]
	@in_ClanID int
AS
BEGIN
	SET NOCOUNT ON;
	
	delete from ClanData where ClanID=@in_ClanID
	delete from ClanApplications where ClanID=@in_ClanID
	delete from ClanInvites where ClanID=@in_ClanID

	update LoginID set ClanID=0 where ClanID=@in_ClanID
	
	return
END
GO
