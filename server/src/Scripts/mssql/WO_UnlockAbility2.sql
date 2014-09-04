USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_UnlockAbility2]    Script Date: 06/01/2011 16:42:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_UnlockAbility2] 
	@in_IP varchar(100),
	@in_CustomerID int,
	@in_AbilityID int
AS
BEGIN
	SET NOCOUNT ON;
	
	-- see if ability ID is correct
	declare @MAX_ABILITY_ID int = 255
	if(@in_AbilityID < 0 or @in_AbilityID > @MAX_ABILITY_ID) begin
		EXEC FN_ADD_SECURITY_LOG 130, @in_IP, @in_CustomerID, @in_AbilityID
		select 6 as ResultCode, 'bad AbilityID' as ResultMsg
		return
	end
	
	-- get player abilities as string
	declare @DataString char(256)
	SELECT @DataString=Abilities from ProfileData where CustomerID=@in_CustomerID
	if (@@RowCount = 0) begin
		-- fix broken table
		INSERT INTO ProfileData (CustomerID) VALUES (@in_CustomerID)
		return
	end
	
	-- split whole string to left + value + right part
	-- please remember that SUBSTRING indices is starting from 1, not from zero
	declare @ValLeft as varchar(1000) = ''
	declare @ValRight as varchar(1000) = ''
	declare @ValChar as char(1)
	set @ValChar = SUBSTRING(@DataString, @in_AbilityID + 1, 1)
	if(@in_AbilityID > 0) set @ValLeft  = SUBSTRING(@DataString, 1, @in_AbilityID)
	set @ValRight = SUBSTRING(@DataString, @in_AbilityID + 2, 999)
	--select @DataString as 'ab'
	--select @ValChar as 'val', @ValLeft as 'left', @ValRight as 'right'
	
	if(@ValChar = '1') begin
		-- ability already unlocked, return
		select 0 as ResultCode
		return
	end

	-- unlock ability and recombine string
	set @ValChar = '1';
	set @DataString = @ValLeft + @ValChar + @ValRight
	--select @DataString as 'newval'
	
	-- update ability data
	UPDATE ProfileData SET Abilities=@DataString where CustomerID=@in_CustomerID

	select 0 as ResultCode
END
