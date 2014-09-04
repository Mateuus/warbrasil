SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[FN_AddWeaponAllAttachments]
	@in_CustomerID int,
	@in_WeaponID int,
	@in_BuyDays int
AS
BEGIN
	SET NOCOUNT ON;
	
	--
	-- adding all attachments to already existing weapon
	--
	
	declare @FPSSpec0 int = 0
	declare @FPSSpec1 int = 0
	declare @FPSSpec2 int = 0
	declare @FPSSpec3 int = 0
	declare @FPSSpec4 int = 0
	declare @FPSSpec5 int = 0
	declare @FPSSpec6 int = 0
	declare @FPSSpec7 int = 0
	declare @FPSSpec8 int = 0

	select
		@FPSSpec0=FPSSpec0,
		@FPSSpec1=FPSSpec1,
		@FPSSpec2=FPSSpec2,
		@FPSSpec3=FPSSpec3,
		@FPSSpec4=FPSSpec4,
		@FPSSpec5=FPSSpec5,
		@FPSSpec6=FPSSpec6,
		@FPSSpec7=FPSSpec7,
		@FPSSpec8=FPSSpec8
	from Items_Weapons where ItemID=@in_WeaponID
	
	if(@FPSSpec0 > 0) exec FN_AddWeaponSlotAttachments @in_CustomerID, @in_WeaponID, @FPSSpec0, @in_BuyDays
	if(@FPSSpec1 > 0) exec FN_AddWeaponSlotAttachments @in_CustomerID, @in_WeaponID, @FPSSpec1, @in_BuyDays
	if(@FPSSpec2 > 0) exec FN_AddWeaponSlotAttachments @in_CustomerID, @in_WeaponID, @FPSSpec2, @in_BuyDays
	if(@FPSSpec3 > 0) exec FN_AddWeaponSlotAttachments @in_CustomerID, @in_WeaponID, @FPSSpec3, @in_BuyDays
	if(@FPSSpec4 > 0) exec FN_AddWeaponSlotAttachments @in_CustomerID, @in_WeaponID, @FPSSpec4, @in_BuyDays
	if(@FPSSpec5 > 0) exec FN_AddWeaponSlotAttachments @in_CustomerID, @in_WeaponID, @FPSSpec5, @in_BuyDays
	if(@FPSSpec6 > 0) exec FN_AddWeaponSlotAttachments @in_CustomerID, @in_WeaponID, @FPSSpec6, @in_BuyDays
	if(@FPSSpec7 > 0) exec FN_AddWeaponSlotAttachments @in_CustomerID, @in_WeaponID, @FPSSpec7, @in_BuyDays
	if(@FPSSpec8 > 0) exec FN_AddWeaponSlotAttachments @in_CustomerID, @in_WeaponID, @FPSSpec8, @in_BuyDays

END
GO
