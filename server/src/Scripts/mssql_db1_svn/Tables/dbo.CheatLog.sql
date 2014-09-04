CREATE TABLE [dbo].[CheatLog]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[SessionID] [bigint] NOT NULL,
[CustomerID] [int] NOT NULL,
[CheatID] [int] NOT NULL,
[ReportTime] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CheatLog] ADD CONSTRAINT [PK_CheatLog] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
