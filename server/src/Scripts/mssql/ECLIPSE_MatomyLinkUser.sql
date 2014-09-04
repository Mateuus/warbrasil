USE [gameid_v1]
GO

/****** Object:  StoredProcedure [dbo].[ECLIPSE_MatomyLinkUser]    Script Date: 09/07/2011 10:53:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ECLIPSE_MatomyLinkUser]
	@in_CustomerID int,
	@in_ce_pub varchar(32),
	@in_ce_cid varchar(64)
AS
BEGIN
	SET NOCOUNT ON;
	
	if exists (select CustomerID from MatomyUserMap where CustomerID=@in_CustomerID)
	begin
		select 0 as ResultCode, 'User is already linked' as ResultMsg
		return
	end
	
	insert into MatomyUserMap values (
		@in_CustomerID,
		@in_ce_pub,
		@in_ce_cid,
		GETDATE(),
		0,
		'1970-01-01'
		)

	-- done
	select 0 as ResultCode, '' as ResultMsg
END
GO
