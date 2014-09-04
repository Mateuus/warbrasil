CREATE TABLE [dbo].[MasterServerInfo]
(
[ServerID] [int] NOT NULL CONSTRAINT [DF_MasterServerInfo_ServerID] DEFAULT ((0)),
[LastUpdated] [datetime] NOT NULL CONSTRAINT [DF_MasterServerInfo_LastUpdated] DEFAULT (((1)/(1))/(1970)),
[CreateGameKey] [int] NOT NULL CONSTRAINT [DF_MasterServerInfo_CreateGameKey] DEFAULT ((0)),
[IP] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_MasterServerInfo_IP] DEFAULT ('0.0.0.0')
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MasterServerInfo] ADD CONSTRAINT [PK_MasterServerInfo] PRIMARY KEY CLUSTERED  ([ServerID]) ON [PRIMARY]
GO
