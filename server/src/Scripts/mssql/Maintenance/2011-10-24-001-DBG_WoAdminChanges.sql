USE [gameid_v1]
GO

/****** Object:  Table [dbo].[DBG_WOAdminChanges]    Script Date: 10/24/2011 14:46:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DBG_WOAdminChanges](
	[ChangeID] [int] IDENTITY(1,1) NOT NULL,
	[ChangeTime] [datetime] NULL,
	[UserName] [varchar](64) NULL,
	[Action] [int] NULL,
	[Field] [varchar](512) NULL,
	[RecordID] [int] NULL,
	[OldValue] [varchar](2048) NULL,
	[NewValue] [varchar](2048) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


