USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_LeaderboardGet]    Script Date: 10/11/2011 12:47:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_LeaderboardGet]
	@in_CustomerID int,
	@in_TableID int,
	@in_StartPos int
AS
BEGIN
	SET NOCOUNT ON;

	-- this call is always success
	select 0 as ResultCode
	
	declare @TotalRows int = 0
	declare @ROWS_TO_FETCH int = 100
	
	-- if need to find our position in leaderboard
	if(@in_StartPos < 0) 
	begin
		if(@in_TableID = 0) begin
			select @in_StartPos=Pos from Leaderboard1 where CustomerID=@in_CustomerID
			select @TotalRows=COUNT(*) from Leaderboard1
		end else if(@in_TableID = 1) begin
			select @in_StartPos=Pos from Leaderboard7 where CustomerID=@in_CustomerID
			select @TotalRows=COUNT(*) from Leaderboard7
		end else if(@in_TableID = 2) begin
			select @in_StartPos=Pos from Leaderboard30 where CustomerID=@in_CustomerID
			select @TotalRows=COUNT(*) from Leaderboard30
		end else begin
			select @in_StartPos=Pos from Leaderboard where CustomerID=@in_CustomerID
			select @TotalRows=COUNT(*) from Leaderboard
		end
	
		set @in_StartPos = @in_StartPos - (@ROWS_TO_FETCH / 2)
		if(@in_StartPos < 0)
			set @in_StartPos = 0
	end

	-- report starting position
	select @in_StartPos as 'StartPos', @TotalRows as 'Size'
	
	-- return actual leaderboard

	if(@in_TableID = 0) begin
		select * from Leaderboard1 where Pos > @in_StartPos and Pos <= (@in_StartPos + @ROWS_TO_FETCH)
			order by HonorPoints desc
	end else if(@in_TableID = 1) begin
		select * from Leaderboard7 where Pos > @in_StartPos and Pos <= (@in_StartPos + @ROWS_TO_FETCH)
			order by HonorPoints desc
	end else if(@in_TableID = 2) begin
		select * from Leaderboard30 where Pos > @in_StartPos and Pos <= (@in_StartPos + @ROWS_TO_FETCH)
			order by HonorPoints desc
	end else begin
		select * from Leaderboard where Pos > @in_StartPos and Pos <= (@in_StartPos + @ROWS_TO_FETCH)
			order by HonorPoints desc
	end
	
END
