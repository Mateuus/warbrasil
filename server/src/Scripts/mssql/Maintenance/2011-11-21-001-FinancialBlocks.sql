USE [gameid_v1]
GO

/****** Object:  Table [dbo].[FinancialBlocks]    Script Date: 11/21/2011 16:57:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FinancialBlocks](
	[CustomerID] [int] NOT NULL,
	[LastBlockedTime] [datetime] NOT NULL,
 CONSTRAINT [PK_FinancialBlocks] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


