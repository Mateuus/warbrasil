SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[ECLIPSE_PROCESSTRANSACTION_CHECK]
	@in_CustomerID int,
	@in_DoBlock int
AS
BEGIN
	SET NOCOUNT ON;
	
	if(@in_DoBlock > 0) begin
		-- block user
		delete from FinancialBlocks where CustomerID=@in_CustomerID
		insert into FinancialBlocks values (@in_CustomerID, GETDATE())
		return
	end
	
	-- check block status
	declare @LastBlockedTime datetime
	select @LastBlockedTime=LastBlockedTime from FinancialBlocks where CustomerID=@in_CustomerID
	if(@@ROWCOUNT = 0) begin
		select 0 as 'Blocked'
	end
	
	-- enforce 60 sec delay between blocked transactions
	declare @secs int = DATEDIFF(second, @LastBlockedTime, GETDATE())
	if(@secs < 60) begin
		select 1 as 'Blocked'
	end
	
	select 0 as 'Blocked'
END
GO
