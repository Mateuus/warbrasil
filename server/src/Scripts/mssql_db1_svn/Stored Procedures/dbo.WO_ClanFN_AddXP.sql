
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_ClanFN_AddXP]
	@in_ClanID int,
	@in_AddXP int
AS
BEGIN
	SET NOCOUNT ON;
	
	-- update clan xp
	update ClanData set ClanXP=(ClanXP+@in_AddXP) where ClanID=@in_ClanID

	-- get old level and current xp
	declare @OldClanLevel int
	declare @ClanXP int
	select @OldClanLevel=ClanLevel, @ClanXP=ClanXP from ClanData where ClanID=@in_ClanID

	-- calc new level
	declare @NewClanLevel int
	select top(1) @NewClanLevel=ClanLevel from DataClanXP where @ClanXP<ClanXP order by ClanXP asc
	
	if(@NewClanLevel = @OldClanLevel)
		return
		
--	
-- WOW, we're leveled up!
--
	update ClanData set ClanLevel=@NewClanLevel where ClanID=@in_ClanID

	-- generate clan event
	insert into ClanEvents (
		ClanID,
		EventDate,
		EventType,
		EventRank,
		Var1
	) values (
		@in_ClanID,
		GETDATE(),
		12, -- CLANEvent_LevelUp
		99, -- Visible to all
		@NewClanLevel
	)

	-- TODO: give some bonuses
	
	return
END
GO
