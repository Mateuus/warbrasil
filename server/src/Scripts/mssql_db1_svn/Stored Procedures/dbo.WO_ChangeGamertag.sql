SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_ChangeGamertag]
	@in_IP char(32),
	@in_CustomerID int,
	@in_GamerTag nvarchar(32),
	@in_ActualExec int
AS
BEGIN
	SET NOCOUNT ON;
	
	-- change gamertag
	if(@in_ActualExec > 0) begin
		update LoginID set Gamertag=@in_GamerTag where CustomerID=@in_CustomerID
		select 0 as ResultCode
		return
	end

	-- check if gamertag is unique
	if exists (select CustomerID from LoginID where Gamertag=@in_GamerTag) begin
		select 9 as ResultCode, 'Gamertag already exists' as ResultMsg
		return
	end

	select 0 as ResultCode
END
GO
