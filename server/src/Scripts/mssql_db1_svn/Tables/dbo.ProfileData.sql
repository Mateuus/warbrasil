CREATE TABLE [dbo].[ProfileData]
(
[CustomerID] [int] NOT NULL,
[Skills] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_ProfileData_Skills] DEFAULT ('0000000000'),
[Achievements] [char] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_ProfileData_Achievements] DEFAULT ((0)),
[Abilities] [char] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_ProfileData_Abilities] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProfileData] ADD CONSTRAINT [PK_ProfileData] PRIMARY KEY CLUSTERED  ([CustomerID]) ON [PRIMARY]
GO
