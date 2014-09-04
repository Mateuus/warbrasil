USE [gameid_v1]
GO

/****** Object:  Table [dbo].[Leaderboard]    Script Date: 09/12/2011 16:57:29 ******/
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
	[HavePremium] [int] NOT NULL,
 CONSTRAINT [PK_Leaderboard] PRIMARY KEY CLUSTERED 
(
	[Pos] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE UNIQUE NONCLUSTERED INDEX IX_Leaderboard_CustomerID ON dbo.Leaderboard
	(CustomerID) WITH(STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
