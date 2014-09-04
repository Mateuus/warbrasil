USE [gameid_v1]
GO

/****** Object:  Table [dbo].[Items_UpgradeData]    Script Date: 11/30/2011 23:28:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Items_UpgradeData](
	[ItemID] [int] NOT NULL,
	[FNAME] [varchar](32) NOT NULL,
	[Category] [int] NOT NULL,
	[Name] [nvarchar](32) NOT NULL,
	[Description] [nvarchar](512) NOT NULL,
	[Price1] [int] NOT NULL,
	[Price7] [int] NOT NULL,
	[Price30] [int] NOT NULL,
	[PriceP] [int] NOT NULL,
	[LevelRequired] [int] NOT NULL,
	[GPrice1] [int] NOT NULL,
	[GPrice7] [int] NOT NULL,
	[GPrice30] [int] NOT NULL,
	[GPriceP] [int] NOT NULL,
	[GPChance] [float] NOT NULL,
	[GDChance] [float] NOT NULL,
	[UpgradeID] [int] NOT NULL,
	[Value] [float] NOT NULL,
 CONSTRAINT [PK_Items_UpgradeData] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Items_UpgradeData] ADD  CONSTRAINT [DF_Items_UpgradeData_FNAME]  DEFAULT ('UP') FOR [FNAME]
GO

ALTER TABLE [dbo].[Items_UpgradeData] ADD  CONSTRAINT [DF_Items_UpgradeData_Price1]  DEFAULT ((0)) FOR [Price1]
GO

ALTER TABLE [dbo].[Items_UpgradeData] ADD  CONSTRAINT [DF_Items_UpgradeData_Price7]  DEFAULT ((0)) FOR [Price7]
GO

ALTER TABLE [dbo].[Items_UpgradeData] ADD  CONSTRAINT [DF_Items_UpgradeData_Price30]  DEFAULT ((0)) FOR [Price30]
GO

ALTER TABLE [dbo].[Items_UpgradeData] ADD  CONSTRAINT [DF_Items_UpgradeData_PriceP]  DEFAULT ((0)) FOR [PriceP]
GO

ALTER TABLE [dbo].[Items_UpgradeData] ADD  CONSTRAINT [DF_Items_UpgradeData_LevelRequired]  DEFAULT ((0)) FOR [LevelRequired]
GO

ALTER TABLE [dbo].[Items_UpgradeData] ADD  CONSTRAINT [DF_Items_UpgradeData_GPrice1]  DEFAULT ((0)) FOR [GPrice1]
GO

ALTER TABLE [dbo].[Items_UpgradeData] ADD  CONSTRAINT [DF_Items_UpgradeData_GPrice7]  DEFAULT ((0)) FOR [GPrice7]
GO

ALTER TABLE [dbo].[Items_UpgradeData] ADD  CONSTRAINT [DF_Items_UpgradeData_GPrice30]  DEFAULT ((0)) FOR [GPrice30]
GO

ALTER TABLE [dbo].[Items_UpgradeData] ADD  CONSTRAINT [DF_Items_UpgradeData_GPriceP]  DEFAULT ((0)) FOR [GPriceP]
GO


