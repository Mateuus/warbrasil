CREATE TABLE [dbo].[ClanEvents]
(
[ClanEventID] [int] NOT NULL IDENTITY(1, 1),
[ClanID] [int] NOT NULL,
[EventDate] [datetime] NOT NULL,
[EventType] [int] NOT NULL,
[EventRank] [int] NOT NULL,
[Var1] [int] NOT NULL CONSTRAINT [DF_ClanEvents_Var1] DEFAULT ((0)),
[Var2] [int] NOT NULL CONSTRAINT [DF_ClanEvents_Var2] DEFAULT ((0)),
[Var3] [int] NOT NULL CONSTRAINT [DF_ClanEvents_Var3] DEFAULT ((0)),
[Var4] [int] NOT NULL CONSTRAINT [DF_ClanEvents_Var4] DEFAULT ((0)),
[Text1] [nvarchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Text2] [nvarchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Text3] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[ClanEvents] TO [support1]
GO

ALTER TABLE [dbo].[ClanEvents] ADD CONSTRAINT [PK_ClanEvents] PRIMARY KEY CLUSTERED  ([ClanEventID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ClanEvents_ClanID] ON [dbo].[ClanEvents] ([ClanID]) ON [PRIMARY]
GO
