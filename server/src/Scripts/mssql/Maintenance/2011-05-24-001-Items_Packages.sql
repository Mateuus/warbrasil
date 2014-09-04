USE [gameid_v1]
GO

/****** Object:  Table [dbo].[Items_Packages]    Script Date: 05/24/2011 21:37:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Items_Packages](
	[ItemID] [int] IDENTITY(500000,1) NOT NULL,
	[FNAME] [varchar](64) NOT NULL default '',
	[Name] [nvarchar](32) NOT NULL default N'',
	[Description] [nvarchar](512) NOT NULL default N'',
	[Category] [int] NOT NULL default 9,
	[Price1] [int] NOT NULL default 0,
	[Price7] [int] NOT NULL default 0,
	[Price30] [int] NOT NULL default 0,
	[PriceP] [int] NOT NULL default 0,
	[IsNew] [int] NOT NULL default 0,
	[LevelRequired] [int] NOT NULL default 0,
	[GPrice1] [int] NOT NULL default 0,
	[GPrice7] [int] NOT NULL default 0,
	[GPrice30] [int] NOT NULL default 0,
	[GPriceP] [int] NOT NULL default 0,
	[IsEnabled] [int] NOT NULL default 1,
	[AddGP] [int] NOT NULL default 0,
	[AddSP] [int] NOT NULL default 0,
	[Item1_ID] [int] NOT NULL default 0,
	[Item1_Exp] [int] NOT NULL default 0,
	[Item2_ID] [int] NOT NULL default 0,
	[Item2_Exp] [int] NOT NULL default 0,
	[Item3_ID] [int] NOT NULL default 0,
	[Item3_Exp] [int] NOT NULL default 0,
	[Item4_ID] [int] NOT NULL default 0,
	[Item4_Exp] [int] NOT NULL default 0,
	[Item5_ID] [int] NOT NULL default 0,
	[Item5_Exp] [int] NOT NULL default 0,
	[Item6_ID] [int] NOT NULL default 0,
	[Item6_Exp] [int] NOT NULL default 0,
 CONSTRAINT [PK_Items_Package] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
