CREATE TABLE [dbo].[GamersfirstUserIDMap]
(
[CustomerID] [int] NOT NULL,
[GamersfirstID] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GamersfirstUserIDMap] ADD CONSTRAINT [PK_GamersfirstUserIDMap] PRIMARY KEY CLUSTERED  ([CustomerID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_GamersfirstUserIDMap_GamersfirstID] ON [dbo].[GamersfirstUserIDMap] ([GamersfirstID]) ON [PRIMARY]
GO
