USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_SRV_AddLogInfo]    Script Date: 11/15/2011 19:28:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[WO_SRV_AddLogInfo]
	@in_CustomerID int,
	@in_CustomerIP varchar(64),
	@in_GameSessionID bigint,
	@in_CheatID int,
	@in_Msg varchar(4000),
	@in_Data varchar(4000)
AS
BEGIN
	SET NOCOUNT ON;
	
	-- see if this event is recurring inside single game session
	declare @RecordID int
	select @RecordID=RecordID from DBG_SrvLogInfo where
		GameSessionID=@in_GameSessionID 
		and CustomerID=@in_CustomerID
		and (@in_CheatID > 0 and CheatID=@in_CheatID)
		and @in_Msg=Msg 
		and @in_Data=Data
	if(@@ROWCOUNT > 0) begin
		-- increase count
		update DBG_SrvLogInfo set RepeatCount=RepeatCount+1 where RecordID=@RecordID

		select 0 as ResultCode
		return
	end
	
	insert into DBG_SrvLogInfo (
		ReportTime,
		IsProcessed,
		CustomerID,
		CustomerIP,
		GameSessionID,
		CheatID,
		RepeatCount,
		Msg,
		Data)
	values (
		GETDATE(),
		0,
		@in_CustomerID,
		@in_CustomerIP,
		@in_GameSessionID,
		@in_CheatID,
		1,
		@in_Msg,
		@in_Data)
		
	-- we're done
	select 0 as ResultCode
END
