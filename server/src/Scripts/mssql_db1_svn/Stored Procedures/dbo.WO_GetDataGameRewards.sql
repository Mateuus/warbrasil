SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_GetDataGameRewards]
AS
BEGIN  
	SET NOCOUNT ON;  

	select 0 as ResultCode
	select * from DataGameRewards
END
GO
