CREATE TABLE [dbo].[MatomyUserMap]
(
[CustomerID] [int] NOT NULL,
[ce_pub] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ce_cid] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateRegistered] [datetime] NULL,
[IsConverted] [int] NULL,
[DateConverted] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MatomyUserMap] ADD CONSTRAINT [PK_MatomyUserMap] PRIMARY KEY CLUSTERED  ([CustomerID]) ON [PRIMARY]
GO
