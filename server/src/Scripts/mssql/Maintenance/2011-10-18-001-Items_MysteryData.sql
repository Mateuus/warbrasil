USE [gameid_v1]
GO

/****** Object:  Table [dbo].[Items_MysteryData]    Script Date: 10/18/2011 17:32:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Items_LootData](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[LootID] [int] NOT NULL,
	[Chance] [float] NULL,
	[ItemID] [int] NULL,
	[ExpDaysMin] [int] NULL,
	[ExpDaysMax] [int] NULL,
	[GDMin] [int] NULL,
	[GDMax] [int] NULL
) ON [PRIMARY]

GO


CREATE TABLE [dbo].[DBG_LootRewards](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[ReportTime] [datetime] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[Roll] [float] NOT NULL,
	[LootID] [float] NOT NULL,
	[ItemID] [int] NOT NULL,
	[ExpDays] [int] NOT NULL,
	[GD] [int] NOT NULL,
) ON [PRIMARY]

GO


