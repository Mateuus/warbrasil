CREATE TABLE [dbo].[AmazonPurchases]
(
[PurchaseIdentity] [int] NOT NULL IDENTITY(1, 1),
[PurchaseID] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CustomerID] [int] NULL,
[PurchaseTime] [datetime] NULL,
[SKU] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsRevoked] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AmazonPurchases] ADD CONSTRAINT [PK_AmazonPurchases] PRIMARY KEY CLUSTERED  ([PurchaseIdentity]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_AmazonPurchases_PurchaseID] ON [dbo].[AmazonPurchases] ([PurchaseID]) ON [PRIMARY]
GO
