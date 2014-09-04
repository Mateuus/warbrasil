SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_SRV_AddWeaponStats] 
	@in_ItemID int,
	@in_ShotsFired int,
	@in_ShotsHits int,
	@in_KillsCQ int,
	@in_KillsDM int,
	@in_KillsSB int
AS
BEGIN
	SET NOCOUNT ON;

	update Items_Weapons set
		ShotsFired=(ShotsFired + @in_ShotsFired),
		ShotsHits=(ShotsHits + @in_ShotsHits),
		KillsCQ=(KillsCQ + @in_KillsCQ),
		KillsDM=(KillsDM + @in_KillsDM),
		KillsSB=(KillsSB + @in_KillsSB)
	where ItemID=@in_ItemID

	-- we're done
	select 0 as ResultCode

END
GO
