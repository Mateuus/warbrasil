USE [gameid_v1]
GO

/****** Object:  Table [dbo].[Items_Attachments]    Script Date: 03/09/2012 16:23:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Items_Attachments](
	[ItemID] [int] IDENTITY(400000,1) NOT NULL,
	[FNAME] [varchar](32) NOT NULL,
	[Type] [int] NOT NULL,
	[Name] [varchar](32) NOT NULL,
	[Description] [nvarchar](256) NOT NULL,
	[MuzzleParticle] [varchar](64) NOT NULL,
	[FireSound] [varchar](256) NOT NULL,
	[Damage] [float] NOT NULL,
	[Range] [float] NOT NULL,
	[Firerate] [float] NOT NULL,
	[Recoil] [float] NOT NULL,
	[Spread] [float] NOT NULL,
	[Clipsize] [int] NOT NULL,
	[ScopeMag] [float] NOT NULL,
	[ScopeType] [varchar](32) NOT NULL,
	[AnimPrefix] [varchar](32) NOT NULL,
	[SpecID] [int] NOT NULL,
	[Category] [int] NOT NULL,
	[Price1] [int] NOT NULL,
	[Price7] [int] NOT NULL,
	[Price30] [int] NOT NULL,
	[PriceP] [int] NOT NULL,
	[GPrice1] [int] NOT NULL,
	[GPrice7] [int] NOT NULL,
	[GPrice30] [int] NOT NULL,
	[GPriceP] [int] NOT NULL,
	[IsNew] [int] NOT NULL,
	[LevelRequired] [int] NOT NULL,
 CONSTRAINT [PK_Items_Attachments] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Items_Attachments] ADD  CONSTRAINT [DF__Items_Att__SpecI__3A228BCB]  DEFAULT ((0)) FOR [SpecID]
GO

ALTER TABLE [dbo].[Items_Attachments] ADD  CONSTRAINT [DF__Items_Att__Categ__3B16B004]  DEFAULT ((19)) FOR [Category]
GO

ALTER TABLE [dbo].[Items_Attachments] ADD  CONSTRAINT [DF__Items_Att__Price__3C0AD43D]  DEFAULT ((0)) FOR [Price1]
GO

ALTER TABLE [dbo].[Items_Attachments] ADD  CONSTRAINT [DF__Items_Att__Price__3CFEF876]  DEFAULT ((0)) FOR [Price7]
GO

ALTER TABLE [dbo].[Items_Attachments] ADD  CONSTRAINT [DF__Items_Att__Price__3DF31CAF]  DEFAULT ((0)) FOR [Price30]
GO

ALTER TABLE [dbo].[Items_Attachments] ADD  CONSTRAINT [DF__Items_Att__Price__3EE740E8]  DEFAULT ((0)) FOR [PriceP]
GO

ALTER TABLE [dbo].[Items_Attachments] ADD  CONSTRAINT [DF__Items_Att__GPric__3FDB6521]  DEFAULT ((0)) FOR [GPrice1]
GO

ALTER TABLE [dbo].[Items_Attachments] ADD  CONSTRAINT [DF__Items_Att__GPric__40CF895A]  DEFAULT ((0)) FOR [GPrice7]
GO

ALTER TABLE [dbo].[Items_Attachments] ADD  CONSTRAINT [DF__Items_Att__GPric__41C3AD93]  DEFAULT ((0)) FOR [GPrice30]
GO

ALTER TABLE [dbo].[Items_Attachments] ADD  CONSTRAINT [DF__Items_Att__GPric__42B7D1CC]  DEFAULT ((0)) FOR [GPriceP]
GO

ALTER TABLE [dbo].[Items_Attachments] ADD  CONSTRAINT [DF__Items_Att__IsNew__43ABF605]  DEFAULT ((0)) FOR [IsNew]
GO

ALTER TABLE [dbo].[Items_Attachments] ADD  CONSTRAINT [DF__Items_Att__Level__44A01A3E]  DEFAULT ((0)) FOR [LevelRequired]
GO


