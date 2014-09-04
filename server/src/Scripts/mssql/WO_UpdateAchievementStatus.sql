USE [gameid_v1]
GO

/****** Object:  StoredProcedure [dbo].[WO_UpdateAchievementStatus]    Script Date: 02/16/2012 11:02:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[WO_UpdateAchievementStatus]
	@in_CustomerID int,
	@in_AchID int,
	@in_AchValue int,
	@in_AchUnlocked int
AS
BEGIN
	SET NOCOUNT ON;

	if not exists (select * from Achievements where (AchID=@in_AchID and CustomerID=@in_CustomerID))
	begin
		INSERT INTO Achievements(
			CustomerID, 
			AchID, 
			Value, 
			Unlocked
		)
		VALUES (
			@in_CustomerID,
			@in_AchID,
			@in_AchValue,
			@in_AchUnlocked
		)
	end
	else
	begin
		UPDATE Achievements SET 
			Value=@in_AchValue,
			Unlocked=@in_AchUnlocked
		WHERE AchID=@in_AchID and CustomerID=@in_CustomerID
    end

    select 0 as ResultCode
    
    -- check for steamID
    declare @SteamID bigint = 0
	select @SteamID=SteamID from SteamUserIDMap where CustomerID=@in_CustomerID
	select @SteamID as 'SteamID'
	
END

GO


