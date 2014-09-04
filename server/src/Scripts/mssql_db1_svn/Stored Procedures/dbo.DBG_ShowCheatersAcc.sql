SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[DBG_ShowCheatersAcc]
AS
BEGIN
	SET NOCOUNT ON;

	select LoginID.AccountName, DBG_UserRoundResults.* from DBG_UserRoundResults 
		join LoginID on LoginId.CustomerID=DBG_UserRoundResults.CustomerID
		where ShotsFired>50 and ShotsHits>ShotsFired*0.9
		and exists (select CustomerID from LoginID 
			where LoginID.CustomerID=DBG_UserRoundResults.CustomerID 
				and LoginID.AccountStatus<200
			)
		order by GameReportTime desc
		
END
GO
