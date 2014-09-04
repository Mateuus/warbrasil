SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[WO_RECORD_NAIVE_CCU]
AS
BEGIN

	SET NOCOUNT ON;


declare @today datetime
set @today = GETDATE()

declare @CCU int;

set @CCU = (select count(distinct CustomerID ) from LoginSessions where TimeUpdated > DATEADD(MINUTE, -10, @today))

INSERT INTO VitalStats_CCU (UpdateTime, CCU) VALUES (@today, @CCU );
	    
END





GO
