SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ECLIPSE_Unsubscribe]
	@in_Email varchar(128)
AS
BEGIN
	SET NOCOUNT ON;

	declare @CustomerID as int
	declare @OptOut1 as int
	SELECT @CustomerID=CustomerID, @OptOut1=OptOut1 from AccountInfo where email=@in_Email
	if(@@ROWCOUNT = 0) begin
		-- no email
		select 3 as 'ResultCode', 'bad email' as 'ResultMsg'
		return
	end
	
	if(@OptOut1 > 0) begin
		-- already unsubscribed or blocked
		select 0 as 'ResultCode'
		return
	end

	-- unsubscribe	
	update AccountInfo set OptOut1=1 where CustomerID=@CustomerID
	select 0 as 'ResultCode'
	return
		
END
GO
