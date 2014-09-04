SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[FN_ADD_SECURITY_LOG] 
	-- Add the parameters for the stored procedure here
	@EventID int,
	@IP varchar(64),
	@CustomerID int,
	@EventData varchar(256)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO SecurityLog
		(EventID, Date, IP, CustomerID, EventData) 
	VALUES 
		(@EventID, GETDATE(), @IP, @CustomerID, @EventData)

END
GO
