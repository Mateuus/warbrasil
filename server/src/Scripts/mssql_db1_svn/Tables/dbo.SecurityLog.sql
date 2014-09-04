CREATE TABLE [dbo].[SecurityLog]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[EventID] [int] NOT NULL,
[Date] [datetime] NOT NULL,
[IP] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_SecurityLog_IP] DEFAULT ('0.0.0.0'),
[CustomerID] [int] NOT NULL CONSTRAINT [DF_SecurityLog_UserID] DEFAULT ((0)),
[EventData] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_SecurityLog_EventData] DEFAULT ('')
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SecurityLog] ADD CONSTRAINT [PK_SecurityLog] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
