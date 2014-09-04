SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[WO_RECORD_DAILY_STATS]
AS
BEGIN

	SET NOCOUNT ON;


declare @today datetime
set @today = GETDATE()

declare @Visitors int;
declare @TUsersLogin int;
declare @TUsersActive int;
declare @TUsersJoined int;
declare @TUsersPlayed int;

declare @NewVisitors int;
declare @NewActived int;

declare @MAUL int;
declare @MAUJ int;
declare @MAUP int;
declare @DAUL int;
declare @DAUJ int;
declare @DAUP int;


set @Visitors = (select count(*) from LoginID)
set @TUsersLogin = (select count(*) from LoginID where AccountStatus>100 and lastlogindate > '3-28-2010 00:00:00')
set @TUsersActive = (select count(*) from LoginID where AccountStatus>100 )
set @TUsersJoined = (select count(*) from LoginID where AccountStatus>100 and lastjoineddate > '3-28-2010 00:00:00')
set @TUsersPlayed = (select count(*) from LoginID where AccountStatus>100 and lastgamedate > '3-28-2010 00:00:00')

set @NewVisitors = (select count(*) from LoginID where dateregistered >DATEADD(day, -1, @today))
set @NewActived = (select count(*) from LoginID where dateregistered >DATEADD(day, -1, @today) and AccountStatus>100)


set @MAUL = (select count(*) from LoginID where lastlogindate > DATEADD(day, -31, @today) )
set @MAUJ = (select count(*) from LoginID where lastjoineddate > DATEADD(day, -31, @today) )
set @MAUP = (select count(*) from LoginID where lastgamedate > DATEADD(day, -31, @today) )


set @DAUL = (select count(*) from LoginID where lastlogindate > DATEADD(hour, -25, @today) )
set @DAUJ = (select count(*) from LoginID where lastjoineddate > DATEADD(hour, -25, @today) )
set @DAUP = (select count(*) from LoginID where lastgamedate > DATEADD(hour, -25, @today) )


declare @CashPaying int;
declare @Cash24Paying int;
declare @Cash24Num int;

declare @Cash24Total float;
declare @CashTotal float;

declare @CashM float;
declare @CashMPaying int;

declare @ARPU float;
declare @ARPPU float;


set @CashPaying = (SELECT COUNT (distinct CustomerID) FROM FinancialTransactions where TransactionType=1000 )
set @CashTotal = (SELECT SUM(Amount) FROM FinancialTransactions where TransactionType=1000 )

set @Cash24Num= (select count(*) from FinancialTransactions where DateTime > DATEADD(hour, -26, @today ) and TransactionType = 1000)
set @Cash24Paying = (SELECT COALESCE(COUNT (distinct CustomerID),0) FROM FinancialTransactions where DateTime > DATEADD(hour, -26, @today ) and TransactionType=1000 )
set @Cash24Total = (SELECT COALESCE(SUM(Amount),0) FROM FinancialTransactions where DateTime >DATEADD(hour, -26, @today ) and TransactionType=1000 )

set @CashM = (SELECT COALESCE(SUM(Amount),0) FROM FinancialTransactions where DateTime >DATEADD(day, -32, @today ) and TransactionType=1000 )
set @CashMPaying = (SELECT COALESCE(COUNT (distinct CustomerID),0) FROM FinancialTransactions where DateTime >DATEADD(day, -32, @today ) and TransactionType=1000 )

set @ARPU = @CashM/(@MAUP)
set @ARPPU = @CashM/(@CashMPaying)

declare @PlayedToday int;


set @PlayedToday = (select count(distinct GameSessionID ) from DBG_UserRoundResults where GameReportTime > DATEADD(day, -1, GETDATE()))

INSERT INTO VitalStatsV3 (	UpdateTime, TotalVisitors, TotalUsersLogin, TotalUsersActivated, TotalUsersJoined, TotalUsersPlayed, 	NewRegistered,	NewActivated,	MAU_Login,	MAU_Joined,	MAU_Played,	DAU_Login,	DAU_Joined, 	DAU_Played,	Cash24Num,	Cash24Total,	Cash24Paying,	CashTotal,	CashPaying,	ARPU,	ARPPU,	PlayedToday) VALUES (@today, @Visitors, @TUsersLogin, @TUsersActive, @TUsersJoined, @TUsersPlayed, @NewVisitors, @NewActived, @MAUL, @MAUJ,  @MAUP,@DAUL,  @DAUJ,  @DAUP, @Cash24Num, @Cash24Total,@Cash24Paying, @CashTotal,@CashPaying,@ARPU,@ARPPU,@PlayedToday );

	    
END




GO
