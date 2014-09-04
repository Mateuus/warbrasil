USE [gameid_v1]
GO

alter table LoginID add lastRetBonusDate datetime
GO

/****** Object:  Table [dbo].[DataRetentionBonuses]    Script Date: 03/16/2012 11:52:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DataRetentionBonuses](
	[Day] [int] NOT NULL,
	[Bonus] [int] NOT NULL,
 CONSTRAINT [PK_DataRetentionBonuses] PRIMARY KEY CLUSTERED 
(
	[Day] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


!!!!
NOTE: must set lastRetBonusDate to GETDATE() when applying this patch
