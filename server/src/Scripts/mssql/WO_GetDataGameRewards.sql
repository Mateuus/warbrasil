USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_GetDataGameRewards]    Script Date: 12/13/2011 18:41:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_GetDataGameRewards]
AS
BEGIN  
	SET NOCOUNT ON;  

	select 0 as ResultCode
	select * from DataGameRewards
END
