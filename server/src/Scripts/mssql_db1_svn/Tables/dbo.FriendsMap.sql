CREATE TABLE [dbo].[FriendsMap]
(
[CustomerID] [int] NULL,
[FriendID] [int] NULL,
[FriendStatus] [int] NULL,
[DateAdded] [datetime] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_FriendsMap_CustomerID] ON [dbo].[FriendsMap] ([CustomerID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX_FriendsMap_FriendID] ON [dbo].[FriendsMap] ([FriendID]) ON [PRIMARY]
GO
