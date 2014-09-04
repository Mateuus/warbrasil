SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Pavel Tumik
-- Create date: Jun 7, 2011
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[ECLIPSE_ReportHWInfo_CustomerID] 
	@in_IP varchar(100),
	@in_CustomerID int,
	@r00 bigint,
	@r10 varchar(128),
	@r11 varchar(128),
	@r12 int,
	@r13 int,
	@r20 int,
	@r21 int,
	@r22 int,
	@r23 int,
	@r24 int,
	@r25 varchar(128),
	@r30 varchar(32)
AS
BEGIN
	SET NOCOUNT ON;

	-- insert new record in case we didn't had it
	if not exists (SELECT ComputerID FROM DBG_HWInfo WHERE ComputerID=@r00) begin
		insert into DBG_HWInfo (ComputerID, CustomerID) values (@r00, 0)
	end
	
	UPDATE DBG_HWInfo SET
		CustomerID=@in_CustomerID,
		ReportDate=GETDATE(),
		CPUName=@r10,
		CPUBrand=@r11,
		CPUFreq=@r12,
		TotalMemory=@r13,
		DisplayW=@r20,
		DisplayH=@r21,
		gfxErrors=@r22,
		gfxVendorId=@r23,
		gfxDeviceId=@r24,
		gfxDescription=@r25,
		OSVersion=@r30
	WHERE ComputerID=@r00

	select 0 as ResultCode
END
GO
