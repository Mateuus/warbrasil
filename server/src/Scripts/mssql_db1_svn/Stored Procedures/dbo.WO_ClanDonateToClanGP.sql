
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_ClanDonateToClanGP]
	@in_CustomerID int,
	@in_GP int
AS
BEGIN
	SET NOCOUNT ON;
	
-- sanity checks
	declare @ClanID int
	declare @ClanRank int
	declare @Gamertag nvarchar(64)
	declare @GamePoints int
	select @ClanID=ClanID, @ClanRank=ClanRank, @Gamertag=Gamertag, @GamePoints=GamePoints from LoginID where CustomerID=@in_CustomerID
	if(@ClanID = 0) begin
		select 6 as ResultCode, 'not in clan' as ResultMsg
		return
	end
	
	if(@in_GP < 0) begin
		select 6 as ResultCode, 'sneaky bastard...' as ResultMsg
		return
	end
	if(@in_GP > @GamePoints) begin
		select 6 as ResultCode, 'not enough GP' as ResultMsg
		return
	end

	-- customer must have purchased GP
	if not exists (select * from FinancialTransactions where TransactionType=1000 and CustomerID=@in_CustomerID) begin
		select 26 as ResultCode, 'must have GP purchased' as ResultMsg
		return
	end
	-- most not be greater that sum of last 30 days purchases
	declare @BuyDate datetime = DATEADD(day, -30, GETDATE())
	declare @BuyAmount float = 0
	select @BuyAmount=SUM(amount) from FinancialTransactions where TransactionType=1000 and CustomerID=@in_CustomerID
	if(@in_GP > @BuyAmount) begin
		select 26 as ResultCode, '30 days limit' as ResultMsg
		return
	end
	
-- donating

	-- substract GP
	declare @AlterGP int = -@in_GP
	exec FN_AlterUserGP @in_CustomerID, @AlterGP, 'toclan'
	update LoginID set ClanContributedGP=(ClanContributedGP+@in_GP) where CustomerID=@in_CustomerID
	-- and record that
	INSERT INTO FinancialTransactions
		VALUES (@in_CustomerID, 'CLAN_GPToClan', 4000, GETDATE(), 
				@in_GP, '1', 'APPROVED', @ClanID)
	
	-- add clan gp
	update ClanData set ClanGP=(ClanGP+@in_GP) where ClanID=@ClanID

-- generate clan event
	insert into ClanEvents (
		ClanID,
		EventDate,
		EventType,
		EventRank,
		Var1,
		Var3,
		Text1
	) values (
		@ClanID,
		GETDATE(),
		10, -- CLANEvent_DonateToClanGP
		99, -- Visible to all
		@in_CustomerID,
		@in_GP,
		@Gamertag
	)

	-- success
	select 0 as ResultCode
END
GO
