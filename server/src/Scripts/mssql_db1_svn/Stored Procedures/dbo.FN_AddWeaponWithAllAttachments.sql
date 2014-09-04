SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[FN_AddWeaponWithAllAttachments]
	@in_CustomerID int,
	@in_WeaponID int,
	@in_BuyDays int,
	@in_AttachBuyDays int
AS
BEGIN
	SET NOCOUNT ON;
	
	--
	-- adding weapon with all attachments
	--

	exec FN_AddItemToUser @in_CustomerID, @in_WeaponID, @in_BuyDays
	exec FN_AddWeaponAllAttachments @in_CustomerID, @in_WeaponID, @in_AttachBuyDays

END
GO
