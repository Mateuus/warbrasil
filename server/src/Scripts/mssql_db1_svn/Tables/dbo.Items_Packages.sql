CREATE TABLE [dbo].[Items_Packages]
(
[ItemID] [int] NOT NULL IDENTITY(500000, 1),
[FNAME] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Items_Pac__FNAME__23A93AC7] DEFAULT (''),
[Name] [nvarchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Items_Pack__Name__249D5F00] DEFAULT (N''),
[Description] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Items_Pac__Descr__25918339] DEFAULT (N''),
[Category] [int] NOT NULL CONSTRAINT [DF__Items_Pac__Categ__2685A772] DEFAULT ((9)),
[Price1] [int] NOT NULL CONSTRAINT [DF__Items_Pac__Price__2779CBAB] DEFAULT ((0)),
[Price7] [int] NOT NULL CONSTRAINT [DF__Items_Pac__Price__286DEFE4] DEFAULT ((0)),
[Price30] [int] NOT NULL CONSTRAINT [DF__Items_Pac__Price__2962141D] DEFAULT ((0)),
[PriceP] [int] NOT NULL CONSTRAINT [DF__Items_Pac__Price__2A563856] DEFAULT ((0)),
[IsNew] [int] NOT NULL CONSTRAINT [DF__Items_Pac__IsNew__2B4A5C8F] DEFAULT ((0)),
[LevelRequired] [int] NOT NULL CONSTRAINT [DF__Items_Pac__Level__2C3E80C8] DEFAULT ((0)),
[GPrice1] [int] NOT NULL CONSTRAINT [DF__Items_Pac__GPric__2D32A501] DEFAULT ((0)),
[GPrice7] [int] NOT NULL CONSTRAINT [DF__Items_Pac__GPric__2E26C93A] DEFAULT ((0)),
[GPrice30] [int] NOT NULL CONSTRAINT [DF__Items_Pac__GPric__2F1AED73] DEFAULT ((0)),
[GPriceP] [int] NOT NULL CONSTRAINT [DF__Items_Pac__GPric__300F11AC] DEFAULT ((0)),
[IsEnabled] [int] NOT NULL CONSTRAINT [DF__Items_Pac__IsEna__310335E5] DEFAULT ((1)),
[AddGP] [int] NOT NULL CONSTRAINT [DF__Items_Pac__AddGP__31F75A1E] DEFAULT ((0)),
[AddSP] [int] NOT NULL CONSTRAINT [DF__Items_Pac__AddSP__32EB7E57] DEFAULT ((0)),
[Item1_ID] [int] NOT NULL CONSTRAINT [DF__Items_Pac__Item1__33DFA290] DEFAULT ((0)),
[Item1_Exp] [int] NOT NULL CONSTRAINT [DF__Items_Pac__Item1__34D3C6C9] DEFAULT ((0)),
[Item2_ID] [int] NOT NULL CONSTRAINT [DF__Items_Pac__Item2__35C7EB02] DEFAULT ((0)),
[Item2_Exp] [int] NOT NULL CONSTRAINT [DF__Items_Pac__Item2__36BC0F3B] DEFAULT ((0)),
[Item3_ID] [int] NOT NULL CONSTRAINT [DF__Items_Pac__Item3__37B03374] DEFAULT ((0)),
[Item3_Exp] [int] NOT NULL CONSTRAINT [DF__Items_Pac__Item3__38A457AD] DEFAULT ((0)),
[Item4_ID] [int] NOT NULL CONSTRAINT [DF__Items_Pac__Item4__39987BE6] DEFAULT ((0)),
[Item4_Exp] [int] NOT NULL CONSTRAINT [DF__Items_Pac__Item4__3A8CA01F] DEFAULT ((0)),
[Item5_ID] [int] NOT NULL CONSTRAINT [DF__Items_Pac__Item5__3B80C458] DEFAULT ((0)),
[Item5_Exp] [int] NOT NULL CONSTRAINT [DF__Items_Pac__Item5__3C74E891] DEFAULT ((0)),
[Item6_ID] [int] NOT NULL CONSTRAINT [DF__Items_Pac__Item6__3D690CCA] DEFAULT ((0)),
[Item6_Exp] [int] NOT NULL CONSTRAINT [DF__Items_Pac__Item6__3E5D3103] DEFAULT ((0))
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[Items_Packages] TO [support1]
GRANT INSERT ON  [dbo].[Items_Packages] TO [support1]
GRANT DELETE ON  [dbo].[Items_Packages] TO [support1]
GRANT UPDATE ON  [dbo].[Items_Packages] TO [support1]
GO

ALTER TABLE [dbo].[Items_Packages] ADD CONSTRAINT [PK_Items_Package] PRIMARY KEY CLUSTERED  ([ItemID]) ON [PRIMARY]
GO
