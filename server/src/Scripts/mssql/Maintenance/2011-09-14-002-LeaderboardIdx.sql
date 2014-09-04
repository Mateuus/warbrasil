USE [gameid_v1]
GO
drop index IX_DBG_UserRoundResults_LBIdx1 on DBG_UserRoundResults

CREATE NONCLUSTERED INDEX [IX_DBG_UserRoundResults_LBIdx1]
ON [dbo].[DBG_UserRoundResults] ([GameReportTime])
INCLUDE ([CustomerID],[HonorPoints],[Kills],[Deaths],[ShotsFired],[ShotsHits],[Wins],[Losses],[TimePlayed])
GO
