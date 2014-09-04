USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_WeaponAttachCheckBuy]    Script Date: 03/04/2012 16:03:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_WeaponAttachCheckBuy]
	@in_CustomerID int,
	@in_WeaponID int,
	@in_AttachmentID int,
	@in_Slot int
AS
BEGIN
	SET NOCOUNT ON;
	
	-- check if we have that attachment and get their SpecID
	declare @SpecID int = 0
	declare @Slot int = 0
	select @Slot=[Type], @SpecID=SpecID from Items_Attachments where ItemID=@in_AttachmentID
	if(@@ROWCOUNT = 0) begin
		select 6 as 'ResultCode', 'no such attachment' as 'ResultMsg'
		return
	end
	
	-- check slot (just in case client screwed something)
	if(@Slot <> @in_Slot) begin
		select 6 as 'ResultCode', 'bad attachment slot' as 'ResultMsg'
		return
	end
	
	-- get weapon attachment parameters
	declare @FPSSpec0 int
	declare @FPSSpec1 int
	declare @FPSSpec2 int
	declare @FPSSpec3 int
	declare @FPSSpec4 int
	declare @FPSSpec5 int
	declare @FPSSpec6 int
	declare @FPSSpec7 int
	declare @FPSSpec8 int
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
	if(@@ROWCOUNT = 0) begin
		select 6 as 'ResultCode', 'no such weapon' as 'ResultMsg'
		return
	end
	
	-- check if we can put that attachment to this slot
	declare @BadPut int = 0
	if(@Slot = 0 and @FPSSpec0 <> @SpecID) set @BadPut = 1
	if(@Slot = 1 and @FPSSpec1 <> @SpecID) set @BadPut = 1
	if(@Slot = 2 and @FPSSpec2 <> @SpecID) set @BadPut = 1
	if(@Slot = 3 and @FPSSpec3 <> @SpecID) set @BadPut = 1
	if(@Slot = 4 and @FPSSpec4 <> @SpecID) set @BadPut = 1
	if(@Slot = 5 and @FPSSpec5 <> @SpecID) set @BadPut = 1
	if(@Slot = 6 and @FPSSpec6 <> @SpecID) set @BadPut = 1
	if(@Slot = 7 and @FPSSpec7 <> @SpecID) set @BadPut = 1
	if(@Slot = 8 and @FPSSpec8 <> @SpecID) set @BadPut = 1
	if(@BadPut > 0) begin
		select 6 as 'ResultCode', 'SpecID mismatch' as 'ResultMsg'
		return
	end
	
	select 0 as 'ResultCode'
	return
END
