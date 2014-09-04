USE [gameid_v1]
GO

/****** Object:  Table [dbo].[DBG_SrvLogInfo]    Script Date: 11/15/2011 21:21:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DBG_SrvLogInfo](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[ReportTime] [datetime] NULL,
	[IsProcessed] [int] NULL,
	[CustomerID] [int] NULL,
	[CustomerIP] [varchar](64) NULL,
	[GameSessionID] [bigint] NULL,
	[CheatID] [int] NULL,
	[RepeatCount] [int] NULL,
	[Msg] [varchar](512) NULL,
	[Data] [varchar](4096) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


