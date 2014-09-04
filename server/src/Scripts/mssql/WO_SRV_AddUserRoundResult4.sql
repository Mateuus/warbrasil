USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_SRV_AddUserRoundResult4]    Script Date: 03/22/2012 17:02:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Pavel Tumik
-- Create date: May 29, 2011
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[WO_SRV_AddUserRoundResult4] 
	@in_IP char(32),
	@in_CustomerID int,
	@in_GameSessionID bigint,
	@in_skey2 varchar(64),

	@in_MapID int,
	@in_MapType int = 99,
	@in_TeamID int,
	@in_GamePoints int,
	@in_GameDollars int,
	@in_HonorPoints int,
	@in_SkillPoints int,
	@in_Kills int,
	@in_Deaths int,
	@in_ShotsFired int,
	@in_ShotsHits int,
	@in_Headshots int,
	@in_AssistKills int,
	@in_Wins int,
	@in_Losses int,
	@in_CaptureNeutralPoints int,
	@in_CaptureEnemyPoints int,
	@in_TimePlayed int,
	@in_LevelUpMin int,
	@in_LevelUpMax int
AS
BEGIN
	SET NOCOUNT ON;

	if(@in_skey2 != 'ACsR4x23GsjYU*476xnDvYXK@!56')
	begin
		EXEC FN_ADD_SECURITY_LOG 171, @in_IP, 0, @in_skey2
		select 6 as ResultCode
		return;
	end

	declare @GamePoints int = 0
	declare @GameDollars int = 0
	declare @HonorPoints int = 0
	declare @SkillPoints int = 0
	declare @Kills int = 0
	declare @Deaths int = 0
	declare @ShotsFired int = 0
	declare @ShotsHits int = 0
	declare @Headshots int = 0
	declare @AssistKills int = 0
	declare @Wins int = 0
	declare @Losses int = 0
	declare @CaptureNeutralPoints int = 0
	declare @CaptureEnemyPoints int = 0
	declare @TimePlayed int = 0
	
	declare @RefferalID int

	-- get current data#1 from player info
	SELECT
		@GamePoints=GamePoints, 
		@GameDollars=GameDollars,
		@HonorPoints=HonorPoints, 
		@SkillPoints=SkillPoints,
		@RefferalID=ReferralID
	FROM LoginID
	WHERE CustomerID=@in_CustomerID
	-- fail if CustomerID is valid
	if @@ROWCOUNT = 0 begin
		EXEC FN_ADD_SECURITY_LOG 170, @in_IP, 0, @in_CustomerID
		select 6 as ResultCode
		return;
	end

	-- get current data#2 from player info
	SELECT
		@Kills=Kills, 
		@Deaths=Deaths, 
		@ShotsFired=ShotsFired, 
		@ShotsHits=ShotsHits, 
		@Headshots=Headshots, 
		@AssistKills=AssistKills, 
		@Wins=Wins, 
		@Losses=Losses, 
		@CaptureNeutralPoints=CaptureNeutralPoints, 
		@CaptureEnemyPoints=CaptureEnemyPoints, 
		@TimePlayed=TimePlayed 
	FROM Stats
	WHERE CustomerID=@in_CustomerID
	
	-- store for debug	
	INSERT INTO DBG_UserRoundResults VALUES (
		@in_IP,
		@in_GameSessionID,
		@in_CustomerID,
		@in_GamePoints,
		@in_HonorPoints,
		@in_SkillPoints,
		@in_Kills,
		@in_Deaths,
		@in_ShotsFired,
		@in_ShotsHits,
		@in_Headshots,
		@in_AssistKills,
		@in_Wins,
		@in_Losses,
		@in_CaptureNeutralPoints,
		@in_CaptureEnemyPoints,
		@in_TimePlayed,
		GETDATE(),	
		@in_GameDollars,
		@in_TeamID,
		@in_MapID,
		@in_MapType
	)

	-- update
	UPDATE Stats SET 
		Kills=(@Kills + @in_Kills), 
		Deaths=(@Deaths + @in_Deaths), 
		ShotsFired=(@ShotsFired + @in_ShotsFired),
		ShotsHits=(@ShotsHits + @in_ShotsHits), 
		Headshots=(@Headshots + @in_Headshots), 
		AssistKills=(@AssistKills + @in_AssistKills), 
		Wins=(@Wins + @in_Wins), 
		Losses=(@Losses + @in_Losses), 
		CaptureNeutralPoints=(@CaptureNeutralPoints + @in_CaptureNeutralPoints), 
		CaptureEnemyPoints=(@CaptureEnemyPoints + @in_CaptureEnemyPoints), 
		TimePlayed=(@TimePlayed + @in_TimePlayed)
	where CustomerID=@in_CustomerID
	
	UPDATE LoginID SET 
		GamePoints=(@GamePoints + @in_GamePoints), 
		GameDollars=(@GameDollars + @in_GameDollars),
		HonorPoints=(@HonorPoints + @in_HonorPoints), 
		SkillPoints=(@SkillPoints + @in_SkillPoints), 
		lastgamedate=GETDATE()  
	where CustomerID=@in_CustomerID

	-- level up bonuses
	declare @newLevel int;
	set @newLevel = @in_LevelUpMin+1;
	WHILE(@newLevel <= @in_LevelUpMax)
	BEGIN
		insert into DBG_LevelUpEvents (CustomerID, LevelGained, ReportTime, SessionID) 
			VALUES (@in_CustomerID, @newLevel, GETDATE(), @in_GameSessionID)

		exec FN_LevelUpBonus @in_CustomerID, @newLevel
		
		if(@newLevel = 10) begin
			exec FN_GiveReferrerReward @RefferalID, @in_CustomerID
		end
		
		set @newLevel = (@newLevel+1);
	END
	
	-- faction bonus
	exec WO_FactionAddRoundResult @in_CustomerID, @in_MapID, @in_TeamID, @in_Wins

	-- we're done
	select 0 as ResultCode
	
END
