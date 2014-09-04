USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_BuyItemFN_UnlearnSkills]    Script Date: 05/27/2011 18:24:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_BuyItemFN_UnlearnSkills]
	@out_FNResult int out,
	@in_CustomerID int,
	@in_ExecRefund int
AS
BEGIN
	SET NOCOUNT ON;
	
	-- get SkillPoints for that customer
	declare @SkillPoints int
	SELECT @SkillPoints=SkillPoints FROM LoginID WHERE CustomerID=@in_CustomerID
	if (@@RowCount = 0) begin
		set @out_FNResult = 6
		return
	end
	
	-- get player skills as string
	declare @DataString char(256)
	SELECT @DataString=Skills from ProfileData where CustomerID=@in_CustomerID
	if (@@RowCount = 0) begin
		set @out_FNResult = 6
		return
	end

--
-- push invididual skill values to temporary table
--
	declare @t_skills table (
		sv varchar(1)
	) 
	
	declare @MAX_SKILL_ID int = 10
	declare @SkillId int = 1
	while(@SkillId <= @MAX_SKILL_ID) 
	begin
		declare @sv char(1) = SUBSTRING(@DataString, @SkillId, 1)
		-- fix bad skill value
		if(@sv < '0' or @sv > '5') set @sv = '0';

		insert into @t_skills values(@sv)
		set @SkillId = @SkillId + 1
	end
	
--
-- grab skill cost
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

	--some debug crap
	--select * from DataSkillPrice
	--select @DataString
	--select * from @t_skills

--
-- iterate for each skill value and refund SP
--	
	declare @TotalSP int = 0

	DECLARE t_skills_Cursor CURSOR FOR SELECT * from @t_skills
	OPEN t_skills_Cursor
	FETCH NEXT FROM t_skills_Cursor into @sv
	while @@FETCH_STATUS = 0 
	begin
		if(@sv = '1')      set @TotalSP = @TotalSP + @COST_LV1
		else if(@sv = '2') set @TotalSP = @TotalSP + @COST_LV1 + @COST_LV2
		else if(@sv = '3') set @TotalSP = @TotalSP + @COST_LV1 + @COST_LV2 + @COST_LV3
		else if(@sv = '4') set @TotalSP = @TotalSP + @COST_LV1 + @COST_LV2 + @COST_LV3 + @COST_LV4
		else if(@sv = '5') set @TotalSP = @TotalSP + @COST_LV1 + @COST_LV2 + @COST_LV3 + @COST_LV4 + @COST_LV5

		FETCH NEXT FROM t_skills_Cursor into @sv
	end
	CLOSE t_skills_Cursor
	DEALLOCATE t_skills_Cursor

	-- actually execute refund
	if(@in_ExecRefund > 0) begin
		update LoginID set SkillPoints=(SkillPoints+@TotalSP) where CustomerID=@in_CustomerID
		update ProfileData set Skills='0000000000' where CustomerID=@in_CustomerID
	end
	
	set @out_FNResult = 0
END
