SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[FN_AlterUserGP]
	@in_CustomerID int,
	@in_GP int,
	@in_Reason varchar(64)
AS
BEGIN
	SET NOCOUNT ON;
	
	if(@in_GP = 0)
		return
		
	declare @GamePoints int = 0
	select @GamePoints=GamePoints from LoginID where CustomerID=@in_CustomerID

	insert into DBG_GPTransactions (
		CustomerID,
		TransactionTime,
		Amount,
		Reason,
		Previous
	) values (
		@in_CustomerID,
		GETDATE(),
		@in_GP,
		@in_Reason,
		@GamePoints
	)
	
	update LoginID set GamePoints=(GamePoints + @in_GP) where CustomerID=@in_CustomerID

END
GO
