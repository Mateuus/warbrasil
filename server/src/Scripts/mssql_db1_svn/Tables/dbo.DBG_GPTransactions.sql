CREATE TABLE [dbo].[DBG_GPTransactions]
(
[TransactionID] [int] NOT NULL IDENTITY(1, 1),
[CustomerID] [int] NULL,
[TransactionTime] [datetime] NULL,
[Amount] [int] NULL,
[Reason] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Previous] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DBG_GPTransactions] ADD CONSTRAINT [PK_DBG_GPTransactions] PRIMARY KEY CLUSTERED  ([TransactionID]) ON [PRIMARY]
GO
