SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_AMAZON_GetAddresses]
	@in_AccountToken varchar(128)
AS
BEGIN
	SET NOCOUNT ON;

	declare @CustomerID int = 0
	declare @AccountStatus int = 0
	declare @AccountName varchar(128) = ''

	-- this call is always valid
	select 0 as ResultCode
	
	if(ISNUMERIC(@in_AccountToken) = 1)
	begin
		select 
			@CustomerID=CustomerID, 
			@AccountStatus=@AccountStatus,
			@AccountName=AccountName
			from LoginID where CustomerID=@in_AccountToken
	end
	
	select @CustomerID as 'CustomerID', @AccountStatus as 'AccountStatus', @AccountName as 'AccountName'
END
GO
