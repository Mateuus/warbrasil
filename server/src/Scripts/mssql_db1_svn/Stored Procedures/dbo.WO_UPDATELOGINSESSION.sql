SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_UPDATELOGINSESSION]
	@in_IP varchar(32),
	@in_CustomerID int,
	@in_SessionID int
AS
BEGIN
	SET NOCOUNT ON;
	
	declare @SessionID int
	declare @IP varchar(16)

	-- check if we have record for that user          
	SELECT 
		@SessionID=LoginSessions.SessionID,
		@IP=LoginSessions.LoginIP
	FROM LoginSessions
	WHERE CustomerID=@in_CustomerID
	if (@@RowCount = 0) begin
		select 6 as ResultCode
		return
	end

	-- compare session key. if it's different, supplied sesson is invalid	
	if(@in_SessionID <> @SessionID) begin
		select 1 as ResultCode
		return
	end
	
	-- update last ping time
	UPDATE LoginSessions SET 
		LoginSessions.TimeUpdated=GETDATE()
	WHERE CustomerID=@in_CustomerID
	
	select 0 as ResultCode
END
GO
