use gameid_v1

USE [gameid_v1]
GO

/****** Object:  Table [dbo].[Leaderboard]    Script Date: 09/12/2011 16:57:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Leaderboard1](
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
 CONSTRAINT [PK_Leaderboard1] PRIMARY KEY CLUSTERED 
(
	[Pos] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE UNIQUE NONCLUSTERED INDEX IX_Leaderboard1_CustomerID ON dbo.Leaderboard1
	(CustomerID) WITH(STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Leaderboard7](
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
 CONSTRAINT [PK_Leaderboard7] PRIMARY KEY CLUSTERED 
(
	[Pos] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE UNIQUE NONCLUSTERED INDEX IX_Leaderboard7_CustomerID ON dbo.Leaderboard7
	(CustomerID) WITH(STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Leaderboard30](
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
 CONSTRAINT [PK_Leaderboard30] PRIMARY KEY CLUSTERED 
(
	[Pos] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE UNIQUE NONCLUSTERED INDEX IX_Leaderboard30_CustomerID ON dbo.Leaderboard30
	(CustomerID) WITH(STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
