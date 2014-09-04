CREATE TABLE [dbo].[ClanInvites]
(
[ClanInviteID] [int] NOT NULL IDENTITY(1, 1),
[ClanID] [int] NOT NULL,
[InviterID] [int] NOT NULL,
[CustomerID] [int] NOT NULL,
[ExpireTime] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ClanInvites] ADD CONSTRAINT [PK_ClanInvites] PRIMARY KEY CLUSTERED  ([ClanInviteID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ClanInvites_ClanID] ON [dbo].[ClanInvites] ([ClanID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ClanInvites_CustomerID] ON [dbo].[ClanInvites] ([CustomerID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ClanInvites_ExpireTime] ON [dbo].[ClanInvites] ([ExpireTime]) ON [PRIMARY]
GO
