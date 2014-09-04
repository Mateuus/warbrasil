USE [gameid_v1]
GO

/****** Object:  Table [dbo].[Inventory_FPS]    Script Date: 03/01/2012 18:50:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Inventory_FPS](
	[CustomerID] [int] NOT NULL,
	[WeaponID] [int] NOT NULL,
	[AttachmentID] [int] NOT NULL,
	[LeasedUntil] [datetime] NOT NULL,
	[Slot] [int] NOT NULL,
	[IsEquipped] [int] NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Inventory_FPS] ADD  CONSTRAINT [DF_Inventory_FPS_IsEquipped]  DEFAULT ((0)) FOR [IsEquipped]
GO


NOTE: add index for CustomerID
