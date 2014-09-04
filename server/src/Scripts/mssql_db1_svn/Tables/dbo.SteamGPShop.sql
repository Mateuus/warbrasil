CREATE TABLE [dbo].[SteamGPShop]
(
[SteamGPItemId] [int] NOT NULL IDENTITY(1, 1),
[IsEnabled] [int] NULL,
[GP] [int] NULL,
[BonusGP] [int] NULL,
[PriceCentsUSD] [int] NULL
) ON [PRIMARY]
GO
