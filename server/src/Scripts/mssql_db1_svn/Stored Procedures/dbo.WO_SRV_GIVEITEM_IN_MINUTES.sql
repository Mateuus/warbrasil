SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		Pavel Tumik
-- Create date: May 24, 2011
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[WO_SRV_GIVEITEM_IN_MINUTES] 
	@in_IP char(32),
	@in_CustomerID int,
	@in_ItemId int,
	@in_BuyMinutes int,
	@in_skey2 varchar(64)
AS
BEGIN
	if(@in_skey2 != 'ACsR4x23GsjYU*476xnDvYXK@!56')
	begin
		EXEC FN_ADD_SECURITY_LOG 251, @in_IP, @in_CustomerID, @in_skey2
		select 6 as ResultCode
		return;
	end

	INSERT INTO FinancialTransactions
		VALUES (@in_CustomerID, 'INGAME_SRV', 2002, GETDATE(), 
				0, '1', 'APPROVED', @in_ItemId)

	if(@in_ItemId = 301004) begin
	-- premium acc
		select 0 as ResultCode
	end 
	else begin
		-- add that item
		exec FN_AddItemToUserInMin @in_CustomerID, @in_ItemId, @in_BuyMinutes
	end

	select 0 as ResultCode
END

GO
