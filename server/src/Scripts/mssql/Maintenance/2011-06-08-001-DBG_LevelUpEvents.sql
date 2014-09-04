USE [gameid_v1]
GO

/****** Object:  Table [dbo].[DBG_LevelUpEvents]    Script Date: 06/08/2011 14:28:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DBG_LevelUpEvents](
	[CustomerID] [int] NULL,
	[LevelGained] [int] NULL,
	[ReportTime] [datetime] NULL,
	[SessionID] [bigint] NOT NULL
) ON [PRIMARY]

GO


