SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[ECLIPSE_GETALLITEMS1] 
	@pkey char(32) = 'wrong app key'
AS
BEGIN
	SET NOCOUNT ON;

	if (@pkey != 'ACOR4823G%sjYU*@476xnDvYaK@!56' )
	begin

		select -1 as CustomerID;

		print 'WRONG API KEY'
	 return;
	end


SELECT * FROM Items_Weapons
SELECT * FROM Items_Gear
SELECT * FROM Items_Generic
SELECT * FROM Items_Packages

END
GO
