CREATE TABLE [dbo].[Items_Attachments]
(
[ItemID] [int] NOT NULL IDENTITY(400000, 1),
[FNAME] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Type] [int] NOT NULL,
[Name] [nvarchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MuzzleParticle] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FireSound] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Damage] [float] NOT NULL,
[Range] [float] NOT NULL,
[Firerate] [float] NOT NULL,
[Recoil] [float] NOT NULL,
[Spread] [float] NOT NULL,
[Clipsize] [int] NOT NULL,
[ScopeMag] [float] NOT NULL,
[ScopeType] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AnimPrefix] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SpecID] [int] NOT NULL CONSTRAINT [DF__Items_Att__SpecI__3A228BCB] DEFAULT ((0)),
[Category] [int] NOT NULL CONSTRAINT [DF__Items_Att__Categ__3B16B004] DEFAULT ((19)),
[Price1] [int] NOT NULL CONSTRAINT [DF__Items_Att__Price__3C0AD43D] DEFAULT ((0)),
[Price7] [int] NOT NULL CONSTRAINT [DF__Items_Att__Price__3CFEF876] DEFAULT ((0)),
[Price30] [int] NOT NULL CONSTRAINT [DF__Items_Att__Price__3DF31CAF] DEFAULT ((0)),
[PriceP] [int] NOT NULL CONSTRAINT [DF__Items_Att__Price__3EE740E8] DEFAULT ((0)),
[GPrice1] [int] NOT NULL CONSTRAINT [DF__Items_Att__GPric__3FDB6521] DEFAULT ((0)),
[GPrice7] [int] NOT NULL CONSTRAINT [DF__Items_Att__GPric__40CF895A] DEFAULT ((0)),
[GPrice30] [int] NOT NULL CONSTRAINT [DF__Items_Att__GPric__41C3AD93] DEFAULT ((0)),
[GPriceP] [int] NOT NULL CONSTRAINT [DF__Items_Att__GPric__42B7D1CC] DEFAULT ((0)),
[IsNew] [int] NOT NULL CONSTRAINT [DF__Items_Att__IsNew__43ABF605] DEFAULT ((0)),
[LevelRequired] [int] NOT NULL CONSTRAINT [DF__Items_Att__Level__44A01A3E] DEFAULT ((0))
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[Items_Attachments] TO [support1]
GRANT INSERT ON  [dbo].[Items_Attachments] TO [support1]
GRANT DELETE ON  [dbo].[Items_Attachments] TO [support1]
GRANT UPDATE ON  [dbo].[Items_Attachments] TO [support1]
GO

ALTER TABLE [dbo].[Items_Attachments] ADD CONSTRAINT [PK_Items_Attachments] PRIMARY KEY CLUSTERED  ([ItemID]) ON [PRIMARY]
GO
