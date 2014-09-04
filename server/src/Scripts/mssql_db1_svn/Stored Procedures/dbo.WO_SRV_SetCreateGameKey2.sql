SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_SRV_SetCreateGameKey2]
	@in_IP varchar(32),
	@in_ServerID int,
	@in_CreateGameKey int
AS
BEGIN
	SET NOCOUNT ON;

	if not exists (select ServerID from MasterServerInfo where ServerID=@in_ServerID) begin
		insert into MasterServerInfo (ServerID) values (@in_ServerID)
	end
	
	-- update
	UPDATE MasterServerInfo set 
		LastUpdated=GETDATE(),
		CreateGameKey = @in_CreateGameKey,
		IP=@in_IP
	WHERE ServerID = @in_ServerID
	if (@@RowCount = 0) begin
		select 6 as ResultCode
		return
	end
	
	select 0 as ResultCode

END
GO
