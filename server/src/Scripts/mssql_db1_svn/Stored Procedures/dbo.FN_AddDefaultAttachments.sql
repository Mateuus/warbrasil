
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[FN_AddDefaultAttachments]
	@in_CustomerID int,
	@in_WeaponID int,			-- weapon id for adding attachment
	@in_ExpDays int
AS
BEGIN
	SET NOCOUNT ON;
	
	declare @IsFPS int = 0
	declare @FPSAttach0 int = 0
	declare @FPSAttach1 int = 0
	declare @FPSAttach2 int = 0
	declare @FPSAttach3 int = 0
	declare @FPSAttach4 int = 0
	declare @FPSAttach5 int = 0
	declare @FPSAttach6 int = 0
	declare @FPSAttach7 int = 0
	declare @FPSAttach8 int = 0

	select 
		@IsFPS=IsFPS,
		@FPSAttach0=FPSAttach0,
		@FPSAttach1=FPSAttach1,
		@FPSAttach2=FPSAttach2,
		@FPSAttach3=FPSAttach3,
		@FPSAttach4=FPSAttach4,
		@FPSAttach5=FPSAttach5,
		@FPSAttach6=FPSAttach6,
		@FPSAttach7=FPSAttach7,
		@FPSAttach8=FPSAttach8
	from Items_Weapons where ItemID=@in_WeaponID

	if(@IsFPS > 0) begin
		if(@FPSAttach0 > 0) exec FN_AddAttachmentToUser @in_CustomerID, @in_WeaponID, @FPSAttach0, @in_ExpDays
		if(@FPSAttach1 > 0) exec FN_AddAttachmentToUser @in_CustomerID, @in_WeaponID, @FPSAttach1, @in_ExpDays
		if(@FPSAttach2 > 0) exec FN_AddAttachmentToUser @in_CustomerID, @in_WeaponID, @FPSAttach2, @in_ExpDays
		if(@FPSAttach3 > 0) exec FN_AddAttachmentToUser @in_CustomerID, @in_WeaponID, @FPSAttach3, @in_ExpDays
		if(@FPSAttach4 > 0) exec FN_AddAttachmentToUser @in_CustomerID, @in_WeaponID, @FPSAttach4, @in_ExpDays
		if(@FPSAttach5 > 0) exec FN_AddAttachmentToUser @in_CustomerID, @in_WeaponID, @FPSAttach5, @in_ExpDays
		if(@FPSAttach6 > 0) exec FN_AddAttachmentToUser @in_CustomerID, @in_WeaponID, @FPSAttach6, @in_ExpDays
		if(@FPSAttach7 > 0) exec FN_AddAttachmentToUser @in_CustomerID, @in_WeaponID, @FPSAttach7, @in_ExpDays
		if(@FPSAttach8 > 0) exec FN_AddAttachmentToUser @in_CustomerID, @in_WeaponID, @FPSAttach8, @in_ExpDays
	end
	
	return
END

GO
