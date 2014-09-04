CREATE TABLE [dbo].[DBG_SQLHacks]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[CustomerID] [int] NOT NULL CONSTRAINT [DF_DBG_SQLHacks_CustomerID] DEFAULT ((0)),
[IP] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Query] [varchar] (1024) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[StoredProc] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
