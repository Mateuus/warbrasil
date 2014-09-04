CREATE TABLE [dbo].[Leaderboard30]
(
[Pos] [int] NOT NULL IDENTITY(1, 1),
[CustomerID] [int] NOT NULL,
[gamertag] [nvarchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Rank] [int] NOT NULL,
[HonorPoints] [int] NOT NULL,
[Wins] [int] NOT NULL,
[Losses] [int] NOT NULL,
[Kills] [int] NOT NULL,
[Deaths] [int] NOT NULL,
[ShotsFired] [int] NOT NULL,
[ShotsHit] [int] NOT NULL,
[TimePlayed] [int] NOT NULL,
[HavePremium] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Leaderboard30] ADD CONSTRAINT [PK_Leaderboard30] PRIMARY KEY CLUSTERED  ([Pos]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Leaderboard30_CustomerID] ON [dbo].[Leaderboard30] ([CustomerID]) ON [PRIMARY]
GO
