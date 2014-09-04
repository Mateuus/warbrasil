CREATE TABLE [dbo].[Logins]
(
[LoginID] [int] NOT NULL IDENTITY(1, 1),
[CustomerID] [int] NOT NULL CONSTRAINT [DF_Logins_CustomerID] DEFAULT ((0)),
[LoginTime] [datetime] NOT NULL CONSTRAINT [DF_Logins_LoginTime] DEFAULT (((12)/(1))/(1973)),
[IP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Logins_IP] DEFAULT ('1.1.1.1'),
[LoginSource] [int] NOT NULL CONSTRAINT [DF_Logins_Source] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Logins] ADD CONSTRAINT [PK_Logins] PRIMARY KEY CLUSTERED  ([LoginID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_Logins_CustomerID_LoginTime] ON [dbo].[Logins] ([CustomerID], [LoginTime]) ON [PRIMARY]
GO
