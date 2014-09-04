USE [gameid_v1]
GO

/****** Object:  Table [dbo].[DataGameRewards]    Script Date: 12/13/2011 21:37:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DataGameRewards](
	[RewardID] [int] NOT NULL,
	[RewardName] [nvarchar](128) NOT NULL,
	[GD_CQ] [int] NOT NULL,
	[HP_CQ] [int] NOT NULL,
	[GD_DM] [int] NOT NULL,
	[HP_DM] [int] NOT NULL,
	[GD_SB] [int] NOT NULL,
	[HP_SB] [int] NOT NULL,
 CONSTRAINT [PK_DataGameRewards] PRIMARY KEY CLUSTERED 
(
	[RewardID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[DataGameRewards] ADD  CONSTRAINT [DF_DataGameRewards_RewardDescription]  DEFAULT ('') FOR [RewardName]
GO

ALTER TABLE [dbo].[DataGameRewards] ADD  CONSTRAINT [DF_DataGameRewards_GD_CQ]  DEFAULT ((0)) FOR [GD_CQ]
GO

ALTER TABLE [dbo].[DataGameRewards] ADD  CONSTRAINT [DF_DataGameRewards_HP_CQ]  DEFAULT ((0)) FOR [HP_CQ]
GO

ALTER TABLE [dbo].[DataGameRewards] ADD  CONSTRAINT [DF_DataGameRewards_GD_DM]  DEFAULT ((0)) FOR [GD_DM]
GO

ALTER TABLE [dbo].[DataGameRewards] ADD  CONSTRAINT [DF_DataGameRewards_HP_DM]  DEFAULT ((0)) FOR [HP_DM]
GO

ALTER TABLE [dbo].[DataGameRewards] ADD  CONSTRAINT [DF_DataGameRewards_GD_SB]  DEFAULT ((0)) FOR [GD_SB]
GO

ALTER TABLE [dbo].[DataGameRewards] ADD  CONSTRAINT [DF_DataGameRewards_HP_SB]  DEFAULT ((0)) FOR [HP_SB]
GO


