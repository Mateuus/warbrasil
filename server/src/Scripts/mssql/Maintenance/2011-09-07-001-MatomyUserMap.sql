USE [gameid_v1]
GO

/****** Object:  Table [dbo].[MatomyUserMap]    Script Date: 09/07/2011 10:38:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[MatomyUserMap](
	[CustomerID] [int] NOT NULL,
	[ce_pub] [varchar](32) NULL,
	[ce_cid] [varchar](64) NULL,
	[DateRegistered] [datetime] NULL,
	[IsConverted] [int] NULL,
	[DateConverted] [datetime] NULL,
 CONSTRAINT [PK_MatomyUserMap] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


