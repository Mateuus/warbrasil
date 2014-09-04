CREATE TABLE [dbo].[DBG_WOAdminChanges]
(
[ChangeID] [int] NOT NULL IDENTITY(1, 1),
[ChangeTime] [datetime] NULL,
[UserName] [nvarchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Action] [int] NULL,
[Field] [varchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordID] [int] NULL,
[OldValue] [varchar] (2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NewValue] [varchar] (2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
GRANT INSERT ON  [dbo].[DBG_WOAdminChanges] TO [support1]
GO
