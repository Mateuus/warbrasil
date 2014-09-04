SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_ClanCreateCheckParams]
	@in_CustomerID int,
	@in_ClanName nvarchar(64),
	@in_ClanTag nvarchar(4)
AS
BEGIN
	SET NOCOUNT ON;

	-- user can't create more that one clan
	declare @ClanID int = 0
	select @ClanID=ClanID from LoginID where CustomerID=@in_CustomerID
	if(@ClanID > 0) begin
		select 6 as ResultCode, 'already have clan' as ResultMsg
		return
	end
	
	-- check that name/tag is unique
	if(exists(select * from ClanData where ClanName=@in_ClanName)) begin
		select 27 as ResultCode, 'clan name' as ResultMsg
		return
	end
	if(exists(select * from ClanData where ClanTag=@in_ClanTag)) begin
		select 28 as ResultCode, 'clan tag' as ResultMsg
		return
	end

	select 0 as ResultCode
	return
END
GO
