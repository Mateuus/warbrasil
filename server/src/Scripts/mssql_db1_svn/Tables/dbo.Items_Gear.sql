CREATE TABLE [dbo].[Items_Gear]
(
[ItemID] [int] NOT NULL IDENTITY(20000, 1),
[FNAME] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Items_Gea__FNAME__0539C240] DEFAULT ('ITEM000'),
[Name] [nvarchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Items_Gear_Name] DEFAULT (N'Name'),
[Description] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Items_Gear_Description] DEFAULT (N'Description'),
[Category] [int] NOT NULL CONSTRAINT [DF__Items_Gea__Categ__062DE679] DEFAULT ((0)),
[Weight] [int] NOT NULL CONSTRAINT [DF_Items_Gear_Weight] DEFAULT ((0)),
[DamagePerc] [int] NOT NULL CONSTRAINT [DF_Items_Gear_Armor] DEFAULT ((0)),
[DamageMax] [int] NOT NULL CONSTRAINT [DF_Items_Gear_Speed] DEFAULT ((0)),
[Bulkiness] [int] NOT NULL CONSTRAINT [DF_Items_Gear_Bulkiness] DEFAULT ((0)),
[Inaccuracy] [int] NOT NULL CONSTRAINT [DF_Items_Gear_Inaccuracy] DEFAULT ((0)),
[Stealth] [int] NOT NULL CONSTRAINT [DF_Items_Gear_Stealth] DEFAULT ((0)),
[CustomFunction] [int] NOT NULL CONSTRAINT [DF_Items_Gear_CustomFunction] DEFAULT ((0)),
[Protection] [char] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Items_Gear_ProtectionCHEM] DEFAULT ('00000'),
[Price1] [int] NOT NULL CONSTRAINT [DF_Items_Gear_Price1] DEFAULT ((0)),
[Price7] [int] NOT NULL CONSTRAINT [DF_Items_Gear_Price7] DEFAULT ((0)),
[Price30] [int] NOT NULL CONSTRAINT [DF_Items_Gear_Price30] DEFAULT ((0)),
[PriceP] [int] NOT NULL CONSTRAINT [DF_Items_Gear_PriceP] DEFAULT ((0)),
[IsNew] [int] NOT NULL CONSTRAINT [DF_Items_Gear_IsNew] DEFAULT ((0)),
[ProtectionLevel] [int] NOT NULL CONSTRAINT [DF_Items_Gear_ProtectionLevel] DEFAULT ((1)),
[LevelRequired] [int] NOT NULL CONSTRAINT [DF_Items_Gear_LevelRequired] DEFAULT ((0)),
[GPrice1] [int] NOT NULL CONSTRAINT [DF__Items_Gea__GPric__070CFC19] DEFAULT ((0)),
[GPrice7] [int] NOT NULL CONSTRAINT [DF__Items_Gea__GPric__08012052] DEFAULT ((0)),
[GPrice30] [int] NOT NULL CONSTRAINT [DF__Items_Gea__GPric__08F5448B] DEFAULT ((0)),
[GPriceP] [int] NOT NULL CONSTRAINT [DF__Items_Gea__GPric__09E968C4] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Items_Gear] ADD CONSTRAINT [PK_Items_Gear] PRIMARY KEY CLUSTERED  ([ItemID]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[Items_Gear] TO [support1]
GRANT INSERT ON  [dbo].[Items_Gear] TO [support1]
GRANT DELETE ON  [dbo].[Items_Gear] TO [support1]
GRANT UPDATE ON  [dbo].[Items_Gear] TO [support1]
GO
