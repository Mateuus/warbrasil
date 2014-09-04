CREATE TABLE [dbo].[Items_LootData]
(
[RecordID] [int] NOT NULL IDENTITY(1, 1),
[LootID] [int] NOT NULL,
[Chance] [float] NULL,
[ItemID] [int] NULL,
[ExpDaysMin] [int] NULL,
[ExpDaysMax] [int] NULL,
[GDMin] [int] NULL,
[GDMax] [int] NULL,
[GDIfHave] [int] NOT NULL CONSTRAINT [DF__Items_Loo__GDIfH__02D256E1] DEFAULT ((0))
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[Items_LootData] TO [support1]
GRANT INSERT ON  [dbo].[Items_LootData] TO [support1]
GRANT DELETE ON  [dbo].[Items_LootData] TO [support1]
GRANT UPDATE ON  [dbo].[Items_LootData] TO [support1]
GO
