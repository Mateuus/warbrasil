USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_SRV_GIVEITEM]    Script Date: 05/24/2011 16:30:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Pavel Tumik
-- Create date: May 24, 2011
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[WO_SRV_GIVEITEM] 
	@in_IP char(32),
	@in_CustomerID int,
	@in_ItemId int,
	@in_BuyDays int,
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
		exec FN_AddPremiumAccToUser @in_CustomerID, @in_BuyDays
	end 
	else begin
		-- add that item
		exec FN_AddItemToUser @in_CustomerID, @in_ItemId, @in_BuyDays
	end

	select 0 as ResultCode
END
