USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_GetCreateGameKey2]    Script Date: 07/25/2011 11:49:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_GetCreateGameKey2]
	@in_IP varchar(32),
	@in_CustomerID int,
	@in_ServerID int
AS
BEGIN
	SET NOCOUNT ON;

	-- always return success
	select 0 as ResultCode
	
	declare @PREMIUM_ITEM_ID int = 301004

	-- check player's level, should be 40+ to create a game
	declare @honorPoints int = 0
	select @honorPoints=[HonorPoints] from LoginID where CustomerID=@in_CustomerID
	declare @HPLevel40 int = 0
	select @HPLevel40=[HonorPoints] from DataRankPoints where [Rank]=39 -- ranks in DB are starting from 1, hence check with 39
	if(@honorPoints<@HPLevel40) -- if not level 40+, then check for premium account
	begin
		--check if user have premium account
		if not exists(
			select ItemID from Inventory 
				where (CustomerID = @in_CustomerID and ItemID = @PREMIUM_ITEM_ID))
		begin
			select 0 as CreateGameKey
			return
		end
	end
	
	-- retrieve create game key from master server info
	declare @CreateGameKey int
	select @CreateGameKey=CreateGameKey from MasterServerInfo 
		where ServerID = @in_ServerID
	if(@@ROWCOUNT = 0) begin
		EXEC FN_ADD_SECURITY_LOG 301, @in_IP, @in_CustomerID, @in_ServerID
		select 0 as CreateGameKey
		return
	end

	select @CreateGameKey as CreateGameKey

END
