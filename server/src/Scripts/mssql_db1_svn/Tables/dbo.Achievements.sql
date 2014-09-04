CREATE TABLE [dbo].[Achievements]
(
[CustomerID] [int] NOT NULL,
[AchID] [int] NOT NULL,
[Value] [int] NOT NULL CONSTRAINT [DF_Achievements_Value] DEFAULT ((0)),
[Unlocked] [int] NOT NULL CONSTRAINT [DF_Achievements_Unlocked] DEFAULT ((0))
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Achievements_AchID] ON [dbo].[Achievements] ([CustomerID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Achievements_CustomerID] ON [dbo].[Achievements] ([CustomerID]) ON [PRIMARY]
GO
