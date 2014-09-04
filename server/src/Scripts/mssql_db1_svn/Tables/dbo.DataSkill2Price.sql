CREATE TABLE [dbo].[DataSkill2Price]
(
[SkillID] [int] NOT NULL,
[SkillName] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_DataSkill2Price_SkillName] DEFAULT ('SKILL DESC'),
[Lv1] [int] NULL CONSTRAINT [DF_DataSkill2Price_Lv1] DEFAULT ((0)),
[Lv2] [int] NULL CONSTRAINT [DF_DataSkill2Price_Lv2] DEFAULT ((0)),
[Lv3] [int] NULL CONSTRAINT [DF_DataSkill2Price_Lv3] DEFAULT ((0)),
[Lv4] [int] NULL CONSTRAINT [DF_DataSkill2Price_Lv4] DEFAULT ((0)),
[Lv5] [int] NULL CONSTRAINT [DF_DataSkill2Price_Lv5] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DataSkill2Price] ADD CONSTRAINT [PK_DataSkill2Price] PRIMARY KEY CLUSTERED  ([SkillID]) ON [PRIMARY]
GO
