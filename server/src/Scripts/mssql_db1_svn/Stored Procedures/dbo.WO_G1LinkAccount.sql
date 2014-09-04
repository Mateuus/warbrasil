
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_G1LinkAccount]
	@in_CustomerID int,
	@in_G1ID int,
	@in_G1PayCode int
AS
BEGIN
	SET NOCOUNT ON;
	
	select 0 as ResultCode

	insert into GamersfirstUserIDMap (CustomerID, GamersfirstID) values (@in_CustomerID, @in_G1ID)
	
	--
	-- g1 account bonuses based on tiers
	--

	if(@in_G1PayCode = 1)	-- WRPaidTier5 - Tier 1: Top 1% of paying players
	begin
		exec FN_AlterUserGP @in_CustomerID, 10000, 'G1RefBonus'

		-- 5 day rental of following guns plus for each gun rental of 3 days of all attachments:
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101055, 5, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101077, 5, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101218, 5, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101219, 5, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101215, 5, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101084, 5, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101232, 5, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101200, 5, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101245, 5, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101247, 5, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101197, 5, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101214, 5, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101227, 5, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101106, 5, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101246, 5, 3
		return
	end

	if(@in_G1PayCode = 2)	-- WRPaidTier4 - Tier 2: Next 9% of paying players
	begin
		exec FN_AlterUserGP @in_CustomerID, 5000, 'G1RefBonus'

		-- 7 day rental of following guns plus for each gun rental of 3 days of all attachments:
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101055, 7, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101077, 7, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101215, 7, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101247, 7, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101084, 7, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101227, 7, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101106, 7, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101246, 7, 3
		return
	end

	if(@in_G1PayCode = 3)	-- WRPaidTier3 - Tier 3: Next 20% of paying players
	begin
		exec FN_AlterUserGP @in_CustomerID, 5000, 'G1RefBonus'
		update LoginID set GameDollars=(GameDollars+100000) where CustomerID=@in_CustomerID

		-- 7 day rental of following guns plus for each gun rental of 3 days of all attachments:
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101055, 7, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101215, 7, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101247, 7, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101106, 7, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101246, 7, 3
		return
	end

	if(@in_G1PayCode = 4)	-- WRPaidTier2 - Tier 4: Next 30 % of paying players
	begin
		exec FN_AlterUserGP @in_CustomerID, 8000, 'G1RefBonus'
		update LoginID set GameDollars=(GameDollars+100000) where CustomerID=@in_CustomerID

		-- 5 day rental of following guns plus for each gun rental of 3 days of all attachments:
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101055, 5, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101247, 5, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101106, 5, 3
		return
	end

	if(@in_G1PayCode = 5)	-- WRPaidTier1 - Tier 5: Bottom 40% of paying players
	begin
		exec FN_AlterUserGP @in_CustomerID, 10000, 'G1RefBonus'

		-- 3 day rental of following guns plus for each gun rental of 3 days of all attachments:
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101215, 3, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101247, 3, 3
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101106, 3, 3
		return
	end


	if(@in_G1PayCode = 6)	-- WRFreeTier4 - Tier 6: Top 1% of level-earners
	begin
		exec FN_AlterUserGP @in_CustomerID, 15000, 'G1RefBonus'

		-- 7 day rental of following guns ( no attachments rentals ):
		exec FN_AddItemToUser @in_CustomerID, 101247, 7
		exec FN_AddItemToUser @in_CustomerID, 101055, 7
		exec FN_AddItemToUser @in_CustomerID, 101227, 7
		-- 7 days rental of
		exec FN_AddItemToUser @in_CustomerID, 301001, 7
		exec FN_AddItemToUser @in_CustomerID, 301003, 7
		return
	end
		
	if(@in_G1PayCode = 7)	-- WRFreeTier3 - Tier 7: Next 9% of level-earners 
	begin
		exec FN_AlterUserGP @in_CustomerID, 10000, 'G1RefBonus'

		-- 5 day rental of following guns ( no attachments rentals ):
		exec FN_AddItemToUser @in_CustomerID, 101247, 5
		exec FN_AddItemToUser @in_CustomerID, 101055, 5
		exec FN_AddItemToUser @in_CustomerID, 101227, 5
		-- 5 days rental of
		exec FN_AddItemToUser @in_CustomerID, 301001, 5
		exec FN_AddItemToUser @in_CustomerID, 301003, 5
		return
	end

	if(@in_G1PayCode = 8)	-- WRFreeTier2 - Tier 8: Next 20% of level earners
	begin
		exec FN_AlterUserGP @in_CustomerID, 7000, 'G1RefBonus'
		return
	end

	if(@in_G1PayCode = 9)	-- WRFreeTier1 - Tier 9: Next 30% of level earners
	begin
		exec FN_AlterUserGP @in_CustomerID, 5000, 'G1RefBonus'
		return
	end

	if(@in_G1PayCode >= 0)	-- any other tier - Tier 10: Bottom 40% of level earners
	begin
		exec FN_AlterUserGP @in_CustomerID, 5000, 'G1RefBonus'
		-- 7 day rental of following guns with 5 days rental of all attachments for each gun
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101247, 7, 5
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101215, 7, 5
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101055, 7, 5
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101108, 7, 5
		exec FN_AddWeaponWithAllAttachments @in_CustomerID, 101227, 7, 5
		-- 5 days rental of
		exec FN_AddItemToUser @in_CustomerID, 301001, 5
		exec FN_AddItemToUser @in_CustomerID, 301003, 5
		return
	end

END
GO
