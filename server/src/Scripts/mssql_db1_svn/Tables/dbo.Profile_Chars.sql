CREATE TABLE [dbo].[Profile_Chars]
(
[LoadoutID] [int] NOT NULL IDENTITY(1, 1),
[CustomerID] [int] NOT NULL,
[Class] [int] NOT NULL,
[HonorPoints] [int] NOT NULL CONSTRAINT [DF_Profile_Chars_HonorPoints] DEFAULT ((0)),
[TimePlayed] [int] NOT NULL CONSTRAINT [DF_Profile_Chars_TimePlayed] DEFAULT ((0)),
[Loadout] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Skills] [char] (31) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Profile_C__Skill__4B180DA3] DEFAULT (''),
[SpendSP1] [int] NOT NULL CONSTRAINT [DF__Profile_C__Spend__4EE89E87] DEFAULT ((0)),
[SpendSP2] [int] NOT NULL CONSTRAINT [DF__Profile_C__Spend__4FDCC2C0] DEFAULT ((0)),
[SpendSP3] [int] NOT NULL CONSTRAINT [DF__Profile_C__Spend__50D0E6F9] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Profile_Chars] ADD CONSTRAINT [PK_Profile_Loadouts2] PRIMARY KEY CLUSTERED  ([LoadoutID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Profile_Loadouts2_CustomerID] ON [dbo].[Profile_Chars] ([CustomerID]) ON [PRIMARY]
GO
