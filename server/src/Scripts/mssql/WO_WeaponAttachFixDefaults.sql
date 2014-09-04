USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_WeaponAttachFixDefaults]    Script Date: 03/21/2012 15:08:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_WeaponAttachFixDefaults]
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

