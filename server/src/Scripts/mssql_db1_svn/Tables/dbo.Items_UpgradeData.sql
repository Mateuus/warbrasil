CREATE TABLE [dbo].[Items_UpgradeData]
(
[ItemID] [int] NOT NULL,
[FNAME] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Items_UpgradeData_FNAME] DEFAULT ('UP'),
[Category] [int] NOT NULL,
[Name] [nvarchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Price1] [int] NOT NULL CONSTRAINT [DF_Items_UpgradeData_Price1] DEFAULT ((0)),
[Price7] [int] NOT NULL CONSTRAINT [DF_Items_UpgradeData_Price7] DEFAULT ((0)),
[Price30] [int] NOT NULL CONSTRAINT [DF_Items_UpgradeData_Price30] DEFAULT ((0)),
[PriceP] [int] NOT NULL CONSTRAINT [DF_Items_UpgradeData_PriceP] DEFAULT ((0)),
[LevelRequired] [int] NOT NULL CONSTRAINT [DF_Items_UpgradeData_LevelRequired] DEFAULT ((0)),
[GPrice1] [int] NOT NULL CONSTRAINT [DF_Items_UpgradeData_GPrice1] DEFAULT ((0)),
[GPrice7] [int] NOT NULL CONSTRAINT [DF_Items_UpgradeData_GPrice7] DEFAULT ((0)),
[GPrice30] [int] NOT NULL CONSTRAINT [DF_Items_UpgradeData_GPrice30] DEFAULT ((0)),
[GPriceP] [int] NOT NULL CONSTRAINT [DF_Items_UpgradeData_GPriceP] DEFAULT ((0)),
[GPChance] [float] NOT NULL,
[GDChance] [float] NOT NULL,
[UpgradeID] [int] NOT NULL,
[Value] [float] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Items_UpgradeData] ADD CONSTRAINT [PK_Items_UpgradeData] PRIMARY KEY CLUSTERED  ([ItemID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Items_UpgradeData] ADD CONSTRAINT [UQ__Items_Up__727E83EA6CE315C2] UNIQUE NONCLUSTERED  ([ItemID]) ON [PRIMARY]
GO
