USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_FactionAddReward]    Script Date: 06/20/2011 16:13:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_FactionAddReward] 
	@in_CustomerID int,
	@in_FactionID int,
	@in_PrevScore int,
	@in_NewScore int
AS
BEGIN
	SET NOCOUNT ON;

	--
	--
	-- this internal function used for adding items based on faction ID and faction score
	--
	--
	
	--SAMPLE:
	--if(@in_FactionID = 1 and @in_PrevScore < 100 and @in_NewScore >= 100) begin
	--	exec FN_AddItemToUser @in_CustomerID, 301001, 7
	--	return
	--end
	
END
