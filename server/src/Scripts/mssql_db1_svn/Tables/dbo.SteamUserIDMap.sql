CREATE TABLE [dbo].[SteamUserIDMap]
(
[CustomerID] [int] NULL,
[SteamID] [bigint] NULL
) ON [PRIMARY]
CREATE UNIQUE NONCLUSTERED INDEX [IX_SteamUserIDMap_CustomerID] ON [dbo].[SteamUserIDMap] ([CustomerID]) ON [PRIMARY]

GO
CREATE UNIQUE CLUSTERED INDEX [IX_SteamUserIDMap_SteamID] ON [dbo].[SteamUserIDMap] ([SteamID]) ON [PRIMARY]
GO
