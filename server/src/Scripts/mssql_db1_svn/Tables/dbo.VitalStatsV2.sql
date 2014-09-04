CREATE TABLE [dbo].[VitalStatsV2]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[UpdateTime] [datetime] NOT NULL,
[TotalUsers] [int] NULL,
[NewUsers] [int] NULL,
[LoggedIn] [int] NULL,
[NonActive] [int] NULL,
[PlayedGame] [int] NULL,
[CCU] [int] NOT NULL,
[DAU] [int] NULL,
[MAU] [int] NULL,
[ActiveSessions] [int] NULL,
[CashNum] [int] NULL,
[CashTotal] [float] NULL,
[GPNum] [int] NULL,
[GPTotal] [int] NULL,
[DAU1] [int] NULL CONSTRAINT [DF_VitalStatsV2_DAU1] DEFAULT ((0)),
[MAU1] [int] NULL CONSTRAINT [DF_VitalStatsV2_MAU1] DEFAULT ((0))
) ON [PRIMARY]
GO
