CREATE TABLE [dbo].[DBG_SrvLogInfo]
(
[RecordID] [int] NOT NULL IDENTITY(1, 1),
[ReportTime] [datetime] NULL,
[IsProcessed] [int] NULL,
[CustomerID] [int] NULL,
[CustomerIP] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[GameSessionID] [bigint] NULL,
[CheatID] [int] NULL,
[RepeatCount] [int] NULL,
[Msg] [varchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Data] [varchar] (4096) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
