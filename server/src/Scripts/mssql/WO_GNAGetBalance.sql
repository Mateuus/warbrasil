USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_GNAGetBalance]    Script Date: 06/03/2011 16:04:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_GNAGetBalance]
	@in_CustomerID int
AS
BEGIN
	SET NOCOUNT ON;

	-- gna service id for warinc
	declare @ServiceId bigint = 300005010000000000

	-- get points for that customer
	declare @GNAUserId bigint
	select @GNAUserId=GNAUserId from LoginID where CustomerID=@in_CustomerID
	if (@@RowCount = 0) begin
		select 6 as ResultCode, 'no CustomerID' as ResultMsg
		return
	end
	declare @AuthId varchar(40)
	set @AuthId = convert(varchar(32), @GnaUserID)

	-- get balance from gamenet
	DECLARE @o_Balance money;
	DECLARE @o_Error int;

	SET @o_Balance = NULL;
	SET @o_Error = NULL;
	EXEC dblink_api.billing.dbo.usp_GetBalance 
		@i_ServiceId = @ServiceId,
		@i_AuthType = 'user_id',
		@i_AuthId = @AuthId,
		@o_Balance = @o_Balance out,
		@o_Error = @o_Error out;
	if(@o_Error > 0) begin
		select 6 as ResultCode, 'can not get balance' as ResultMsg
		return
	end
	
	-- convert NULL to 0
	if(@o_Balance is NULL) set @o_Balance = 0

	declare @Balance int = convert(int, @o_Balance)
	select 0 as ResultCode
	select @Balance as 'GNABalance'

END
