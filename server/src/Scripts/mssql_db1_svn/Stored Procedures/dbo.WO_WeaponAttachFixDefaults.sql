SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_WeaponAttachFixDefaults]
	@in_CustomerID int,
	@in_WeaponID int
AS
BEGIN
	SET NOCOUNT ON;
	
	--
	-- this procedure is called from client in case weapons is missing its default attachments
	-- so we need to fix that.
	--
	
	if(not exists (select * from Inventory where CustomerID=@in_CustomerID and ItemID=@in_WeaponID and LeasedUntil>GETDATE()))
	begin
		select 6 as ResultCode, 'no such weapon' as ResultMsg
		return
	end
	
	exec FN_AddDefaultAttachments @in_CustomerID, @in_WeaponID, 2000
	
	select 0 as 'ResultCode'
	return
END

GO
