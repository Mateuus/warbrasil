USE [gameid_v1]
GO

/****** Object:  Table [dbo].[Leaderboard]    Script Date: 05/20/2011 20:13:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Leaderboard](
	[Pos] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[gamertag] [nvarchar](32) NOT NULL,
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


