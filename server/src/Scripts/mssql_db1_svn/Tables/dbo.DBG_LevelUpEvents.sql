CREATE TABLE [dbo].[DBG_LevelUpEvents]
(
[CustomerID] [int] NULL,
[LevelGained] [int] NULL,
[ReportTime] [datetime] NULL,
[SessionID] [bigint] NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_DBG_LevelUpEvents] ON [dbo].[DBG_LevelUpEvents] ([CustomerID]) ON [PRIMARY]

GO
