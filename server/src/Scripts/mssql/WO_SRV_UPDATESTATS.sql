USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_SRV_UPDATESTATS]    Script Date: 03/11/2011 13:40:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_SRV_UPDATESTATS] 
	@in_IP char(32),
	@in_CustomerID int, 
	@in_skey2 varchar(64),

	@GamePoints int,
	@HonorPoints int,
	@SkillPoints int,
	@Kills int,
	@Deaths int,
	@ShotsFired int,
	@ShotsHits int,
	@Headshots int,
	@AssistKills int,
	@Wins int,
	@Losses int,
	@CaptureNeutralPoints int,
	@CaptureEnemyPoints int,
	@TimePlayed int
AS
BEGIN
	SET NOCOUNT ON;

	if(@in_skey2 != 'ACsR4x23GsjYU*476xnDvYXK@!56')
	begin
		EXEC FN_ADD_SECURITY_LOG 171, @in_IP, 0, @in_skey2
		select 6 as ResultCode
		return;
	end

	-- check if CustomerID is valid
	if not exists (SELECT CustomerID FROM LoginID WHERE CustomerID=@in_CustomerID)
	begin
		EXEC FN_ADD_SECURITY_LOG 170, @in_IP, 0, @in_CustomerID
		select 6 as ResultCode
		return;
	end
	
	-- update
	select 0 as ResultCode

	UPDATE Stats SET 
		Kills=@Kills, 
		Deaths=@Deaths, 
		ShotsFired=@ShotsFired, 
		ShotsHits=@ShotsHits, 
		Headshots=@Headshots, 
		AssistKills=@AssistKills, 
		Wins=@Wins, 
		Losses=@Losses, 
		CaptureNeutralPoints=@CaptureNeutralPoints, 
		CaptureEnemyPoints=@CaptureEnemyPoints, 
		TimePlayed=@TimePlayed 
	where CustomerID=@in_CustomerID
	
	UPDATE LoginID SET 
		GamePoints=@GamePoints, 
		HonorPoints=@HonorPoints, 
		SkillPoints=@SkillPoints, 
		lastgamedate=GETDATE()  
	where CustomerID=@in_CustomerID
	    
END
