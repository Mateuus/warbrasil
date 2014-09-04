USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_FactionAddRoundResult]    Script Date: 06/20/2011 16:16:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_FactionAddRoundResult] 
	@in_CustomerID int,
	@in_MapID int,
	@in_TeamID int,
	@in_Wins int
AS
BEGIN
	SET NOCOUNT ON;

	if(@in_Wins = 0)
		return

	-- detect faction id based on mapid
	-- FactionID is:
	--  1. Ironstone Security / Russians 
	--  2. Shadow Corp Unlimited - USA
	--  3. United Warriors - Africa
	--  4. Brotherhood - Middle East, North Africa
	--  5. Roaring Tigers - China
	
	declare @Fact1 int -- blue faction id
	declare @Fact2 int -- red faction id
	
	if(@in_MapID = 2) begin 
		-- Crossroads16
		set @Fact1  = 2;
		set @Fact2  = 4;
	end
	else if(@in_MapID = 3 or @in_MapID = 12) begin
		-- Grozny and Grozny_CQ
		set @Fact1  = 1;
		set @Fact2  = 4;
	end 
	else if(@in_MapID = 10) begin 
		-- Burning Sea
		set @Fact1  = 3;
		set @Fact2  = 5;
	end
	else if(@in_MapID = 4) begin 
		-- Torn CQ
		set @Fact1  = 2;
		set @Fact2  = 1;
	end
	else if(@in_MapID = 9) begin 
		-- Nightfall
		set @Fact1  = 5;
		set @Fact2  = 3;
	end
	else begin
		-- not faction ranked map
		return
	end
	
	-- faction based on your team
	declare @RwdFact int
	if(@in_TeamID = 0) set @RwdFact = @Fact1
	else if(@in_TeamID = 1) set @RwdFact = @Fact2
	else return
	
	-- get previous faction score
	declare @PrevScore int
	     if(@RwdFact = 1)	select @PrevScore=Faction1Score from LoginID where CustomerID=@in_CustomerID
	else if(@RwdFact = 2)	select @PrevScore=Faction2Score from LoginID where CustomerID=@in_CustomerID
	else if(@RwdFact = 3)	select @PrevScore=Faction3Score from LoginID where CustomerID=@in_CustomerID
	else if(@RwdFact = 4)	select @PrevScore=Faction4Score from LoginID where CustomerID=@in_CustomerID
	else if(@RwdFact = 5)	select @PrevScore=Faction5Score from LoginID where CustomerID=@in_CustomerID
	
	-- update new faction score
	declare @NewScore int = @PrevScore + 1
	     if(@RwdFact = 1)	update LoginID set Faction1Score=@NewScore where CustomerID=@in_CustomerID
	else if(@RwdFact = 2)	update LoginID set Faction2Score=@NewScore where CustomerID=@in_CustomerID
	else if(@RwdFact = 3)	update LoginID set Faction3Score=@NewScore where CustomerID=@in_CustomerID
	else if(@RwdFact = 4)	update LoginID set Faction4Score=@NewScore where CustomerID=@in_CustomerID
	else if(@RwdFact = 5)	update LoginID set Faction5Score=@NewScore where CustomerID=@in_CustomerID
	
	-- apply faction rewards
	exec WO_FactionAddReward @in_CustomerID, @RwdFact, @PrevScore, @NewScore
	
END
