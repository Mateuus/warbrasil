
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ECLIPSE_RadiumGiveBonus] 
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
		
	exec FN_AlterUserGP @in_CustomerID, @in_Amount, 'RadiumBonus'
	select 0 as 'ResultCode'
	
END
GO
