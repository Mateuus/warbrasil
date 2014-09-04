USE [gameid_v1]
GO

/****** Object:  Table [dbo].[DBG_ReferredEvents]    Script Date: 02/01/2012 16:30:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DBG_ReferredEvents](
	[CustomerID] [int] NOT NULL,
	[InvitedID] [int] NOT NULL,
	[LevelUpTime] [datetime] NOT NULL,
	[NumReferrers] [int] NOT NULL
) ON [PRIMARY]

GO


