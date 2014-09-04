SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_BuyItemFN_AddClanMembers]
	@out_FNResult int out,
	@in_CustomerID int,
	@in_ItemID int
AS
BEGIN
	SET NOCOUNT ON;
	
	--
	--
	-- function must be called from WO_BuyItemFN_Exec
	--
	--

	-- add members value is in 1day GP price
	declare @Price1 int = 0
	select @Price1=Price1 from Items_Generic where ItemID=@in_ItemID
	if(@Price1 = 0) begin
		set @out_FNResult = 1
		return
	end
	
	-- check if user have clan
	declare @ClanID int = 0
	declare @Gamertag nvarchar(32)
	select @ClanID=ClanID, @Gamertag=Gamertag from LoginID where CustomerID=@in_CustomerID
	if(@ClanID = 0) begin
		set @out_FNResult = 2
		return
	end
	
	-- update clan
	update ClanData set MaxClanMembers=(MaxClanMembers+@Price1) where ClanID=@ClanID
	
	-- generate clan event
	insert into ClanEvents (
		ClanID,
		EventDate,
		EventType,
		EventRank,
		Var1,
		Var2,
		Text1
	) values (
		@ClanID,
		GETDATE(),
		13, -- ClanEvent_AddMaxMembers
		99, -- Visible to all
		@in_CustomerID,
		@Price1,
		@Gamertag
	)
	
	-- success
	set @out_FNResult = 0

END
GO
