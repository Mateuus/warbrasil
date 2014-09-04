USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[ECLIPSE_RadiumGiveBonus]    Script Date: 01/27/2012 03:00:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ECLIPSE_RadiumGiveBonus] 
	@in_CustomerID int,
	@in_Amount int,
	@in_TrackId varchar(128)
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO FinancialTransactions VALUES (
		@in_CustomerID, 
		@in_TrackId, 
		1002, 
		GETDATE(), 
		@in_Amount, 
		'RADIUM', 
		'APPROVED', 
		'RADIUM_BONUS')
		
	UPDATE LoginID SET GamePoints=GamePoints+@in_Amount WHERE CustomerID=@in_CustomerID

	select 0 as 'ResultCode'
END
