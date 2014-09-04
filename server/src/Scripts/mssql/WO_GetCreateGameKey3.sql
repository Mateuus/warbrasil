USE [gameid_v1]
GO

/****** Object:  StoredProcedure [dbo].[WO_GetCreateGameKey3]    Script Date: 11/23/2011 15:56:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[WO_GetCreateGameKey3]
	@in_IP varchar(32),
	@in_CustomerID int,
	@in_ServerID int,
	@in_BasicGame int
AS
BEGIN
	SET NOCOUNT ON;

	-- always return success
	select 0 as ResultCode
	
	declare @PREMIUM_ITEM_ID int = 301004

	-- basic games requires level 20+ or premium account
	-- premium game requires only premium account
	
	if(@in_BasicGame=1) begin
		-- check player's level, should be 20+ to create a game
		declare @honorPoints int = 0
		select @honorPoints=[HonorPoints] from LoginID where CustomerID=@in_CustomerID
		declare @HPLevel20 int = 0
		select @HPLevel20=[HonorPoints] from DataRankPoints where [Rank]=19 -- ranks in DB are starting from 1, hence check with 19
		if(@honorPoints<@HPLevel20) -- if not level 20+, then reject
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
	end
	else begin
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


GO


