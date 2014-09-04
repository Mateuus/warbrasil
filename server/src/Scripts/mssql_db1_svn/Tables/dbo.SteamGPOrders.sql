CREATE TABLE [dbo].[SteamGPOrders]
(
[OrderID] [bigint] NOT NULL IDENTITY(1, 1),
[CustomerID] [int] NULL,
[SteamID] [bigint] NULL,
[InitTxnTime] [datetime] NULL,
[Price] [int] NULL,
[GP] [int] NULL,
[ItemCode] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
