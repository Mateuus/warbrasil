USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_LEARNSKILL]    Script Date: 03/23/2011 12:16:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_LEARNSKILL]
	@in_IP char(32),
	@in_CustomerID int,
	@in_SkillID int
AS
BEGIN
	SET NOCOUNT ON;
	
	-- see if ability ID is correct
	declare @MAX_SKILL_ID int = 10
	if(@in_SkillID < 0 or @in_SkillID >= @MAX_SKILL_ID) begin
		EXEC FN_ADD_SECURITY_LOG 120, @in_IP, @in_CustomerID, @in_SkillID
		select 6 as ResultCode, 'bad SkillID' as ResultMsg
		return
	end
	
	-- get SkillPoints for that customer
	declare @SkillPoints int
	SELECT @SkillPoints=SkillPoints FROM LoginID WHERE CustomerID=@in_CustomerID
	if (@@RowCount = 0) begin
		select 6 as ResultCode, 'no CustomerID' as ResultMsg
		return
	end
	
	-- get player skills as string
	declare @DataString char(256)
	SELECT @DataString=Skills from ProfileData where CustomerID=@in_CustomerID
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
	set @ValChar = SUBSTRING(@DataString, @in_SkillID + 1, 1)
	if(@in_SkillID > 0) set @ValLeft  = SUBSTRING(@DataString, 1, @in_SkillID)
	set @ValRight = SUBSTRING(@DataString, @in_SkillID + 2, 999)
	--select @DataString as 'ab'
	--select @ValChar as 'val', @ValLeft as 'left', @ValRight as 'right'
	
	-- fix bad skill value
	if(@ValChar < '0' or @ValChar > '5') set @ValChar = '0';
	
	-- check if skill at max value
	if(@ValChar >= '5') begin
		select 0 as ResultCode
		select @ValChar as 'SkillLevel', @SkillPoints as SkillPoints
		return
	end

--
-- skill cost
--
	declare @COST_LV1 int
	declare @COST_LV2 int
	declare @COST_LV3 int
	declare @COST_LV4 int
	declare @COST_LV5 int
	select
		@COST_LV1=Lv1,
		@COST_LV2=Lv2,
		@COST_LV3=Lv3,
		@COST_LV4=Lv4,
		@COST_LV5=Lv5
	from DataSkillPrice
	declare @SKILL_COST int
	if(@ValChar = '0') set @SKILL_COST = @COST_LV1;
	else if(@ValChar = '1') set @SKILL_COST = @COST_LV2;
	else if(@ValChar = '2') set @SKILL_COST = @COST_LV3;
	else if(@ValChar = '3') set @SKILL_COST = @COST_LV4;
	else if(@ValChar = '4') set @SKILL_COST = @COST_LV5;
	
	-- fail, if we don't have SP
	if(@SkillPoints < @SKILL_COST) begin
		declare @smsg1 varchar(1000) = LTRIM(STR(@SkillPoints)) + ' ' + 
			LTRIM(STR(@SKILL_COST)) + ' ' + LTRIM(STR(@ValChar))
		EXEC FN_ADD_SECURITY_LOG 121, @in_IP, @in_CustomerID, @smsg1
		select 7 as ResultCode, 'Not Enough SP' as ResultMsg
		return
	end

	-- unlock ability and recombine string
	set @ValChar = @ValChar + 1;
	set @DataString = @ValLeft + @ValChar + @ValRight
	--select @DataString as 'newval'
	
	-- update player skill points & set skill data
	set @SkillPoints = @SkillPoints - @SKILL_COST
	UPDATE LoginID SET SkillPoints=@SkillPoints where CustomerID=@in_CustomerID
	UPDATE ProfileData SET Skills=@DataString where CustomerID=@in_CustomerID

	select 0 as ResultCode
	select @ValChar as 'SkillLevel', @SkillPoints as SkillPoints
END
