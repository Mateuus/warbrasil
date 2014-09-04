CREATE TABLE [dbo].[DBG_LootRewards]
(
[RecordID] [int] NOT NULL IDENTITY(1, 1),
[ReportTime] [datetime] NOT NULL,
[CustomerID] [int] NOT NULL,
[Roll] [float] NOT NULL,
[LootID] [float] NOT NULL,
[ItemID] [int] NOT NULL,
[ExpDays] [int] NOT NULL,
[GD] [int] NOT NULL
) ON [PRIMARY]
GO
