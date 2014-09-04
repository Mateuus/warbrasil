CREATE TABLE [dbo].[VitalStatsV3]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[UpdateTime] [datetime] NOT NULL,
[TotalVisitors] [int] NULL,
[TotalUsersLogin] [int] NULL,
[TotalUsersActivated] [int] NULL,
[TotalUsersJoined] [int] NULL,
[TotalUsersPlayed] [int] NULL,
[NewRegistered] [int] NULL,
[NewActivated] [int] NULL,
[MAU_Login] [int] NULL,
[MAU_Joined] [int] NULL,
[MAU_Played] [int] NULL,
[DAU_Login] [int] NULL,
[DAU_Joined] [int] NULL,
[DAU_Played] [int] NULL,
[Cash24Num] [int] NULL,
[Cash24Total] [float] NULL,
[Cash24Paying] [int] NULL,
[CashTotal] [float] NULL,
[CashPaying] [int] NULL,
[ARPU] [float] NULL,
[ARPPU] [float] NULL,
[PlayedToday] [int] NULL
) ON [PRIMARY]
GO
