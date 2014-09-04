USE [gameid_v1]
GO

/****** Object:  Table [dbo].[SteamGPShop]    Script Date: 06/28/2011 15:33:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SteamGPShop](
	[SteamGPItemId] [int] IDENTITY(1,1) NOT NULL,
	[IsEnabled] [int],
	[GP] [int],
	[BonusGP] [int],
	[PriceCentsUSD] [int]
) ON [PRIMARY]

GO


