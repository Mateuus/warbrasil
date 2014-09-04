CREATE TABLE [dbo].[Stats]
(
[CustomerID] [int] NOT NULL,
[Kills] [int] NOT NULL CONSTRAINT [DF_Stats_Kills] DEFAULT ((0)),
[Deaths] [int] NOT NULL CONSTRAINT [DF_Stats_Deaths] DEFAULT ((0)),
[ShotsFired] [int] NOT NULL CONSTRAINT [DF_Stats_ShotsFired] DEFAULT ((0)),
[ShotsHits] [int] NOT NULL CONSTRAINT [DF_Stats_ShotsHits] DEFAULT ((0)),
[Headshots] [int] NOT NULL CONSTRAINT [DF_Stats_Headshots] DEFAULT ((0)),
[AssistKills] [int] NOT NULL CONSTRAINT [DF_Stats_AssistKills] DEFAULT ((0)),
[Wins] [int] NOT NULL CONSTRAINT [DF_Stats_Wins] DEFAULT ((0)),
[Losses] [int] NOT NULL CONSTRAINT [DF_Stats_Losses] DEFAULT ((0)),
[CaptureNeutralPoints] [int] NOT NULL CONSTRAINT [DF_Stats_CaptureNeutralPoints] DEFAULT ((0)),
[CaptureEnemyPoints] [int] NOT NULL CONSTRAINT [DF_Stats_CaptureEnemyPoints] DEFAULT ((0)),
[TimePlayed] [int] NOT NULL CONSTRAINT [DF_Stats_TimePlayed] DEFAULT ((0)),
[CheatAttempts] [int] NOT NULL CONSTRAINT [DF_Stats_CheatAttempts] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Stats] ADD CONSTRAINT [PK_Stats] PRIMARY KEY CLUSTERED  ([CustomerID]) ON [PRIMARY]
GO
