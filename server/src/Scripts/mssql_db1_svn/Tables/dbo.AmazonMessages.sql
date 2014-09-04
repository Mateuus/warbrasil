CREATE TABLE [dbo].[AmazonMessages]
(
[MessageIdentity] [int] NOT NULL IDENTITY(1, 1),
[MessageId] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MessageBody] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MessageTime] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AmazonMessages] ADD CONSTRAINT [PK_AmazonMessages] PRIMARY KEY CLUSTERED  ([MessageIdentity]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_AmazonMessages_MessageId] ON [dbo].[AmazonMessages] ([MessageId]) ON [PRIMARY]
GO
