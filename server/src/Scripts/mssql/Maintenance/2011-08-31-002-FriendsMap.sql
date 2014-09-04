USE [gameid_v1]
GO

/****** Object:  Table [dbo].[FriendsMap]    Script Date: 08/31/2011 16:30:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FriendsMap](
	[CustomerID] [int] NULL,
	[FriendID] [int] NULL,
	[FriendStatus] [int] NULL,
	[DateAdded] [datetime] NULL
) ON [PRIMARY]

GO


CREATE NONCLUSTERED INDEX [IDX_FriendsMap_CustomerID]
ON [dbo].[FriendsMap] ([CustomerID])

CREATE NONCLUSTERED INDEX [IDX_FriendsMap_FriendID]
ON [dbo].[FriendsMap] ([FriendID])

GO
