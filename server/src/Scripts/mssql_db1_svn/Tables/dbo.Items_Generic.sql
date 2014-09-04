CREATE TABLE [dbo].[Items_Generic]
(
[ItemID] [int] NOT NULL IDENTITY(301000, 1),
[FNAME] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Items_Generic_FNAME] DEFAULT ('Item_Generic'),
[Category] [int] NOT NULL,
[Name] [nvarchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Items_Generic_Name] DEFAULT (N'Name'),
[Description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Items_Generic_Description] DEFAULT (N'Description'),
[Price1] [int] NOT NULL CONSTRAINT [DF_Items_Generic_Price1] DEFAULT ((0)),
[Price7] [int] NOT NULL CONSTRAINT [DF_Items_Generic_Price7] DEFAULT ((0)),
[Price30] [int] NOT NULL CONSTRAINT [DF_Items_Generic_Price30] DEFAULT ((0)),
[PriceP] [int] NOT NULL CONSTRAINT [DF_Items_Generic_PriceP] DEFAULT ((0)),
[IsNew] [int] NOT NULL CONSTRAINT [DF_Items_Generic_IsNew] DEFAULT ((0)),
[LevelRequired] [int] NOT NULL CONSTRAINT [DF_Items_Generic_LevelRequired] DEFAULT ((0)),
[GPrice1] [int] NOT NULL CONSTRAINT [DF__Items_Gen__GPric__0ADD8CFD] DEFAULT ((0)),
[GPrice7] [int] NOT NULL CONSTRAINT [DF__Items_Gen__GPric__0BD1B136] DEFAULT ((0)),
[GPrice30] [int] NOT NULL CONSTRAINT [DF__Items_Gen__GPric__0CC5D56F] DEFAULT ((0)),
[GPriceP] [int] NOT NULL CONSTRAINT [DF__Items_Gen__GPric__0DB9F9A8] DEFAULT ((0)),
[IsStackable] [int] NOT NULL CONSTRAINT [DF__Items_Gen__IsSta__42ECDBF6] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Items_Generic] ADD CONSTRAINT [PK_Items_Generic] PRIMARY KEY CLUSTERED  ([ItemID]) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[Items_Generic] TO [support1]
GRANT INSERT ON  [dbo].[Items_Generic] TO [support1]
GRANT DELETE ON  [dbo].[Items_Generic] TO [support1]
GRANT UPDATE ON  [dbo].[Items_Generic] TO [support1]
GO
