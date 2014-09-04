CREATE TABLE [dbo].[AmazonShop]
(
[SKU] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsEnabled] [int] NOT NULL,
[PriceUSD_For_Log] [float] NOT NULL,
[ItemNote] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AmazonShop] ADD CONSTRAINT [PK_AmazonShop] PRIMARY KEY CLUSTERED  ([SKU]) ON [PRIMARY]
GO
