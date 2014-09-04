CREATE TABLE [dbo].[AccountPwdReset]
(
[RequestID] [int] NOT NULL IDENTITY(1, 1),
[RequestTime] [datetime] NOT NULL,
[IP] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[token] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CustomerID] [int] NOT NULL,
[email] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AccountPwdReset] ADD CONSTRAINT [PK_AccountPasswordReset] PRIMARY KEY CLUSTERED  ([RequestID]) ON [PRIMARY]
GO
