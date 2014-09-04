SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ECLIPSE_GETACCOUNTINFO] 
	@in_CustomerID int,
	@in_db_apikey varchar(100)
AS
BEGIN
	SET NOCOUNT ON;

	if(@in_db_apikey != 'ACOR4823G%sjYU*@476xnDvYaK@!56') begin
		print 'WRONG API KEY'
		return;
	end

	-- check if CustomerID is valid
	if not exists (SELECT CustomerID FROM LoginID WHERE CustomerID=@in_CustomerID)
	begin
		return;
	end

	SELECT *
	FROM LoginID 
	JOIN Stats ON (LoginID.CustomerID = Stats.CustomerID) 
	JOIN ProfileData ON (LoginID.CustomerID = ProfileData.CustomerID) 
	where LoginID.CustomerID=@in_CustomerID

END
GO
