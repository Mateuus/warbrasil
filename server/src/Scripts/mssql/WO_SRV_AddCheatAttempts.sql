USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_SRV_AddCheatAttempt]    Script Date: 04/15/2011 19:14:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[WO_SRV_AddCheatAttempt]
	@in_IP char(32),
	@in_CustomerID int,
	@in_GameSessionID bigint,

	@in_CheatID int
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO CheatLog (SessionID, CustomerID, CheatID, ReportTime)
	VALUES               (@in_GameSessionID, @in_CustomerID, @in_CheatID, GETDATE())

	-- increase cheat attempts
	update Stats set CheatAttempts=(CheatAttempts+1) where CustomerID=@in_CustomerID

	-- we're done
	select 0 as ResultCode
END
