CREATE TABLE [dbo].[FinancialTransactions]
(
[CustomerID] [int] NOT NULL,
[TransactionID] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TransactionType] [int] NOT NULL,
[DateTime] [datetime] NOT NULL,
[Amount] [float] NOT NULL,
[ResponseCode] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AprovalCode] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ItemID] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_FinancialTransactions_DateTime] ON [dbo].[FinancialTransactions] ([DateTime]) ON [PRIMARY]

GO
GRANT SELECT ON  [dbo].[FinancialTransactions] TO [support1]
GO

CREATE NONCLUSTERED INDEX [IX_FinancialTransactions_ItemID] ON [dbo].[FinancialTransactions] ([ItemID]) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_FinancialTransactions_TransactionType] ON [dbo].[FinancialTransactions] ([TransactionType]) ON [PRIMARY]

GO
CREATE NONCLUSTERED INDEX [IX_FinancialTransactions_CustomerID] ON [dbo].[FinancialTransactions] ([CustomerID]) ON [PRIMARY]
GO
