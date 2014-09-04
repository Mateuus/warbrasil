CREATE TABLE [dbo].[DataGameRewards]
(
[RewardID] [int] NOT NULL,
[RewardName] [nvarchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_DataGameRewards_RewardDescription] DEFAULT (''),
[GD_CQ] [int] NOT NULL CONSTRAINT [DF_DataGameRewards_GD_CQ] DEFAULT ((0)),
[HP_CQ] [int] NOT NULL CONSTRAINT [DF_DataGameRewards_HP_CQ] DEFAULT ((0)),
[GD_DM] [int] NOT NULL CONSTRAINT [DF_DataGameRewards_GD_DM] DEFAULT ((0)),
[HP_DM] [int] NOT NULL CONSTRAINT [DF_DataGameRewards_HP_DM] DEFAULT ((0)),
[GD_SB] [int] NOT NULL CONSTRAINT [DF_DataGameRewards_GD_SB] DEFAULT ((0)),
[HP_SB] [int] NOT NULL CONSTRAINT [DF_DataGameRewards_HP_SB] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DataGameRewards] ADD CONSTRAINT [PK_DataGameRewards] PRIMARY KEY CLUSTERED  ([RewardID]) ON [PRIMARY]
GO
