SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_AMAZON_LogMessage]
	@in_MessageId varchar(128),
	@in_MessageBody varchar(512)
AS
BEGIN
	SET NOCOUNT ON;

	-- this call is always valid
	select 0 as ResultCode
	
	if(exists(select * from AmazonMessages where MessageId=@in_MessageId)) begin
		select 'FAILURE_UNKNOWN' as 'Status'
		return
	end
	
	insert into AmazonMessages 	(
		MessageId,
		MessageBody,
		MessageTime
		) values (
		@in_MessageId, 
		@in_MessageBody,
		GETDATE()
		)

	select 'SUCCESS' as 'Status';
	return;
END
GO
