USE [gameid_v1]
GO

/****** Object:  Table [dbo].[SteamGPOrders]    Script Date: 07/07/2011 20:51:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SteamGPOrders]') AND type in (N'U'))
DROP TABLE [dbo].[SteamGPOrders]
GO

USE [gameid_v1]
GO

/****** Object:  Table [dbo].[SteamGPOrders]    Script Date: 07/07/2011 20:51:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[SteamGPOrders](
	[OrderID] [bigint] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL,
	[SteamID] [bigint] NULL,
	[InitTxnTime] [datetime] NULL,
	[Price] [int] NULL,
	[GP] [int] NULL,
	[ItemCode] [varchar](32) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


