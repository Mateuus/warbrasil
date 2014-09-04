	--
	-- inventory weapon reset script with GP refunds...
	--
	use gameid_v1
	
	declare @ACTUAL_REFUND int = 0

	-- cleanup thigs first
	delete from Inventory where LeasedUntil<GETDATE()

	-- make a copy of customer-GP data
	delete from TMP_WeapRefund_GP
	insert into TMP_WeapRefund_GP select CustomerID, GamePoints, 0 from LoginID

	declare @CustomerID int
	declare @ItemID int
	declare @LeasedUntil datetime

	-- fill refund data
	delete from TMP_WeapRefund_Data
	DECLARE curs_inventory CURSOR FOR SELECT * from Inventory
	OPEN curs_inventory
	FETCH NEXT FROM curs_inventory into @CustomerID, @ItemID, @LeasedUntil
	while(@@FETCH_STATUS = 0) begin
		declare @Price7 int
		declare @PriceP int
		declare @Category int
		declare @Name varchar(128)
		declare @tmpvar int

		-- check that this is a weapon
		select @Price7=Price7, @PriceP=PriceP, @Category=Category, @Name=Name from Items_Weapons where ItemID=@ItemID
		if(@@ROWCOUNT = 0) begin
			FETCH NEXT FROM curs_inventory into @CustomerID, @ItemID, @LeasedUntil
			continue
		end

		declare @ddif int = DATEDIFF(day, GETDATE(), @LeasedUntil)
		if(@Category < 20 or @Category > 26) begin
			--  Reset только ОРУЖИЯ. 20-26 ( исключая explosives 27
			set @tmpvar = 0
		end 
		else if(@ddif < 0) begin
			-- expired item, skip
			set @tmpvar = 0
		end
		else 
		if(@ddif > 300 and @PriceP = 0) begin
            -- Если у чувака айтем с expiration >300 дней и цена в магазине Permanent 0 - то не стираем оставляем ему айтем ( это 
			set @tmpvar = 0
		end
		else if(@ddif > 300) begin
            -- Если у чувака айтем с expiration >300 дней и цена в магазине Permanent не ноль - возвращаем эту цену
            insert into TMP_WeapRefund_Data values(@CustomerID, @ItemID, @PriceP, 0, @Name)
		end
		else if(@ddif >= 7 and @Price7 > 0) begin
            -- Если у чувака айтем с expiration >7 дней возвразаем 7 day price		
            insert into TMP_WeapRefund_Data values(@CustomerID, @ItemID, @Price7, 1, @Name)
		end
		else if(@ddif < 7 and @Price7 > 0) begin
            -- Если у чувака айтем с expiration <7 дней возвразаем половину 7 day price
            insert into TMP_WeapRefund_Data values(@CustomerID, @ItemID, (@Price7 / 2), 2, @Name)
		end
		else begin
            print 'UNKNOWN ' + cast(@ItemId as varchar(100)) + ' ' + cast(@LeasedUntil as varchar(100)) + ' ddif:' + cast(@ddif as varchar(100)) + ' ' + cast(@Price7 as varchar(100)) + ' ' + cast(@PriceP as varchar(100))
		end

		FETCH NEXT FROM curs_inventory into @CustomerID, @ItemID, @LeasedUntil
	end
	CLOSE curs_inventory
	DEALLOCATE curs_inventory
	
	-- display refund list for debug
	select * from TMP_WeapRefund_Data order by CustomerID
	
	if(@ACTUAL_REFUND > 0)
	begin
		declare @GP int
		DECLARE curs_refund CURSOR FOR SELECT CustomerID, ItemID, GP from TMP_WeapRefund_Data order by CustomerID
		OPEN curs_refund
		FETCH NEXT FROM curs_refund into @CustomerID, @ItemID, @GP
		while(@@FETCH_STATUS = 0) begin
			-- ok, refund and delete item from inventory
			delete from Inventory where CustomerID=@CustomerID and ItemID=@ItemID
			update LoginID set GamePoints=(GamePoints+@GP) where CustomerID=@CustomerID
			FETCH NEXT FROM curs_refund into @CustomerID, @ItemID, @GP
		end
		CLOSE curs_refund
		DEALLOCATE curs_refund
	end

	update TMP_WeapRefund_GP set NewGP=LoginID.GamePoints from LoginID where TMP_WeapRefund_GP.CustomerID=LoginID.CustomerID
	-- the end.
