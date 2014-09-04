CREATE TABLE [dbo].[LoginSessions]
(
[CustomerID] [int] NOT NULL,
[SessionKey] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SessionID] [int] NOT NULL CONSTRAINT [DF_LoginSessions_SessionID] DEFAULT ((0)),
[LoginIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TimeLogged] [datetime] NOT NULL,
[TimeUpdated] [datetime] NOT NULL,
[GameSessionID] [bigint] NOT NULL CONSTRAINT [DF__LoginSess__GameS__15261146] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoginSessions] ADD CONSTRAINT [PK_LoginSessions] PRIMARY KEY CLUSTERED  ([CustomerID]) ON [PRIMARY]
GO
