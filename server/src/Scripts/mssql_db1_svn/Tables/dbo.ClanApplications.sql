CREATE TABLE [dbo].[ClanApplications]
(
[ClanApplicationID] [int] NOT NULL IDENTITY(1, 1),
[ClanID] [int] NOT NULL,
[CustomerID] [int] NOT NULL,
[ExpireTime] [datetime] NOT NULL,
[ApplicationText] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsProcessed] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ClanApplications] ADD CONSTRAINT [PK_ClanApplications] PRIMARY KEY CLUSTERED  ([ClanApplicationID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ClanApplications_ClanID] ON [dbo].[ClanApplications] ([ClanID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ClanApplications_CustomerID] ON [dbo].[ClanApplications] ([CustomerID]) ON [PRIMARY]
GO
