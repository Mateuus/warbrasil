CREATE TABLE [dbo].[DBG_UserRoundResults]
(
[IP] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[GameSessionID] [bigint] NOT NULL CONSTRAINT [DF_GameResultAdds_GameSessionID] DEFAULT ((0)),
[CustomerID] [int] NOT NULL CONSTRAINT [DF_GameResultAdds_CustomerID] DEFAULT ((0)),
[GamePoints] [int] NOT NULL CONSTRAINT [DF_GameResultAdds_GamePoints] DEFAULT ((0)),
[HonorPoints] [int] NOT NULL CONSTRAINT [DF_GameResultAdds_HonorPoints] DEFAULT ((0)),
[SkillPoints] [int] NOT NULL CONSTRAINT [DF_GameResultAdds_SkillPoints] DEFAULT ((0)),
[Kills] [int] NOT NULL CONSTRAINT [DF_GameResultAdds_Kills] DEFAULT ((0)),
[Deaths] [int] NOT NULL CONSTRAINT [DF_GameResultAdds_Deaths] DEFAULT ((0)),
[ShotsFired] [int] NOT NULL CONSTRAINT [DF_GameResultAdds_ShotsFired] DEFAULT ((0)),
[ShotsHits] [int] NOT NULL,
[Headshots] [int] NOT NULL CONSTRAINT [DF_GameResultAdds_Headshots] DEFAULT ((0)),
[AssistKills] [int] NOT NULL CONSTRAINT [DF_GameResultAdds_AssistKills] DEFAULT ((0)),
[Wins] [int] NOT NULL CONSTRAINT [DF_GameResultAdds_Wins] DEFAULT ((0)),
[Losses] [int] NOT NULL CONSTRAINT [DF_GameResultAdds_Losses] DEFAULT ((0)),
[CaptureNeutralPoints] [int] NOT NULL CONSTRAINT [DF_GameResultAdds_CaptureNeutralPoints] DEFAULT ((0)),
[CaptureEnemyPoints] [int] NOT NULL CONSTRAINT [DF_GameResultAdds_CaptureEnemyPoints] DEFAULT ((0)),
[TimePlayed] [int] NOT NULL CONSTRAINT [DF_GameResultAdds_TimePlayed] DEFAULT ((0)),
[GameReportTime] [datetime] NOT NULL CONSTRAINT [DF_DBG_UserRoundResults_GameReportTime] DEFAULT (((1)/(1))/(1970)),
[GameDollars] [int] NOT NULL CONSTRAINT [DF_DBG_UserRoundResults_GameDollars] DEFAULT ((0)),
[TeamID] [int] NOT NULL CONSTRAINT [DF__DBG_UserR__TeamI__5AF96FB1] DEFAULT ((2)),
[MapID] [int] NOT NULL CONSTRAINT [DF__DBG_UserR__MapID__5BED93EA] DEFAULT ((255)),
[MapType] [int] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [DBG_URR_CID_GRP] ON [dbo].[DBG_UserRoundResults] ([CustomerID], [GameReportTime]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_DBG_UserRoundResults_LBIdx1] ON [dbo].[DBG_UserRoundResults] ([GameReportTime]) INCLUDE ([CustomerID], [Deaths], [HonorPoints], [Kills], [Losses], [ShotsFired], [ShotsHits], [TimePlayed], [Wins]) ON [PRIMARY]
GO
