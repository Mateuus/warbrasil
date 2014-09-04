CREATE TABLE [dbo].[FinancialBlocks]
(
[CustomerID] [int] NOT NULL,
[LastBlockedTime] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FinancialBlocks] ADD CONSTRAINT [PK_FinancialBlocks] PRIMARY KEY CLUSTERED  ([CustomerID]) ON [PRIMARY]
GO
